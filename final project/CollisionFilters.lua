local CollisionFilters = {};

CollisionFilters.player = { categoryBits=1, maskBits=24};
CollisionFilters.bullet = { categoryBits=2, maskBits=60};
CollisionFilters.bomb = { categoryBits=4, maskBits=58};
CollisionFilters.enemy = { categoryBits=8, maskBits=7};
CollisionFilters.enemyBullet={categoryBits=16,maskBits=39};
CollisionFilters.walls = { categoryBits=32, maskBits=22};

return CollisionFilters;
