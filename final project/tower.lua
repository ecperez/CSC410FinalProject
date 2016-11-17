local soundTable=require("soundTable");
local CollisionFilters = require("CollisionFilters");
local data = require("data");

local tower = {tag="tower", HP=4, xPos=display.contentWidth/2, yPos=0};



function tower:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function tower:spawn()
	print("created")
 self.shape = display.newCircle(self.xPos, self.yPos, display.contentWidth/14);
 self.shape.pp = self;      -- parent object
 self.shape.tag = self.tag; -- “enemy”
 self.shape:setFillColor (1,0,0);
 physics.addBody(self.shape, "kinematic", {filter=CollisionFilters.tower}); 
end

function tower:shoot (interval)
  interval = interval or 800;
  local function createShot(obj)
    local p = display.newCircle (obj.shape.x, obj.shape.y+50, 10);
    p:setFillColor(1,0,0);
    p.anchorY=0;
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
end
return tower;