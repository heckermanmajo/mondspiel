--- @class  ParticleSpawner Smoke, fire, blood and gore, other debree is spanwed in by particle spawners
---         which are placed on the map and have different parameters. some spawn over a short time, others
---         spawn continuously. All have timers that determine when to spawn the next particle or when to remove
---         themselves from the map. The can be done but the particles stay, like debree. Then they are put in another
---         "dont update list".
ParticleSpawner = {}