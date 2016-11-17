local Enemy = require ("Enemy");
local CollisionFilters = require("CollisionFilters");


local Triangle = Enemy:new( {HP=3, bR=360, fT=500, 
				     bT=150});

function Triangle:spawn()
 self.shape = display.newPolygon(self.xPos, self.yPos, 
			             {-25,-25,25,-25,0,25});
  
 self.shape.pp = self;
 self.shape.tag = "enemy";
 self.shape:setFillColor ( 1, 0, 1);
 physics.addBody(self.shape, "dynamic", 
		     {shape={-25,-25,25,-25,0,25}, filter=CollisionFilters.enemy}); 
end

function Triangle:back ()	
  transition.to(self.shape, {x=self.shape.x-130, 
    y=self.shape.y, time=self.bT, rotation=self.bR, 
    onComplete= function (obj) self:forward() end } );
end

function Triangle:side ()	
   transition.to(self.shape, {x=self.shape.x + 130, 
      time=self.sT, rotation=self.sR, 
      onComplete= function (obj) self:back () end });	
end

function Triangle:forward ()	
  transition.to(self.shape, {x=self.shape.x+120,  
    y=self.shape.y+200, time=self.fT, rotation=self.fR, 
    onComplete= function (obj) self:side() end } );
end

function Triangle:shoot (interval)
  interval = interval or 1500;
  local function createShot(obj)
    local p = display.newRect (obj.shape.x, obj.shape.y+50, 
                               50,50);
    p:setFillColor(1,0,0);
    p.anchorY=0;
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
end


return Triangle;