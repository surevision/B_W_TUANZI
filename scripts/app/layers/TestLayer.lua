--
-- Author: SureBrz
-- Date: 2014-07-11 12:04:47
--
require("app.layers.BaseLayer")
require("app.layers.Test2Layer")
require("app.layers.InputLayer")


TestLayer = class("TestLayer", BaseLayer)

TestLayer.TestButton = nil
TestLayer.ImageView = nil

function TestLayer:ctor()
	TestLayer.super.ctor(self, "SampleUIAnimation/SampleUIAnimation.json")
	self.TestButton = self:registUIWithEventHandler("TextButton", handler(self, self.onTestButton))
	self.TestButton:setTouchPriority(-1280)
	self.ImageView = self:registUI("ImageView")
	--dump(self)
end

function TestLayer:onTestButton(sender, eventType)
	--dump(self.uiExportFilePath)
	if eventType == TOUCH_EVENT_ENDED then
		ActionManager:shareManager():playActionByName("SampleUIAnimation.json", "Animation1");
		local test2Layer = Test2Layer.new()
		test2Layer:addTo(self)
	end
end

function TestLayer:onEnter()
	TestLayer.super:onEnter()
end

function TestLayer:onExit()
	TestLayer.super:onExit()
end

return TestLayer