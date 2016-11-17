local soundTable=require("soundTable");
local CollisionFilters = require("CollisionFilters");

local Enemy = {tag="enemy", HP=1, xPos=display.contentWidth/2, yPos=0, 
    fR=0, sR=0, bR=0, fT=200, sT=500, bT	=500};



function Enemy:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Enemy:spawn()
 self.shape = display.newCircle(display.contentWidth/2, self.yPos,25);
 self.shape.pp = self;      -- parent object
 self.shape.tag = self.tag; -- “enemy”
 self.shape:setFillColor (1,1,0);
 physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.enemy}); 
end


function Enemy:back ()
  transition.to(self.shape, {x= display.contentWidth/2, y=self.shape.y - 75,  
  time=self.fB, rotation=self.bR, 
  onComplete=function (obj) self:forward() end} );
end

function Enemy:left ()   
   transition.to(self.shape, {x=self.shape.x-200, 
   time=self.fS, rotation=self.sR, 
   onComplete=function (obj) self:right() end } );
end

function Enemy:right ()   
   transition.to(self.shape, {x=self.shape.x+400, 
   time=self.fS, rotation=self.sR, 
   onComplete=function (obj) self:back() end } );
end

function Enemy:forward ()   
   transition.to(self.shape, {x=self.shape.x, y=self.shape.y + 350, 
   time=self.fT, rotation=self.fR, 
   onComplete= function (obj) self:left() end } );
end

function Enemy:move ()	
	self:forward();
end


function Enemy:hit () 
	self.HP = self.HP - 1;
	if (self.HP > 0) then 
		audio.play( soundTable["hitSound"] );
		self.shape:setFillColor(0.5,0.5,0.5);
	else 
		audio.play( soundTable["explodeSound"] );
		transition.cancel( self.shape );
		
		if (self.timerRef ~= nil) then
			timer.cancel ( self.timerRef );
		end

		-- die
		self.shape:removeSelf();
		self.shape=nil;	
		self = nil;  
	end		
end

function Enemy:shoot (interval)
  interval = interval or 1500;
  local function createShot(obj)
    local p = display.newRect (obj.shape.x, obj.shape.y+50, 
                               10,10);
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

return Enemy;