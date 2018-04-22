-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y
local oX = display.screenOriginX -- Centro X
local oY = display.screenOriginY -- Origem Y
local h = display.contentHeight
local w = display.contentWidth


-- Set up display groups
local backGroup = display.newGroup()

function scene:create( event )

	local sceneGroup = self.view

	local lives = 6
    local money = 0
    local jumpLimit = 0 
    local dead = false
    local speedCity = 1
    local speedGround = 2
    --local cloudCity = 0.5
    physics.start()  -- Temporarily pause the physics engine

    --Background
	local background = display.newImageRect("ui/background/sky.png", display.actualContentWidth, display.actualContentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY 

	-- Ground
	local gnd1 = display.newImageRect("ui/screens/ground.png", 1100, 90)
	gnd1.x = display.contentCenterX
	gnd1.y = display.contentCenterY +400
    physics.addBody( gnd1, "static" )
    gnd1.speed = speedGround
    

    local gnd2 = display.newImageRect("ui/screens/ground.png", 1100, 90)
    gnd2.x = display.contentCenterX +500
    gnd2.y = display.contentCenterY +400
    physics.addBody( gnd2, "static" )
	gnd2.speed = speedGround

    -- Cloud
    -- local cloud1 = display.newImageRect("ui/telas/cloud1.png", 554, 50 )
    -- cloud1.x = 0
    -- cloud1.y = h/5
    -- cloud1.speed = cloudCity

    -- local cloud2 = display.newImageRect("ui/telas/cloud2.png", 554, 50 )
    -- cloud2.x = 544
    -- cloud2.y = h/5
    -- cloud2.speed = cloudCity

    -- City
    local city1 = display.newImageRect("ui/screens/bg1.png",1000, 190 )
    city1.x = cX
    city1.y = h -90
    city1.speed = speedCity
    
    local city2 = display.newImageRect("ui/screens/bg2.png", 1000, 130 )
    city2.x = cX
    city2.y = h-80
    city2.speed = speedCity

    -- Credit and Debit
	-- local credit = display.newImage("ui/elements/dola.png", 130, 40)
	-- credit.x = cX-205
	-- credit.y = cY -90

	-- local debit = display.newImage("ui/elements/baddola.png", 130, 40)
	-- debit.x = cX-70
	-- debit.y = cY -90

	-- local buttons = {}

	-- buttons[1] = display.newImage("ui/background/up.png", 50, 50)
	-- buttons[1].x = 50 
	-- buttons[1].y = cY+127
	-- buttons[1].myName = "up" 

	-- buttons[2] = display.newImage("ui/background/up.png", 50, 50)
	-- buttons[2].x = 510 
	-- buttons[2].y = cY+127
	-- buttons[2].myName = "jumpBoy"

	-- local ten = display.newImage("ui/elements/ten.png", 50, 50)
	-- ten.x = 554
	-- ten.y = 180
	-- physics.addBody( ten, "kinematic", {density=1.0, friction=0.5, bounce=0.3} )
	-- ten:setLinearVelocity(-150,0)

	-- local twenty = display.newImage("ui/elements/twenty.png", 50, 50)
	-- twenty.x = 250
	-- twenty.y = 100
	-- physics.addBody( twenty, "kinematic", {density=1.0, friction=0.5, bounce=0.3} )
	-- twenty:setLinearVelocity(-150,0)



    -- Function for move all elements on Display
	local function moveX(self, event )
		if self.x < -200 then
		   self.x = display.contentCenterX + 100
		else
			self.x = self.x -3  - self.speed
			
		end
	
	end

    gnd1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", gnd1)
    gnd2.enterFrame = moveX
    Runtime:addEventListener("enterFrame", gnd2)
    city1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city1)
    city2.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city2)
    -- cloud1.enterFrame = moveX
    -- Runtime:addEventListener("enterFrame", cloud1)
    -- cloud2.enterFrame = moveX
    -- Runtime:addEventListener("enterFrame", cloud2)

    -- Score
    livesText = display.newText( " Lives ".. lives, 50, 29, "RifficFree-Bold.ttf", 36)
    livesText:setFillColor( 255, 0, 0  ) 
    moneyText = display.newText( "$ ".. money, 190, 29, "RifficFree-Bold.ttf", 36)
    moneyText:setFillColor( 0, 255, 0 )

    -- Load the Sprite

	local sheetData = {
	    width=120;               --Largura Sprite
	    height=120;              --Altura Sprite
	    numFrames=5;            --Número de Frames
	    sheetContentWidth=600,  --Largura da Folha de Sprites
	    sheetContentHeight=120   --Altura da Folha de Sprites
	    -- 1 to 6 corre
	    -- 7 to 10 pula
	}

	local sequenceData = {
	    { name = "run", start=1, count=6, time=800},
	    --{ name = "jump", start=7, count=10, time=1000}
	}

	local mySheet = graphics.newImageSheet( "ui/sprites/cowSprite.png", sheetData )

	local cow = display.newSprite(mySheet, sequenceData)
		  cow.x = cX-500
		  cow.y = cY +300

		  cow.timeScale = 1.2
		  cow:setSequence( "run" )
		  cow:play()


	-- End the Sprite

	local function onTouch(event)
		if(event.phase == "began") then
			jumpLimit = jumpLimit + 1
			if jumpLimit < 5 then
			  physics.addBody(cow, "dynamic", { density = 0.015, friction = 0, bounce = 0, gravity = 0 })
			  cow:applyLinearImpulse(0, -1.3, cow.x, cow.y)
			end
		jumpLimit = 0
		end
		end
		Runtime:addEventListener("touch", onTouch)

end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --physics.start()
         --audio.play( musicTrack, { channel=1, loops=-1 } )
       
 
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
		composer.hideOverlay()
		--Runtime:removeEventListener( "collision", onCollision)
		--Runtime:removeEventListener("touch", onTouch)
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