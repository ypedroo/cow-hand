-- Include modules/libraries
local composer = require( "composer")
-- local loadsave = require( "loadsave")

composer.recycleOnSceneChange = true

local physics = require("physics")
local widget = require( "widget" )
local sounds = require( "soundsfile" )
local base = require( "base")

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y

-- Create a new Composer scene
local scene = composer.newScene()

local function gotoGame()
	playSFX(losesound)
	 
	composer.gotoScene( "scene.level1" )
end

local function gotoHighscore()
	-- playSFX(losesound)

	composer.gotoScene( "scene.highscore", { time=800, effect="crossFade" } )
end

function gotoQuit()
    if  system.getInfo("platformName")=="Android" then
        native.requestExit()
    else
		os.exit() 
	end
end



local backGroup = display.newGroup()
local mainGroup = display.newGroup()

function scene:create( event )
	musicTrack = audio.loadStream( "sound/Splashing_Around.mp3" )
	-- playGameMusic(menubgmusic)
	-- audio.play(musicTrack)

	
local sceneGroup = self.view
	local background = display.newImageRect( backGroup,"ui/menu/display.png", display.actualContentWidth, display.actualContentHeight )
	background.x = cX 
	background.y = cY

	local logo = display.newImageRect(mainGroup, "ui/menu/logo.png", 300, 200)
    logo.x = cX 
	logo.y = cY-123
	
    local play = display.newImageRect(mainGroup, "ui/menu/start.png", 150, 100)
    play.x = cX
	play.y = cY
	
    local score = display.newImageRect(mainGroup, "ui/menu/score.png", 150, 100)
    score.x = cX 
	score.y = cY+65
	
    local quit = display.newImageRect(mainGroup, "ui/menu/quit.png", 150, 100)
    quit.x = cX
	quit.y = cY+90 
	
    play:addEventListener( "tap", gotoGame )
	score:addEventListener( "tap", gotoHighscore )
	quit:addEventListener( "tap", gotoQuit )
	
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then		
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play( musicTrack, { channel=1, loops=-1 }) 
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene("menu")
		display.remove(backGroup)
		print( "Removendo background" )
		display.remove(mainGroup)
		print( "Removendo Botões" )
		composer.hideOverlay()
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