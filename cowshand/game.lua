--Testa criar um name pra cada object e usar self como na doc para testar collision
local composer = require( "composer" )

local scene = composer.newScene()

local widget = require "widget"

--composer.recycleOnSceneChange = true

physics = require( "physics" )
physics.start()

local sheetInfo = require("sprites.cow")
local sheet = graphics.newImageSheet( "ui/cowSprite.png", sheetInfo:getSheet() )

local musicTrack


local lives = 6
local money = 0
local jumpLimit = 0 
local dead = false
local headsTable = {}
local gameLoopTimer




local function createBaddola()
    baddola = display.newImageRect( "ui/baddola.png", 70, 70 )
    table.insert( headsTable, newHead )
    physics.addBody( "dynamic", { radius=30, bounce=0 } )
    newHead.myName = "baddola"

local whereFrom = math.random( 3 )

    if ( whereFrom == 1 ) then
        newHead.x = display.contentCenterX + 1000
        newHead.y = math.random(90,220)
        newHead.setLinearVelocity( math.random( 30,90 ), math.random( 10,50 ) )
    elseif ( whereFrom == 2 ) then
        newHead.x = display.contentCenterX + 1000
        newHead.y = math.random(80,220)
        newHead.setLinearVelocity( math.random( -20,20 ), math.random( 30,90 ) )
    elseif ( whereFrom == 3 ) then
        newHead.x = display.contentCenterX + 1000
        newHead.y = math.random(75,220)
        newHead.setLinearVelocity( math.random( -90,-30 ), math.random( 10,50 ) )
    end
        newHead.applyTorque( math.random( -3,3 ) )
end


local function gameLoop()
createBaddola()
for i = #headsTable, 1, -1 do
local thisHead = headsTable[i]

    if ( thisHead.x < -1000 or
            thisHead.x > display.contentWidth + 50 or
            thisHead.y < -1000 or
            thisHead.y > display.contentHeight + 50 )
    then
        display.remove( thisHead )
        table.remove( headsTable, i )
    end
end
end

gameLoopTimer = timer.performWithDelay(800, gameLoop, 0 )  


--[[local function createBaddola1()
local baddola1 = display.newImageRect( "ui/baddola.png", 70, 70 )
baddola1.x = display.contentCenterX +550
baddola1.y = display.contentHeight  -100
baddola1.speed = math.random(2,8)
baddola1.initY = baddola1.y
baddola1.amp   = math.random(20,100)
baddola1.angle = math.random(20,100)
baddola1.name = "baddola"
physics.addBody(baddola1, "static", { density = 0, friction = 0, bounce = .02 })
end

local function createGorgoyle()
local gorgoyle = display.newImageRect( "ui/gorgoyle.png", 160, 160 )
gorgoyle.x = display.contentCenterX +550
gorgoyle.y = display.contentHeight  -100
gorgoyle.speed = math.random(2,8)
gorgoyle.initY = gorgoyle.y
gorgoyle.amp   = math.random(20,100)
gorgoyle.angle = math.random(20,100)
gorgoyle.name = "gorgoyle"
physics.addBody(gorgoyle, "static", { density = 0, friction = 0, bounce = .02 })
end]]
--Functions 
local function onTouch(event)
if(event.phase == "began") then
    jumpLimit = jumpLimit + 1
    if jumpLimit < 5 then
      physics.addBody(cow, "dynamic", { density = 0.015, friction = 0, bounce = 0, gravity = 0 })
      cow:applyLinearImpulse(0, -1.3, cow.x, cow.y)
    end
 jumpLimit = 0
end
end
Runtime:addEventListener("touch", onTouch)


local function onCollision( event )

if ( event.phase == "began" ) then

    local obj1 = event.object1
    local obj2 = event.object2

    if ( ( obj1.myName == "cow" and obj2.myName == "baddola" ) or
       ( obj1.myName == "baddola" and obj2.myName == "cow" ) )
    then
        
    display.remove( obj1 )
    display.remove( obj2 )

    for i = #headsTable, 1, -1 do
        if ( headsTable[i] == obj1 or headsTable[i] == obj2 ) then
            table.remove( headsTable, i )
            break
        end
    end
    
    
    -- Increase pontos
    money = money - 100
    moneyText.text = "Money: " .. money

    end

end
end 

Runtime:addEventListener( "collision", onCollision )

local function scrollCity(self, event )
    if self.x < -1024 then
       self.x = display.contentCenterX + 1199
    else
        self.x = self.x -3  - self.speed
        
    end

end

    
local function moveIncome(self, event )
    if self.x < -2000 then
        self.x = display.contentCenterX + 1000
        self.y = math.random(90,220)
        self.speed = math.random(2,8)
        self.amp   = math.random(20,100)
        self.angle = math.random(20,100)
    else
        self.x = self.x - self.speed
        self.angle = self.angle + .1
        self.y = self.amp * math.sin(self.angle)+self.initY
    end

