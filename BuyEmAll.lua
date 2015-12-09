--[[ BuyEmAll - By Cogwheel v1.0 - See readme.txt

Allows you to buy more than the stack size of an item from a vendor at once. ]]


local OldOpenStackSplitFrame = OpenStackSplitFrame

function OpenStackSplitFrame(maxStack, parent, anchor, anchorTo)
	if string.find(parent:GetName(), "^MerchantItem.-ItemButton$") then
		BuyEmAll_trueMax = maxStack
		maxStack = 10000
	end

	return OldOpenStackSplitFrame(maxStack, parent, anchor, anchorTo)
end

function BuyEmAll_OnLoad()
	StaticPopupDialogs["BUYEMALL_CONFIRM"] = {
		text = "Are you sure you want to buy %d of this item?",
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = BuyEmAll_OnAccept,
		timeout = 0,
		hideOnEscape = true
	}
	
	for i=1,12 do
		getglobal("MerchantItem"..i.."ItemButton").SplitStack = function(button, split)
			if (split > 0) then
				if split > BuyEmAll_trueMax then
					local dialog = StaticPopup_Show("BUYEMALL_CONFIRM", split)
					dialog.data = { button = button, amount = split }
				else
					BuyMerchantItem(button:GetID(), split);
				end
			end
		end
	end
end

function BuyEmAll_OnAccept(params)
	for i=1,math.floor(params.amount / BuyEmAll_trueMax) do
		BuyMerchantItem(params.button:GetID(), BuyEmAll.trueMax)
	end
	local leftover = math.mod(params.amount, BuyEmAll_trueMax)
	if leftover then BuyMerchantItem(params.button:GetID(), leftover) end
end
