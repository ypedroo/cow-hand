local composer = require("composer") 	 	--Importa o Composer
local physics = require("physics") 		 	--Importa a Fisica

local sounds = require( "soundsfile" )	 	--Importa o Som

local level = require("leveltemplate")		--Importa o aqruivo leveltemplate.lua
local scene = composer.newScene()	

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Initialize variables
local json = require( "json" )

local scoresTable = {}

local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )

local musicTrack


local function loadScores()

	local file = io.open( filePath, "r" )

	if file then
		local contents = file:read( "*a" )
		io.close( file )
		scoresTable = json.decode( contents )
	end

	if ( scoresTable == nil or #scoresTable == 0 ) then
		scoresTable = { 0, 0, 0, 0, 0 }
	end
end


local function saveScores()

	for i = #scoresTable, 6, -1 do
		table.remove( scoresTable, i )
	end

	local file = io.open( filePath, "w" )

	if file then
		file:write( json.encode( scoresTable ) )
		io.close( file )
	end
end


local function gotoMenu()
	composer.gotoScene( "scene.menu", { time=800, effect="crossFade" } )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Load the previous scores
	loadScores()

	-- Insert the saved score from the last game into the table
	table.insert( scoresTable, composer.getVariable( "finalScore" ) )
	composer.setVariable( "finalScore", 0 )

	-- Sort the table entries from highest to lowest
	local function compare( a, b )
		return a > b
	end
	table.sort( scoresTable, compare )

	-- Save the scores
	saveScores()

	background = display.newImageRect( sceneGroup, "ui/background/gameover.png", 600, 400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- local backButton = display.newImageRect( sceneGroup, "ui/background/backBtn.png", 100, 50 )
	-- backButton.x = display.contentCenterX + 200
	-- backButton.y = display.contentCenterY + 120

	local backButton = display.newImageRect( sceneGroup, "ui/background/menu.png", 200, 110 )
	backButton.x = display.contentCenterX + 198
	backButton.y = display.contentCenterY + 150

	backButton:addEventListener( "tap", gotoMenu )

	local highScoresHeader = display.newText( sceneGroup, "High Scores", display.contentCenterX, 30, native.systemFont, 30 )
    highScoresHeader:setFillColor( 0.1 )
	for i = 1, 5 do
		if ( scoresTable[i] ) then
			local yPos = 130 + ( i * 23 )

			local rankNum = display.newText( sceneGroup, i .. ")", display.contentCenterX + 90, yPos -60, native.systemFont, 15 )
			rankNum:setFillColor( 0.1 )
			rankNum.anchorX = 1

			local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX + 90, yPos-60, native.systemFont, 25 )
            thisScore.anchorX = 0
            thisScore:setFillColor( 0.1 )
		end
	end

	-- local menuButton = display.newText( sceneGroup, "Menu", display.contentCenterX, 810, native.systemFont, 44 )
	-- menuButton:setFillColor( 0.75, 0.78, 1 )
	-- menuButton:addEventListener( "tap", gotoMenu )

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
		-- Start the music!
		audio.play( musicTrack, { channel=1, loops=-1 } )
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
		-- Stop the music!
		audio.stop( 1 )
		composer.removeScene( "highscore" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	-- Dispose audio!
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
