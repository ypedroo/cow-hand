--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:fb881337445caef2cbb41cdf91fb6955:84d193335201f863d889ff13dd6d5fdc:f4caa75ab36abe878642dd57c00e7ff8$
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
            -- WhatsApp Image 2018-04-17 at 11.41.14.jpeg
            x=1,
            y=1,
            width=120,
            height=120,

        },
        {
            -- WhatsApp Image 2018-04-17 at 11.41.15.jpeg
            x=123,
            y=1,
            width=120,
            height=120,

        },
        {
            -- WhatsApp Image 2018-04-17 at 11.41.16 (1).jpeg
            x=245,
            y=1,
            width=120,
            height=120,

        },
        {
            -- WhatsApp Image 2018-04-17 at 11.41.16.jpeg
            x=367,
            y=1,
            width=120,
            height=120,

        },
        {
            -- WhatsApp Image 2018-04-17 at 11.41.17.jpeg
            x=489,
            y=1,
            width=120,
            height=120,

        },
    },

    sheetContentWidth = 610,
    sheetContentHeight = 122
}

SheetInfo.frameIndex =
{

    ["WhatsApp Image 2018-04-17 at 11.41.14.jpeg"] = 1,
    ["WhatsApp Image 2018-04-17 at 11.41.15.jpeg"] = 2,
    ["WhatsApp Image 2018-04-17 at 11.41.16 (1).jpeg"] = 3,
    ["WhatsApp Image 2018-04-17 at 11.41.16.jpeg"] = 4,
    ["WhatsApp Image 2018-04-17 at 11.41.17.jpeg"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
