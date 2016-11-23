local soundTable=require("soundTable");
local CollisionFilters = require("CollisionFilters");
local data = require("data");
local ImageSheet = require("ImageSheet");
local tower = {tag="tower", HP=4, xPos=display.contentWidth/2, yPos=0, tPos = 0, timerR};

function tower:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function tower:spawn()
	print("created");
	self.shape = display.newSprite(gameSheet, sequenceData);
	self.shape.x = self.xPos;
	self.shape.y = self.yPos;
	self.shape.pp = self;      -- parent object
	self.shape.tag = self.tag; -- “enemy”
	self.shape:setSequence("Turret Type 1 Red");
	self.shape.HP = self.HP; 
	self.shape.tPos = self.tPos;
	physics.addBody(self.shape, "kinematic", {filter=CollisionFilters.tower});
	data.CurrentTowers[self.tPos] = 1;
end

function tower:shoot (interval)
  interval = interval or 800;
  local function createShot(obj)
    local p = display.newSprite(gameSheet,sequenceData);
    p.x = obj.shape.x;
    p.y = obj.shape.y-90;
    p.anchorY=0;
    p:setSequence("Laser Type 1 Green");
    physics.addBody (p, "dynamic", {filter=CollisionFilters.bullet});
    p:applyForce(0, -4, p.x, p.y);
		p.tag = "shot";

    local function shotHandler (event)
      if (event.phase == "began") then

      --print("you got me")
	  event.target:removeSelf();
   	  event.target = nil;

   	    if (event.other.tag == "enemy") then

    		event.other.pp:hit();
    		print("hit an enemy")
         	if(event.other.pp.HP == 0) then
         		--gold = gold + 20;
         		--scoreText.text = "Gold: " .. gold;
         		data.enemyCount = data.enemyCount - 1;
         		print("Enemies: " ..data.enemyCount);
         		--print("Gold: " ..gold);
            if(data.enemyCount == 0)then
              
            end
         	end

        end
      end
    end
    p:addEventListener("collision", shotHandler);		
  end
  self.timerRef = timer.performWithDelay(interval, 
	function (event) createShot(self) end, -1);
	self.shape.timerRef = self.timerRef;
  self.timerR = timerRef;
  self.shape.timerR = self.timerR;
end

function tower:tHit () 
  print("tower got hit boys");
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

return tower;