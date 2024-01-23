//Summon Magic and Summon Guns. Removes giving the survival objective so people don't turn into antags and have an excuse to murder eachother over a pointless greentext.
/datum/round_event/wizard/summonmagic/start()
	summon_magic(survivor_probability = 0)

/datum/round_event/wizard/summonguns/start()
	summon_guns(survivor_probability = 0)
