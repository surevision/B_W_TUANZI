--
-- Author: SureBrz
-- Date: 2014-07-14 10:33:24
--
require("app.layers.TestLayer")
import("..game.GameData")
import("..game.GameMap")
import("..game.GameCharacter")
import("..sprite.SpriteCharacter")
TestScene = class("TestScene", function()
	return display.newScene("TestScene")
end)

function TestScene:ctor()
	--testLayer = TestLayer.new()
	--testLayer:addTo(self)
	-- local sizeLabel = ui.newTTFLabel({text = "hello world", size = 36, align = ui.TEXT_ALIGN_CENTER})
	-- sizeLabel:pos(display.cx, display.cy)
 --    --blinkAction = CCBlink:create(1, 1)	-- cause crash when stop
 --    --repeatAction = CCRepeat:create(blinkAction, 2)

 --    --sizeLabel:runAction(repeatAction)
	-- sizeLabel:addTo(self)

	local drawNode = CCDrawNode:create()

	local r = cc.RectMake(0, 0, 100, 100)
	local c = ccColor4F:new()
	c.r = 0
	c.g = 1
	c.b = 1
	c.a = 1
	drawNode:drawSegment(ccp(200, 200), ccp(100, 100), 6, c)
	self:addChild(drawNode)


    local gameMap = GameMap:new()
    gameMap:setup(1)

    GameData.gameMap = gameMap
    local gameCharacter = GameCharacter:new()
    gameCharacter.x = 2
    gameCharacter.y = 8
    
    spriteCharacter = SpriteCharacter:create("Hero", gameCharacter)
    print("3333333333333333333333")

    --print(GameData.gameMap:passable(3, 8))
    CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(handler(self, self.update), 0, false)

    spriteCharacter:addTo(self)   
    print("1")
    dump(GameData.gameMap)

    	spriteCharacter:update()

    	spriteCharacter:update()

    	spriteCharacter:update()

    	spriteCharacter:update()

    	spriteCharacter:update()

    	spriteCharacter:update()

    	
    	spriteCharacter:update()

end

function TestScene:onCallback()

end

function TestScene:update(dt)
	if flag == nil then
		flag = true
	    print("2")
	    dump(GameData.gameMap)
    end
	--print(spriteCharacter.character.x)
end
return TestScene