--
-- Author: SureBrz
-- Date: 2014-07-14 10:40:46
--
import("app.layers.BaseLayer")

Test2Layer = class("Test2Layer", BaseLayer)

Test2Layer.Button_1 = nil
Test2Layer.Button_2 = nil
Test2Layer.TextField_3 = nil
function Test2Layer:ctor()
	Test2Layer.super.ctor(self, "ButtonTest_1/ButtonTest_1.json")
	self.Button_1 = self:registUIWithEventHandler("Button_1", handler(self, self.onButton1))
	self.Button_2 = self:registUIWithEventHandler("Button_2", handler(self, self.onButton2))
	self.TextField_3 = self:registUIWithEventHandler("TextField_3")
	self.TextField_3:setTouchEnabled(true)
	self.TextField_3:setPlaceHolder("hi")
	self.TextField_3:setPosition(ccp(100, 200))
	self.TextField_3:setVisible(false)

	local textField = TextField:create()
	textField:setPosition(ccp(self.TextField_3:getPositionX(), self.TextField_3:getPositionY()))
	textField:setPlaceHolder("text")
	textField:setTouchEnabled(true)
	textField:addEventListenerTextField(handler(self, self.textFieldEvent)) 
	textField:addTo(self)
	print(";;;;;;;;;;;;;;", self.TextField_3)



	dump(self.Button_1, self.Button_2)
	local lb = CCLabelTTF:create("ttttttttttttttttttttttttttttttttt", "Arial.ttf", 36, cc.SizeMake(64, 1), kCCTextAlignmentLeft)
	lb:setAnchorPoint(0, 0)
	lb:pos(display.cx, display.cy)
	lb:addTo(self)
	--dump(self)
end

function Test2Layer:textFieldEvent(sender, eventType)
	print(eventType)
end

function Test2Layer:onButton1(sender, eventType)
	--dump(self.uiExportFilePath)
	if eventType == TOUCH_EVENT_ENDED then
		local str = string.urlencode("中文")
		print(str)
		--print(string.urldecode(string.urlencode("中文")))
	end
end

function Test2Layer:onButton2(sender, eventType)
	--dump(self.uiExportFilePath)
	if eventType == TOUCH_EVENT_ENDED then
		print("button2")
		self:removeFromParentAndCleanup(true)
	end
end

function Test2Layer:onEnter()
	Test2Layer.super:onEnter()
end

function Test2Layer:onExit()
	Test2Layer.super:onExit()
end

return Test2Layer