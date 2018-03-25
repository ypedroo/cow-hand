
local composer = require( "composer" )

local scene = composer.newScene()

local widget = require "widget"

--physics.setGravity( 9, 8 )


--Display live and scroe
--livesText = display.newText( uiGroup, "Lives:".. Lives, 200, 80, native.systemFont, 36)
--mesText = display.newText( uiGroup, "mes:".. Mes, 600, 80, native.systemFont, 36)


local physics = require( "physics" )
        
local Lives --= 6
local mes --= 0
local died --= false

local musicTrack


--physics.start()
--physics.setGravity( 9, 8 )

function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    physics.start()  -- Temporarily pause the physics engine
   
 
    -- Set up display groups
   -- backGroup = display.newGroup()  -- Display group for the background image
   -- sceneGroup:insert( backGroup )  -- Insert into the scene's view group
 
--    mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
  --  sceneGroup:insert( mainGroup )  -- Insert into the scene's view group
 
   -- uiGroup = display.newGroup()    -- Display group for UI objects like the score
    --sceneGroup:insert( uiGroup )    -- Insert into the scene's view group
    
    --Background

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


    local ground = display.newImageRect( "ui/ground.png", 260000, 30)
    ground.x = display.contentCenterX 
    ground.y =  display.contentHeight -10
    physics.addBody(ground, "static")

-- Cow

    local cow = display.newImageRect( "ui/cow.png", 120, 130 )
    cow.x = display.contentCenterX -550
    cow.y = display.contentHeight -85
    physics.addBody(cow, "dynamic", { density = 0, friction = 0, bounce = .02, gravity = 0 })


    local function onTouch(event)
        if(event.phase == "began") then
            cow:applyLinearImpulse(0, -1, cow.x, cow.y)
        end
    end


    local function scrollCity(self, event )
        if self.x < -1024 then
            self.x = display.contentCenterX + 1200
        else
            self.x = self.x -3  - self.speed
        end

    end

    bg.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg)

    bg1.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg1)

    bg2.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg2)

    bg3.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg3)
    

    cow:addEventListener("touch", onTouch)
    musicTrack  = audio.loadSound( "soundsfile/So_Long.mp3" )
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --physics.start()
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