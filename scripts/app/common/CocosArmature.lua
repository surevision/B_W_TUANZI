import(".EffectMgr")

CocosArmature = class("CocosArmature", function()
	return display.newLayer()
end)

CocosArmature.baseFolder = "armature/"
CocosArmature.fileExtensionName = ".ExportJson"

CocosArmature.funcCaller = nil
CocosArmature.mainArmature = nil
CocosArmature.registedFrameEvents = {}
CocosArmature.registedMovementEvents = {}
CocosArmature.effects = {}
CocosArmature.effectCnt = 0
CocosArmature.xFliped = false

function CocosArmature:createArmature(params, caller)
	--dump(params)
	local animationName = params.animationName
	local frameEvents = params.frameEvents or {}
	local movementEvents = params.movementEvents or {}
	local exportFileType = params.exportFileType or "COCOSTUDIO"
	local cocosArmature = CocosArmature.new()
	cocosArmature.funcCaller = caller
    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(CocosArmature.baseFolder..animationName..CocosArmature.fileExtensionName)
    cocosArmature.mainArmature = CCArmature:create(animationName)
    cocosArmature:setContentSize(cocosArmature.mainArmature:getContentSize())
    cocosArmature:setAnchorPoint(0, 0)
    cocosArmature.mainArmature:getAnimation():setFrameEventCallFunc(handler(cocosArmature, cocosArmature.onFrameEvent))
    cocosArmature.mainArmature:getAnimation():setMovementEventCallFunc(handler(cocosArmature, cocosArmature.onMovementEvent))
    cocosArmature.registedFrameEvents = frameEvents
    cocosArmature.registedMovementEvents = movementEvents
    cocosArmature.mainArmature:addTo(cocosArmature)
    --dump(cocosArmature)
    return cocosArmature
end

function CocosArmature:play(actionName)
	self.mainArmature:getAnimation():play(actionName)
end

function CocosArmature:onFrameEvent(bone, frameEventName, origFrameIndex, currFrameIndex)
	local armature = bone:getArmature()
	table.foreach(self.registedFrameEvents, function(_frameEventName, _function)
		if frameEventName == _frameEventName then
			--print("callback_all_frame", armature, frameEventName, origFrameIndex, currFrameIndex)
			handler(self.funcCaller, _function)()
		end
	end)
end

function CocosArmature:onMovementEvent(armature, movementType, movementId)
	table.foreach(self.registedMovementEvents, function(_movementType, _function)
		if movementType == _movementType then
			--print("callback_movement", armature, movementType, movementId)
			handler(self.funcCaller, _function)()
		end
	end)
end

function CocosArmature:remArmature(animationName)
	self.registedFrameEventHandlers[animationName] = nil
	self.registedMovementEventHandlers[animationName] = nil
end

function CocosArmature:addEffect(effectName)
	local effect = EffectMgr:create(effectName)
	if self.xFliped then
		effect:flipX()
	end
	effect:bindRootAndPlay(self)
end

function CocosArmature:flipX()
	self.mainArmature:setScaleX((self.xFliped and 1) or -1)
	self.xFliped = not self.xFliped
	-- flip all effects
	table.foreach(self.effects, function(_, effect)
		effect.armature:flipX()
	end)
	self.xFliped = not self.xFliped
end
return CocosArmature