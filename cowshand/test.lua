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
	local headsTable = {}
    --local cloudCity = 0.5
    physics.start()  -- Temporarily pause the physics engine

    --Background
	local background = display.newImageRect("ui/background/sky.png", display.actualContentWidth, display.actualContentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY 

	-- Ground
	local gnd1 = display.newImageRect("ui/screens/ground.png", 26000, 90)
	gnd1.x = display.contentCenterX
	gnd1.y = display.contentCenterY +426
    physics.addBody( gnd1, "static" , {bounce=0})
    gnd1.speed = speedGround
    

    -- City
    local city1 = display.newImageRect("ui/screens/bg1.png",1100, 750 )
    city1.x = cX
    city1.y = h-230
    city1.speed = speedCity
    
    local city2 = display.newImageRect("ui/screens/bg2.png", 1100, 300 )
    city2.x = cX
    city2.y = h-130
	city2.speed = speedCity
	
	local city3 = display.newImageRect("ui/screens/bg1.png", 1100, 750 )
    city3.x = cX+1100
    city3.y = h-230
	city3.speed = speedCity
	
	local city4 = display.newImageRect("ui/screens/bg2.png", 1100, 300 )
    city4.x = cX+1100
    city4.y = h-130
    city4.speed = speedCity

    -- Function for move all elements on Display
	local function moveX(self, event )
		if self.x < -1024 then
		   self.x = display.contentCenterX + 600
		else
			--this set the game speed use it for phase 2
			self.x = self.x -3  - self.speed
			
		end
	
	end

    gnd1.enterFrame = moveX
    --Runtime:addEventListener("enterFrame", gnd1)
    -- gnd2.enterFrame = moveX
    -- Runtime:addEventListener("enterFrame", gnd2)
    city1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city1)
    city2.enterFrame = moveX
	Runtime:addEventListener("enterFrame", city2)
	city3.enterFrame = moveX
	Runtime:addEventListener("enterFrame", city3)
	city4.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city4)
    -- cloud1.enterFrame = moveX
    -- Runtime:addEventListener("enterFrame", cloud1)
    -- cloud2.enterFrame = moveX
    -- Runtime:addEventListener("enterFrame", cloud2)

    -- Score
    livesText = display.newText( " Lives ".. lives, 50, 29, "Bubblegum.ttf", 46)
    livesText:setFillColor( 255, 0, 0  ) 
    moneyText = display.newText( "    Money ".. money, 300, 29, "Bubblegum.ttf", 46)
    moneyText:setFillColor( 0,255, 0 )

	-- Load the Sprite
	
	local sheetData = {
	    width=120;               --Largura Sprite
	    height=120;              --Altura Sprite
	    numFrames=5;            --Número de Frames
	    sheetContentWidth=120,  --Largura da Folha de Sprites
	    sheetContentHeight=600   --Altura da Folha de Sprites
	    -- 1 to 6 corre
	    -- 7 to 10 pula
	}

	local sequenceData = {
	    { name = "run", start=1, count=5, time=400},
	    --{ name = "jump", start=7, count=10, time=1000}
	}

	local mySheet = graphics.newImageSheet( "ui/sprites/VACA1.png", sheetData )

	-- local cow = display.newSprite(mySheet, sequenceData)
	-- 	  cow.x = cX-500
	-- 	  cow.y = cY +340

	-- 	  cow.timeScale = 1.2
	-- 	  cow:setSequence( "run" )
	-- 	  cow:play()

	local baddola = display.newImageRect("ui/elements/baddola.png", 80, 80)
    baddola.x = 554
    baddola.y = 380
    baddola.myName = "baddola"
    physics.addBody( baddola, "kinematic", {density=1.0, friction=0.5, bounce=0.3, isSensor=false, radius=50 } )
    baddola:setLinearVelocity(-150,0)

	
	local cow = display.newSprite( mySheet, sequenceData)
	cow.x = cX-500
	cow.y = cY +200
    cow.myName = "cow"
    physics.addBody( cow, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0,
										radius=40, isSensor=false } )
	cow.timeScale = 1.2
	cow:setSequence( "run" )
	cow:play( )



	-- End the Sprite

	local function onTouch(event)
		if(event.phase == "began") then
			jumpLimit = jumpLimit + 1
			if jumpLimit < 3 then
			  physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0 })
			  cow:applyLinearImpulse(0, -0.5, cow.x, cow.y)
			end
		jumpLimit = 0
		end
		end
		Runtime:addEventListener("touch", onTouch)

end

--collision function
local function onCollision( event )

	if ( event.phase == "began" ) then
	
		local obj1 = event.object1
		local obj2 = event.object2
	
		if ( ( obj1.myName == "cow" and obj2.myName == "baddola" ) or
		   ( obj1.myName == "baddola" and obj2.myName == "cow" ) )
		then
			
		display.remove( obj1 )
		display.remove( obj2 )
	
		for i = #headsTable, 1, -1 do
			if ( headsTable[i] == obj1 or headsTable[i] == obj2 ) then
				table.remove( headsTable, i )
				break
			end
		end
		
		
		-- Increase pontos
		money = money - 100
		moneyText.text = "Money: " .. money
	
		end
	
	end
	end 

	musicTrack  = audio.loadSound( "soundsfile/So_Long.mp3" )
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- Code here runs when the scene is entirely on screen
        --physics.start()
        physics.start()
		Runtime:addEventListener( "collision", onCollision )
		--gameLoopTimer = timer.performWithDelay( 1300, gameLoop, 0 )
				
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
