
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

--Physics the game
local physics
physics = require("physics")
physics.start()

system.activate( "multitouch" )

--Load Sprite Sheets
local sheetInfo = require("sprites.cowSprite")
local sheet = graphics.newImageSheet( "ui/cowSprite.png", sheetInfo:getSheet() )


-- local sheetInfo = require("sprites.gameObjetos")
-- local objectSheet = graphics.newImageSheet( "assets/img/gameObjetos.png", sheetInfo:getSheet() )


--Initialize Variables

local vidas = 6
local pontos = 0
local morto = false

local headsTable = {}

local background

local solo

local barreira1

local finalScore

local cow
local gameLoopTimer
local vidasText
local pontosText


local lado = "direito"

local w = display.contentWidth -- variable of width
local h = display.contentHeight -- variable of higth

local eixoX = w - 5
local eixoY = h


local sequenceCow = {
    -- { name= "paradoLeft", start = 14, count = 0, time = 800 , loopCount = 0},--loopDirection = "forward"},
	-- { name= "paradoRight", start = 13, count = 0, time = 800 , loopCount = 0},--loopDirection = "forward"},
    { name= "andandoRight", start= 1, count = 6, time =700, loopCount = 0}, --loopDirection= "forward" },
    -- { name= "andandoLeft", start= 7, count = 6, time =700, loopCount = 0},-- loopDirection= "forward" }

}

-- Set up display groups
local backGroup --= display.newGroup()  -- Display group for the background image
local mainGroup --= display.newGroup()  -- Display group for the Cow etc.
local uiGroup --= display.newGroup()    -- Display group for UI objects like the pontos

local function updateText()
	vidasText.text = "Vidas: " .. vidas
	pontosText.text = "Pontos: " .. pontos
end


-- local function update( event )
-- 	updateBackgrounds()
-- end
 
-- function updateBackgrounds()
-- 	--background movement
-- 	background.x = background.x - (2)
 
-- 	--solo movement
-- 	solo.x = solo.x - (2)

-- 	if(background.x < -200) then
-- 		background.x = 600
-- 	end
 
-- 	solo.x = solo.x - (2)

-- 	if(solo.x < -200) then
-- 		solo.x = 600
-- 	end


-- end

local function createInimigo()
	baddola = display.newImageRect( "ui/baddola.png", 70, 70 )
    table.insert( headsTable, newHead )
    physics.addBody( "dynamic", { radius=30, bounce=0 } )
    newHead.myName = "baddola"

	local whereFrom = math.random( 3 )

	if ( whereFrom == 1 ) then
        -- From the left
        newHead.x = -60
		newHead.y = math.random( 100 )
		newHead:setLinearVelocity( math.random( 30,90 ), math.random( 10,50 ) )
	elseif ( whereFrom == 2 ) then
        -- From the top
        newHead.x = math.random( display.contentWidth )
        newHead.y =  -60
        newHead:setLinearVelocity( math.random( -20,20 ), math.random( 30,90 ) )
    elseif ( whereFrom == 3 ) then
        -- From the right
        newHead.x = display.contentWidth + 60 
        newHead.y = math.random( 100 )
        newHead:setLinearVelocity( math.random( -90,-30 ), math.random( 10,50 ) )
	end
	
	newHead:applyTorque( math.random( -3,3 ) )
end

local function gameLoop()
	
	   -- Create new headGado
	   createInimigo()
	
	   -- Remove headGados which have drifted off screen
	   for i = #headsTable, 1, -1 do
		local thisHead = headsTable[i]
		
			   if ( thisHead.x < -100 or
			   		thisHead.x > display.contentWidth + 50 or
			   		thisHead.y < -100 or
			   		thisHead.y > display.contentHeight + 50 )
			   then
				   display.remove( thisHead )
				   table.remove( headsTable, i )
			   end
	   end
   end

--gameLoopTimer = timer.performWithDelay( 800, gameLoop, 0 )

-- --Reviver Lampião
-- local function reviverLampiao()
	
