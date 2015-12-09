-- BuyEmAll - By Cogwheel v1.9 - See readme.txt

--[[Hook BuyMerchantItem for debugging purposes 
function BuyMerchantItem(button, amount)
    if not amount then amount = 1 end
    print("Buying "..amount.." items.")
end --]]

-- Herb & Enchanting item lists courtesy of Periodic Table by Tekkub
BuyEmAll_SpecialItems = {
    Herb = "3358 8839 13466 4625 13467 3821 785 13465 13468 2450 2452 3818 3355 3357 8838 3369 3820 8153 8836 13463 8845 8846 13464 2447 2449 765 2453 3819 3356 8831",
    Enchant = "11083 16204 11137 11176 10940 11174 10938 11135 11175 16202 11134 16203 10998 11082 10939 11084 14343 11139 10978 11177 14344 11138 11178",
}




function BuyEmAllFrame_OnLoad()
    -- Set up confirmation dialog
	StaticPopupDialogs["BUYEMALL_CONFIRM"] = {
		text = "Are you sure you want to buy %d × %s?",
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = BuyEmAll_OnAccept,
		timeout = 0,
		hideOnEscape = true
	}
	
    -- Replace the SplitStack callback and  for each merchant item button
	for i=1,12 do
        local button=getglobal("MerchantItem"..i.."ItemButton")
		button.SplitStack = BuyEmAll_SplitStack
        button:SetScript("OnHide", function()
            if ( this.hasBuyEmAll == 1 ) then
				BuyEmAllFrame:Hide();
			end
        end)
	end
end




--[[ Since I have to control two different paths through this function, I just
     recreated it here to make life a bit easier. ]]
function MerchantItemButton_OnClick(button, ignoreModifiers)
	if ( MerchantFrame.selectedTab == 1 ) then
		-- Is merchant frame
		if ( button == "LeftButton" ) then
			if ( IsControlKeyDown() and not ignoreModifiers ) then
				DressUpItemLink(GetMerchantItemLink(this:GetID()));
			elseif ( IsShiftKeyDown() and not ignoreModifiers ) then
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:Insert(GetMerchantItemLink(this:GetID()));
				else
                    BuyEmAll_ChooseAmount()
				end
			else
				PickupMerchantItem(this:GetID());
			end
		else
			if ( IsControlKeyDown() and not ignoreModifiers ) then
				return;
			elseif ( IsShiftKeyDown() and not ignoreModifiers ) then
                BuyEmAll_ChooseAmount()
			else
				BuyMerchantItem(this:GetID());
			end
		end
	else
		-- Is buyback item
		BuybackItem(this:GetID());
	end
end




-- Courtesy of wowwiki.com
function GetItemInfoFromItemLink(link)
    local itemId = nil;
    if ( type(link) == "string" ) then
        _,_, itemId = string.find(link, "item:(%d+):");
    end
    if ( itemId ) then
        return itemId, GetItemInfo(itemId);
    end
end




-- Figures out maximum purchase amount and shows the BuyEmAllFrame
function BuyEmAll_ChooseAmount()
    local name, _, price, quantity, numAvailable = GetMerchantItemInfo(this:GetID());
    this.presetStack = quantity
    this.itemName = name
    this.itemID, _,_,_,_,_, this.itemSubType, this.stackSize = 
        GetItemInfoFromItemLink(GetMerchantItemLink(this:GetID()))
    
    local bagSpace, specialSpace = BuyEmAll_FreeSpace(name, itemID)
    local bagMax = math.floor(bagSpace / quantity) * quantity
    local specialMax = math.floor(specialSpace / quantity) * quantity
    local moneyMax = math.floor(GetMoney() / price) * quantity
    local maxPurchase = math.min(bagMax, moneyMax)
    if numAvailable > 0 then maxPurchase = math.min(maxPurchase, numAvailable * quantity) end
    
    if not name or maxPurchase == 0 then
        return
    elseif maxPurchase == 1 then
        MerchantItemButton_OnClick("LeftButton", 1)
        return
    end
    
    OpenBuyEmAllFrame(maxPurchase+specialMax, specialMax > 0 and specialMax or quantity, "BOTTOMLEFT", "TOPLEFT")
