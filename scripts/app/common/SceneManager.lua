--
-- Author: SureBrz
-- Date: 2014-08-08 09:23:07
--
SceneManager = class("SceneManager")

SceneManager.TRANSITION_FADE_TIME = 0.2

SceneManager.scene = nil


function SceneManager:pushScene(scene)
	CCDirector:sharedDirector():pushScene(scene)
	SceneManager.scene = scene
end

function SceneManager:popScene()
	CCDirector:sharedDirector():popScene()
	SceneManager.scene = display.getRunningScene()
end

function SceneManager:replaceScene(scene, noFade)
	if noFade then
		CCDirector:sharedDirector():replaceScene(scene)
	else
		CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(SceneManager.TRANSITION_FADE_TIME, scene))
	end
end

