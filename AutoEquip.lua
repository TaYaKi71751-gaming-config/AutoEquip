local slots = {"Head", "Neck", "Shoulder", "Back", "Chest", "Shirt", "Tabard", "Wrist", "Waist", "Legs", "Feet", "Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "MainHand", "SecondaryHand"}

-- Function to get item level of a specific item (either equipped or in the bag)
local function GetItemLevel(itemLink)
    if itemLink then
					   local itemLevel = GetDetailedItemLevelInfo(itemLink)
        return itemLevel
    end
    return nil
end

-- Function to equip a better item based on item level comparison
local function EquipBestGear()
    -- Loop through each equipment slot
    for _, slotName in ipairs(slots) do
        local slotID = GetInventorySlotInfo(slotName.."Slot") -- Get the ID for the specific equipment slot
        local itemLink = GetInventoryItemLink("player", slotID) -- Get the item link for the equipped item in that slot

        -- If the slot has an item equipped
        if itemLink then
            local currentItemLevel = GetItemLevel(itemLink)
            
            -- Check all items in the player's bags to see if any item has a higher item level
            for bag = 0, 4 do
                for slotInBag = 1, C_Container.GetContainerNumSlots(bag) do
                    local bagItemLink = C_Container.GetContainerItemLink(bag, slotInBag)  -- Get the item link from the bag slot
                    
                    -- Check if the bag slot has an item and get the item level if valid
                    if bagItemLink then
                        local bagItemLevel = GetItemLevel(bagItemLink)
                        
                        -- If the bag item has a higher item level, equip it
                        if bagItemLevel and bagItemLevel > currentItemLevel then
                            EquipItemByName(bagItemLink)  -- Equip the better item from the bag
																											 print("AutoEquip: Equipped " .. bagItemLink .. " (Item level: " .. bagItemLevel .. ")" .. "Before:" .. itemLink .. "(" .. currentItemLevel .. ")")
                            return -- Stop after equipping the better item (don't look for other upgrades)
                        end
                    end
                end
            end
        end
    end
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
