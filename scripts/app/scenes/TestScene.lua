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
    gameCharacter:setPos(13, 0)
    
    spriteCharacter = SpriteCharacter:create("TuanZi", gameCharacter)
    spriteCharacter:refreshPosition()

    --print(GameData.gameMap:passable(3, 8))
    CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(handler(self, self.update), 0, false)
    gameMap.tmxMap:addTo(self)
    spriteCharacter:addTo(self, 127, 12)      
	spriteCharacter:refreshPosition()	

	local jumpticker = CCCallFunc:create(handler(self, function()
		spriteCharacter.character.spY = -GameCharacter.JUMP_SPEED
	end))
	local delay = CCDelayTime:create(2)
	local array = CCArray:create()
	array:addObject(delay)
	array:addObject(jumpticker)
	local repeater = CCRepeatForever:create(CCSequence:create(array))
	-- spriteCharacter:runAction(repeater)

	local uilayer = InputLayer:create(self)
	uilayer:setAnchorPoint(0, 0)
	uilayer:pos(0, 0)
	uilayer:addTo(self, 128)

    local label = CCLabelTTF:create("h", "Arial", 12)
    print(label:getContentSize())
end

function TestScene:onCallback()

end

function TestScene:update(dt)
    local label = CCLabelTTF:create("h", "Arial", 12)
    print(label:getContentSize().width, "----------======================-------------")
    label = CCLabelTTF:create("i", "Arial", 12)
    print(label:getContentSize().width, "----------======================-------------")
    label = CCLabelTTF:create("W", "Arial", 12)
    print(label:getContentSize().width, "----------======================-------------")
    label = CCLabelTTF:create("我", "Arial", 12)
    print(label:getContentSize().width, "----------======================-------------")


	if spriteCharacter.character.real_x <= display.cx then 
		-- 不到中心，在左侧
	elseif spriteCharacter.character.real_x >= GameData.gameMap:rwidth() - display.cx then 
		-- 不到中心，在右侧
	else
		-- 在中心
		GameData.gameMap.tmxMap:setPositionX(display.cx - spriteCharacter.character.real_x)
	end

    spriteCharacter:update()

	--print(spriteCharacter.character.x)
end

function TestScene:onJump(sender, eventType)
	--dump(self.uiExportFilePath)
	
	if eventType == TOUCH_EVENT_BEGAN then
		spriteCharacter.character:jump()
	end
end

function TestScene:onLeft(sender, eventType)
	--dump(self.uiExportFilePath)
	
	if eventType == TOUCH_EVENT_BEGAN then
		spriteCharacter.character:walkLeft()
	elseif eventType == TOUCH_EVENT_ENDED then
		spriteCharacter.character:walkIdle()
	end
end

function TestScene:onRight(sender, eventType)
	--dump(self.uiExportFilePath)
	if eventType == TOUCH_EVENT_BEGAN then
		spriteCharacter.character:walkRight()
	elseif eventType == TOUCH_EVENT_ENDED then
		spriteCharacter.character:walkIdle()
	end
end

return TestScene