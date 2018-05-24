local composer = require("composer") 	 	--Importa o Composer
local physics = require("physics") 		 	--Importa a Fisica

local sounds = require( "soundsfile" )	 	--Importa o Som

local level = require("leveltemplate")		--Importa o aqruivo leveltemplate.lua
local scene = composer.newScene()			-- Cria uma nova cena pelo Composer

composer.recycleOnSceneChange = true		-- Não sei o que faz

local backGroup = display.newGroup()		-- bg1 Cria um grupo para o Background
local mainGroup = display.newGroup()		-- Cria um grupo para o .....
local uiGroup = display.newGroup()			-- Cria um grupo para o .....

local jumpLimit = 0							-- Variável para Limite de pulo

musicTrack  = audio.loadSound( "soundsfile/Splashing_Around.mp3" )

function scene:create( event )

	
	
	local sceneGroup = self.view
	level:setCurrentLevel(1)				--Seta o nível atual
	--playGameMusic(babybgmusic)				--Importa do arquivo soundsfile.lua a musica 
	--audio.setVolume( 0.50, { channel=1 } ) 

	background = level:createBackground(level:getCurrentLevel()) --(OK) Adc o background relativo ao level
	backGroup:insert(background) -- OK

	player = level:createPlayer("ui/sprite/sprite_cow.png", "running")
	mainGroup:insert(player) -- OK

	level:setValues(1,100,0)		
		
	physics.start()		
	
	local floor = level:createFloor("ui/background/ground1.png")
	mainGroup:insert(floor)
		
	physics.addBody(player, "dynamic", { density = 0, friction = 0, bounce = 0})
	player.isFixedRotation=true	
	player.gravityScale = 0.8

	local function creationLoop(event)
		local aux = math.random(0, 10)

		if aux <= 6 then
			invoices = level:createInvoices(level:getCurrentLevel())
			mainGroup:insert(invoices)
		else
			incomes = level:createIncomes(level:getCurrentLevel())
			mainGroup:insert(incomes)
		end
	end

	local function update( event )
		level:moveIncomes()
		level:moveInvoices()
		level:moveFloor(floor)
		
		back = level:updateBackground(level:getCurrentLevel())
		backGroup:insert(back)
	end

	movementLoop = timer.performWithDelay(10, update, -1)
	emergeLoop = timer.performWithDelay(1700, creationLoop, -1 )

	local function playerCollision( self, event )
		
		if(event.other.name == "CHAO") then	
			jumpLimit = 0
		end

		-- AQUI EU GANHO DINHEIRO
		if( event.other.type == "money") then
			--playSFX(money)

			if event.other.name == "note" then
				level:addCredit(event.other.value)
			end
			if event.other.name == "jackpot" then
				level:addCredit(event.other.value)
			end
			if event.other.name == "medkit" then
				level:addLife(event.other.value)
			end

			
			level:collideIncomes()
			timer.performWithDelay(1, function()
				event.other.alpha = 0
		        event.other = nil
		    end, 1)
			event.other:removeSelf();
			
		end

		-- AQUI EU PERCO DINHEIRO
		if( event.other.type == "bill") then
			--playSFX(money)
			if ( event.other.name == "receipt") then
				-- level:addDebit(event.other.value)
				level:reduceCredit(event.other.value)
			end			

			if ( event.other.name == "gargoyle") then
				-- level:addDebit(event.other.value)
				level:reduceCredit(event.other.value)
				level:reducelife(event.other.value)
			end

			if ( event.other.name == "golpe") then
				level:reducelife(event.other.value)
				-- level:reduceCredit(event.other.value)
			end
	
			level:collideInvoices()
			if level:isAlive() then
				timer.performWithDelay(1, function()
					event.other.alpha = 0
					event.other = nil
				end, 1)
				event.other:removeSelf();
			else
				composer.gotoScene( "scene.gameover", { time=800, effect="crossFade" } )
			end				    	
		end
	end
	player.collision = playerCollision
	player:addEventListener("collision")


	--FUNÇÃO PARA IR PARA O PRÓXIMO NIVEL

	jumpbtn = display.newImageRect("ui/button/up.png", 60, 60)
	jumpbtn.x = 0
	jumpbtn.y = display.contentHeight - 35

--Jump Function
	function jumpbtn:touch(event)
		if(event.phase == "began") then
			jumpLimit = jumpLimit + 1
			if jumpLimit < 3 then
			  physics.addBody(player, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0 })
			  player:applyLinearImpulse(0, -0.15, player.x, player.y)
			end
		jumpLimit = 0
		end
	end

	jumpbtn:addEventListener("touch", jumpbtn)
	uiGroup:insert(jumpbtn)
		
	local header = level:buildHeader(true, true, true)
	uiGroup:insert(header)

	level:buildPause(player)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play( musicTrack, { channel=1, loops=-1 } )

	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		timer.cancel(movementLoop)
		timer.cancel(emergeLoop)
		if(toLeft ~= nil) then
			timer.cancel(toLeft)			
		end
		level:destroy()		
		display.remove(mainGroup)
		display.remove(uiGroup)
		display.remove(backGroup)		
	elseif ( phase == "did" ) then
		physics.pause()
		composer.removeScene("level1")
		composer.hideOverlay()
		Runtime:removeEventListener( "collision", onLocalCollision)
		Runtime:removeEventListener("touch", onTouch)
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

return scene