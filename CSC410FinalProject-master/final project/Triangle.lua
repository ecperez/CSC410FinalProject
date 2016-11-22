local Enemy = require ("Enemy");
local CollisionFilters = require("CollisionFilters");
local ImageSheet = require("ImageSheet");


local Triangle = Enemy:new( {HP=3, bR=360, fT=500, 
				     bT=150});

function Triangle:spawn()
 self.shape = display.newSprite(gameSheet, sequenceData);
 self.shape.x = self.xPos;
 self.shape.y = self.yPos;
 self.shape.pp = self;
 self.shape.tag = "enemy";
 self.shape:setSequence("Enemy Type 5 Green");
 physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.enemy}); 
end

function Triangle:back ()	
  transition.to(self.shape, {x=self.shape.x-130, 
    y=self.shape.y, time=self.bT, 
    onComplete= function (obj) self:forward() end } );
end

function Triangle:side ()	
   transition.to(self.shape, {x=self.shape.x + 130, time=self.sT, 
      onComplete= function (obj) self:back () end });	
end

function Triangle:forward ()	
  transition.to(self.shape, {x=self.shape.x+120,  
    y=self.shape.y+200, time=self.fT, 
    onComplete= function (obj) self:side() end } );
end

function Triangle:shoot (interval)
  interval = interval or 1500;
  local function createShot(obj)
    local p = display.newSprite(gameSheet,sequenceData);
    p.x = obj.shape.x;
    p.y = obj.shape.y+50;
    p.anchorY=0;
    p:setSequence("Bomb Type 1 Red");
    physics.addBody (p, "dynamic", {filter=CollisionFilters.enemyBullet});
    p:applyForce(0, 1, p.x, p.y);
		p.tag = "shot";
    local function shotHandler (event)
      if (event.phase == "began") then
        event.target:removeSelf();
        event.target = nil;
      end
    end
    p:addEventListener("collision", shotHandler);		
  end
  self.timerRef = timer.performWithDelay(interval, 
	function (event) createShot(self) end, -1);
  self.timerR = timerRef;
end


return Triangle;