-- 	   lampiao.isBodyActive = false
-- 	   lampiao.x = solo.x - 600
-- 	   lampiao.y = solo.y-195
	
-- 	   -- Fade in the lampiao
-- 	   transition.to( lampiao, { alpha=1, time=4000,
-- 		   onComplete = function()
-- 			   lampiao.isBodyActive = true
-- 			   morto = false
-- 		   end
-- 	   } )
-- end

local function endGame()
	composer.setVariable( "finalScore", pontos )
    composer.gotoScene( "morreu", { time=800, effect="crossFade" } )
	--composer.removeScene("menu")
end

local function onCollision( event )
	
	if ( event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		if ( ( obj1.myName == "cow" and obj2.myName == "baddola" ) or
		( obj1.myName == "baddola" and obj2.myName == "cow" ) )
			then
			
			-- Remove both the municao and headGado
			display.remove( obj1 )
			display.remove( obj2 )

			for i = #headsTable, 1, -1 do
			if ( headsTable[i] == obj1 or headsTable[i] == obj2 ) then
				table.remove( headsTable, i )
				break
			end
			end
			
			-- Increase pontos
			pontos = pontos + 1
			pontosText.text = "Pontos: " .. pontos
		

		end
	end
end

--Runtime:addEventListener( "collision", onCollision )
   

function pular( event)
    if event.phase=="began" then
		local vx, vy = cow:getLinearVelocity()
        cow:applyLinearImpulse(0, -1.2, cow.x, cow.y)
	end
end

local function andandoRight( event )

  if ( "began" == event.phase ) then
	-- audio.play( moveTrack )
	lado = "direito"
    lampiao:setSequence( "andandoRight" )
	lampiao:play()
    -- start moving lampiao
	lampiao:applyLinearImpulse( 1, 0, lampiao.x, lampiao.y )
	--lampiao:addEventListener( "tap", tiroBala )
  elseif ( "ended" == event.phase ) then
    lampiao:setSequence( "paradoRight" )
    lampiao:play()
    lampiao:setLinearVelocity( 0,0 )
  end
end

-- local function andandoLeft( event )
-- 	if ( "began" == event.phase ) then
-- 		-- audio.play( moveTrack )
-- 		lado = "esquerdo"
--     	lampiao:setSequence( "andandoLeft" )
--     	lampiao:play()
-- 		lampiao:applyLinearImpulse( -1, 0, lampiao.x, lampiao.y )
-- 		--lampiao:addEventListener( "tap", tiroBala )
--   	elseif ( "ended" == event.phase ) then
--     	lampiao:setSequence( "paradoLeft" )
-- 		lampiao:play()
--     	--lampiao:setFrame(1)
--     	lampiao:setLinearVelocity( 0,0 )
--   end
-- end

--timer.performWithDelay(1, update, -1)


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()
	
	-- Set up display groups
	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert(backGroup)  -- Insert into the scene's view group
		
	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert(mainGroup)  -- Insert into the scene's view group
		
	uiGroup = display.newGroup()    -- Display group for UI objects like the score
	sceneGroup:insert(uiGroup)    -- Insert into the scene's view group

		
	--Backgroud image
	local background = display.newImageRect("ui/bg1.png", 1400, 750)
	background.x = display.contentCenterX
    background.y = display.contentCenterY
    background.speed = 1

    local background1 = display.newImageRect("ui/bg1.png",1400, 750)
    background1.x = 2000
    background1.y = 400
    background1.speed = 1

    local background2 = display.newImageRect("ui/bg2.png", 1400, 200)
    background2.x = display.contentCenterX 
    background2.y = display.contentCenterY +250
    background2.speed = 2
    
    local background3 = display.newImageRect("ui/bg2.png", 1600, 200)
    background3.x =  1800
    background3.y =  640
    background3.speed = 2

	--Solo image
	local solo = display.newImageRect( "ui/ground.png", 2600000, 30)
    solo.x = display.contentCenterX 
    solo.y =  display.contentHeight -10
    physics.addBody(solo, "static",{ bounce=0 })
	solo.name = "solo"
	
	-- cactu = display.newImageRect( backGroup, "assets/img/cactuSprite.png", 80, 75 )
	-- cactu.x = display.contentCenterX - 130
	-- cactu.y = solo.y-195
	-- physics.addBody(cactu, "static", {friction= .1, isSensor=true})

	-- cactu2 = display.newImageRect( backGroup, "assets/img/cactuSprite.png", 90, 90 )
	-- cactu2.x = display.contentCenterX + 400
	-- cactu2.y = solo.y-195
	-- physics.addBody(cactu2, "static", {friction= .1, isSensor=true})

	-- barreira1 = display.newRect(2, 1080, 2, 1080)
	-- barreira1.x = solo.x - 700
	-- barreira1.y = solo.y-195
	-- barreira1:setFillColor(0,255,0)
	-- --barreira1.alpha = 2
	-- physics.addBody(barreira1, "static")

	-- barreira2 = display.newRect(2, 1080, 2, 1080)
	-- barreira2.x = solo.x + 700
	-- barreira2.y = solo.y-195
	-- barreira2:setFillColor(0,255,0)
	-- --barreira1.alpha = 2
	-- physics.addBody(barreira2, "static")


	cow = display.newSprite( backGroup, sheet, sequenceCow)
	cow.x = solo.x - 600
	cow.y = solo.y-195
	physics.addBody( cow, "dynamic", {box, bounce=0.1, friction=0, isSensor=false},
	{box={halfWidth=30, halfHeight=10, x=0, y=60}, isSensor=true } )
	cow: setSequence("paradoRight")
	cow:play()
	cow.isFixedRotation = true
	cow.myName = "cow"

	
	-- Display vidas and pontos
	vidasText = display.newText( uiGroup, "Vidas: " .. vidas, 10, 40, native.systemFont, 36 )
	vidasText:setFillColor( 0, 0, 0 )
	pontosText = display.newText( uiGroup, "Pontos: " .. pontos, 210, 40, native.systemFont, 36 )
	pontosText:setFillColor( 0, 0, 0 )


end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		
		physics.start()
		Runtime:addEventListener( "collision", onCollision )
		gameLoopTimer = timer.performWithDelay( 1300, gameLoop, 0 )
				
		-- Initialize widget(Botões)
		-- widget = require("widget")


		-- jump_button = widget.newButton( {
		-- 	id = "jumpButton",
		-- 	width = 120,
		-- 	height = 120,
		-- 	defaultFile = "assets/buttons/lineLight23.png",
		-- 	left = 1000,
		-- 	top = 615,
		-- 	onEvent = pular
		-- } )

		-- atack_button = widget.newButton( {
		-- 	id = "atack_button",
		-- 	width = 120,
		-- 	height = 120,
		-- 	defaultFile = "assets/buttons/lineAtack.png",
		-- 	left = 790,
		-- 	top = 615,
		-- 	onEvent = tiroBala;
		-- } )

		-- left_button = widget.newButton( {
		-- 	id = "left_button",
		-- 	width = 120,
		-- 	height = 120,
		-- 	defaultFile = "assets/buttons/lineLight22.png",
		-- 	left = -100,
		-- 	top = 615,
		-- 	onEvent = andandoLeft
		-- } )

		-- right_button = widget.newButton( {
		-- 	id = "right_button",
		-- 	width = 120,
		-- 	height = 120,
		-- 	defaultFile = "assets/buttons/lineLight23.png",
		-- 	left = 110,
		-- 	top = 615,
		-- 	onEvent = andandoRight
		-- } )

		-- right_button.alpha = .2;
		-- left_button.alpha = .2;
		-- atack_button.alpha = .2;
		-- jump_button.alpha = .2;
		-- jump_button.rotation = -90;

		--uiGroup:insert( atk_button )
		--uiGroup:insert( jump_button )
		--uiGroup:insert( right_button )
		--uiGroup:insert( left_button )
		-- Load gamepad end

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
		Runtime:removeEventListener( "collision", onCollision )
		physics.pause()
		composer.removeScene( "game" )
		

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
