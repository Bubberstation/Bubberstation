//BLOOPER defines
#define BLOOPER_DEFAULT_MINPITCH 0.4
#define BLOOPER_DEFAULT_MAXPITCH 2
#define BLOOPER_DEFAULT_MINVARY 0.1
#define BLOOPER_DEFAULT_MAXVARY 0.8
#define BLOOPER_DEFAULT_MINSPEED 2
#define BLOOPER_DEFAULT_MAXSPEED 16

#define BLOOPER_SPEED_BASELINE 4 //Used to calculate delay between BLOOPERs, any BLOOPER speeds below this feature higher BLOOPER density, any speeds above feature lower BLOOPER density. Keeps BLOOPERing length consistent

#define BLOOPER_MAX_BLOOPERS 24
#define BLOOPER_MAX_TIME (1.5 SECONDS) // More or less the amount of time the above takes to process through with a BLOOPER speed of 2.

#define BLOOPER_PITCH_RAND(gend) ((gend == MALE ? rand(60, 120) : (gend == FEMALE ? rand(80, 140) : rand(60,140))) / 100) //Macro for determining random pitch based off gender
#define BLOOPER_VARIANCE_RAND (rand(BLOOPER_DEFAULT_MINVARY * 100, BLOOPER_DEFAULT_MAXVARY * 100) / 100) //Macro for randomizing BLOOPER variance to reduce the amount of copy-pasta necessary for that

#define BLOOPER_DO_VARY(pitch, variance) (rand(((pitch * 100) - (variance*50)), ((pitch*100) + (variance*50))) / 100)

#define BLOOPER_SOUND_FALLOFF_EXPONENT 0.5 //At lower ranges, we want the exponent to be below 1 so that whispers don't sound too awkward. At higher ranges, we want the exponent fairly high to make yelling less obnoxious
