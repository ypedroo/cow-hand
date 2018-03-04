display.setStatusBar(display.HiddenStatusBar)
local physics = require( "physics" )
physics.start()
math.randomseed( os.time())
--physics.setGravity( 9, 8 )

local sky = display.newImageRect("ui/sky.png", 1500, 750)
sky.x = display.contentCenterX
sky.y = display.contentCenterY


local bg = display.newImageRect("ui/bg1.png", 1400, 750)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local ground = display.newImageRect( "ui/ground.png", 26000, 30)
ground.x = display.contentCenterX 
ground.y =  display.contentHeight -10
physics.addBody(ground, "static")

local cow = display.newImageRect( "ui/cow.png", 120, 130 )
cow.x = display.contentCenterX -400
cow.y = display.contentHeight -10
--physics.addBody( cow, { radius=30 })
physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = .3, gravity = 0 })

--Display live and scroe
--livesText = display.newText( uiGroup, "Lives:".. Lives, 200, 80, native.systemFont, 36)
--mesText = display.newText( uiGroup, "mes:".. Mes, 600, 80, native.systemFont, 36)

local button = display.newImageRect( "ui/button.png", 130, 140 )
button.x = display.contentCenterX -600
button.y = display.contentHeight -80

        
local Lives --= 6
local mes --= 0
local died --= false

local function onTouch(event)
    if(event.phase == "began") then
        cow:applyLinearImpulse(0, -0.8, cow.x, cow.y)
    end
end

Runtime:addEventListener("touch", onTouch)

