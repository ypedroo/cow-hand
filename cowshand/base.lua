local base = {}
    base.moneys = {}
    base.qtdMoney = 3

        base.moneys[1]={}
        base.moneys[1].name = "note"
        base.moneys[1].path = "ui/elements/note.png"
        base.moneys[1].value = 50
        base.moneys[1].type = "money"

        base.moneys[2]={}
        base.moneys[2].name = "jackpot"
        base.moneys[2].path = "ui/elements/jackpot.png"
        base.moneys[2].value = 250
        base.moneys[2].type = "money"

        base.moneys[3]={}
        base.moneys[3].name = "medkit"
        base.moneys[3].path = "ui/elements/medkit.png"
        base.moneys[3].value = 1
        base.moneys[3].type = "money"

        -- base.moneys[4]={}
        -- base.moneys[4].name = "100"
        -- base.moneys[4].path = "ui/elements/oneHundred.png"
        -- base.moneys[4].value = 100
        -- base.moneys[4].type = "money"

        -- base.moneys[5]={}
        -- base.moneys[5].name = "bonus"
        -- base.moneys[5].path = "ui/elements/moneyBag.png"
        -- base.moneys[5].value = 250
        -- base.moneys[5].type = "money"

    base.bills = {}
    base.qtdBill = 3

        base.bills[1]={}
        base.bills[1].name = "receipt"
        base.bills[1].path = "ui/elements/receipt.png"
        base.bills[1].value = 100
        base.bills[1].type = "bill"

        base.bills[2]={}
        base.bills[2].name = "gargoyle"
        base.bills[2].path = "ui/elements/gargoyle.png"
        base.bills[2].value = 1
        base.bills[2].type = "bill"

        base.bills[3]={}
        base.bills[3].name = "golpe"
        base.bills[3].path = "ui/elements/golpe.png"
        base.bills[3].value = 1000000
        base.bills[3].type = "bill" 

    base.levels = {}       
        base.levels[1] = {}
            base.levels[1].background = "ui/background/sky.png"
            base.levels[1].numBackgroundsNear = 2
            base.levels[1].backgroundNear = {}

                base.levels[1].backgroundNear[1] = {}
                base.levels[1].backgroundNear[1].path = "ui/background/city1.png"
                base.levels[1].backgroundNear[1].y = 200
                
                base.levels[1].backgroundNear[2] = {}
                base.levels[1].backgroundNear[2].path = "ui/background/city1.png"
                base.levels[1].backgroundNear[2].y = 200

                base.levels[1].backgroundNear[3] = {}
                base.levels[1].backgroundNear[3].path = "ui/background/city1.png"
                base.levels[1].backgroundNear[3].y = 200
return base