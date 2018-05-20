
-- Include modules/libraries
local composer = require( "composer")
local widget = require( "widget" )
--local sounds = require( "soundsfile" )

local level = require("leveltemplate")

-- Create a new Composer scene
local scene = composer.newScene()

local background

local function gotoMenu()
	composer.gotoScene( "scene.level1" )
end

function scene:create( event )

	local sceneGroup = self.view
	level:setValues(100,100,3)


	-- Code here runs when the scene is first created but has not yet appeared on screen

	background = display.newImageRect( sceneGroup, "ui/background/gameover.png", 600, 400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local backButton = display.newImageRect( sceneGroup, "ui/background/backBtn.png", 200, 65 )
	backButton.x = display.contentCenterX + 180
	backButton.y = display.contentCenterY + 120

	--[[local age = level:createScoreAge()
	sceneGroup:insert(age)
	age.y = 50]]

	backButton:addEventListener( "tap", gotoMenu )
	--level:reduceProjectiles(level:getNumProjectiles())
	--level:addProjectiles(10)
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