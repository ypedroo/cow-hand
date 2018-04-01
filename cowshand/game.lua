
local composer = require( "composer" )

local scene = composer.newScene()

local widget = require "widget"

composer.recycleOnSceneChange = true

--Display live and scroe
--livesText = display.newText( uiGroup, "Lives:".. Lives, 200, 80, native.systemFont, 36)
--mesText = display.newText( uiGroup, "mes:".. Mes, 600, 80, native.systemFont, 36)


local physics = require( "physics" )

local distance --=0 
local Lives --= 6
local money --= 0
local died --= false

local musicTrack

function scene:create( event )
 
    local sceneGroup = self.view
    
    physics.start()  -- Temporarily pause the physics engine
   
    --Background

    local sky = display.newImageRect("ui/sky.png", 1400, 750)
    sky.x = display.contentCenterX
    sky.y = display.contentCenterY 

    local bg = display.newImageRect("ui/bg1.png", 1400, 750)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    bg.speed = 1

    local bg1 = display.newImageRect("ui/bg1.png",1400, 750)
    bg1.x = 2000
    bg1.y = 400
    bg1.speed = 1

    local bg2 = display.newImageRect("ui/bg2.png", 1400, 200)
    bg2.x = display.contentCenterX 
    bg2.y = display.contentCenterY +250
    bg2.speed = 2
    
    local bg3 = display.newImageRect("ui/bg2.png", 1600, 200)
    bg3.x =  1800
    bg3.y =  640
    bg3.speed = 2


    local ground = display.newImageRect( "ui/ground.png", 260000, 30)
    ground.x = display.contentCenterX 
    ground.y =  display.contentHeight -10
    physics.addBody(ground, "static")

-- Cow

    local cow = display.newImageRect( "ui/cow.png", 120, 130 )
    cow.x = display.contentCenterX -550
    cow.y = display.contentHeight -85
    physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = -1, gravity = 1 })

-- Colectables
    local dola = display.newImageRect( "ui/dola.png", 70, 70 )
    dola.x = display.contentCenterX +550
    dola.y = display.contentHeight  -100
    dola.speed = math.random(2,8)
    dola.initY = dola.y
    dola.amp   = math.random(20,100)
    dola.angle = math.random(20,100)
    physics.addBody(dola, "static", { density = 0, friction = 0, bounce = .02 })

    local check = display.newImageRect( "ui/check.png", 70, 70 )
    check.x = display.contentCenterX +550
    check.y = display.contentHeight  -100
    check.speed = math.random(2,8)
    check.initY = check.y
    check.amp   = math.random(20,100)
    check.angle = math.random(20,100)
    physics.addBody(check, "static", { density = 0, friction = 0, bounce = .02 })

--enemies
    local baddola = display.newImageRect( "ui/baddola.png", 70, 70 )
    baddola.x = display.contentCenterX +550
    baddola.y = display.contentHeight  -100
    baddola.speed = math.random(2,8)
    baddola.initY = baddola.y
    baddola.amp   = math.random(20,100)
    baddola.angle = math.random(20,100)
    physics.addBody(baddola, "static", { density = 0, friction = 0, bounce = .02 })

    local baddola1 = display.newImageRect( "ui/baddola.png", 70, 70 )
    baddola1.x = display.contentCenterX +550
    baddola1.y = display.contentHeight  -100
    baddola1.speed = math.random(2,8)
    baddola1.initY = baddola.y
    baddola1.amp   = math.random(20,100)
    baddola1.angle = math.random(20,100)
    physics.addBody(baddola1, "static", { density = 0, friction = 0, bounce = .02 })

    local gorgoyle = display.newImageRect( "ui/gorgoyle.png", 150, 160 )
    gorgoyle.x = display.contentCenterX +550
    gorgoyle.y = display.contentHeight  -100
    gorgoyle.speed = math.random(2,8)
    gorgoyle.initY = baddola.y
    gorgoyle.amp   = math.random(20,100)
    gorgoyle.angle = math.random(20,100)
    physics.addBody(gorgoyle, "static", { density = 0, friction = 0, bounce = .02 })
    --Functions

    local function onTouch(event)
        if(event.phase == "began") then
            cow:applyLinearImpulse(0, -1, cow.x, cow.y)
        end
    end


    local function scrollCity(self, event )
        if self.x < -1024 then
           self.x = display.contentCenterX + 1200
        else
            self.x = self.x -3  - self.speed
        end

    end

    local function moveEnemies(self, event )
        if self.x < -1000 then
            self.x = display.contentCenterX + 1000
            self.y = math.random(90,220)
            self.speed = math.random(2,8)
            self.amp   = math.random(20,100)
            self.angle = math.random(20,100)
        else
            self.x = self.x - self.speed
            self.angle = self.angle + .1
            self.y = self.amp * math.sin(self.angle)+self.initY
        end

    end

    local function moveElements(self, event )
        if self.x < -1000 then
            self.x = display.contentCenterX + 1000
            self.y = math.random(90,220)
            self.speed = math.random(2,8)
            self.amp   = math.random(20,100)
            self.angle = math.random(20,100)
        else
            self.x = self.x - self.speed
            self.angle = self.angle + .1
            self.y = self.amp * math.sin(self.angle)+self.initY
        end

    end

    
    local function moveCollect(self, event )
        if self.x < -1000 then
            self.x = display.contentCenterX + 1000
            self.y = math.random(90,220)
            self.speed = math.random(2,8)
            self.amp   = math.random(20,100)
            self.angle = math.random(20,100)
        else
            self.x = self.x - self.speed
            self.angle = self.angle + .1
            self.y = self.amp * math.sin(self.angle)+self.initY
        end

    end

    local function onCollision(event)
        if (event.phase == "began") then
            composer.gotoScene( "restart", { time=800, effect="fade" } )
        end
    end

    bg.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg)

    bg1.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg1)

    bg2.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg2)

    bg3.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg3)

    baddola.enterFrame = moveEnemies
    Runtime:addEventListener("enterFrame", baddola)

    baddola1.enterFrame = moveEnemies
    Runtime:addEventListener("enterFrame", baddola1)

    Runtime:addEventListener("touch", onTouch)
    --Runtime:addEventListener( "collision", onCollision)
    --cow:addEventListener("touch", onTouch)

    --musicTrack  = audio.loadSound( "soundsfile/So_Long.mp3" )
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --physics.start()
         audio.play( musicTrack, { channel=1, loops=-1 } )
       
 
    end
end
   



-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		physics.pause()
        composer.removeScene( "game" )
        cow.removeSelf();
        --Runtime:addEventListener( "collision", onLocalCollision)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene