--
-- Author: SureBrz
-- Date: 2014-07-23 14:29:03
--
import("..layers.Test2Layer")

TestMapScene = class("TestMapScene", function()
	return display:newScene("TestMapScene")
end)

function TestMapScene:ctor()
	Test2Layer:new():addTo(self, 0, 1)
end

return TestMapScene