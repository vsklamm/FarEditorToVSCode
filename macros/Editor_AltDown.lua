Macro {
    description = "VSCode.AltDown (Move line down)",
    area = "Editor",
    key = "AltDown",
    flags = "NoSendKeysToPlugins",
    action = function()
        local Edtr = editor
        local Info = Edtr.GetInfo()
        local ID = Info.EditorID

        local colmNum = Info.CurPos
        local lineNum = Info.CurLine

        if Info.TotalLines < lineNum + 1 then
            return
        end
        local lineCurr = Edtr.GetString(ID, lineNum, 3)
        local lineNext = Edtr.GetString(ID, lineNum + 1, 3)

        Edtr.UndoRedo(ID, 0)
        Edtr.SetString(ID, lineNum + 1, lineCurr)
        Edtr.SetString(ID, lineNum, lineNext)
        Edtr.SetPosition(ID, lineNum + 1, colmNum)
        Edtr.UndoRedo(ID, 1)
    end
}
