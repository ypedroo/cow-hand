--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:72c5cfb78ec38a6415c73130f3e9dc10:135a74a215799caa1c3b4710affd99ef:813687afa71bc74753037f9946530945$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- baddola
            x=71,
            y=1,
            width=32,
            height=20,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- check
            x=1,
            y=73,
            width=50,
            height=20,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 50,
            sourceHeight = 50
        },
        {
            -- dola
            x=71,
            y=23,
            width=32,
            height=16,

            sourceX = 0,
            sourceY = 7,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- golpe
            x=1,
            y=1,
            width=68,
            height=70,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- gorgoyle
            x=71,
            y=41,
            width=18,
            height=20,

            sourceX = 16,
            sourceY = 14,
            sourceWidth = 50,
            sourceHeight = 50
        },
        {
            -- jackpot
            x=53,
            y=73,
            width=40,
            height=44,

        },
        {
            -- medkit
            x=1,
            y=95,
            width=32,
            height=22,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 32,
            sourceHeight = 32
        },
    },

    sheetContentWidth = 104,
    sheetContentHeight = 118
}

SheetInfo.frameIndex =
{

    ["baddola"] = 1,
    ["check"] = 2,
    ["dola"] = 3,
    ["golpe"] = 4,
    ["gorgoyle"] = 5,
    ["jackpot"] = 6,
    ["medkit"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
