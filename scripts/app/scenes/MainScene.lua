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

    blinkAction = CCBlink:create(1, 2)
    repeatAction = CCRepeat:create(blinkAction, 2)

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
    EffectMgr:addEffect(armature2, "dumpling")

    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("AnimationTest/AnimationTest.ExportJson")
    armature3 = CCArmature:create("AnimationTest")
    armature3:getAnimation():play("run")
    armature3:setScale(0.5);

    local skin = CCSkin:createWithSpriteFrameName("角色_png/腰带.png")
    armature3:getBone("武器"):addDisplay(skin, 1)
    armature3:getBone("武器"):changeDisplayWithIndex(1, true)

    armature3:pos(display.cx, display.cy / 2)
    armature3:addTo(self)
    local tab = {1, 2, nil, 3}
    print(#tab, table.maxn(tab))
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
    armature:setScale(0.5);
    armature:pos(display.cx, display.cy)
    armature:addTo(self)
    EffectMgr:addEffect(armature, "paAni")
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

    local gameMap = GameMap:new()
    gameMap:setup(1)

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
