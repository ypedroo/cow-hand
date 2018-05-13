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


local obstacles = {}				--Cria vetor de despesas
local obstaclesCounter = 0				--Qtd de elementos de despesas
local obstaclesDisappear = 0		--Despesas desaparecidas

local qtdBonusIncomes = 10 		-- Tiro

local collectibles = {}
local collectiblesCounter = 0
local collectiblesDisappear = 0



local lives = 3
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

 local whereFrom = math.random( 3 )

     if ( whereFrom == 1 ) then
        newBill.x = display.contentCenterX + 560
        newBill.y = math.random(500,550)
        newBill:setLinearVelocity( -200, 0)
    elseif ( whereFrom == 2 ) then
        newBill.x = display.contentCenterX + 500
        newBill.y = math.random(600,800)
        newBill:setLinearVelocity( -200, 0)
    elseif ( whereFrom == 3 ) then
        newBill.x = display.contentCenterX + 500
        newBill.y = math.random(700,750)
        newBill:setLinearVelocity( -200, 0)
   end
	newBill:applyTorque(0,0, newBill.x, newBill.y )
end

--function to create notes
local function createGoodDola()
    goodBill = display.newImageRect( "ui/elements/notes.png", 70, 70 )
    table.insert( headsTable, goodBill )
	physics.addBody( goodBill, "kinematic", {density=0, friction=0, bounce=0.3, isSensor=true, radius=30 } )
    goodBill.myName = "goodBill"
local whereFrom = math.random( 3 )
    if ( whereFrom == 1 ) then
       goodBill.x = display.contentCenterX + 560
	   goodBill.y = (600)

       goodBill:setLinearVelocity( -200, 0)
   end
   if ( whereFrom == 2 ) then
	goodBill.x = display.contentCenterX + 560
	goodBill.y = (750)

	goodBill:setLinearVelocity( -200, 0)
  end
  if ( whereFrom == 3 ) then
	goodBill.x = display.contentCenterX + 560
	goodBill.y = (570)

	goodBill:setLinearVelocity( -200, 0)
  end
   goodBill:applyTorque(0,0, goodBill.x, goodBill.y )
end

--function to create gargoyle
local function createGargoyle()
    gargoyle = display.newImageRect( "ui/elements/gargoyle.png", 200, 200 )
    table.insert( obstacles, gargoyle )
	physics.addBody( gargoyle, "dynamic", {density=0, friction=0, bounce=0.3, isSensor=false, radius=30 } )
    gargoyle.myName = "gargoyle"
local whereFrom = math.random( 3 )
    if ( whereFrom == 1 ) then
		gargoyle.x = display.contentCenterX + 560
		gargoyle.y = (600)

		gargoyle:setLinearVelocity( -200, 0)
   end
   if ( whereFrom == 2 ) then
	 	gargoyle.x = display.contentCenterX + 560
		gargoyle.y = (750)

		gargoyle:setLinearVelocity( -200, 0)
  end
  if ( whereFrom == 3 ) then
		gargoyle.x = display.contentCenterX + 560
		gargoyle.y = (570)

		gargoyle:setLinearVelocity( -200, 0)
  end
  gargoyle:applyTorque(0,0, gargoyle.x, gargoyle.y )
end


--gameLoop Functions
local function reciptLoop()
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


	gameLoopTimer = timer.performWithDelay(3500, reciptLoop, 0 )


--loop for the notes
local function notesLoop()
	createGoodDola()
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


	gameLoopTimer = timer.performWithDelay(4500, notesLoop, 0 )

--loop for the gargoyle 	
local function gargoyleLoop()
	createGargoyle()
		for i = #obstacles, 1, -1 do
			local thisObstacle = obstacles[i]

				if ( thisObstacle.x < -1000 or
				thisObstacle.x > display.contentWidth + 50 or
				thisObstacle.y < -1000 or
						thisObstacle.y > display.contentHeight + 50 )
				then
					display.remove( thisObstacle )
					table.remove( obstacles, i )
				end
		end
	end


	gameLoopTimer = timer.performWithDelay(5000, gargoyleLoop, 0 )
	
function endGame()
		composer.setVariable( "finalScore", score )
		composer.gotoScene( "restart", { time=400, effect="crossFade" } )
	end


--Jump Function
local function onTouch(event)
		if(event.phase == "began") then
			jumpLimit = jumpLimit + 1
			if jumpLimit < 3 then
			  physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0 })
			  cow:applyLinearImpulse(0, -0.12, cow.x, cow.y)
			end
		jumpLimit = 0
		end
		end
	Runtime:addEventListener("touch", onTouch)

--function to move the elements
local function moveX( self, event )
    	if (self.x < -1000) then
    		self.x =  display.contentCenterX+200
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

		if ( ( obj1.myName == "cow" and obj2.myName == "goodBill" ) or
		     ( obj1.myName == "goodBill" and obj2.myName == "cow" ) )
		 then
			money = money + 100
			moneyText.text = "Money: " .. money
		end
		
		if ( ( obj1.myName == "cow" and obj2.myName == "gargoyle" ) or
   		( obj1.myName == "gargoyle" and obj2.myName == "cow" ) )
		then
			if ( dead == false ) then
			dead = true
			for i = #obstacles, 1, -1 do
				if ( obstacles[i] == obj1 or obstacles[i] == obj2 ) then
					obstacles[i].alpha = 0
					cow.alpha = 0
					timer.performWithDelay(0, restoreCow )
					lives = lives - 1
					livesText.text = "Lives: " .. lives

						if ( lives == 0 ) then
							display.remove( cow )
							timer.performWithDelay( 1000, endGame )				
						end

					break
				end

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
	local gnd1 = display.newImageRect("ui/screens/ground.png", 2200, 142)
	gnd1.x = 0
	gnd1.y = display.contentCenterY +426
	gnd1.cY = 0.7
	physics.addBody( gnd1, "static" , {bounce=0})


	local gnd2 = display.newImageRect("ui/screens/ground.png", 2200, 142)
	gnd2.x = 0
	gnd2.y = display.contentCenterY +426
	gnd2.cY = 0.7
    physics.addBody( gnd2, "static" , {bounce=0})


    -- City
    local city1 = display.newImageRect("ui/screens/bg1.png",1000, 700 )
    city1.x = cX
    city1.y = h-230
    city1.speed = speedCity

    local city2 = display.newImageRect("ui/screens/bg2.png", 1000, 500 )
    city2.x = cX
    city2.y = h-120
	city2.speed = speedCity

	local city3 = display.newImageRect("ui/screens/bg1.png", 1000, 700 )
	city3.x = cX+1000
	city3.y = h-230
	city3.speed = speedCity

	local city4 = display.newImageRect("ui/screens/bg2.png", 1000, 500 )
    city4.x = cX+800
    city4.y = h-120
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



	musicTrack  = audio.loadSound( "soundsfile/AI_2.mp3" )
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
		timer.cancel( gameLoopTimer )

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		physics.pause()
		composer.removeScene( "game" )
		composer.hideOverlay()
		Runtime:removeEventListener( "collision", onCollision)
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
