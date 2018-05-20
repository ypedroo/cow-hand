local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local myData = require( "data" )
local starVertices = { 0,-8,1.763,-2.427,7.608,-2.472,2.853,0.927,4.702,6.472,0.0,3.0,-4.702,6.472,-2.853,0.927,-7.608,-2.472,-1.763,-2.427 }

local function handleCancelButtonEvent()
	composer.gotoScene("scene.menu")
end

local function handleLevelSelect( event )
	if ( "ended" == event.phase ) then
	
		myData.settings.currentLevel = event.target.id
		audio.stop(1)
		if(event.target.id == '1') then
			composer.gotoScene( "scene.level1", { effect="crossFade", time=333 } )
		elseif ( event.target.id == '2') then
			composer.gotoScene( "scene.level1", { effect="crossFade", time=333 } )
		else
			composer.gotoScene( "scene.level1", { effect="crossFade", time=333 } )
		end		
	end
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( sceneGroup, "ui/menu/sky.png", 580, 300 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	sceneGroup:insert( background )

	local levelSelectGroup = display.newGroup()

	local xOffset = 150
	local yOffset = 50

	local scrollView = widget.newScrollView{
		left = -50,
		leftPadding = 50,
		rightPadding = 50,
		top = 90,
		width = display.contentWidth+100,
		height = display.contentHeight/2,
		hideBackground = true,
		horizontalScrollDisabled = false ,
		verticalScrollDisabled = true ,
	}

	local buttons = {}

	for i = 1, myData.maxLevels do

		background = display.newImageRect(myData.settings.levels[i].background, 150, 100)
		background.x = xOffset
		background.y = yOffset
		scrollView:insert(background)

		buttons[i] = widget.newButton({
			id = tostring(i),
			width = 50,
			height = 33,
			defaultFile = "ui/button/btnPause.png",
			onEvent = handleLevelSelect,
		})			

		buttons[i].x = xOffset
		buttons[i].y = yOffset
		scrollView:insert( buttons[i] )

		titleText = display.newText(myData.settings.levels[i].title, 0, 0, "zorque.ttf", 30)
		titleText:setFillColor(0.2)
		titleText.x = xOffset
		titleText.y = yOffset + 100
		scrollView:insert(titleText)

		if ( myData.settings.unlockedLevels == nil ) then
			myData.settings.unlockedLevels = 1
		end
		if ( i <= myData.settings.unlockedLevels ) then
			buttons[i]:setEnabled( true )
			buttons[i].alpha = 1.0
		else 
			buttons[i]:setEnabled( false ) 
			buttons[i].alpha = 0.5 
		end 
		
		local star = {} 
		for j = 1, 3 do
				star[j] = display.newPolygon( 0, 0, starVertices)				
				if( j <= myData.settings.levels[i].stars) then
					star[j]:setFillColor( 1, 0.9, 0 )
					
				else
					star[j]:setFillColor( 0, 0, 0 )
				end
				star[j].x = buttons[i].x + (j * 16) - 32
				star[j].y = buttons[i].y + 70
				scrollView:insert( star[j] )
		end
		
		xOffset = xOffset + 200
	end
	
	sceneGroup:insert(levelSelectGroup)
	levelSelectGroup.x = display.contentCenterX
	levelSelectGroup.y = display.contentCenterY
	
	-- local doneButton = display.newImageRect( sceneGroup, "ui/background/backbtn.png", 150, 50 )
	-- doneButton.x = display.contentCenterX + 200
	-- doneButton.y = 40
	-- doneButton:addEventListener( "tap", handleCancelButtonEvent)
	
	sceneGroup:insert(doneButton)
	sceneGroup:insert(scrollView)
end

-- On scene show...
function scene:show( event )
	local sceneGroup = self.view
	if ( event.phase == "did" ) then
	end
end

-- On scene hide...
function scene:hide( event )
	local sceneGroup = self.view
	if ( event.phase == "will" ) then
	end
end

-- On scene destroy...
function scene:destroy( event )
	local sceneGroup = self.view   
end

-- Composer scene listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
