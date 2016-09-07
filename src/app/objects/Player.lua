local Player = class("Player", function()
    return display.newSprite("#flying1.png")
end)

local MATERIAL_DEFAULT = cc.PhysicsMaterial(0.0, 0.0, 0.0)
function Player:ctor()
	   self:addAnimationCache()
	-- body
	 local body = cc.PhysicsBody:createBox(self:getContentSize(), MATERIAL_DEFAULT)
             body:setRotationEnable(false)

	-- 创建一个包含flying1.png到flying4.png的4个图像帧对象的数组
	-- local  frames = display.newFrames("flying%d.png",1,4)
	--   -- 以包含图像帧的数组创建一个动画 Animation 对象
	--   local  animation  = display.newAnimation(frames,0.3/4)
 -- -- 在显示对象上循环播放动画，并返回 Action 动画动作对象。
	--   transition.playAnimationForever(self, animation)
	self:setPhysicsBody(body)

	  self:getPhysicsBody():setGravityEnable(false)

end

function Player:addAnimationCache( ... )
	-- body

	 local animationNames = {"flying", "drop", "die"}
    local animationFrameNum = {4, 3, 4}

    for i = 1, #animationNames do
        local frames = display.newFrames( animationNames[i] .. "%d.png", 1, animationFrameNum[i])
        local animation = display.newAnimation(frames, 0.5 / 8)
        animation:setDelayPerUnit(0.1)
        display.setAnimationCache(animationNames[i], animation)
    end

end

function Player:flying( ... )
	-- body
	transition.stopTarge(self)
	transition.playAnimationForever(self,display.getAnimationCache("flying"))

end

function Player:drop( ... )
	-- body
    transition.stopTarget(self)
    transition.playAnimationForever(self, display.getAnimationCache("drop"))

end

function Player:die( ... )
	-- body
	transition.stopTarge(self)
	transition.playAnimationForever(self,display.getAnimationCache("die"))

end


return Player
