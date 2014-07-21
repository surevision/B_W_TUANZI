-- ↓ require common
local MovementEventType =
{
    START = 0,
    COMPLETE = 1,
    LOOP_COMPLETE = 2,
}
require("app.common.CocosArmature")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
function MainScene:ctor()
    
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

    blinkAction = CCBlink:create(1, 2)
    repeatAction = CCRepeat:create(blinkAction, 5)

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
    local params = 
    {
        animationName = "DemoPlayer"
    }
    local armature2 = CocosArmature:createArmature(params, self)
    armature2:play("walk")
    armature2:setScale(0.5);
    armature2:pos(display.cx, display.cy)
    armature2:addTo(self)
    armature2:addEffect("dumpling")

    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("AnimationTest/AnimationTest.ExportJson")
    armature3 = CCArmature:create("AnimationTest")
    armature3:getAnimation():play("run")
    armature3:setScale(0.5);
    armature3:pos(display.cx, display.cy / 2)
    armature3:addTo(self)
    params = 
    {
        animationName = "Hero",
        exportFileType = "COCOSTUDIO",
        frameEvents = 
        {
            frameEventTestAttackLayer16Frame18 = self.onFrameEventTestAttackLayer16Frame18,            
        },
        movementEvents = 
        {
            [MovementEventType.LOOP_COMPLETE] = self.onMovementEventTestAttackLayer16Frame18
        }
    }
    armature = CocosArmature:createArmature(params, self)
    armature:play("attack")
    dump(armature)
    armature:setScale(0.5);
    armature:pos(display.cx, display.cy)
    armature:addTo(self)
    armature:addEffect("paAni")
    local runBtn = ui.newTTFLabelMenuItem({
        text = "run",
        listener = handler(self, self.onRunBtn),
        tag = 1,
        x = display.cx / 2,
        y = display.height - 96
    })
    local stopBtn = ui.newTTFLabelMenuItem({
        text = "stop",
        listener = handler(stopBtn, self.onStopBtn),
        tag = 2,
        x = display.cx * 3 / 2,
        y = display.height - 96
    })
    ui.newMenu({runBtn, stopBtn}):addTo(self)

    layer = GUIReader:shareReader():widgetFromJsonFile("SampleUIAnimation/SampleUIAnimation.json")
    --[[
    local lb = CCLabelTTF:create("tttt ttttttttt ttttt ttt tttt ttt tt ttt", "Arial.ttf", 36, cc.SizeMake(128, 100), kCCTextAlignmentLeft)
    lb:setAnchorPoint(0, 0)
    lb:setPosition(CCPoint(40, 400))
    lb:addTo(self)
    ]]--
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
        armature3:getAnimation():play("run")
    end
end

function MainScene:onStopBtn(obj)
    print(type(obj).." "..obj)
    if armature3 ~= nil then
        armature3:getAnimation():stop()
    end
    dump(armature.effects[1].armature.effects)
end

function MainScene:onEnter()
	
end

function MainScene:onExit()
    armature3 = nil
end

return MainScene
