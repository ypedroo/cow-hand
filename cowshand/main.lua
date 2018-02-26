display.setStatusBar(display.HiddenStatusBar)
local physics = require( "physics" )
physics.start()
--physics.setGravity( 0, 0 )


local ground = display.newImageRect( "ui/ground.png", 12000, 30)
ground.x = display.contentCenterX -600
ground.y =  display.contentHeight -100 
physics.addBody(ground, "static")

local sky = display.newImageRect("ui/sky.png", 1500, 750)
sky.x = display.contentCenterX
sky.y = display.contentCenterY


local bg = display.newImageRect("ui/bg.png", 1400, 750)
bg.x = display.contentCenterX
bg.y = display.contentCenterY


local cow = display.newImageRect( "ui/cow.png", 180, 200 )
cow.x = display.contentCenterX -600
cow.y = display.contentHeight -120
physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = .3, gravity = 0 })
        --cow.isFixedRotation=true	
        
local lives = 6
local score = 0
local died = false

local function onTouch(event)
    if(event.phase == "began") then
        --cow:applyLinearImpulse(0, -2, cow.x, cow.y)
        if(event.x < cow.x) then
            --jump left
            cow:applyLinearImpulse(-2,-2, cow.x, cow.y)
        else
            --jump right
            cow:applyLinearImpulse(2,-2, cow.x, cow.y)
        end
    end
end

Runtime:addEventListener("touch", onTouch)

-- isso aqui tem que virar image sheet
--local golpe = display.newImageRect( "golpe.png", 120, 150 )
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

