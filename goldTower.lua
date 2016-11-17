local tower = require ("tower");
local CollisionFilters = require("CollisionFilters");
local data = require("data");

local goldTower = {tag="tower", HP=4, xPos=display.contentWidth/2, yPos=0};



function goldTower:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function goldTower:spawn()
	print("created")
 self.shape = display.newCircle(self.xPos, self.yPos, display.contentWidth/14);
 self.shape.pp = self;      -- parent object
 self.shape.tag = self.tag; -- “enemy”
 self.shape:setFillColor (1,1,0);
 physics.addBody(self.shape, "kinematic", {filter=CollisionFilters.tower}); 
end

function goldTower:shoot (interval)
  interval = interval or 1500;
  local function createShot(obj)
    data.gold = data.gold + 5;
    print("total gold: " ..data.gold);
  end
  self.timerRef = timer.performWithDelay(interval, 
	function (event) createShot(self) end, -1);
end
return goldTower;