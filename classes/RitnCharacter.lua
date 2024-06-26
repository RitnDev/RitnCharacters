-- RitnCharacter
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
RitnCharacter = ritnlib.classFactory.newclass(RitnLibPlayer, function(self, LuaPlayer)
    RitnLibPlayer.init(self, LuaPlayer)
    self.object_name = "RitnCharacter"
    ----
    local players = remote.call("RitnCoreGame", "get_players")
    self.data = players[self.index]
    ----
    local options = remote.call("RitnCoreGame", "get_options")
    self.characters = options.characters
    --------------------------------------------------
end)

----------------------------------------------------------------


function RitnCharacter:change(index_character)
    if index_character == 0 then return self end
    local inventories = {}
    local rInventory = RitnLibInventory(self.player, inventories)
    rInventory:save(true)
    ----
    local data_character = {}
    data_character.character_additional_mining_categories = self.character.character_additional_mining_categories
    data_character.character_build_distance_bonus = self.character.character_build_distance_bonus
    data_character.character_crafting_speed_modifier = self.character.character_crafting_speed_modifier
    data_character.character_health_bonus = self.character.character_health_bonus
    data_character.character_inventory_slots_bonus = self.character.character_inventory_slots_bonus
    data_character.character_item_drop_distance_bonus = self.character.character_item_drop_distance_bonus
    data_character.character_loot_pickup_distance_bonus = self.character.character_loot_pickup_distance_bonus
    data_character.character_maximum_following_robot_count_bonus = self.character.character_maximum_following_robot_count_bonus
    data_character.character_mining_speed_modifier = self.character.character_mining_speed_modifier
    data_character.character_personal_logistic_requests_enabled = self.character.character_personal_logistic_requests_enabled
    data_character.character_reach_distance_bonus = self.character.character_reach_distance_bonus
    data_character.character_resource_reach_distance_bonus = self.character.character_resource_reach_distance_bonus
    data_character.character_running_speed_modifier = self.character.character_running_speed_modifier
    data_character.character_trash_slot_count_bonus = self.character.character_trash_slot_count_bonus
    ----
    self:destroy()
    self.player.create_character(self.characters[index_character].skin)
    ----
    self.player.character.character_additional_mining_categories = data_character.character_additional_mining_categories
    self.player.character.character_build_distance_bonus = data_character.character_build_distance_bonus
    self.player.character.character_crafting_speed_modifier = data_character.character_crafting_speed_modifier
    self.player.character.character_health_bonus = data_character.character_health_bonus
    self.player.character.character_inventory_slots_bonus = data_character.character_inventory_slots_bonus
    self.player.character.character_item_drop_distance_bonus = data_character.character_item_drop_distance_bonus
    self.player.character.character_loot_pickup_distance_bonus = data_character.character_loot_pickup_distance_bonus
    self.player.character.character_maximum_following_robot_count_bonus = data_character.character_maximum_following_robot_count_bonus
    self.player.character.character_mining_speed_modifier = data_character.character_mining_speed_modifier
    self.player.character.character_personal_logistic_requests_enabled = data_character.character_personal_logistic_requests_enabled
    self.player.character.character_reach_distance_bonus = data_character.character_reach_distance_bonus
    self.player.character.character_resource_reach_distance_bonus = data_character.character_resource_reach_distance_bonus
    self.player.character.character_running_speed_modifier = data_character.character_running_speed_modifier
    self.player.character.character_trash_slot_count_bonus = data_character.character_trash_slot_count_bonus
    ----
    rInventory:load(true)
    ----
    self.data.character = {
        index = index_character,
        name = self.characters[index_character].name,
        skin = self.characters[index_character].skin,
    }
    self:update()
end



function RitnCharacter:destroy()
    pcall(function() self.character.destroy() end)
    return self
end



function RitnCharacter:set(character)
    self.data.character = character
    self:update()
    return self
end



function RitnCharacter:get()
    return self.data.character
end



function RitnCharacter:check()
    if self.character then
        if self.character.name ~= self:get() then
            self:change(self.data.character.index)
        end
    end
end



function RitnCharacter:update()
    local players = remote.call("RitnCoreGame", "get_players")
    players[self.index] = self.data
    remote.call("RitnCoreGame", "set_players", players)

    return self
end

----------------------------------------------------------------
--return RitnCharacter