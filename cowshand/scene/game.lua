
local composer = require( "composer" )

local scene = composer.newScene()
--physics.setGravity( 9, 8 )


--Display live and scroe
--livesText = display.newText( uiGroup, "Lives:".. Lives, 200, 80, native.systemFont, 36)
--mesText = display.newText( uiGroup, "mes:".. Mes, 600, 80, native.systemFont, 36)

local physics = require( "physics" )
physics.start()
        
local Lives --= 6
local mes --= 0
local died --= false

local function onTouch(event)
    if(event.phase == "began") then
        cow:applyLinearImpulse(0, -0.8, cow.x, cow.y)
    end



function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
    physics.pause()  -- Temporarily pause the physics engine

    
    local sky = display.newImageRect("ui/sky.png", 1500, 750)
    sky.x = display.contentCenterX
    sky.y = display.contentCenterY
    
    
    local bg = display.newImageRect("ui/bg1.png", 1400, 750)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    
    local ground = display.newImageRect( "ui/ground.png", 26000, 30)
    ground.x = display.contentCenterX 
    ground.y =  display.contentHeight -10
    physics.addBody(ground, "static")
    
    
    
    local cow = display.newImageRect( "ui/cow.png", 120, 130 )
    cow.x = display.contentCenterX -400
    cow.y = display.contentHeight -10
    --physics.addBody( cow, { radius=30 })
    physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = .3, gravity = 0 })
    
    
    local button = display.newImageRect( "ui/button.png", 130, 140 )
    button.x = display.contentCenterX -600
    button.y = display.contentHeight -80
    

    cow:addEventListener("touch", onTouch)
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()
 
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
   

