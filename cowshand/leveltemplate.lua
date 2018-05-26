local composer = require("composer")
local base = require( "base")
local sounds = require( "soundsfile" )

local lvl = {} 
local uiGroup = display.newGroup()
local collectGroup = display.newGroup()

local background
local backgroundnear1
local backgroundnear2

local credit = 0	--Credit
local life = 0		--Vidas
local score = 0

local creditText
local lifeText

local speed = 10;
local jumpLimit = 0

local gamePaused = false
local playerT

local invoices = {}		--Cria vetor de despesas
local invCount = 0		--Qtd de elementos de despesas
local invoicesD = 0		--Despesas desaparecidas

local incomes = {}
local incCount = 0
local incomesD = 0

local currentLevel

function resumeGame()
	playerT:play()
	physics.start()
	timer.resume(movementLoop)
	timer.resume(emergeLoop)
	display.remove(pauseGroup)
	gamePaused = false
end

function pauseGame()
	gamePaused = true
	playerT:pause()
	physics.pause()
	timer.pause(movementLoop)
	timer.pause(emergeLoop)
	pauseGroup = display.newGroup()

	pauserect = display.newRect(0, 0, display.contentWidth+450, 640)
	pauserect.x = display.contentWidth/2 + 180
	pauserect:setFillColor(0)
	pauserect.alpha = 0.75
	pauserect:addEventListener("tap", function() return true end)
	pauseGroup:insert(pauserect)

	resumebox = display.newImageRect("ui/button/pause.png", display.contentWidth/2+200, display.contentHeight/2+100 )
		resumebox.x = display.contentWidth/2
		resumebox.y = display.contentHeight/2
		pauseGroup:insert(resumebox)

	resumebtn = display.newImageRect("ui/button/play.png", 60, 60)
		resumebtn.x = display.contentCenterX
		resumebtn.y = display.contentCenterY -10
		resumebtn:addEventListener("tap", resumeGame)
		pauseGroup:insert(resumebtn)

	quitbtn = display.newImageRect("ui/menu/quit.png", 60, 60)
		quitbtn.x = display.contentCenterX 
		quitbtn.y = display.contentCenterY + 300
		-- quitbtn:addEventListener("tap", menu)
		pauseGroup:insert(quitbtn)
end

-- function endGame(event)
-- 	composer.setVariable( "finalScore", score )
-- 	composer.gotoScene( "scene.gameover", { time=800, effect="crossFade" } )
-- end

function lvl:createPlayer(playerSheet, sequence)

    local sheetData = {
        width=45;               --Largura Sprite
        height=45;              --Altura Sprite
        numFrames=5;            --Número de Frames
        sheetContentWidth=225,  --Largura da Folha de Sprites
        sheetContentHeight=45  --Altura da Folha de Sprites
    }

	local sheet_player
	local player 

    if(sequence == "running") then
        local sequencesPlayer = {{
            name = "running",
            start = 1,
            count = 5,
            time = 500,
            --loopCount = 0,
            --loopDirection = "forward"
        }}

        sheet_player = graphics.newImageSheet(playerSheet, sheetData) 
        player = display.newSprite(sheet_player, sequencesPlayer)       
       
    end
	player.name = 'JOGADOR'
	player.x = 60
	player.y = 60
	player:setSequence("running")
	player:play()	

	playerT = player
	return player
end

function lvl:buildPause(player)
		local pausebtn = display.newImageRect("ui/button/btnPause.png", 60, 60)
		pausebtn.x = display.contentWidth
		pausebtn.y = 280
		pausebtn:addEventListener("tap", pauseGame)
		playerT = player
		print(playerT)
		headerGroup:insert(pausebtn)
end

