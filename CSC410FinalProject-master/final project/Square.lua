local Enemy = require ("Enemy");
local CollisionFilters = require("CollisionFilters");
local ImageSheet = require("ImageSheet");

local Square = Enemy:new( {tag = "enemy", HP=2, fR=720, fT=700, 
				  bT=700} );

function Square:spawn()
  self.shape = display.newSprite(gameSheet, sequenceData);
  self.shape.x = self.xPos;
  self.shape.y = self.yPos; 
  self.shape.pp = self;
  self.shape.tag =self.tag;
  self.shape:setSequence("Enemy Type 3 Black");
  physics.addBody(self.shape, "dynamic", {filter=CollisionFilters.enemy}); 
end

function Square:back ()   
   transition.to(self.shape, {x=self.shape.x-500, 
		     y=self.shape.y+150, time=self.bT, 
   	onComplete=function (obj) self:forward() end});
end

function Square:forward ()	
	transition.to(self.shape, {x=self.shape.x+500, 
			   y=self.shape.y+150, time=self.fT, 
   	onComplete= function (obj) self:back() end });
end


return Square;