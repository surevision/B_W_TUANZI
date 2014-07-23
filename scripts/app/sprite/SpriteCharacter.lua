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
end

function SpriteCharacter:walk()
	self:play("walk")
end

function SpriteCharacter:attack()
	self:play("attack")
end

function SpriteCharacter:jump()
	self:play("jump")
end

function SpriteCharacter:update()
	self.real_x = self.real_x + self.spX * ((self.character:dirX() == DIRECTIONS:RIGHT and 1) or -1)
	self.real_y = self.real_y + self.spY * ((self.character:dirY() == DIRECTIONS:UP and 1) or -1)
	self:adjustXY()
	self.spX = self:refreshSpX()
	self.spY = self:refreshSpY()
end





