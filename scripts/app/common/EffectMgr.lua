import(".EffectArmature")

EffectMgr = class("Effectmgr")

EffectMgr.effectPool = {}

function EffectMgr:add(effectArmature)
	if EffectMgr.effectPool[effectArmature.effectName] == nil then
		EffectMgr.effectPool[effectArmature.effectName] = {}
	end
	table.insert(EffectMgr.effectPool[effectArmature.effectName], effectArmature)
end
function EffectMgr:create(effectName)
	local effectArmature = EffectArmature:create(effectName)
	EffectMgr:add(effectArmature)
	return effectArmature
end
function EffectMgr:get(effectName)
	if EffectMgr.effectPool[effectName] == nil then
		return nil
	end
	table.foreach(EffectMgr.effectPool[effectName], function(_, effectArmature) 
		if effectArmature.disposed ~= true then
			effectArmature:recycle()
			return effectArmature
		end
	end)
end

function EffectMgr:addEffect(armature, effectName)
	local effect = EffectMgr:create(effectName)
	if armature.xFliped then
		effect:flipX()
	end
	effect:bindRootAndPlay(armature)
end

-- function EffectMgr:find(effectArmature)
-- 	if EffectMgr.effectPool[effectArmature.effectName] == nil then
-- 		return nil
-- 	end
-- 	table.foreach(EffectMgr.effectPool[effectArmature.effectName], function(_, _effectArmature) 
-- 		if _effectArmature == effectArmature then
-- 			return _effectArmature
-- 		end
-- 	end)
-- end