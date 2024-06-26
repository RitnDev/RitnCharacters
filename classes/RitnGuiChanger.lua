-- RitnGuiCharacterChanger
----------------------------------------------------------------
local font = ritnlib.defines.names.font
local fGui = require(ritnlib.defines.characters.gui.changer)
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
RitnGuiCharacterChanger = ritnlib.classFactory.newclass(RitnLibGui, function(self, event)
    RitnLibGui.init(self, event, ritnlib.defines.characters.name, "frame-main")
    self.object_name = "RitnGuiCharacterChanger"
    self.shortcut = event.prototype_name
    --------------------------------------------------
    self.gui_name = "changer"
    self.gui_action = {
        [self.gui_name] = {
            [ritnlib.defines.characters.gui_actions.changer.open] = true,
            [ritnlib.defines.characters.gui_actions.changer.close] = true,
            [ritnlib.defines.characters.gui_actions.changer.select] = true,
        }
    }    
    --------------------------------------------------
    self.gui = { self.player.gui.center }
    --------------------------------------------------
    self.content = fGui.getContent()
    --------------------------------------------------
end)

----------------------------------------------------------------


function RitnGuiCharacterChanger:create()
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end
    log("> "..self.object_name..":create()")
    local selecter = 0 
    local character = RitnCharacter(self.player):get()
    if character == nil then 
        log("> "..self.object_name..":create() -> not character (player)")
        character = {
            index = 0,
            name = {"character-name.none"},
            skin = "character",
        }
    end
    selecter = character.index
    if selecter == 0 then selecter = 1 end

    local element = fGui.getElement(self.gui_name)

    -- assembly gui elements
    local content = {
        flow = {},
        frame = {},
        label = {},
        button = {},
    }


    -- frame Teleporter
    content.frame.main =            self.gui[1].add(element.frame.main)
    content.frame.submain =         content.frame.main.add(element.frame.submain)
    -- flow namer
    content.flow.current =          content.frame.submain.add(element.flow.current)
    -- label namer
    content.label.current =         content.flow.current.add(element.label.current)
    -- line 
    content.line =                  content.frame.submain.add(element.line)
    -- flow teleport
    content.flow.selecter =         content.frame.submain.add(element.flow.selecter)
    -- list surfaces
    content.list =                  content.flow.selecter.add(element.list)
    -- flow dialog
    content.flow.dialog =           content.flow.selecter.add(element.flow.dialog)
    -- button request
    content.button.select =         content.flow.dialog.add(element.button.select)
 

    -- styles guiElement
    content.label.current.caption = {"frame-changer.label-current", character.name}
    ----
    RitnLibStyle(content.frame.main):padding(4)
    RitnLibStyle(content.frame.submain):padding(4):stretchable()
    RitnLibStyle(content.flow.current):padding(4)
    RitnLibStyle(content.label.current):font(font.bold18):width(230)
    RitnLibStyle(content.flow.selecter):padding(4):stretchable()
    RitnLibStyle(content.list):horizontalStretch():maxHeight(500)
    RitnLibStyle(content.flow.dialog):horizontalStretch():topPadding(4):align("right")
    RitnLibStyle(content.button.select):height(30)


    local options = remote.call("RitnCoreGame", "get_options")

    for _,item in pairs(options.characters) do 
        content.list.add_item(item.name)
    end
    content.list.selected_index = selecter

    return self
end

----------------------------------------------------------------

function RitnGuiCharacterChanger:on_lua_shortcut()   
    if self.shortcut == "ritnmods-characters-menu" then 
        log("> "..self.object_name..":on_lua_shortcut()")
        self:action_open()
    end
    return self
end

----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnGuiCharacterChanger:action_close()   
    local frame = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame then frame.destroy() end
    if self.character then 
        self.player.character.active = true
    end
    log('> '..self.object_name..':action_close()')
    return self
end

function RitnGuiCharacterChanger:action_open()
    self:action_close()
    if self.controller_name ~= "character" then 
        self.player.print({'msg.no-character', self.controller_name})
        return 
    end
    if self.character then 
        self.player.character.active = false
    end
    self:create()
    log('> '..self.object_name..':action_open()')
    return self
end

function RitnGuiCharacterChanger:action_select() 
    local list = self:getElement("list")
    ----
    local selected_index = list.selected_index
    ----
    if selected_index == 0 then return self end
    ----
    local item_select = list.get_item(selected_index)
    RitnCharacter(self.player):change(selected_index)
    ----
    self:action_close()
    ----
    log('> '..self.object_name..':action_select()')
    return self
end



----------------------------------------------------------------
--return RitnGuiCharacterChanger