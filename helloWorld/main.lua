-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local background = display.newImageRect("background.png", 360, 600)
background.x = display.contentCenterX
background.y = display.contentCenterY


display.newText("Chute a vaca!", 150, 0, native.systemFont, 20);


local platform = display.newImageRect( "platform.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25


local cow = display.newImageRect( "cow.png", 120, 101 )
cow.x = display.contentCenterX
cow.y = display.contentHeight -100
cow.alpha = 0.8


local physics = require( "physics" )
physics.start()

physics.addBody( platform, "static" )
physics.addBody( cow, "dynamic", { radius=10, bounce= .01 } )


local function pushCow()
    cow:applyLinearImpulse( 10, -2, cow.x, cow.y )
end

cow:addEventListener( "tap", pushCow )
