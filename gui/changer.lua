--------------------------------------------------------------------------------
local captions = ritnlib.defines.characters.names.caption.frame_changer
--------------------------------------------------------------------------------

local function getElement(gui_name)
    return {
        flow = {
            current = RitnLibGuiElement(gui_name,"flow","current"):horizontal():get(),
            selecter = RitnLibGuiElement(gui_name,"flow","selecter"):vertical():get(),
            dialog = RitnLibGuiElement(gui_name,"flow","dialog"):horizontal():get(),
        },
        frame = {
            main = RitnLibGuiElement(gui_name,"frame","main"):caption(captions.titre):get(),
            submain = RitnLibGuiElement(gui_name,"frame","submain"):vertical():style("inside_shallow_frame"):get(),
        },
        label = {
            current = RitnLibGuiElement(gui_name,"label","current"):caption(captions.button_select):get(),
        },
        button = {
            select = RitnLibGuiElement(gui_name,"button","select"):style("confirm_button"):caption(captions.button_select):get(),
        },
        line = RitnLibGuiElement(gui_name,"line","line"):horizontal():get(),
        list = RitnLibGuiElement(gui_name,"list-box","characters"):get(),
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