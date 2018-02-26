local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )


local sky = display.newImageRect("ui/sky.png", 1500, 750)
sky.x = display.contentCenterX
sky.y = display.contentCenterY


local bg1 = display.newImageRect("ui/bg1.png", 1400, 750)
bg1.x = display.contentCenterX
bg1.y = display.contentCenterY


local cow = display.newImageRect( "ui/cow.png", 150, 180 )
cow.x = display.contentCenterX -600
cow.y = display.contentHeight -80


local floor = display.newImageRect( "ui/floor.png", 300, 50 )
floor.x = display.contentCenterX
floor.y = display.contentHeight 

-- isso aqui tem que virar image sheet
--ocal golpe = display.newImageRect( "golpe.png", 120, 150 )
--golpe.x = display.contentCenterX 
--golpe.y = display.contentHeight -100
--physics.addBody( golpe, { radius=30, isSensor=true } )
--golpe.alpha = 0.9
--golpe.name = "vampirao"

--local gorgoyle = display.newImageRect( "gorgoyle.png", 200, 200 )
--gorgoyle.x = display.contentCenterX -150
--gorgoyle.y = display.contentHeight -100
--physics.addBody( gorgoyle, { radius=30, isSensor=true } )
--gorgoyle.name = "minion"

local lives = 6
local score = 0
local died = false

local physics = require( "physics" )
physics.start()

--physics.addBody( platform, "static" )
physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0 })
		cow.isFixedRotation=true	

        local function onTouch(event)
            if(event.phase == "ended") then
             transition.to( cow, {x=event.x, y=event.y})
            end
          end
          
          Runtime: addEventListener( "onTouch", onTouch )

Runtime:addEventListener("touch", cow)