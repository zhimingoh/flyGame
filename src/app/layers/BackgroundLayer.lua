BackgroundLayer = class("BackgroundLayer",function()
	return display.newLayer()
	end)


function BackgroundLayer:ctor()

	self.distanceBg={}
	self.nearbyBg ={}
	self.titleMapBg ={}
	self:createBackgrounds()

	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.scrollBackgrounds))
	self:scheduleUpdate()


	local width = self.map:getContentSize().width
	local height1 = self.map:getContentSize().height * 9 / 10
	local height2 = self.map:getContentSize().height * 3 / 16




	local sky = display.newNode()
	local bodyTop = cc.PhysicsBody:createEdgeSegment(cc.p(0, height1), cc.p(width, height1))
	sky:setPhysicsBody(bodyTop)
	self:addChild(sky)

	local ground = display.newNode()
	local bodyBottom = cc.PhysicsBody:createEdgeSegment(cc.p(0, height2), cc.p(width, height2))
	ground:setPhysicsBody(bodyBottom)
	self:addChild(ground)

end

function BackgroundLayer:startGame()
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.scrollBackgrounds))
	self:scheduleUpdate()
end
function BackgroundLayer:addHeart( ... )
	-- body
	local objects = self.map:getObjectGroup("heart"):getObjectS()
	local dict = nil
	local  i = 0
	local len = table.getn(objects)

	for i =0, len-1 ,1 do
		dict=objects[i+1]
		if dict == nil then
			break
		end
		local key = "x"
		local  x = dict["x"]
		key = "y"
		local y = dict["y"]
		print("循环", i);

		local coinSpritel = Heart.new(x,y)
		self.map:addChild(coinSpritel)
	end

end


function BackgroundLayer:createBackgrounds()
	-- 创建布幕背景
	local bg = display.newSprite("image/bj2.jpg")
	:pos(display.cx, display.cy)
	:addTo(self, -4)

	-- 创建远景背景
	local bg1 = display.newSprite("image/b2.png")
	:align(display.BOTTOM_LEFT, display.left, display.bottom + 10)
	:addTo(self, -3)
	local bg2 = display.newSprite("image/b2.png")
	:align(display.BOTTOM_LEFT, display.left + bg1:getContentSize().width, display.bottom + 10)
	:addTo(self, -3)

	table.insert(self.distanceBg, bg1)
	table.insert(self.distanceBg, bg2)

    -- local emitter = cc.ParticleSystemQuad:create("particles/dirt.plist")
    -- -- emitter:setBlendAdditive(false)
    -- emitter:setPosition(display.cx, display.top)
    -- self:addChild(emitter, -3)

	-- 创建近景背景
	local bg3 = display.newSprite("image/b1.png")
	:align(display.BOTTOM_LEFT, display.left, display.bottom)
	:addTo(self, -2)
	local bg4 = display.newSprite("image/b1.png")
	:align(display.BOTTOM_LEFT, display.left + bg3:getContentSize().width, display.bottom)
	:addTo(self, -2)
	print("pos~~~",bg4:getAnchorPoint().x, bg4:getAnchorPoint().y)

	table.insert(self.nearbyBg, bg3)
	table.insert(self.nearbyBg, bg4)

	self.map = cc.TMXTiledMap:create("image/map.tmx")
	:align(display.BOTTOM_LEFT, display.left, display.bottom)
	:addTo(self, -1)

    -- self:addBody("heart", Heart)
    -- self:addBody("airship", Airship)
    -- self:addBody("bird", Bird)
end

function BackgroundLayer:scrollBackgrounds(dt)

	if self.distanceBg[2]:getPositionX() <= 0 then
		self.distanceBg[1]:setPositionX(0)
	end

	local x1 = self.distanceBg[1]:getPositionX() - 50*dt
	local x2 = x1 + self.distanceBg[1]:getContentSize().width

	self.distanceBg[1]:setPositionX(x1)
	self.distanceBg[2]:setPositionX(x2)

	if self.nearbyBg[2]:getPositionX() <= 0 then
		self.nearbyBg[1]:setPositionX(0)
	end

	local x3 = self.nearbyBg[1]:getPositionX() - 100*dt
	local x4 = x3 + self.nearbyBg[1]:getContentSize().width

	self.nearbyBg[1]:setPositionX(x3)
	self.nearbyBg[2]:setPositionX(x4)

	if self.map:getPositionX()  <= display.width - self.map:getContentSize().width then

		print("game over")
		self:unscheduleUpdate()
	end

	local x5 = self.map:getPositionX() - 150*dt
	self.map:setPositionX(x5)

    -- self:addVelocityToBird()

end


return BackgroundLayer