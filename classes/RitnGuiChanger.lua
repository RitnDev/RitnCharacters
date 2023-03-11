-- RitnGuiChanger
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local libStyle = require(ritnlib.defines.class.gui.style)
local libGui = require(ritnlib.defines.class.luaClass.gui)
----------------------------------------------------------------
local font = ritnlib.defines.names.font
local fGui = require(ritnlib.defines.characters.gui.changer)
local RitnCharacter = require(ritnlib.defines.characters.class.character)
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnGuiChanger = class.newclass(libGui, function(base, event)
    libGui.init(base, event, ritnlib.defines.characters.name, "frame-main")
    base.object_name = "RitnGuiChanger"
    base.shortcut = event.prototype_name
    --------------------------------------------------
    base.gui_name = "changer"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.characters.gui_actions.changer.open] = true,
            [ritnlib.defines.characters.gui_actions.changer.close] = true,
            [ritnlib.defines.characters.gui_actions.changer.select] = true,
        }
    }    
    --------------------------------------------------
    base.gui = { base.player.gui.center }
    --------------------------------------------------
    base.content = fGui.getContent()
    --------------------------------------------------
end)

----------------------------------------------------------------


function RitnGuiChanger:create()
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end
    local character = RitnCharacter(self.player):get()
    local selecter = character.index
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
    libStyle(content.frame.main):padding(4)
    libStyle(content.frame.submain):padding(4):stretchable()
    libStyle(content.flow.current):padding(4)
    libStyle(content.label.current):font(font.bold18):width(230)
    libStyle(content.flow.selecter):padding(4):stretchable()
    libStyle(content.list):horizontalStretch():maxHeight(500)
    libStyle(content.flow.dialog):horizontalStretch():topPadding(4):align("right")
    libStyle(content.button.select):height(30)


    local options = remote.call("RitnCoreGame", "get_options")

    for _,item in pairs(options.characters) do 
        content.list.add_item(item.name)
    end
    content.list.selected_index = selecter

    return self
end

----------------------------------------------------------------

function RitnGuiChanger:on_lua_shortcut()   
    if self.shortcut == "ritnmods-characters-menu" then 
        self:action_open()
    end
    return self
end

----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnGuiChanger:action_close()   
    local frame = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame then frame.destroy() end
    if self.character then 
        self.player.character.active = true
    end
    log('> '..self.object_name..':action_close()')
    return self
end

function RitnGuiChanger:action_open()
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

function RitnGuiChanger:action_select() 
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
return RitnGuiChanger