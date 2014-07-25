--
-- Author: SureBrz
-- Date: 2014-07-22 22:59:27
--
import("..common.CocosArmature")

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
	--self:play("idle")
	self.character.currentWalkStates = {[GameCharacter.WALK_STATES.IDLE] = true}
end

function SpriteCharacter:walk()
	--self:play("walk")
	self.character.currentWalkStates[GameCharacter.WALK_STATES.WALK] = true
end

function SpriteCharacter:attack()
	--self:play("attack")
end

function SpriteCharacter:jump()
	--self:play("jump")
	self.character.currentWalkStates[GameCharacter.WALK_STATES.JUMP] = true
end

function SpriteCharacter:update()
	-- 移动
	self.character:move(self:width(), self:height())
	-- 修正位置，改变速度
	self.character:refreshSpXAndAjustRealX(32)
	self.character:refreshSpYAndAjustRealY(32)
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
	-- 设置显示位置
	self:refreshPosition()
	print(self.character.x, self.character.y, "4444444444444444444444444444")
end

-- 更新精灵位置
function SpriteCharacter:refreshPosition()
	-- note: 大概要注意适配时的缩放系数？
	if self.character.real_x <= display.cx then 
		-- 不到中心，在左侧
		self:setPositionX(self.character.real_x)
	elseif self.character.real_x >= GameData.gameMap:width() - display.cx then 
		-- 不到中心，在右侧
		self:setPositionX(self.character.real_x - GameData.gameMap:width() - display.cx)
	else
		-- 在中心
		self:setPositionX(display.cx)
	end
	-- 纵方向直接赋值不需滚动地图？
	self:setPositionY(display.height - self.character.real_y)
end




