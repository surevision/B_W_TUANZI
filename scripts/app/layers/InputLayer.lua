--
-- Author: SureBrz
-- Date: 2014-08-10 09:56:41
--
import(".BaseLayer")
InputLayer = class("InputLayer", BaseLayer)

InputLayer.leftBtn = nil
InputLayer.rightBtn = nil
InputLayer.jumpBtn = nil

function InputLayer:ctor(filePath)
	InputLayer.super.ctor(self, filePath)
	self.leftBtn = nil
	self.rightBtn = nil
	self.jumpBtn = nil
end

function InputLayer:create(rootLayer)
	local inputLayer = self.new("UI/InputPanel/InputPanel.json")	
	inputLayer.jumpBtn = inputLayer:registUIWithEventHandler("jumpBtn", handler(rootLayer, rootLayer.onJump))
	inputLayer.leftBtn = inputLayer:registUIWithEventHandler("leftBtn", handler(rootLayer, rootLayer.onLeft))
	inputLayer.rightBtn = inputLayer:registUIWithEventHandler("rightBtn", handler(rootLayer, rootLayer.onRight))

	return inputLayer
end
