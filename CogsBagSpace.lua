function CogsFreeBagSpace(itemID)
	local freeSpace = 0
	local itemSubType = GetItemFamily(itemID)
	local stackSize = select(8, GetItemInfo(itemID))
	
	for theBag = 0,4 do
		local which, doBag = "freeSpace", true
		
		if theBag > 0 then -- 0 is always the backpack
			local bagLink = GetInventoryItemLink("player", 19 + theBag) -- Bag #1 is in inventory slot 20
			if bagLink then
				local bagSubType = GetItemFamily(bagLink)
				if bagSubType == itemSubType then
					doBag = true
				elseif bagSubType == 0 then
					doBag = true
				else doBag = false
				end
			else
				doBag = false
			end
		end
		
		if doBag then
			local numSlot = GetContainerNumSlots(theBag)
			for theSlot = 1, numSlot do
				local itemLink = GetContainerItemLink(theBag, theSlot)
				if not itemLink then
					freeSpace = freeSpace + stackSize
				elseif strfind(itemLink, "item:"..itemID..":") then
					local _,itemCount = GetContainerItemInfo(theBag, theSlot)
					freeSpace = freeSpace + stackSize - itemCount
				end
			end
		end
	end
	return freeSpace, stackSize
end
