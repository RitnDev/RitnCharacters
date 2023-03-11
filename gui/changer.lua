local libGuiElement = require(ritnlib.defines.class.gui.element)
local captions = ritnlib.defines.characters.names.caption.frame_changer


local function getElement(gui_name)
    return {
        flow = {
            current = libGuiElement(gui_name,"flow","current"):horizontal():get(),
            selecter = libGuiElement(gui_name,"flow","selecter"):vertical():get(),
            dialog = libGuiElement(gui_name,"flow","dialog"):horizontal():get(),
        },
        frame = {
            main = libGuiElement(gui_name,"frame","main"):caption(captions.titre):get(),
            submain = libGuiElement(gui_name,"frame","submain"):vertical():style("inside_shallow_frame"):get(),
        },
        label = {
            current = libGuiElement(gui_name,"label","current"):caption(captions.button_select):get(),
        },
        button = {
            select = libGuiElement(gui_name,"button","select"):style("confirm_button"):caption(captions.button_select):get(),
        },
        line = libGuiElement(gui_name,"line","line"):horizontal():get(),
        list = libGuiElement(gui_name,"list-box","characters"):get(),
    }
end


local function getContent()
    return {
        flow = {
            current = {
                "frame-main",
                "frame-submain",
                "flow-current",
            },
            selecter = {
                "frame-main",
                "frame-submain",
                "flow-selecter",
            },
            dialog = {
                "frame-main",
                "frame-submain",
                "flow-selecter",
                "flow-dialog",
            },
        },
        frame = {
            main = {"frame-main"},
            submain = {
                "frame-main",
                "frame-submain",
            },
        },
        label = {
            current = {
                "frame-main",
                "frame-submain",
                "flow-current",
                "label-current",
            },
        },
        button = {
            select = {
                "frame-main",
                "frame-submain",
                "flow-selecter",
                "flow-dialog",
                "button-select",
            },
        },
        list = {
            "frame-main",
            "frame-submain",
            "flow-selecter",
            "listbox-characters",
        },
    }
end


-----------------------------------------
return {
    getElement = getElement,
    getContent = getContent,
}