//Minimum toxin damage required to transformed. The victim must also be dead.
#define CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_TRANSFORM 100

//Minimum time required to actually transform when all conditions are met.
#define CHANGELING_ZOMBIE_MINIMUM_TRANSFORM_DELAY (30 SECONDS)

//Minimum toxin damage to enter the curable stage. Reducing toxins damage back to 0 cures.
#define CHANGELING_ZOMBIE_TOXINS_THRESHOLD_TO_CURE 50

//Toxin damage per second dealt to living beings with the infection. This doubles every minute.
#define CHANGELING_ZOMBIE_TOXINS_PER_SECOND_LIVING 0.5

//Toxin damage per second dealt to dead beings with the infection. This doubles every minute.
#define CHANGELING_ZOMBIE_TOXINS_PER_SECOND_DEAD 1.5

//Infection chance per instance when a melee attack is supposed to draw blood. This applies to changeling zombies spawned via the event.
#define CHANGELING_ZOMBIE_INFECT_CHANCE 80

//Infection chance per instance when a melee attack is supposed to draw blood. This applies to changeling zombies created by changelings.
#define CHANGELING_ZOMBIE_INFECT_CHANCE_LESSER 0

//Infection cooldown to be able to infect another person after a successful infection.
#define CHANGELING_ZOMBIE_REINFECT_DELAY (3 SECONDS)

//Passive healing provided per second to changeling zombies. Randomly chosen between brute/burn.
#define CHANGELING_ZOMBIE_PASSIVE_HEALING 1

//Amount of time it takes to regenerate a limb, after losing one. Resets when a limb is regrown or another limb is lost.
#define CHANGELING_ZOMBIE_LIMB_REGEN_TIME (30 SECONDS)
