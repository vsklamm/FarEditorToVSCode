Macro {
    description = "VSCode.CtrlX (Cut line)",
    area = "Editor",
    key = "CtrlX",
    flags = "NoSendKeysToPlugins",
    action = function()
        local Flgs = far.Flags
        local Edtr = editor
        local Info = Edtr.GetInfo()
        local ID = Info.EditorID

        Edtr.UndoRedo(ID, 0)
        Keys("CtrlC")
        if Info.BlockType == Flgs.BTYPE_NONE then
            Edtr.DeleteString(ID, Info.CurLine)
        else
            Edtr.DeleteBlock(ID)
        end
        Edtr.UndoRedo(ID, 1)
    end
}
