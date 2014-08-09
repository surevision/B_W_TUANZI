--
-- Author: SureBrz
-- Date: 2014-07-23 14:29:03
--
TestMapScene = class("TestMapScene", function()
	return display:newScene("TestMapScene")
end)

function TestMapScene:ctor()
	TestLayer2:create():addTo(self, 0, "testLayer")
end