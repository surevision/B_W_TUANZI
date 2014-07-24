--
-- Author: SureBrz
-- Date: 2014-07-14 10:33:24
--
require("app.layers.TestLayer")
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
end

function TestScene:onCallback()

end

return TestScene