end




--  Determines free bag space.
function BuyEmAll_FreeSpace(name, itemID)
    local returns = { freeSpace = 0, specialSpace = 0}
    
	for theBag = 0,4 do
        local which = "freeSpace"
        local doBag = true
        
        if theBag > 0 then
            local _,_,_,_,_,_,bagSubType =
                GetItemInfoFromItemLink(GetInventoryItemLink("player", theBag + 19)) -- Bag #1 is in inventory slot 20
            if bagSubType == "Ammo Pouch" and this.itemSubType == "Bullet" or
               bagSubType == "Quiver" and this.itemSubType == "Arrow" then
                which = "specialSpace"
            elseif bagSubType == "Ammo Pouch" and this.itemSubType ~= "Bullet" or
                   bagSubType == "Quiver" and this.itemSubType ~= "Arrow" or
                   bagSubType == "Herb Bag" and not BuyEmAll_IsSpecial("Herb") or
                   bagSubType == "Enchanting Bag" and not BuyEmAll_IsSpecial("Enchant") then
                doBag = false
            end
        end
            
		if doBag then
            local numSlot = GetContainerNumSlots(theBag);
            for theSlot = 1, numSlot do
                local itemLink = GetContainerItemLink(theBag, theSlot);
                if not itemLink then
                    returns[which] = returns[which] + this.stackSize;
                elseif string.find(itemLink, "%["..name.."%]") then
                    local _,itemCount = GetContainerItemInfo(theBag, theSlot)
                    returns[which] = returns[which] + this.stackSize - itemCount
                end
            end
        end
	end
    return returns.freeSpace, returns.specialSpace
end




-- Determine whether an item is an herb or enchanting material
function BuyEmAll_IsSpecial(which)
    for itemID in gfind(BuyEmAll_SpecialItems[which], "%d+") do
        if tonumber(this.itemID) == tonumber(itemID) then return true end
    end
    return false
end




function BuyEmAll_SplitStack(button, amount)
    if (amount > 0) then
        amount = math.ceil(amount/button.presetStack) * button.presetStack
        local params = { button = button, amount = amount }
        if amount > button.stackSize then
            local dialog = StaticPopup_Show("BUYEMALL_CONFIRM", amount, button.itemName)
            dialog.data = params
        elseif button.presetStack > 1 then
            BuyEmAll_OnAccept(params)
        else
            BuyMerchantItem(button:GetID(), amount);
        end
    end
end




function BuyEmAll_OnAccept(params)
    local numLoops, purchAmount, leftover
    
    if params.button.presetStack > 1 then
        numLoops = params.amount/params.button.presetStack
        purchAmount = 1
        leftover = 0
    else
        numLoops = math.floor(params.amount/params.button.stackSize)
        purchAmount = params.button.stackSize
        leftover = math.mod(params.amount, params.button.stackSize)
    end
    
    for i = 1, numLoops do
        BuyMerchantItem(params.button:GetID(), purchAmount)
    end
    
    if leftover > 0 then BuyMerchantItem(params.button:GetID(), leftover) end
end




local OldMerchantFrame_OnHide = MerchantFrame_OnHide
function MerchantFrame_OnHide(...)
    StaticPopup_Hide("BUYEMALL_CONFIRM")
    return OldMerchantFrame_OnHide(unpack(arg))
end









--[[ Below is the modified code from the built-in StackSplitFrame ]]



function OpenBuyEmAllFrame(maxStack, initStack, anchor, anchorTo)
    if ( BuyEmAllFrame.owner ) then
		BuyEmAllFrame.owner.hasBuyEmAll = 0;
	end

	BuyEmAllFrame.maxStack = maxStack;
	if ( BuyEmAllFrame.maxStack < 2 ) then
		BuyEmAllFrame:Hide();
		return;
	end

	BuyEmAllFrame.owner = this;
	this.hasBuyEmAll = 1;
	BuyEmAllFrame.split = initStack;
	BuyEmAllFrame.typing = 0;
	BuyEmAllText:SetText(BuyEmAllFrame.split);
	BuyEmAllLeftButton:Disable();
	BuyEmAllRightButton:Enable();
 
    BuyEmAllMaxText:SetText("Max: "..maxStack)

	BuyEmAllFrame:ClearAllPoints();
	BuyEmAllFrame:SetPoint(anchor, this, anchorTo, 0, 0);
	BuyEmAllFrame:Show();
