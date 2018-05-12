local mainGroup --= display.newGroup()  -- Display group for the Lampiao etc.
local composer = require( "composer")
local scene = composer.newScene()

local mu = audio.loadSound( "soundsfile/mu.wav" )

local function gotoGame()
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
	audio.play( mu ) 
end

function scene:create( event )
 
    local sceneGroup = self.view

        local restartBg = display.newImageRect("ui/restart/tombstone.png", 1400, 750)
        restartBg.x = display.contentCenterX
        restartBg.y = display.contentCenterY

        local restart = display.newImageRect("ui/restart/restart.png", 300, 300)
        restart.x = display.contentCenterX 
        restart.y = display.contentCenterY +85

        restart:addEventListener( "tap", gotoGame )
        
 
end


function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	

	elseif ( phase == "did" ) then


	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then


	elseif ( phase == "did" ) then

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view


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









