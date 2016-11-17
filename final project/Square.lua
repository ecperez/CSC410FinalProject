local Enemy = require ("Enemy");
local CollisionFilters = require("CollisionFilters");

local Square = Enemy:new( {tag = "enemy", HP=2, fR=720, fT=700, 
				  bT=700} );

function Square:spawn()
  self.shape = display.newRect (self.xPos, 
    	 	 			  self.yPos, 45, 45); 
  self.shape.pp = self;
  self.shape.tag =self.tag;
  self.shape:setFillColor ( 0, 1, 1);
   physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.enemy}); 
end

function Square:back ()   
   transition.to(self.shape, {x=self.shape.x-500, 
		     y=self.shape.y+150, time=self.bT, rotation=self.sR, 
   	onComplete=function (obj) self:forward() end});
end

function Square:forward ()	
	transition.to(self.shape, {x=self.shape.x+500, 
			   y=self.shape.y+150, time=self.fT, rotation=self.fR, 
   	onComplete= function (obj) self:back() end });
end


return Square;