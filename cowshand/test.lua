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
    local cloudCity = 0.5
    physics.start()  -- Temporarily pause the physics engine

    --Background
	local background = display.newImageRect("ui/background/sky.png", display.actualContentWidth, display.actualContentHeight )
	background.x = w/2 
	background.y = cY + display.screenOriginY

	-- Ground
	local gnd1 = display.newImageRect("ui/screens/ground.png", 560, 90)
    gnd1.x = 0
    gnd1.y = 275
    physics.addBody( gnd1, "static" )
    gnd1.speed = speedGround
    

    -- local gnd2 = display.newImageRect("ui/telas/street.png", 560, 90)
    -- gnd2.x = 544 
    -- gnd2.y = 275
    -- physics.addBody( gnd2, "static" )
    -- gnd2.speed = speedGround

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
    local city1 = display.newImageRect("ui/screens/bg1.png", 554, 130 )
    city1.x = cX
    city1.y = h-148
    city1.speed = speedCity
    
    local city2 = display.newImageRect("ui/screens/bg2.png", 554, 130 )
    city2.x = cX+554
    city2.y = h-145
    city2.speed = speedCity

    -- Credit and Debit
	local credit = display.newImage("ui/elements/dola.png", 130, 40)
	credit.x = cX-205
	credit.y = cY-130

	local debit = display.newImage("ui/elements/baddola.png", 130, 40)
	debit.x = cX-70
	debit.y = cY-130

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
    local function moveX( self, event )
    	if (self.x < -272) then
    		self.x = 806
    	else
    		self.x = self.x - self.speed
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
    livesText = display.newText( "$ ".. lives, 50, 29, "RifficFree-Bold.ttf", 20)
    livesText:setFillColor( 0, 255, 0 )
    moneyText = display.newText( "$ ".. money, 190, 29, "RifficFree-Bold.ttf", 20)
    moneyText:setFillColor( 255, 0, 0  )

    -- Load the Sprite

	local sheetData = {
	    width=69;               --Largura Sprite
	    height=90;              --Altura Sprite
	    numFrames=10;            --Número de Frames
	    sheetContentWidth=345,  --Largura da Folha de Sprites
	    sheetContentHeight=180   --Altura da Folha de Sprites
	    -- 1 to 6 corre
	    -- 7 to 10 pula
	}

	local sequenceData = {
	    { name = "run", start=1, count=6, time=800},
	    { name = "jump", start=7, count=10, time=1000}
	}

	local mySheet = graphics.newImageSheet( "ui/sprites/cowSprite.png", sheetData )

	local animation = display.newSprite( mySheet, sequenceData )
	animation.x = cX-150
	animation.y = cY+100

	animation.timeScale = 1.2
	animation:setSequence( "run" )
	animation:play( )

	local function onTouch( event )
		
	end
	Runtime:addEventListener("touch", onTouch)


	-- End the Sprite
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