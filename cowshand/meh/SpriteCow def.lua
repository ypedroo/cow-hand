--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:df67a062454244aabb508e84638d184a:40306194e56054fafc7214b2fb5fdf73:b1acc1d9595361f1c809f092219cbea6$
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
            -- VACA1
            x=1,
            y=77,
            width=120,
            height=72,

            sourceX = 0,
            sourceY = 24,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- VACA2
            x=1,
            y=151,
            width=120,
            height=72,

            sourceX = 0,
            sourceY = 24,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- VACA3
            x=1,
            y=1,
            width=120,
            height=74,

            sourceX = 0,
            sourceY = 23,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- VACA4
            x=1,
            y=225,
            width=120,
            height=72,

            sourceX = 0,
            sourceY = 24,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- VACA5
            x=1,
            y=299,
            width=120,
            height=72,

            sourceX = 0,
            sourceY = 23,
            sourceWidth = 120,
            sourceHeight = 120
        },
    },

    sheetContentWidth = 122,
    sheetContentHeight = 372
}

SheetInfo.frameIndex =
{

    ["VACA1"] = 1,
    ["VACA2"] = 2,
    ["VACA3"] = 3,
    ["VACA4"] = 4,
    ["VACA5"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
