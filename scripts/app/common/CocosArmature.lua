import(".Global")

CocosArmature = class("CocosArmature", function()
	return display.newLayer("CocosArmature")
end)

CocosArmature.BaseFolder = "armature/"
CocosArmature.FileExtensionName = ".ExportJson"

CocosArmature.funcCaller = nil
CocosArmature.mainArmature = nil
CocosArmature.registedFrameEvents = {}
CocosArmature.registedMovementEvents = {}
CocosArmature.effects = {}
CocosArmature.effectCnt = 0
CocosArmature.xFliped = false

function CocosArmature:ctor()
	self.funcCaller = nil
	self.mainArmature = nil
	self.registedFrameEvents = {}
	self.registedMovementEvents = {}
	self.effects = {}
	self.effectCnt = 0
	self.xFliped = false
end
function CocosArmature:createArmature(params, caller)
	local cocosArmature = self.new()
	cocosArmature:initWithParamsAndCaller(params, caller)
	return cocosArmature
end

function CocosArmature:initWithParamsAndCaller(params, caller)
	local animationName = params.animationName
	local frameEvents = params.frameEvents or {}
	local movementEvents = params.movementEvents or {}
	local exportFileType = params.exportFileType or "COCOSTUDIO"
    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(CocosArmature.BaseFolder..animationName..CocosArmature.FileExtensionName)
	self:setCaller(caller)
    self.mainArmature = CCArmature:create(animationName)
    self:setContentSize(self.mainArmature:getContentSize())
    self:setAnchorPoint(0, 0)
    self.mainArmature:getAnimation():setFrameEventCallFunc(handler(self, self.onFrameEvent))
    self.mainArmature:getAnimation():setMovementEventCallFunc(handler(self, self.onMovementEvent))
    self.registedFrameEvents = frameEvents
    self.registedMovementEvents = movementEvents
    self.mainArmature:addTo(self)
end

function CocosArmature:initWithParams(params)
	self:initWithParamsAndCaller(params, nil)
end

function CocosArmature:setCaller(caller)
	self.funcCaller = caller
end

function CocosArmature:play(actionName)
	self.mainArmature:getAnimation():play(actionName)
end

function CocosArmature:onFrameEvent(bone, frameEventName, origFrameIndex, currFrameIndex)
	if self.funcCaller == nil then return end
	local armature = bone:getArmature()
	table.foreach(self.registedFrameEvents, function(_frameEventName, _function)
		if frameEventName == _frameEventName then
			--print("callback_all_frame", armature, frameEventName, origFrameIndex, currFrameIndex)
			handler(self.funcCaller, _function)()
		end
	end)
end

function CocosArmature:onMovementEvent(armature, movementType, movementId)
	if self.funcCaller == nil then return end
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

function CocosArmature:width()
	return self:getContentSize().width
end
function CocosArmature:height()
	return self:getContentSize().height
end

-- function CocosArmature:addEffect(effectName)
-- 	local effect = EffectMgr:create(effectName)
-- 	if self.xFliped then
-- 		effect:flipX()
-- 	end
-- 	effect:bindRootAndPlay(self)
-- end

-- 设置朝向， 所有角色默认朝右
function CocosArmature:flipX(dir2)
	-- 
	print(dir2)
	if dir2 == nil then
		-- 未指定方向
		self.mainArmature:setScaleX((self.xFliped and 1) or -1)
		self.xFliped = not self.xFliped
	else		
		-- 指定方向
		self.mainArmature:setScaleX((dir2 == DIRECTIONS.RIGHT and 1) or -1)
		self.xFliped = (dir2 == DIRECTIONS.LEFT and true) or false
	end
	-- flip all effects
	table.foreach(self.effects, function(_, effect)
		effect:flipX(dir2)
	end)
	print(self.xFliped)

end