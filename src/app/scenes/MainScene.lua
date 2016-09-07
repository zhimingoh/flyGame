
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
-- 加载csb文件
MainScene.RESOURCE_FILENAME = "res/csb/MainScene.csb"





function MainScene:ctor()
    -- cc.ui.UILabel.new({
    --         UILabelType = 2, text = "Hello, World", size = 64})
    --     :align(display.CENTER, display.cx, display.cy)
    --     :addTo(self)
      local background = display.newSprite("image/main.jpg", 
      	display.cx, display.cy)
	self:addChild(background)
	print("background",background);
	-- display.newSprite("background.jpg"):pos(display.cx, display.cy):addTo(self)

	self.pri();
-- self.actionWalk();

-- local uinNode = cc.uiloader:load("res/pokemon/res/MainScene.csb")
-- self:addChild(uinNode)

-- title 精灵
local title = display.newSprite("image/title.png",
	display.cx / 2 * 3, display.cy)
 	self:addChild(title)
-- 动作
local  move1 = cc.MoveBy:create(0.5,cc.p(0,10));
local  move2 = cc.MoveBy:create(0.5,cc.p(0,-10));
local  sequenceAction = cc.Sequence:create(move1,move2);
transition.execute(title,cc.RepeatForever:create(sequenceAction))
-- transition.execute(title,cc.RepeatForever:create(sequenceAction), {
--     delay = 1.0,
--     easing = "backout",
--     onComplete = function()
--         print("move completed")
--     end,
-- });

cc.ui.UIPushButton.new({normal = "image/start1.png",pressed="image/start2.png"})
:onButtonClicked(function ()
	-- body
	print("startBtn")
	app:enterScene("GameScene", nil,"SLIDEINT",1.0)
end)

:pos(display.cx/2,display.cy)
:addTo(self)

end

function MainScene:onEnter()
end

function MainScene:actionWalk( ... )
	-- body
	-- 加载动画所用到的数据
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("res/walk/pokemmo0.png","res/walk/pokemmo0.plist","res/walk/pokemmo0.ExportJson");
	local armature = ccs.Armature:create("pokemmo0")  -- 创建动画对象
	armature:setPosition(0, 0)                    -- 设置位置
	armature:getAnimation():play("walk")            -- 设置动画对象执行的动画名称
	self:addChild(armature) 
end

function MainScene:pri( )
	-- body
	print("hello111111111111111111");
end

function MainScene:onExit()
end

return MainScene
