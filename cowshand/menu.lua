
local composer = require( "composer")
local scene = composer.newScene()
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
        local menuBg = display.newImageRect("ui/menu/menuBg.png", 1400, 750)
        menuBg.x = display.contentCenterX
        menuBg.y = display.contentCenterY
        local logo = display.newImageRect("ui/menu/logo.png", 700, 500)
        logo.x = display.contentCenterX 
        logo.y = display.contentCenterY -250

        local start = display.newImageRect("ui/menu/start.png", 300, 300)
        start.x = display.contentCenterX -430
        start.y = display.contentCenterY +80

        local credits = display.newImageRect("ui/menu/credits.png", 300, 300)
        credits.x = display.contentCenterX 
        credits.y = display.contentCenterY 

        local quit = display.newImageRect("ui/menu/quit.png", 300, 300)
        quit.x = display.contentCenterX +430
        quit.y = display.contentCenterY  

        start:addEventListener( "tap", gotoGame )
        --audio.play( mu )
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









