--
-- Author: SureBrz
-- Date: 2014-07-22 22:59:27
--
import(".common.CocosArmature")

SpriteCharacter = class("SpriteCharacter", CocosArmature)

-- 待绑定GameCharacter对象
SpriteCharacter.character = nil

function SpriteCharacter:ctor()
	self.character = nil
end
function SpriteCharacter:create(_animationName, gameCharacter)
	local spriteCharacter = self:new()
	spriteCharacter.character = gameCharacter
	local params = {
		animationName = _animationName
	}
	spriteCharacter:initWithParamsAndCaller(params, spriteCharacter)
	return spriteCharacter
end

--
function SpriteCharacter:idle()
	self:play("idle")
	self.character.currentWalkStates = {[GameCharacter.WALK_STATES.IDLE] = true}
end

function SpriteCharacter:walk()
	self:play("walk")
	self.character.currentWalkStates[GameCharacter.WALK_STATES.WALK] = true
end

function SpriteCharacter:attack()
	self:play("attack")
end

function SpriteCharacter:jump()
	self:play("jump")
	self.character.currentWalkStates[GameCharacter.WALK_STATES.JUMP] = true
end

function SpriteCharacter:update()
	-- 移动
	self.character:move(self:width(), self:height())
	-- 修正位置，改变速度
	self.character:refreshSpXAndAjustRealX(self:width)
	self.character:refreshSpYAndAjustRealY(self:height)
	-- 改变状态
	if self.character.spX == 0 and self.character.spY == 0 then
		self:idle() 	-- 进入闲置状态
	elseif self.character.spX ~= 0 then
		self:walk()
	elseif self.character.spY ~= 0 then
		self:jump()
	end
	-- 取得新地图坐标
	self.character:adjustXY()
end





