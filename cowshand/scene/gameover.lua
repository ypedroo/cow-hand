-- Include modules/libraries
local composer = require( "composer")
local widget = require( "widget" )
local sounds = require( "soundsfile" )

local level = require("leveltemplate")

-- Create a new Composer scene
local scene = composer.newScene()

local background

local function gotoMenu()
	composer.gotoScene( "scene.menu" )
end

function scene:create( event )

	-- playGameMusic(gameoverbgmusic)
	-- audio.setVolume( 0.20, { channel=1 } ) 

	local sceneGroup = self.view
	level:setValues(100,100,3)


	-- Code here runs when the scene is first created but has not yet appeared on screen

	background = display.newImageRect( sceneGroup, "ui/background/gameover.png", 600, 400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local backButton = display.newImageRect( sceneGroup, "ui/background/backBtn.png", 100, 50 )
	backButton.x = display.contentCenterX + 200
	backButton.y = display.contentCenterY + 120

	local backButton = display.newImageRect( sceneGroup, "ui/background/menu.png", 200, 100 )
	backButton.x = display.contentCenterX + 198
	backButton.y = display.contentCenterY + 70

	backButton:addEventListener( "tap", gotoMenu )
	--level:reduceProjectiles(level:getNumProjectiles())
	--level:addProjectiles(10)
	musicTrack = audio.loadStream( "sound/St_Francis.mp3" )
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play( musicTrack, { channel=1, loops=-1 } 

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
		audio.stop( 1 )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose( musicTrack )

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