--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:330cef72e32b986bb48f408c4a105ffe:aec0b3ac9bf614c86a79684e1cb1b596:73660c86d7804c137a619bc1dd262ebd$
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
            x=234,
            y=839,
            width=32,
            height=20,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- badSky
            x=363,
            y=231,
            width=128,
            height=128,

        },
        {
            -- bg1
            x=1,
            y=1,
            width=480,
            height=228,

        },
        {
            -- button
            x=363,
            y=725,
            width=74,
            height=70,

            sourceX = 16,
            sourceY = 20,
            sourceWidth = 110,
            sourceHeight = 110
        },
        {
            -- check
            x=182,
            y=839,
            width=50,
            height=20,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 50,
            sourceHeight = 50
        },
        {
            -- cow
            x=363,
            y=613,
            width=116,
            height=74,

            sourceX = 4,
            sourceY = 46,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- dola
            x=82,
            y=849,
            width=32,
            height=16,

            sourceX = 0,
            sourceY = 7,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- golpe
            x=382,
            y=797,
            width=68,
            height=70,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- gorgoyle
            x=124,
            y=839,
            width=22,
            height=26,

            sourceX = 24,
            sourceY = 21,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- ground
            x=1,
            y=803,
            width=79,
            height=52,

        },
        {
            -- jackpot
            x=82,
            y=803,
            width=40,
            height=44,

        },
        {
            -- medkit
            x=148,
            y=839,
            width=32,
            height=22,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- menu/credits
            x=382,
            y=689,
            width=82,
            height=34,

            sourceX = 8,
            sourceY = 29,
            sourceWidth = 96,
            sourceHeight = 96
        },
        {
            -- menu/menuBg
            x=363,
            y=361,
            width=128,
            height=128,

        },
        {
            -- menu/quit
            x=124,
            y=803,
            width=84,
            height=34,

            sourceX = 6,
            sourceY = 29,
            sourceWidth = 96,
            sourceHeight = 96
        },
        {
            -- menu/start
            x=210,
            y=803,
            width=84,
            height=34,

            sourceX = 6,
            sourceY = 3,
            sourceWidth = 96,
            sourceHeight = 96
        },
        {
            -- restart
            x=296,
            y=803,
            width=84,
            height=34,

            sourceX = 6,
            sourceY = 3,
            sourceWidth = 96,
            sourceHeight = 96
        },
        {
            -- sky
            x=1,
            y=231,
            width=360,
            height=570,

        },
        {
            -- sky1
            x=363,
            y=491,
            width=120,
            height=120,

        },
    },

    sheetContentWidth = 492,
    sheetContentHeight = 868
}

SheetInfo.frameIndex =
{

    ["baddola"] = 1,
    ["badSky"] = 2,
    ["bg1"] = 3,
    ["button"] = 4,
    ["check"] = 5,
    ["cow"] = 6,
    ["dola"] = 7,
    ["golpe"] = 8,
    ["gorgoyle"] = 9,
    ["ground"] = 10,
    ["jackpot"] = 11,
    ["medkit"] = 12,
    ["menu/credits"] = 13,
    ["menu/menuBg"] = 14,
    ["menu/quit"] = 15,
    ["menu/start"] = 16,
    ["restart"] = 17,
    ["sky"] = 18,
    ["sky1"] = 19,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
