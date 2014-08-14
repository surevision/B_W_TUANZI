-- ↓ require common
-- ↓ require common

import("..common.Global")

import("..common.CocosArmature")
import("..common.EffectMgr")
import("..game.GameMap")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
function MainScene:ctor()
    id = 0
    local node = SceneReader:sharedSceneReader():createNodeWithSceneFile("publish/RPGGame.json"):addTo(self)

    ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)
    local labelSize = ui.newTTFLabel({
    	text = string.format("width:%.01f, height:%.01f", display.width, display.height),
    	size = 32,
    	align = ui.TEXT_VALIGN_BOTTOM,
    	})
    labelSize:pos(display.cx, labelSize:getContentSize().height)
    labelSize:addTo(self)

    --labelSize:runAction(repeatAction)

    --CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("Hero/Hero.ExportJson")
    --local armature = CCArmature:create("Hero")
    --print("Hero", "attack", {frameEventTestAttackLayer16Frame18 = handler(self, self.onFrameEventTestAttackLayer16Frame18)}, {})
    --print(CocosArmature.createArmature)
    

    -- CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("DemoPlayer/DemoPlayer.ExportJson")
    -- local armature2 = CCArmature:create("DemoPlayer")
    -- armature2:getAnimation():play("test")
    -- armature2:setScale(0.5);
    -- armature2:pos(display.cx, display.cy)
    -- armature2:addTo(self)
end
function MainScene:onMovementEventTestAttackLayer16Frame18()
    --print("COMOPLETE Movement Event Catched")

end
function MainScene:onFrameEventTestAttackLayer16Frame18()
    --print("Frame Event Catched")
end
function MainScene:onRunBtn(obj)
    --print(type(obj).." "..obj)
    if armature3 ~= nil then
        armature3:getAnimation():playWithIndex(id)
        id = id + 1
        id = id % armature3:getAnimation():getMovementCount()
    end
end

function MainScene:onStopBtn(obj)
    if armature3 ~= nil then
        armature3:getAnimation():stop()
    end
    armature:flipX(DIRECTIONS.RIGHT)
end

function MainScene:onEnter()
	
end

function MainScene:onExit()
    armature3 = nil
    armature = nil
end

return MainScene
