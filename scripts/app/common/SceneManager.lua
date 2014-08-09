--
-- Author: SureBrz
-- Date: 2014-08-08 09:23:07
--
SceneManager = class("SceneManager")

SceneManager.scene = nil

function SceneManager:pushScene(scene)
	CCDirector:sharedDirector():pushScene(scene)
	SceneManager.scene = scene
end

function SceneManager:popScene()
	CCDirector:sharedDirector():popScene()
	SceneManager.scene = display.getRunningScene()
end

function SceneManager:replaceScene(scene)
	CCDirector:sharedDirector():replaceScene(scene)
end