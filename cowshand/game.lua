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



local lives = 6
local money = 0
local jumpLimit = 0
local dead = false
local speedCity = 1
local speedGround = 2
local headsTable = {}


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


--Create enemies function
local function createBaddola()
    newBill = display.newImageRect( "ui/elements/receipt.png", 70, 70 )
    table.insert( headsTable, newBill )
	physics.addBody( newBill, "dynamic", {density=0, friction=0, bounce=0.3, isSensor=false, radius=30 } )
    newBill.myName = "baddola"

 local whereFrom = math.random( 1 )

     if ( whereFrom == 1 ) then
        newBill.x = display.contentCenterX + 550
        newBill.y = math.random(90,220)
        newBill:setLinearVelocity( -200, 0)
    -- elseif ( whereFrom == 2 ) then
    --     newBill.x = display.contentCenterX + 500
    --     newBill.y = math.random(80,220)
    --     newBill:setLinearVelocity( math.random( 30,90 ), math.random( 30,90 ), newBill.x, newBill.y )
    -- elseif ( whereFrom == 3 ) then
    --     newBill.x = display.contentCenterX + 500
    --     newBill.y = math.random(75,220)
    --     newBill:setLinearVelocity( math.random( -30,90 ), math.random( 10,50 ), newBill.x, newBill.y)
   end
	newBill:applyTorque(10,10, newBill.x, newBill.y )
end

--going to need one loop for each element, the gamelooptimer changes the spawn of the obejcts
--gameLoop Function
local function gameLoop()
		createBaddola()
		for i = #headsTable, 1, -1 do
		local thisHead = headsTable[i]

			if ( thisHead.x < -1000 or
					thisHead.x > display.contentWidth + 50 or
					thisHead.y < -1000 or
					thisHead.y > display.contentHeight + 50 )
			then
				display.remove( thisHead )
				table.remove( headsTable, i )
			end
		end
	end

	gameLoopTimer = timer.performWithDelay(4000, gameLoop, 0 )


local function endGame()
		composer.setVariable( "finalScore", score )
		composer.gotoScene( "restart", { time=800, effect="crossFade" } )
	end


--Jump Function
local function onTouch(event)
		if(event.phase == "began") then
			jumpLimit = jumpLimit + 1
			if jumpLimit < 3 then
			  physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0 })
			  cow:applyLinearImpulse(0, -0.3, cow.x, cow.y)
			end
		jumpLimit = 0
		end
		end
	Runtime:addEventListener("touch", onTouch)

--function to move the elements
local function moveX( self, event )
    	if (self.x < -1080) then
    		self.x =  display.contentCenterX + 300
		else
			--this line sets the game speed
    		self.x = self.x - self.speed - 3.5
    	end
end

--function to restore the cow
	local function restoreCow()

		cow.isBodyActive = false
		cow.x =cX -500
		cow.y =cY +200

		transition.to( cow, { alpha=1, time=1000,
			onComplete = function()
				cow.isBodyActive = true
				cow:setLinearVelocity( 0, nil )
				dead = false
				
			end
		} )
	end
	--collision function
local function onCollision( event )

	if ( event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		if ( ( obj1.myName == "cow" and obj2.myName == "baddola" ) or
		   ( obj1.myName == "baddola" and obj2.myName == "cow" ) )
		then
			if ( dead == false ) then
				dead = true

				for i = #headsTable, 1, -1 do
					if ( headsTable[i] == obj1 or headsTable[i] == obj2 ) then
						-- table.remove( headsTable, i )
						-- display.remove (obj1)
						-- display.remove (obj2)
						headsTable[i].alpha = 0
						cow.alpha = 0
						timer.performWithDelay(0, restoreCow )
						-- Decrease pontos
						money = money - 100
						moneyText.text = "Money: " .. money
						break
					end
				end	


				if ( lives == 0 ) then
					display.remove( cow )
					timer.performWithDelay( 2000, endGame )				
				end

			end

		end 
	end
end








function scene:create( event )

	local sceneGroup = self.view

	-- Set up display groups
	local backGroup = display.newGroup()


    --local cloudCity = 0.5
    physics.start()  -- Temporarily pause the physics engine

    --Background
	local background = display.newImageRect("ui/background/sky.png", display.actualContentWidth, display.actualContentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

	-- Ground
	local gnd1 = display.newImageRect("ui/screens/ground.png", 2117, 142)
	gnd1.x = 0
	gnd1.y = display.contentCenterY +426
	gnd1.cY = 0.7
	physics.addBody( gnd1, "static" , {bounce=0})


	local gnd2 = display.newImageRect("ui/screens/ground.png", 2117, 142)
	gnd2.x = 0
	gnd2.y = display.contentCenterY +426
	gnd2.cY = 0.7
    physics.addBody( gnd2, "static" , {bounce=0})


    -- City
    local city1 = display.newImageRect("ui/screens/bg1.png",1100, 900 )
    city1.x = cX
    city1.y = h-230
    city1.speed = speedCity

    local city2 = display.newImageRect("ui/screens/bg2.png", 1100, 500 )
    city2.x = cX
    city2.y = h-130
	city2.speed = speedCity

	local city3 = display.newImageRect("ui/screens/bg1.png", 1100, 900 )
    city3.x = cX+1100
    city3.y = h-100
	city3.speed = speedCity

	local city4 = display.newImageRect("ui/screens/bg2.png", 1100, 500 )
    city4.x = cX+1500
    city4.y = h-130
	city4.speed = speedCity

	--loading the cow(sprite)
	cow = display.newSprite( mySheet, sequenceData)
	cow.x = cX -500
	cow.y = cY +200
    cow.myName = "cow"
    physics.addBody( cow, { density = 0, friction = 10, bounce = 0, gravity = 0,
										radius=20, isSensor=false } )
	cow.timeScale = 1.2
	cow:setSequence( "run" )
	cow:play( )



	-- End the Sprite

-- 	local xOffset = ( 0.3 * cY )
-- 		gnd1.x = gnd1.x - xOffset
-- 		gnd2.x = gnd2.x - xOffset
  
-- 	if (gnd1.x + gnd1.contentWidth) < 0 then
-- 		gnd1:translate( 2119 * 2, 0)
-- 	end
-- 	if (gnd2.x + gnd2.contentWidth) < 0 then
-- 		gnd2:translate( 2119 * 2, 0)
	
-- end

    city1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city1)
    city2.enterFrame = moveX
	Runtime:addEventListener("enterFrame", city2)
	city3.enterFrame = moveX
	Runtime:addEventListener("enterFrame", city3)
	city4.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city4)

    -- Score
    livesText = display.newText( " Lives ".. lives, 50, 29, "Bubblegum.ttf", 46)
    livesText:setFillColor( 255, 0, 0  )
    moneyText = display.newText( "    Money ".. money, 300, 29, "Bubblegum.ttf", 46)
    moneyText:setFillColor( 0,255, 0 )

end



	--musicTrack  = audio.loadSound( "soundsfile/So_Long.mp3" )
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- -- physics.start()
		Runtime:addEventListener( "collision", onCollision )
		-- gameLoopTimer = timer.performWithDelay( 1300, gameLoop, 0 )

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
