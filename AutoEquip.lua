local slots = { "Head", "Neck", "Shoulder", "Back", "Chest", "Shirt", "Wrist", "Waist", "Legs", "Feet", "Hands",
    "Finger0", "Finger1", "Trinket0", "Trinket1", "MainHand", "SecondaryHand" }

-- Function to get item level of a specific item (either equipped or in the bag)
local function GetItemLevel(itemLink)
    if itemLink then
        local itemLevel = GetDetailedItemLevelInfo(itemLink)
        return itemLevel
    end
    return nil
end
local function GetItemEquipLoc(itemLink)
    if itemLink then
        local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
        return itemEquipLoc
    end
end
local function GetItemName(itemLink)
    if itemLink then
        local itemName = GetItemInfo(itemLink)
        return itemName
    end
end
local function GetItemRarity(itemLink)
    if itemLink then
        local _, _, itemRarity = GetItemInfo(itemLink)
        return itemRarity
    end
end

local function EquipItemByNameWithPrint(itemLink)
    if itemLink then
        EquipItemByName(itemLink)
        print("AutoEquip: Equipped item: " .. itemLink)
    end
end

local function EquipBestHead()
    -- Placeholder for future head-specific logic if needed
    local slotID = GetInventorySlotInfo("HeadSlot")
    local headItemLink = GetInventoryItemLink("player", slotID)
    local headItemLevel = nil
    if headItemLink then
        headItemLevel = GetItemLevel(headItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_HEAD" and bagItemRarity > 1 then
                    if headItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > headItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestNeck()
    -- Placeholder for future neck-specific logic if needed
    local slotID = GetInventorySlotInfo("NeckSlot")
    local neckItemLink = GetInventoryItemLink("player", slotID)
    local neckItemLevel = nil
    if neckItemLink then
        neckItemLevel = GetItemLevel(neckItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_NECK" and bagItemRarity > 1 then
                    if neckItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > neckItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestShoulder()
    -- Placeholder for future shoulder-specific logic if needed
    local slotID = GetInventorySlotInfo("ShoulderSlot")
    local slotID = GetInventoryItemLink("player", slotID)
    local shoulderItemLink = GetInventoryItemLink("player", slotID)
    local shoulderItemLevel = nil
    if shoulderItemLink then
        shoulderItemLevel = GetItemLevel(shoulderItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_SHOULDER" and bagItemRarity > 1 then
                    if shoulderItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > shoulderItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestBack()
    -- Placeholder for future back-specific logic if needed
    local slotID = GetInventorySlotInfo("BackSlot")
    local backItemLink = GetInventoryItemLink("player", slotID)
    local backItemLevel = nil
    if backItemLink then
        backItemLevel = GetItemLevel(backItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_CLOAK" and bagItemRarity > 1 then
                    if backItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > backItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestChest()
    -- Placeholder for future chest-specific logic if needed
    local slotID = GetInventorySlotInfo("ChestSlot")
    local chestItemLink = GetInventoryItemLink("player", slotID)
    local chestItemLevel = nil
    if chestItemLink then
        chestItemLevel = GetItemLevel(chestItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_CHEST" and bagItemRarity > 1 then
                    if chestItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > chestItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestWrist()
    -- Placeholder for future wrist-specific logic if needed
    local slotID = GetInventorySlotInfo("WristSlot")
    local wristItemLink = GetInventoryItemLink("player", slotID)
    local wristItemLevel = nil
    if wristItemLink then
        wristItemLevel = GetItemLevel(wristItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_WRIST" and bagItemRarity > 1 then
                    if wristItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > wristItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestWaist()
    -- Placeholder for future waist-specific logic if needed
    local slotID = GetInventorySlotInfo("WaistSlot")
    local waistItemLink = GetInventoryItemLink("player", slotID)
    local waistItemLevel = nil
    if waistItemLink then
        waistItemLevel = GetItemLevel(waistItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_WAIST" and bagItemRarity > 1 then
                    if waistItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > waistItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestLegs()
    -- Placeholder for future legs-specific logic if needed
    local slotID = GetInventorySlotInfo("LegsSlot")
    local legsItemLink = GetInventoryItemLink("player", slotID)
    local legsItemLevel = nil
    if legsItemLink then
        legsItemLevel = GetItemLevel(legsItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_LEGS" and bagItemRarity > 1 then
                    if legsItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > legsItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestFeet()
    -- Placeholder for future feet-specific logic if needed
    local slotID = GetInventorySlotInfo("FeetSlot")
    local feetItemLink = GetInventoryItemLink("player", slotID)
    local feetItemLevel = nil
    if feetItemLink then
        feetItemLevel = GetItemLevel(feetItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_FEET" and bagItemRarity > 1 then
                    if feetItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > feetItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestHands()
    -- Placeholder for future hands-specific logic if needed
    local slotID = GetInventorySlotInfo("HandsSlot")
    local handsItemLink = GetInventoryItemLink("player", slotID)
    local handsItemLevel = nil
    if handsItemLink then
        handsItemLevel = GetItemLevel(handsItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_HAND" and bagItemRarity > 1 then
                    if handsItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > handsItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestFinger()
    -- Placeholder for future finger-specific logic if needed
    local finger0SlotID = GetInventorySlotInfo("Finger0Slot")
    local finger0ItemLink = GetInventoryItemLink("player", finger0SlotID)
    local finger0ItemName = nil
    local finger0ItemLevel = nil
    if finger0ItemLink then
        finger0ItemName = GetItemName(finger0ItemLink)
        finger0ItemLevel = GetItemLevel(finger0ItemLink)
    end
    local finger1SlotID = GetInventorySlotInfo("Finger1Slot")
    local finger1ItemLink = GetInventoryItemLink("player", finger1SlotID)
    local finger1ItemName = nil
    local finger1ItemLevel = nil
    if finger1ItemLink then
        finger1ItemName = GetItemName(finger1ItemLink)
        finger1ItemLevel = GetItemLevel(finger1ItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                local bagItemName = GetItemName(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_FINGER" and bagItemRarity > 1 then
                    if finger0ItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    elseif finger1ItemLink == nil then
                        if finger0ItemName == bagItemName then
                            if finger0ItemLevel < bagItemLevel then
                                EquipItemByNameWithPrint(bagItemLink)
                                return
                            end
                        else
                            EquipItemByNameWithPrint(bagItemLink)
                            return
                        end
                    elseif finger1ItemLink and finger1ItemName == bagItemName then
                        if finger1ItemLevel < bagItemLevel then
                            EquipItemByNameWithPrint(bagItemLink)
                            return
                        else
                            return
                        end
                    end
                    if bagItemLevel > finger0ItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    elseif bagItemLevel > finger1ItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestTrinket()
    -- Placeholder for future trinket-specific logic if needed
    local trinket0SlotID = GetInventorySlotInfo("Trinket0Slot")
    local trinket0ItemLink = GetInventoryItemLink("player", trinket0SlotID)
    local trinket0ItemLevel = nil
    local trinket0ItemName = nil
    if trinket0ItemLink then
        trinket0ItemLevel = GetItemLevel(trinket0ItemLink)
        trinket0ItemName = GetItemName(trinket0ItemLink)
    end
    local trinket1SlotID = GetInventorySlotInfo("Trinket1Slot")
    local trinket1ItemLink = GetInventoryItemLink("player", trinket1SlotID)
    local trinket1ItemLevel = nil
    local trinket1ItemName = nil
    if trinket1ItemLink then
        trinket1ItemLevel = GetItemLevel(trinket1ItemLink)
        trinket1ItemName = GetItemName(trinket1ItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                local bagItemRarity = GetItemRarity(bagItemLink)
                local bagItemName = GetItemName(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_TRINKET" and bagItemRarity > 1 then
                    if trinket0ItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    elseif trinket1ItemLink == nil then
                        if trinket0ItemName == bagItemName then
                            if trinket0ItemLevel < bagItemLevel then
                                EquipItemByNameWithPrint(bagItemLink)
                                return
                            end
                        end
                    elseif trinket1ItemLink and trinket1ItemName == bagItemName then
                        if trinket1ItemName < bagItemLevel then
                            EquipItemByNameWithPrint(bagItemLink)
                            return
                        else
                            return
                        end
                    end

                    if bagItemLevel > trinket0ItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    elseif bagItemLevel > trinket1ItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestMainHand()
    -- Placeholder for future main hand-specific logic if needed
    local mainHandItemLink = GetInventorySlotInfo("MainHandSlot")
    local mainHandItemLevel = nil
    if mainHandItemLink then
        mainHandItemLevel = GetItemLevel(mainHandItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_WEAPONMAINHAND" or bagItemEquipLoc == "INVTYPE_2HWEAPON" then
                    if mainHandItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > mainHandItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

local function EquipBestSecondaryHand()
    -- Placeholder for future off hand-specific logic if needed
    local offHandItemLink = GetInventorySlotInfo("SecondaryHandSlot")
    local offHandItemLevel = nil
    if offHandItemLink then
        offHandItemLevel = GetItemLevel(offHandItemLink)
    end
    for bag = 0, 4 do
        for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
            local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)
            if bagItemLink then
                local bagItemLevel = GetItemLevel(bagItemLink)
                local bagItemEquipLoc = GetItemEquipLoc(bagItemLink)
                if bagItemEquipLoc == "INVTYPE_WEAPONOFFHAND" or bagItemEquipLoc == "INVTYPE_SHIELD" then
                    if offHandItemLink == nil then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                    if bagItemLevel > offHandItemLevel then
                        EquipItemByNameWithPrint(bagItemLink)
                        return
                    end
                end
            end
        end
    end
end

-- Function to equip a better item based on item level comparison
local function EquipBestGear()
    EquipBestHead()
    EquipBestNeck()
    EquipBestShoulder()
    EquipBestBack()
    EquipBestChest()
    EquipBestWrist()
    EquipBestWaist()
    EquipBestLegs()
    EquipBestFeet()
    EquipBestHands()
    EquipBestFinger()
    EquipBestTrinket()
    EquipBestMainHand()
    EquipBestSecondaryHand()
    -- Additional slot-specific functions can be added here
end

-- Create a frame to listen for the events
local frame = CreateFrame("Frame")

-- Register for the relevant events
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

-- Set the event handler function
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        -- When the player logs in, check if any better gear is available and equip it
        EquipBestGear()
    elseif event == "BAG_UPDATE" then
        -- When the bag is updated (e.g., after looting), recheck and equip any better gear
        EquipBestGear()
    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        -- When the equipment changes, recheck and equip any better gear
        EquipBestGear()
    end
end)
