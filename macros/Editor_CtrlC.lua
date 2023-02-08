Macro {
    description = "VSCode.CtrlC` (Copy line)",
    area = "Editor",
    key = "CtrlC",
    flags = "NoSendKeysToPlugins",
    action = function()
        local Flgs = far.Flags
        local Edtr = editor
        local Info = Edtr.GetInfo()
        local ID = Info.EditorID

        local function GetSelectionBounds(sel)
            if sel then
                sel.BlockStartLine = sel.StartLine
                sel.BlockStartPos = sel.BlockType == Flgs.BTYPE_COLUMN and
                                        (Edtr.RealToTab(ID, sel.StartLine, sel.StartPos)) or (sel.StartPos)
                sel.BlockWidth = sel.BlockType == Flgs.BTYPE_COLUMN and
                                     (Edtr.RealToTab(ID, sel.EndLine, sel.EndPos) - sel.BlockStartPos + 1) or
                                     (sel.EndPos - sel.StartPos + 1)
                sel.BlockHeight = sel.EndLine - sel.StartLine + 1
            end
            return sel
        end

        Edtr.UndoRedo(ID, 0)
        if Info.BlockType == Flgs.BTYPE_NONE then
            local lineStr = Edtr.GetString(ID, Info.CurLine, 3)
            far.CopyToClipboard(lineStr)
        else
            local selBounds = GetSelectionBounds(Edtr.GetSelection())
            local blockString = ""
            for i = selBounds.BlockStartLine, selBounds.BlockStartLine + selBounds.BlockHeight - 1 do
                local lineString = Edtr.GetString(ID, i, 3)
                if selBounds.BlockHeight == 1 then
                    lineString = lineString:sub(selBounds.BlockStartPos,
                        selBounds.BlockStartPos + selBounds.BlockWidth - 1)
                elseif i == selBounds.BlockStartLine then
                    lineString = lineString:sub(selBounds.BlockStartPos, -1)
                elseif i == selBounds.BlockStartLine + selBounds.BlockHeight - 1 then
                    lineString = lineString:sub(1, selBounds.BlockStartPos + selBounds.BlockWidth - 1)
                end
                blockString = blockString .. lineString
                if i ~= selBounds.BlockStartLine + selBounds.BlockHeight - 1 then
                    blockString = blockString .. "\n"
                end
            end
            far.CopyToClipboard(blockString)
        end
        Edtr.UndoRedo(ID, 1)
    end
}
