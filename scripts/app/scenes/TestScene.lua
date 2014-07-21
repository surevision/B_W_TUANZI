--
-- Author: SureBrz
-- Date: 2014-07-14 10:33:24
--
require("app.layers.TestLayer")
TestScene = class("TestScene", function()
	return display.newScene("TestScene")
end)

function TestScene:ctor()
	testLayer = TestLayer.new()
	testLayer:addTo(self)
end

return TestScene