function lvl:buildHeader(debitBoolean, lifeBoolean, creditBoolean) --Faixa la em cima
	headerGroup = display.newGroup()

	-- if(debitBoolean == true) then
	-- 	debitText = display.newText("Bills: $ ".. debit, 0, 0, "RifficFree-Bold.ttf", 20)
	-- 	debitText.x = 45
	-- 	debitText.y = 25
	-- 	headerGroup:insert(debitText)
	-- end

	if(creditBoolean == true) then
		creditText = display.newText("Money: ".. credit, 0, 0, "Skranji-Regular.ttf", 20)
		creditText.x = 200
		creditText.y = 25
		headerGroup:insert(creditText)
	end

	if(lifeBoolean == true) then
		lifeText = display.newText("Life: ".. life, 0, 0, "Skranji-Regular.ttf", 20)
		lifeText.x = 350
		lifeText.y = 25
		headerGroup:insert(lifeText)
	end

	return headerGroup
end

-- function lvl:addDebit(score)
-- 	debit = debit + score
-- 	debitText.text = "Debit: $ ".. debit
-- end

function lvl:addCredit(score)
	credit = credit + score
	creditText.text = "Money: $ ".. credit
end

function lvl:reduceCredit(score)
	credit = credit - score
	creditText.text = "Money: $ ".. credit
end

function lvl:addLife(score)
	life = life + score
	lifeText.text = "Life:  ".. life
end

function lvl:reducelife(score)
	life = life - score
	lifeText.text = "Life:  ".. life
end

function lvl:isAlive()
	if( life>0) then
		return true
	elseif (life > 0) then
		lvl:reducelife(1)
		return true
	else
		return false
	end
end

function lvl:setValues(lifeValue, creditValue, debitValue)
	life = lifeValue
	credit = creditValue
	debit = debitValue
end

function lvl:createBackground(currentLevel)
	local backGroup = display.newGroup()

	background = display.newImageRect(backGroup, base.levels[currentLevel].background, display.actualContentWidth, display.actualContentHeight )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	backGroup:insert(background)

	local aux1 = math.random(1, base.levels[currentLevel].numBackgroundsNear) -- Deifini o intervalo de opções	
	backgroundnear1 = display.newImage(base.levels[currentLevel].backgroundNear[aux1].path)
	backgroundnear1.y = base.levels[currentLevel].backgroundNear[aux1].y
	backgroundnear1.x = 240
	backGroup:insert(backgroundnear1)

	local aux2 = math.random(1, base.levels[currentLevel].numBackgroundsNear)
	
	backgroundnear2 = display.newImage(base.levels[currentLevel].backgroundNear[aux2].path)
	backgroundnear2.x = 760
	backgroundnear2.y = base.levels[currentLevel].backgroundNear[aux2].y
	backGroup:insert(backgroundnear2)

	return backGroup

end

function lvl:updateBackground(currentLevel)
	local backGroup = display.newGroup()

	backgroundnear1.x = backgroundnear1.x - (speed/5)

	if(backgroundnear1.x < -250) then
		local aux1 = math.random(1, base.levels[currentLevel].numBackgroundsNear)
		backgroundnear1:removeSelf()
		backgroundnear1 = display.newImage(base.levels[currentLevel].backgroundNear[aux1].path)
		backgroundnear1.y = base.levels[currentLevel].backgroundNear[aux1].y
		backgroundnear1.x = 760
		
		backGroup:insert(backgroundnear1)
	end

	backgroundnear2.x = backgroundnear2.x - (speed/5)
	if(backgroundnear2.x < -250) then
		local aux2 = math.random(1, base.levels[currentLevel].numBackgroundsNear)
		backgroundnear2:removeSelf()
		backgroundnear2 = display.newImage(base.levels[currentLevel].backgroundNear[aux2].path)
		backgroundnear2.y = base.levels[currentLevel].backgroundNear[aux2].y
		backgroundnear2.x = 760
		
		backGroup:insert(backgroundnear2)
	end

	return backGroup
end

