local MovementEventType =
{
    START = 0,
    COMPLETE = 1,
    LOOP_COMPLETE = 2,
}
EffectArmature = class("EffectAnimation")

EffectArmature.effectName = ""
EffectArmature.armature = nil
EffectArmature.rootNode = nil
EffectArmature.disposed = false
EffectArmature.added = false

function EffectArmature:create(effectName)
	local effectArmature = EffectArmature.new()
	local params = 
	{
		animationName = effectName,
		movementEvents = {
			[MovementEventType.COMPLETE] = self.onMovementComplete,
			--[MovementEventType.LOOP_COMPLETE] = self.onLoopMovementComplete
		}
	}
	local armature = CocosArmature:createArmature(params, effectArmature)
	dump(armature.effects)
	effectArmature.armature = armature
	dump(armature)
	effectArmature.effectName = effectName
	return effectArmature
end

function EffectArmature:bindRootAndPlay(rootNode)
	self.rootNode = rootNode
	self.armature:setPosition(ccp(rootNode:getPositionX(), rootNode:getPositionY()))
	self.armature:play("effect")
	table.insert(rootNode.effects, self)
	if not self.added then
		-- first time added to scene layer
		self.armature:addTo(rootNode:getParent())
		self.added = true
	end
end

function EffectArmature:onMovementComplete()
	dump(self.rootNode)
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
		self.armature:setVisible(false)
	end
	self:dispose()
end

function EffectArmature:dispose()
	--self.armature:setVisible(false)
	self.disposed = true
end

function EffectArmature:recycle()
	self.armature:setVisible(true)
	self.disposed = false
end