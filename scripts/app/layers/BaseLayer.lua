--
-- Author: SureBrz
-- Date: 2014-07-11 09:40:08
--
BaseLayer = class("BaseLayer", function()
	return display.newLayer("BaseLayer")
end)

BaseLayer.uiExportFilePath = nil
BaseLayer.uiLayout = nil
-- 
function BaseLayer:ctor(filePath)
	print("BaseLayer ctor with:", filePath)
	if (filePath ~= nil) then
		self:initWithExportFile(filePath)
	end
end

function BaseLayer:initWithExportFile(filePath)
	self.uiExportFilePath = filePath
	self.uiLayout = GUIReader:shareReader():widgetFromJsonFile(filePath)
	local uiLayer = TouchGroup:create()
	--print("self:", self, "self.uiLayout:", self.uiLayout, "uiLayer:", uiLayer)
	uiLayer:addWidget(self.uiLayout)
	self:addChild(uiLayer)
end

function BaseLayer:registUI(uiName)
	local t_ui = UIHelper:seekWidgetByName(self.uiLayout, uiName)
	return t_ui
end

function BaseLayer:registUIWithEventHandler(uiName, onEventHandler)
	local t_ui = UIHelper:seekWidgetByName(self.uiLayout, uiName)
	--print(uiName, onEventHandler, t_ui)
	if onEventHandler ~= nil then
		--dump(self.uiLayout)
		t_ui:addTouchEventListener(onEventHandler)
	end
	return t_ui
end

function BaseLayer:onEnter()
end

function BaseLayer:onExit()
end

return BaseLayer
--[[
function BaseLayer:handleUIEvent(sender, eventType)
	print("sender:"..sender.."\r\neventType:"..eventType)
end
]]--

