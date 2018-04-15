
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

--[[Load Sprite Sheets
local sheetInfo = require("sprites.lampion")
local sheet = graphics.newImageSheet( "assets/img/lampion.png", sheetInfo:getSheet() )

local sheetInfo = require("sprites.gameObjetos")
local objectSheet = graphics.newImageSheet( "assets/img/gameObjetos.png", sheetInfo:getSheet() )
]]

--Initialize Variables

local vidas = 3
local royal = 0
local morto = false

local headsTable = {}

local background
local solo

local barreira1
local barreira2

local lampiao
local gameLoopTimer
local vidasText
local pontosText


local lado = "direito"

local w = display.contentWidth -- variable of width
local h = display.contentHeight -- variable of higth

local eixoX = w - 5
local eixoY = h


-- Set up display groups
local backGroup --= display.newGroup()  -- Display group for the background image
local mainGroup --= display.newGroup()  -- Display group for the Lampiao etc.
local uiGroup --= display.newGroup()    -- Display group for UI objects like the pontos

local function updateText()
	vidasText.text = "Vidas: " .. vidas
	royalText.text = "Pontos: " .. pontos
end


local function update( event )
	updateBackgrounds()
end
 
function updateBackgrounds()
	--background movement
	background.x = background.x - (2)
 
	--solo movement
	solo.x = solo.x - (2)

	if(background.x < -200) then
		background.x = 600
	end
 
	solo.x = solo.x - (2)

	if(solo.x < -200) then
		solo.x = 600
	end


end

local function createInimigo()
	local baddola = display.newImageRect( "ui/baddola.png", 70, 70 )
        table.insert( headsTable, newHead )
        physics.addBody( newHead, "dynamic", { radius=30, bounce=0.4 } )
        newHead.myName = "baddola"
	newHead.isFixedRotation = true

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

--Reviver Lampião

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
			royal = royal + 1
			royalText.text = "Royal: " .. royal
		--[[elseif ( ( obj1.myName == "lampiao" and obj2.myName == "headGado" ) or
		( obj1.myName == "headGado" and obj2.myName == "lampiao" ) )
			then
			
				if ( morto == false ) then
				morto = true
	
				-- Update vidas
				vidas = vidas - 1
				vidasText.text = "Vidas: " .. vidas
	
				if ( vidas == 0 and morto == true ) then
					display.remove( lampiao )
					display.remove(jump_button)
					display.remove(atack_button)
					display.remove(right_button)
					display.remove(left_button)
					timer.performWithDelay( 400, endGame )
				else
					lampiao.alpha = 0
					timer.performWithDelay( 950, reviverLampiao )
				end
			end]]

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


    local ground = display.newImageRect( "ui/ground.png", 2600000, 30)
    ground.x = display.contentCenterX 
    ground.y =  display.contentHeight -10
    physics.addBody(ground, "static")
    ground.name = "ground"


	
	-- Display vidas and pontos
	vidasText = display.newText(  "Vidas: " .. vidas, 10, 40, "xilosa.ttf", 36 )
	vidasText:setFillColor( 0, 0, 0 )
	royalText = display.newText( "Royal: " .. royal, 210, 40, "xilosa.ttf", 36 )
	royalText:setFillColor( 0, 0, 0 )


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