function lvl:createFloor(groundImg)
	floorGroup = display.newGroup()
	local groundMin = 300
	local groundMax = 340
	local groundLevel = groundMin
	 
	for a = 1, 9, 1 do
		--AQUI GERAMOS O NOSSO CHÃO
		local newBlock
		newBlock = display.newImage(groundImg)
		newBlock.name = "GROUND"
		-- REPOSICIONANDO O CHÃO
		newBlock.x = (a * 79) - 85
		newBlock.y = groundLevel
		physics.addBody(newBlock, "static",  { density = 0, friction = 0, bounce = 0 })
		floorGroup:insert(newBlock)
	end

	return floorGroup
end

function lvl:moveFloor(blocks)
	for a = 1, blocks.numChildren, 1 do
		
	   if(a > 1) then
	   		newX = (blocks[a - 1]).x + 79
	   else
			newX = (blocks[9]).x + 70
	   end
		
	   if((blocks[a]).x < -80) then
	   		(blocks[a]).x, (blocks[a]).y = newX, 300
	   else
	   		(blocks[a]):translate(-5, 0)
	   end
		
	end
end

function lvl:createInvoices(currentLevel)

	local height = math.random(100, display.contentHeight-80)
	local numBills = math.random(1, base.qtdBill)
	
	invoices[invCount] = display.newImageRect(base.bills[numBills].path, 40, 40)
	invoices[invCount].x = display.contentWidth + 50
	invoices[invCount].y = height
	invoices[invCount].name = base.bills[numBills].name
	invoices[invCount].value = base.bills[numBills].value
	invoices[invCount].type = base.bills[numBills].type
	invoices[invCount].id = invCount
	physics.addBody(invoices[invCount], "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
	invCount = invCount + 1
	return invoices[invCount - 1]
end

function lvl:moveInvoices()
	for a = 0, invCount, 1 do
		if invoices[a] ~= nil and invoices[a].x ~= nil then
			if invoices[a].x < -100 then
				invoicesD = invoicesD + 1
				timer.performWithDelay(1, function()
					invoices[a] = nil;
				end, 1)
			else
				invoices[a].x = invoices[a].x  - (5/2)  -- spped/2
			end
		end
	end
end

function lvl:collideInvoices()
	invoicesD = invoicesD + 1
end

function lvl:createIncomes(currentLevel)
	local height = math.random(100, display.contentHeight-80)	
	local numColl = math.random(1, base.qtdMoney)
	print(numColl)
	
	incomes[incCount] = display.newImageRect(base.moneys[numColl].path, 30, 30)
	incomes[incCount].x = display.contentWidth + 50
	incomes[incCount].y = height
	incomes[incCount].name = base.moneys[numColl].name	
	incomes[incCount].value = base.moneys[numColl].value
	incomes[incCount].type = base.moneys[numColl].type
	incomes[incCount].id = incCount
	physics.addBody(incomes[incCount], "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
	
	incCount = incCount + 1

	return incomes[incCount - 1]
end

function lvl:moveIncomes()
	for a = 0, incCount, 1 do
		if incomes[a] ~= nil and incomes[a].x ~= nil then
			if incomes[a].x < -100 then
				incomesD = incomesD + 1
				timer.performWithDelay(1, function()
					incomes[a] = nil;
				end, 1)
			else
				incomes[a].x = incomes[a].x  - (5/2)  -- spped/2
			end
		end
	end
end

function lvl:collideIncomes()
	incomesD = incomesD + 1
end

function lvl:getCurrentLevel()
	return currentLevel
end

function lvl:setCurrentLevel(numCurrent)
	currentLevel = numCurrent
end

function lvl:getJumpLimit()
	return jumpLimit
end

function lvl:setJumpLimit(num)
	jumpLimit = jumpLimit
end

function lvl:destroy()
	display.remove(collectGroup)	
	incomes = {}
	incCount = 0
	invoices = {}
	invCount = 0
	score = 0
end

return lvl