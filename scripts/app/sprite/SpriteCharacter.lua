--
-- Author: SureBrz
-- Date: 2014-07-22 22:59:27
--
require("app.common.CocosArmature")

SpriteCharacter = class("SpriteCharacter", CocosArmature)

-- 待绑定GameCharacter对象
SpriteCharacter.character = nil

