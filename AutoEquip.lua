-- AutoEquip Addon for World of Warcraft
-- Automatically equips the best gear from bags based on item level, with special handling for same-named items

local ADDON_NAME = "AutoEquip"

-- Configuration
local MIN_RARITY = 2  -- Minimum rarity to consider (2 = Uncommon)
local NUM_BAGS = NUM_BAG_SLOTS or 4  -- Number of bags to scan

-- Slot definitions with equip locations
local SLOT_DEFINITIONS = {
    Head = { slot = "HeadSlot", equipLocs = { "INVTYPE_HEAD" } },
    Neck = { slot = "NeckSlot", equipLocs = { "INVTYPE_NECK" } },
    Shoulder = { slot = "ShoulderSlot", equipLocs = { "INVTYPE_SHOULDER" } },
    Back = { slot = "BackSlot", equipLocs = { "INVTYPE_CLOAK" } },
    Chest = { slot = "ChestSlot", equipLocs = { "INVTYPE_CHEST" } },
    Wrist = { slot = "WristSlot", equipLocs = { "INVTYPE_WRIST" } },
    Waist = { slot = "WaistSlot", equipLocs = { "INVTYPE_WAIST" } },
    Legs = { slot = "LegsSlot", equipLocs = { "INVTYPE_LEGS" } },
    Feet = { slot = "FeetSlot", equipLocs = { "INVTYPE_FEET" } },
    Hands = { slot = "HandsSlot", equipLocs = { "INVTYPE_HAND" } },
    MainHand = { slot = "MainHandSlot", equipLocs = { "INVTYPE_WEAPONMAINHAND", "INVTYPE_2HWEAPON" } },
    SecondaryHand = { slot = "SecondaryHandSlot", equipLocs = { "INVTYPE_WEAPONOFFHAND", "INVTYPE_SHIELD" } },
    Finger = { slots = { "Finger0Slot", "Finger1Slot" }, equipLocs = { "INVTYPE_FINGER" }, maxItems = 2, handleSameName = true },
    Trinket = { slots = { "Trinket0Slot", "Trinket1Slot" }, equipLocs = { "INVTYPE_TRINKET" }, maxItems = 2, handleSameName = true },
}

-- Utility functions
local function GetItemInfoSafe(itemLink)
    if not itemLink then return end
    local itemName, _, itemRarity, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
    local itemLevel = GetDetailedItemLevelInfo(itemLink)
    return itemName, itemRarity, itemLevel, itemEquipLoc
end

local function IsValidItem(itemLink)
    local _, itemRarity = GetItemInfoSafe(itemLink)
    return itemRarity and itemRarity >= MIN_RARITY
end

local function GetEquippedItem(slotKey)
    local slotID = GetInventorySlotInfo(slotKey)
    if not slotID then return end
    return GetInventoryItemLink("player", slotID)
end

local function EquipItem(itemLink)
    if not itemLink then return end
    EquipItemByName(itemLink)
    print(ADDON_NAME .. ": Equipped " .. itemLink)
end

local function CanEquipInSlot(itemEquipLoc, validEquipLocs)
    for _, loc in ipairs(validEquipLocs) do
        if itemEquipLoc == loc then
            return true
        end
    end
    return false
end

-- Find the best item in bags for a given slot, with special handling for same-named items
local function FindBestItemInBags(validEquipLocs, equippedItems, handleSameName)
    local candidates = {}

    for bag = 0, NUM_BAGS do
        local numSlots = C_Container.GetContainerNumSlots(bag)
        for slot = 1, numSlots do
            local itemLink = C_Container.GetContainerItemLink(bag, slot)
            if itemLink and IsValidItem(itemLink) then
                local itemName, _, itemLevel, itemEquipLoc = GetItemInfoSafe(itemLink)
                if itemLevel and CanEquipInSlot(itemEquipLoc, validEquipLocs) then
                    table.insert(candidates, { link = itemLink, name = itemName, level = itemLevel })
                end
            end
        end
    end

    if #candidates == 0 then return end

    -- Sort candidates by level descending
    table.sort(candidates, function(a, b) return a.level > b.level end)

    if not handleSameName then
        return candidates[1].link
    end

    -- Special handling for same-named items (e.g., Finger, Trinket)
    local equippedNames = {}
    for _, item in ipairs(equippedItems) do
        if item.link then
            local name = GetItemInfoSafe(item.link)
            if name then
                equippedNames[name] = (equippedNames[name] or 0) + 1
            end
        end
    end

    -- Prefer items with names not already equipped, or upgrade same-named items
    for _, candidate in ipairs(candidates) do
        local count = equippedNames[candidate.name] or 0
        if count < 2 then  -- Allow up to 2 of same name for dual slots
            return candidate.link
        end
    end

    -- If all slots have same-named items, upgrade the lowest level one
    return candidates[1].link