end

local function moveCheck(self, event )
    if self.x < -3000 then
        self.x = display.contentCenterX + 1000
        self.y = math.random(90,220)
        self.speed = math.random(2,8)
        self.amp   = math.random(20,100)
        self.angle = math.random(20,100)
    else
        self.x = self.x - self.speed
        self.angle = self.angle + .1
        self.y = self.amp * math.sin(self.angle)+self.initY
    end
    

end

function scene:create( event )
 
    local sceneGroup = self.view
    local phase = event.phase

   
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


    local ground = display.newImageRect( "ui/ground.png", 2600000, 30)
    ground.x = display.contentCenterX 
    ground.y =  display.contentHeight -10
    physics.addBody(ground, "static",{ bounce=0 })
    ground.name = "ground"

-- Score
    livesText = display.newText( "Lives: ".. lives, 0, 100, native.systemFont, 40)
    livesText:setFillColor( 0, 0, 0 )
    moneyText = display.newText( "Money: ".. money, 300, 100, native.systemFont, 40)
    moneyText:setFillColor( 0, 0, 0  )

-- Cow

    local cow = display.newImageRect( "ui/cow.png", 120, 130 )
    cow.x = display.contentCenterX -550
    cow.y = display.contentHeight -85
    cow.name = "cow"


-- Colectables
  --[[  local function createMoney()
        local dola = display.newImageRect( "ui/dola.png", 70, 70 )
        dola.x = display.contentCenterX +550
        dola.y = display.contentHeight  -100
        dola.speed = math.random(2,8)
        dola.initY = dola.y
        dola.amp   = math.random(20,100)
        dola.angle = math.random(20,100)
        dola.name = "dola"
        physics.addBody(dola, "static", { density = 0, friction = 0, bounce = .02 })
    end

    local function createCheck()
        local check = display.newImageRect( "ui/check.png", 70, 70 )
        check.x = display.contentCenterX +550
        check.y = display.contentHeight  -100
        check.speed = math.random(2,8)
        check.initY = check.y
        check.amp   = math.random(20,100)
        check.angle = math.random(20,100)
        check.name = "check"
        physics.addBody(check, "static", { density = 0, friction = 0, bounce = .02 })
    end

--enemies
    local function createBaddola()
        local baddola = display.newImageRect( "ui/baddola.png", 70, 70 )
        baddola.x = display.contentCenterX +550
        baddola.y = display.contentHeight  -100
        baddola.speed = math.random(2,8)
        baddola.initY = baddola.y
        baddola.amp   = math.random(20,100)
        baddola.angle = math.random(20,100)
        baddola.name = "baddola"
        physics.addBody(baddola, "static", { density = 0, friction = 0, bounce = .02 })
    end]]--
    
  

    --[[local function moveEnemies(self, event )
        if self.x < -2300 then
            self.x = display.contentCenterX + 1000
            self.y = math.random(90,220)
            self.speed = math.random(2,8)
            self.amp   = math.random(20,100)
            self.angle = math.random(20,100)
        else
            self.x = self.x - self.speed
            self.angle = self.angle + .1
            self.y = self.amp * math.sin(self.angle)+self.initY
            --gorgoyle:removeSelf()
        end

    end

    local function moveBaddola(self, event )
        if self.x < -1500 then
            self.x = display.contentCenterX + 1000
            self.y = math.random(90,220)
            self.speed = math.random(2,8)
            self.amp   = math.random(20,100)
            self.angle = math.random(20,100)
        else
            self.x = self.x - self.speed
            self.angle = self.angle + .1
            self.y = self.amp * math.sin(self.angle)+self.initY
        end

    end--]]

    bg.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg)

    bg1.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg1)

    bg2.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg2)

    bg3.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", bg3)

   --[[ baddola.enterFrame = movmoveEnemies
    Runtime:addEventListener("enterFrame", baddola)

    baddola1.enterFrame = moveBaddola
    Runtime:addEventListener("enterFrame", baddola1)

    gorgoyle.enterFrame = moveEnemies
    Runtime:addEventListener("enterFrame", gorgoyle)

    dola.enterFrame = moveIncome
    Runtime:addEventListener("enterFrame", dola)
    
    check.enterFrame = moveCheck
    Runtime:addEventListener("enterFrame", check)]]
    
    
    
    --musicTrack  = audio.loadSound( "soundsfile/So_Long.mp3" )
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --physics.start()
        physics.start()
		--Runtime:addEventListener( "collision", onCollision )
		gameLoopTimer = timer.performWithDelay( 1300, gameLoop, 0 )
				
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
		composer.hideOverlay()
		--Runtime:removeEventListener( "collision", onCollision)
		--Runtime:removeEventListener("touch", onTouch)
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
