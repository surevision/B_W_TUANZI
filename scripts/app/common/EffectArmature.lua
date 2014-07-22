local MovementEventType =
{
    START = 0,
    COMPLETE = 1,
    LOOP_COMPLETE = 2,
}
import(".CocosArmature")
EffectArmature = class("EffectAnimation", CocosArmature)

EffectArmature.effectName = ""
EffectArmature.rootNode = nil
EffectArmature.disposed = false
EffectArmature.added = false

function EffectArmature:ctor()
	dump(self)
	self.effectName = ""
	self.rootNode = nil
	self.disposed = false
	self.added = false
end
function EffectArmature:create(effectName)
	local params = 
	{
		animationName = effectName,
		movementEvents = {
			[MovementEventType.COMPLETE] = self.onMovementComplete,
			--[MovementEventType.LOOP_COMPLETE] = self.onLoopMovementComplete
		}
	}
	local effectArmature = self:new()
	effectArmature:initWithParamsAndCaller(params, effectArmature)
	effectArmature.effectName = effectName
	return effectArmature
end

function EffectArmature:bindRootAndPlay(rootNode)
	self.rootNode = rootNode
	self:setPosition(ccp(rootNode:getPositionX(), rootNode:getPositionY()))
	self:play("effect")
	table.insert(rootNode.effects, self)
	if not self.added then
		-- first time added to scene layer
		self:addTo(rootNode:getParent())
		self.added = true
	end
end

function EffectArmature:onMovementComplete()
	if self.rootNode ~= nil then 
		self.rootNode.effectCnt = self.rootNode.effectCnt - 1
		local pos = nil
		for i, v in ipairs(self.rootNode.effects) do
			if v == self then
				pos = i
				break
			end
		end
		table.remove(self.rootNode.effects, pos)
	end
	self:dispose()
end

function EffectArmature:dispose()
	self:setVisible(false)
	self.disposed = true
end

function EffectArmature:recycle()
	self:setVisible(true)
	self.disposed = false
end