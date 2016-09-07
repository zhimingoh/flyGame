local Player = require("app.objects.Player")

local GameScene = class("GameScene", function()
    return display.newPhysicsScene("GameScene")
end)

function GameScene:ctor()
	-- body
         self.world = self:getPhysicsWorld()
    	self.world:setGravity(cc.p(0, -98))
        self.world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
    
    self.backgroundLayer = BackgroundLayer.new()
        :addTo(self)

        self.player = Player.new()
        self.player:setPosition(-20,display.height *2/3)
        self:addChild(self.player)
        self:playerFlyToScence();


end

function GameScene:playerFlyToScence( ... )
	-- body
	local function startDrop()
        self.player:getPhysicsBody():setGravityEnable(true)  
        self.player:drop() 
        self.backgroundLayer:startGame()
    end

    local animation = display.getAnimationCache("flying")
    transition.playAnimationForever(self.player, animation)

    local action = transition.sequence({
        cc.MoveTo:create(4, cc.p(display.cx, display.height * 2 / 3)),
        cc.CallFunc:create(startDrop)
    })
    self.player:runAction(action)
end


function GameScene:onEnter()

end



function GameScene:onExit()

end



return GameScene