local Enemy = require ("Enemy");
local CollisionFilters = require("CollisionFilters");
local ImageSheet = require("ImageSheet");

local Square = Enemy:new( {HP=2, fR=720, fT=700, bT=700} );

function Square:spawn()
  self.shape = display.newSprite(gameSheet, sequenceData);
  self.shape.x = self.xPos;
  self.shape.y = self.yPos;
  self.shape:setSequence("Enemy Type 3 Green");
  self.shape.pp = self;
  self.shape.tag = "enemy";
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
