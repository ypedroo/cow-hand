
local composer = require( "composer")
local scene = composer.newScene()
--composer.recycleOnSceneChange = true
--local widget = require( "widget" )
--local sounds = require( "soundsfile" )
--local base = require( "base")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local mu = audio.loadSound( "soundsfile/mu.wav" )

local function gotoGame()
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end
 
--local function gotoCredits()
  --  composer.gotoScene( "credits", { time=800, effect="crossFade" } )
--end
 

function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
        local menuBg = display.newImageRect("ui/restart/tombstone.png", 1400, 750)
        menuBg.x = display.contentCenterX
        menuBg.y = display.contentCenterY

        local start = display.newImageRect("ui/restart/start.png", 300, 300)
        start.x = display.contentCenterX -430
        start.y = display.contentCenterY +80

        restart:addEventListener( "tap", gotoGame )
        audio.play( mu ) 
    --credits:addEventListener( "tap", gotoCredits )
    --quit:addEventListener( "tap", gotoQuit )
 
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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









