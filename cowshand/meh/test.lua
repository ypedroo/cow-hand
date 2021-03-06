local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )
-- local sounds = require( "soundsfile" )

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



local lives = 1
local money = 0
local jumpLimit = 0
local dead = false
local speedCity = 1
local speedGround = 2
local headsTable = {}
audio.setVolume( 0.30, { channel=1 } ) 
-- playGameMusic(soundsfile/AI_2.mp3)
mu = audio.loadSound( "soundsfile/mu.wav" )
jackpot = audio.loadSound("soundsfile/jackpot.wav")
coin = audio.loadSound("soundsfile/Change_Drop_on_Wood.mp3")
-- baddolaSound = audio.loadSound("soundsfile/Cartoon_Cowbell")
musicTrack  = audio.loadSound( "soundsfile/AI_2.mp3" )













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
    local city1 = display.newImageRect("ui/screens/bg1.png",1024, 600 )
    city1.x = 0
    city1.y = h-250
    city1.speed = 1

    local city2 = display.newImageRect("ui/screens/bg1.png", 1024, 600 )
    city2.x = 1024
    city2.y = h-250
	city2.speed = 1

	local city3 = display.newImageRect("ui/screens/bg2.png", 1024, 400 )
	city3.x = 0
	city3.y = h-50
	city3.speed = 2

	local city4 = display.newImageRect("ui/screens/bg2.png", 1024, 400)
    city4.x = 1024
    city4.y = h-50
	city4.speed = 2

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
--Create enemies function
	local function createBaddola()
	newBill = display.newImageRect( "ui/elements/receipt.png", 70, 70 )
	table.insert( headsTable, newBill )
	physics.addBody( newBill, "kinematic", {density=0, friction=0, bounce=0.3, isSensor=true, radius=30 } )
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

	--function to create jackpot
	local function createJackpot()
	jackpot = display.newImageRect( "ui/elements/jackpot.png", 70, 70 )
	table.insert( headsTable, jackpot )
	physics.addBody( jackpot, "kinematic", {density=0, friction=0, bounce=0.3, isSensor=true, radius=30 } )
	jackpot.myName = "jackpot"
	local whereFrom = math.random( 3 )
	if ( whereFrom == 1 ) then
	jackpot.x = display.contentCenterX + 560
	jackpot.y = (600)

		jackpot:setLinearVelocity( -200, 0)
	end
	if ( whereFrom == 2 ) then
	jackpot.x = display.contentCenterX + 560
	jackpot.y = (750)

	jackpot:setLinearVelocity( -200, 0)
	end
	if ( whereFrom == 3 ) then
	jackpot.x = display.contentCenterX + 560
	jackpot.y = (570)

	jackpot:setLinearVelocity( -200, 0)
	end
	jackpot:applyTorque(0,0, jackpot.x, jackpot.y )
	end

	--function to create gargoyle
	local function createGargoyle()
	gargoyle = display.newImageRect( "ui/elements/gargoyle.png", 200, 200 )
	table.insert( obstacles, gargoyle )
	physics.addBody( gargoyle, "kinematic", {density=0, friction=0, bounce=0.3, isSensor=true, radius=30 } )
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


	--function to create golpe
	local function createGolpe()
		golpe = display.newImageRect( "ui/elements/golpe.png", 200, 200 )
		table.insert( obstacles, golpe )
		physics.addBody( golpe, "kinematic", {density=0, friction=0, bounce=0.3, isSensor=true, radius=30 } )
		golpe.myName = "golpe"
	local whereFrom = math.random( 3 )
		if ( whereFrom == 1 ) then
			golpe.x = display.contentCenterX + 560
			golpe.y = (600)

			golpe:setLinearVelocity( -200, 0)
	   end
	   if ( whereFrom == 2 ) then
			golpe.x = display.contentCenterX + 560
			golpe.y = (750)

			golpe:setLinearVelocity( -200, 0)
	  end
	  if ( whereFrom == 3 ) then
			golpe.x = display.contentCenterX + 560
			golpe.y = (570)

			golpe:setLinearVelocity( -200, 0)
	  end
	  golpe:applyTorque(0,0, golpe.x, golpe.y )
	end

	--function to create medkits
	local function createMedkit()
	medkit = display.newImageRect( "ui/elements/medkit.png", 70, 70 )
	table.insert( collectibles, medkit )
	physics.addBody( medkit, "kinematic", {density=0, friction=0, bounce=0.3, isSensor=true, radius=30 } )
	medkit.myName = "medkit"
	local whereFrom = math.random( 3 )
	if ( whereFrom == 1 ) then
		medkit.x = display.contentCenterX + 560
		medkit.y = (600)

		medkit:setLinearVelocity( -200, 0)
	end
	if ( whereFrom == 2 ) then
		medkit.x = display.contentCenterX + 560
		medkit.y = (750)

		medkit:setLinearVelocity( -200, 0)
	end
	if ( whereFrom == 3 ) then
		medkit.x = display.contentCenterX + 560
		medkit.y = (570)

		medkit:setLinearVelocity( -200, 0)
	end
	medkit:applyTorque(0,0, medkit.x, medkit.y )
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


	--loop for the medkit
	local function medkitLoop()
	createMedkit()
		for i = #collectibles, 1, -1 do
			local thisCollectible = collectibles[i]

			if ( thisCollectible.x < -1000 or
			thisCollectible.x > display.contentWidth + 50 or
			 thisCollectible.y < -1000 or
			 thisCollectible.y > display.contentHeight + 50 )
			 then
						display.remove( thisCollectible )
						 table.remove( collectibles, i )
			 end
		end
	end


	gameLoopTimer = timer.performWithDelay(25000, medkitLoop, 0 )

	--loop for the jackpots
	local function jackpotLoop()
	createJackpot()
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

	gameLoopTimer = timer.performWithDelay(19000, jackpotLoop, 0 )


	--loop for the golpes

	local function golpeLoop()
	createGolpe()
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


	gameLoopTimer = timer.performWithDelay(55000, golpeLoop, 0 )

	local function endGame()
		composer.setVariable( "finalScore", score )
		composer.gotoScene( "restart")
	end


	--Jump Function
	local function onTouch(event)
		if(event.phase == "began") then
			jumpLimit = jumpLimit + 1
			if jumpLimit < 3 then
			  physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = -2 })
			  cow:applyLinearImpulse(0, -0.1, cow.x, cow.y)
			end
		jumpLimit = 0
		end
	end
	Runtime:addEventListener("touch", onTouch)

	--function to move the elements
	local function moveX( self, event )
		if (self.x < -1022) then
			self.x =  1010
		else
			--this line sets the game speed
			self.x = self.x - self.speed - 3.5
		end
	end

	--function to restore the cow
	local function restoreCow()

		cow.isBodyActive = false
		cow.x =cX -500
		cow.y =cY +300

		transition.to( cow, { alpha=1, time=1000,
			onComplete = function()
				cow.isBodyActive = true
				-- cow:setLinearVelocity( 0, nil )
				dead = false

			end
		} )
	end
	--collision function
	local function onCollision( event )

	if ( event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		--recepit collision
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
			end
		end 

		--notes collsion
		if ( ( obj1.myName == "cow" and obj2.myName == "goodBill" ) or
			 ( obj1.myName == "goodBill" and obj2.myName == "cow" ) )
		 then
			audio.play(jackpot)
			money = money + 100
			moneyText.text = "Money: " .. money
		end

		--jackpot collision
		if ( ( obj1.myName == "cow" and obj2.myName == "jackpot" ) or
		( obj1.myName == "jackpot" and obj2.myName == "cow" ) )
		then
		   audio.play(coin)
			money = money +500
		   moneyText.text = "Money: " .. money
		   end



		--gargoyle collission
		if ( ( obj1.myName == "cow" and obj2.myName == "gargoyle" ) or
		   ( obj1.myName == "gargoyle" and obj2.myName == "cow" ) )
		then
			if ( dead == false ) then
			dead = true
			
			for i = #obstacles, 1, -1 do
				if ( obstacles[i] == obj1 or obstacles[i] == obj2 ) then
					obstacles[i].alpha = 0
					cow.alpha = 0
					audio.play( mu )
					timer.performWithDelay(0, restoreCow )
					lives = lives - 1
					livesText.text = "Lives: " .. lives
					break
				end
			 end
				 if ( lives == 0 ) then
					cow.alpha = 0
					display.remove( cow )
					timer:performWithDelay( 300, endGame )				
				end	
			end
		end	


		--medkit collision
		if ( ( obj1.myName == "cow" and obj2.myName == "medkit" ) or
		( obj1.myName == "medkit" and obj2.myName == "cow" ) )
		then
			 lives = lives + 1
			  livesText.text = "Lives: " .. lives
		   end
	   
		--golpe collision
		if ( ( obj1.myName == "cow" and obj2.myName == "golpe" ) or
			( obj1.myName == "golpe" and obj2.myName == "cow" ) )
		then
			for i = #obstacles, 1, -1 do
				if ( obstacles[i] == obj1 or obstacles[i] == obj2 ) then
					obstacles[i].alpha = 0
					 cow.alpha = 0
					 timer.performWithDelay( 300, endGame )
				break
				end
			end	
		end 






	end 		
	end

    city1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city1)
    city2.enterFrame = moveX
	Runtime:addEventListener("enterFrame", city2)
	city3.enterFrame = moveX
	Runtime:addEventListener("enterFrame", city3)
	city4.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city4)

    -- Score
    livesText = display.newText( " Lives ".. lives, 50, 29, "Skranji-Regular.ttf", 40)
    livesText:setFillColor( 255,255,255 )
    moneyText = display.newText( "    Money ".. money, 300, 29, "Skranji-Regular.ttf", 40)
	moneyText:setFillColor( 255,255,255 )
	
	

end




function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- -- physics.start()
		Runtime:addEventListener( "collision", onCollision )
		gameLoopTimer = timer.performWithDelay( 1300, gameLoop, 0 )

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
		display.remove(backGroup)	

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		physics.pause()
		composer.removeScene( "game" )
		composer.hideOverlay()
		Runtime:removeEventListener( "collision", onCollision)
		Runtime:removeEventListener("touch", onTouch)
	end
end

-- 
function scene:destroy( event )

	local sceneGroup = self.view
	-- composer.removeScene( "game" )
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