end




function BuyEmAllFrame_OnChar()
	if ( arg1 < "0" or arg1 > "9" ) then
		return;
	end

	if ( this.typing == 0 ) then
		this.typing = 1;
		this.split = 0;
	end

	local split = (this.split * 10) + arg1;
	if ( split == this.split ) then
		if( this.split == 0 ) then
			this.split = 1;
		end
		return;
	end

	if ( split <= this.maxStack ) then
		this.split = split;
		BuyEmAllText:SetText(split);
		if ( split == this.maxStack ) then
			BuyEmAllRightButton:Disable();
		else
			BuyEmAllRightButton:Enable();
		end
		if ( split <= this.owner.presetStack ) then
			BuyEmAllLeftButton:Disable();
		else
			BuyEmAllLeftButton:Enable();
		end
	elseif ( split == 0 ) then
		this.split = 1;
	end
end




function BuyEmAllFrame_OnKeyDown()
	if ( arg1 == "BACKSPACE" or arg1 == "DELETE" ) then
		if ( this.typing == 0 or this.split == 1 ) then
			return;
		end

		this.split = floor(this.split / 10);
		if ( this.split <= 1 ) then
			this.split = 1;
			this.typing = 0;
        end
        if ( this.split <= this.owner.presetStack ) then
			BuyEmAllLeftButton:Disable();
		else
			BuyEmAllLeftButton:Enable();
		end
		BuyEmAllText:SetText(this.split);
		if ( this.money == this.maxStack ) then
			BuyEmAllRightButton:Disable();
		else
			BuyEmAllRightButton:Enable();
		end
	elseif ( arg1 == "ENTER" ) then
		BuyEmAllOkay_Click();
	elseif ( arg1 == "ESCAPE" ) then
		BuyEmAllCancel_Click();
	elseif ( arg1 == "LEFT" or arg1 == "DOWN" ) then
		BuyEmAllLeft_Click();
	elseif ( arg1 == "RIGHT" or arg1 == "UP" ) then
		BuyEmAllRight_Click();
	end
end




function BuyEmAllLeft_Click()
    local preset = BuyEmAllFrame.owner.presetStack
	if ( BuyEmAllFrame.split <= preset ) then
		return;
	end
    
    local decrease = math.mod(BuyEmAllFrame.split, preset)
    decrease = decrease == 0 and preset or decrease

	BuyEmAllFrame.split = BuyEmAllFrame.split - decrease

	BuyEmAllText:SetText(BuyEmAllFrame.split)
	if ( BuyEmAllFrame.split <= preset ) then
		BuyEmAllLeftButton:Disable()
	end
	BuyEmAllRightButton:Enable()
end




function BuyEmAllRight_Click()
    local preset = BuyEmAllFrame.owner.presetStack
    local increase = preset - math.mod(BuyEmAllFrame.split, preset)

	if ( BuyEmAllFrame.split + increase > BuyEmAllFrame.maxStack ) then
		return;
	end
    
	BuyEmAllFrame.split = BuyEmAllFrame.split + increase;
	BuyEmAllText:SetText(BuyEmAllFrame.split);
	if ( BuyEmAllFrame.split == BuyEmAllFrame.maxStack ) then
		BuyEmAllRightButton:Disable();
	end
	BuyEmAllLeftButton:Enable();
end




function BuyEmAllOkay_Click()
	if ( BuyEmAllFrame.owner ) then
		BuyEmAllFrame.owner.SplitStack(BuyEmAllFrame.owner, BuyEmAllFrame.split);
	end
	BuyEmAllFrame:Hide();
end




function BuyEmAllCancel_Click()
	BuyEmAllFrame:Hide();
end




function BuyEmAllFrame_OnHide()
	if ( BuyEmAllFrame.owner ) then
		BuyEmAllFrame.owner.hasBuyEmAll = 0;
	end
end
