local Enemy = require ("Enemy");
local CollisionFilters = require("CollisionFilters");

local Square = Enemy:new( {HP=2, fR=720, fT=700, 
				  bT=700} );

function Square:spawn()
  self.shape = display.newRect (self.xPos, 
    	 	 			  self.yPos, 30, 30); 
  self.shape.pp = self;
  self.shape.tag = "enemy";
  self.shape:setFillColor ( 0, 1, 1);
   physics.addBody(self.shape, "kinematic", {filter=CollisionFilters.enemy}); 
end

function Square:back ()   
   transition.to(self.shape, {x=self.shape.x-400, 
		     time=self.bT, rotation=self.sR, 
   	onComplete=function (obj) self:forward() end});
end

function Square:forward ()	
	transition.to(self.shape, {x=self.shape.x+400, 
			  time=self.fT, rotation=self.fR, 
   	onComplete= function (obj) self:back() end });
end


return Square;