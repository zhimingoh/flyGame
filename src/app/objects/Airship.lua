-- @Author: Marte
-- @Date:   2016-09-07 13:45:35
-- @Last Modified by:   Marte
-- @Last Modified time: 2016-09-07 13:54:17
local Airship = class("Airship", function()

    return display.newSprite("#airship.png")

end)
local MATERIAL_DEFAULT = cc.PhysicsMaterial(0.0, 0.0, 0.0)

function Airship:ctor( ... )
    -- body
    local airshipSize = self:getContentSize()
    local airshipBody = cc.PhysicsBody:createCircle(airshipSize.width/2,MATERIAL_DEFAULT)
    self:setPhysicsBody(airshipBody)
    self:getPhysicsBody():setGravityEnable(false)
    self:setPosition(x,y)

    local move1 = cc.MoveBy:create(3.cc.p(0,airshipSize.height/2))
    local move2 = cc.MoveBy:create(3.cc.p(0,-airshipSize.height/2))

    local SequenceAction = cc.Sequence:create( move1, move2 )
    transition.execute(self, cc.RepeatForever:create( SequenceAction ))

end
return Airship