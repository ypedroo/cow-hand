local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

local background = display.newImageRect("bg.png", 1500, 750)
background.x = display.contentCenterX
background.y = display.contentCenterY



local cow = display.newImageRect( "cow.png", 120, 130 )
cow.x = display.contentCenterX -600
cow.y = display.contentHeight -80


local golpe = display.newImageRect( "golpe.png", 120, 150 )
golpe.x = display.contentCenterX 
golpe.y = display.contentHeight -100
physics.addBody( golpe, { radius=30, isSensor=true } )
golpe.alpha = 0.6
golpe.name = "vampirao"

local gorgoyle = display.newImageRect( "gorgoyle.png", 200, 200 )
gorgoyle.x = display.contentCenterX -150
gorgoyle.y = display.contentHeight -100
physics.addBody( gorgoyle, { radius=30, isSensor=true } )
gorgoyle.name = "minion"



local platform = display.newImageRect( "floor.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25