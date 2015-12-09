--[[ BuyEmAll - By Cogwheel v1.5 - See readme.txt

Allows you to buy more than the stack size of an item from a vendor at once. 
Additionally, you can now shift-click to buy multiple units of items that are
sold in preset stacks (e.g. Refreshing Spring Water)

]]

--[[ Hook BuyMerchantItem for debugging purposes 
function BuyMerchantItem(button, amount)
    if not amount then amount = 1 end
    print("Buying "..amount.." items.")
end --]]




function BuyEmAll_OnLoad()
    -- Set up confirmation dialog
	StaticPopupDialogs["BUYEMALL_CONFIRM"] = {
		text = "Are you sure you want to buy %d of this item?",
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = BuyEmAll_OnAccept,
		timeout = 0,
		hideOnEscape = true
	}
	
    -- Replace the SplitStack callback for each merchant item button
	for i=1,12 do
		getglobal("MerchantItem"..i.."ItemButton").SplitStack = BuyEmAll_SplitStack
	end
end




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
                    BuyEmAll_ChooseAmount(this)
				end
			else
				PickupMerchantItem(this:GetID());
			end
		else
			if ( IsControlKeyDown() and not ignoreModifiers ) then
				return;
			elseif ( IsShiftKeyDown() and not ignoreModifiers ) then
                BuyEmAll_ChooseAmount(this)
			else
				BuyMerchantItem(this:GetID());
			end
		end
	else
		-- Is buyback item
		BuybackItem(this:GetID());
	end
end




function BuyEmAll_ChooseAmount(this)
    local name, _, price, quantity, numAvailable = GetMerchantItemInfo(this:GetID());
    if not name or numAvailable == 0 then
        return
    elseif numAvailable == 1 then
        MerchantItemButton_OnClick("LeftButton", 1)
        return
    end
    local _,_,itemString = string.find(GetMerchantItemLink(this:GetID()), "|H(.-)|h")
    _,_,_,_,_,_,this.stackSize = GetItemInfo(itemString)
    this.presetStack = quantity

    local bagMax = math.floor(BuyEmAll_FreeSpace(name, this.stackSize) / quantity) * quantity
    local moneyMax = math.floor(GetMoney() / price) * quantity
    local maxPurchase = math.min(bagMax, moneyMax)
    if numAvailable > 0 then maxPurchase = math.min(maxPurchase, numAvailable * quantity) end

    OpenStackSplitFrame(maxPurchase, this, "BOTTOMLEFT", "TOPLEFT");
end




function BuyEmAll_FreeSpace(name, stackSize)
    local freeSpace = 0
    
	for theBag = 0,4 do
		local numSlot = GetContainerNumSlots(theBag);
		for theSlot = 1, numSlot do
			local itemLink = GetContainerItemLink(theBag, theSlot);
			if not itemLink then
				freeSpace = freeSpace + stackSize;
			elseif string.find(itemLink, "%["..name.."%]") then
                local _,itemCount = GetContainerItemInfo(theBag, theSlot)
                freeSpace = freeSpace + stackSize - itemCount
            end
		end
	end
    
    return freeSpace
end




function BuyEmAll_SplitStack(button, amount)
    if (amount > 0) then
        amount = math.ceil(amount/button.presetStack) * button.presetStack
        local params = { button = button, amount = amount }
        if amount > button.stackSize then
            local dialog = StaticPopup_Show("BUYEMALL_CONFIRM", amount)
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
