Macro {
    description = "VSCode.ShiftCtrlK (Delete line)",
    area = "Editor",
    key = "CtrlShiftK",
    flags = "NoSendKeysToPlugins",
    action = function()
        local Flgs = far.Flags
        local Edtr = editor
        local Info = Edtr.GetInfo()
        local ID = Info.EditorID

        Edtr.UndoRedo(ID, 0)
        if Info.BlockType == Flgs.BTYPE_NONE then
            Edtr.DeleteString(ID, Info.CurLine)
        else
            Edtr.DeleteBlock(ID)
            -- TODO: check when to delete
            Edtr.DeleteString(ID, Info.CurLine)
        end
        Edtr.UndoRedo(ID, 1)
    end
}
