--
-- Author: SureBrz
-- Date: 2014-07-27 21:45:02
--
--
-- Author: SureBrz
-- Date: 2014-07-11 12:04:47
--
import("app.layers.BaseLayer")

TestLayer2 = class("TestLayer2", BaseLayer)

TestLayer2.TestButton = nil
TestLayer2.ImageView = nil

function TestLayer2:ctor()

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
	
	self.spriteCharacter = SpriteCharacter:create("TuanZi", gameCharacter)

	--print(GameData.gameMap:passable(3, 8))
	CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(handler(self, self.update), 0, false)
	f = self
	self.spriteCharacter:pos(100, 100)
	self.spriteCharacter:addTo(self)

	--dump(self)
end

function TestLayer2:update(dt)
	self.spriteCharacter:update()
	--print(spriteCharacter.character.x)
end


function TestLayer2:onEnter()
	TestLayer2.super:onEnter()
end

function TestLayer2:onExit()
	TestLayer2.super:onExit()
end

return TestLayer2