end

-- Equip best item for a single slot
local function EquipBestForSlot(slotDef)
    local validEquipLocs = slotDef.equipLocs

    if slotDef.slots then
        -- Multi-slot items (Finger, Trinket) with same-name handling
        local equippedItems = {}
        local hasEmptySlot = false
        for _, slotKey in ipairs(slotDef.slots) do
            local itemLink = GetEquippedItem(slotKey)
            if itemLink then
                local _, _, itemLevel = GetItemInfoSafe(itemLink)
                table.insert(equippedItems, { link = itemLink, level = itemLevel or 0 })
            else
                table.insert(equippedItems, { link = nil, level = 0 })
                hasEmptySlot = true
            end
        end

        local bestItem = FindBestItemInBags(validEquipLocs, equippedItems, slotDef.handleSameName)
        if not bestItem then return end

        local bestLevel = select(3, GetItemInfoSafe(bestItem)) or 0

        -- If there's an empty slot, equip the best item there
        if hasEmptySlot then
            EquipItem(bestItem)
            return
        end

        -- Otherwise, find the slot with the lowest level item and upgrade if better
        local lowestSlot = 1
        local lowestLevel = equippedItems[1].level
        for i = 2, #equippedItems do
            if equippedItems[i].level < lowestLevel then
                lowestSlot = i
                lowestLevel = equippedItems[i].level
            end
        end

        if bestLevel > lowestLevel then
            EquipItem(bestItem)
        end
    else
        -- Single slot items
        local currentItem = GetEquippedItem(slotDef.slot)
        local currentLevel = 0
        if currentItem then
            _, _, currentLevel = GetItemInfoSafe(currentItem)
            currentLevel = currentLevel or 0
        end

        -- If slot is empty, equip the best available item
        if not currentItem then
            local equippedItems = { { link = nil, level = 0 } }
            local bestItem = FindBestItemInBags(validEquipLocs, equippedItems, false)
            if bestItem then
                EquipItem(bestItem)
            end
            return
        end

        -- Otherwise, check if we can upgrade
        local equippedItems = { { link = currentItem, level = currentLevel } }
        local bestItem = FindBestItemInBags(validEquipLocs, equippedItems, false)
        if bestItem then
            local bestLevel = select(3, GetItemInfoSafe(bestItem)) or 0
            if bestLevel > currentLevel then
                EquipItem(bestItem)
            end
        end
    end
end

-- Main function to equip best gear
local function EquipBestGear()
    for _, slotDef in pairs(SLOT_DEFINITIONS) do
        EquipBestForSlot(slotDef)
    end
end

-- Event handling
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        EquipBestGear()
    elseif event == "BAG_UPDATE" then
        -- Debounce bag updates to avoid excessive calls
        C_Timer.After(0.5, EquipBestGear)
    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        -- Only equip if slot is relevant
        local slotID = ...
        for _, slotDef in pairs(SLOT_DEFINITIONS) do
            if slotDef.slot and GetInventorySlotInfo(slotDef.slot) == slotID then
                EquipBestForSlot(slotDef)
                break
            elseif slotDef.slots then
                for _, slotKey in ipairs(slotDef.slots) do
                    if GetInventorySlotInfo(slotKey) == slotID then
                        EquipBestForSlot(slotDef)
                        break
                    end
                end
            end
        end
    end
end)
