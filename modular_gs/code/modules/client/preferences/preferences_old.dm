//GS13 Preferences
/datum/preferences
	//Weight Gain Sources
	///Weight gain from food
	var/weight_gain_food = FALSE
	///Weight gain from chems
	var/weight_gain_chems = FALSE
	///Weight gain from items
	var/weight_gain_items = FALSE
	///Weight gain from weapons
	var/weight_gain_weapons = FALSE
	///Weight gain from magic
	var/weight_gain_magic = FALSE
	///Weight gain from viruses
	var/weight_gain_viruses = FALSE
	///Weight gain from nanites
	var/weight_gain_nanites = FALSE
	///Weight gain from atmos gasses
	var/weight_gain_atmos = FALSE
	///content related to transformation
	var/transformation = FALSE
	///Blueberry Inflation
	var/blueberry_inflation = FALSE
	///Extreme weight gain
	var/weight_gain_extreme = FALSE
	///Persistant fatness
	var/weight_gain_persistent = FALSE
	///Permanent weight gain
	var/weight_gain_permanent = FALSE
	/// At what weight will you start to get stuck in airlocks?
	var/stuckage = FALSE
	// Percentage chance to get stuck in doors. Setting this to 0 will make the chance depend on the person's weight
	var/stuckage_chance = 0
	/// At what weight will you start to break chairs?
	var/chair_breakage = FALSE
	/// Are items that only affect those at high weights able to affect the player?
	var/fatness_vulnerable = FALSE
	/// Similar to fatness_vulnerable, but with more extreme effects such as transformation/hypno.
	var/extreme_fatness_vulnerable = FALSE
	/// Can the person be transformed into an object?
	var/object_tf

	// Helplessness, a set of prefs that make things extra tough at higher weights. If set to FALSE, they won't do anything.
	///What fatness level disables movement?
	var/helplessness_no_movement = FALSE
	///What fatness level makes the user clumsy?
	var/helplessness_clumsy = FALSE
	///What fatness level makes the user nearsighted
	var/helplessness_nearsighted = FALSE
	///What fatness level makes the user's face unrecognizable.
	var/helplessness_hidden_face = FALSE
	///What fatness level makes the user unable to speak?
	var/helplessness_mute = FALSE

	///What fatness level, makes the user unable to use their arms?
	var/helplessness_immobile_arms = FALSE
	///What fatness level prevents the user from wearing jumpsuits
	var/helplessness_clothing_jumpsuit = FALSE
	///What fatness level prevents the user from wearing non-jumpsuit clothing
	var/helplessness_clothing_misc = FALSE
	// What fatness level prevents the user from wearing belts. Also affects the max weight the PBS Belt can hide
	var/helplessness_belts = FALSE
	///What fatness level prevents the user from wearing anything on their back
	var/helplessness_clothing_back = FALSE
	///What fatness level prevents the user from being buckled to anything?
	var/helplessness_no_buckle = FALSE

	///Does the person wish to be involved with non-con weight gain events?
	var/noncon_weight_gain = FALSE
	///Does the person want to get into confrontation?
	var/trouble_seeker = FALSE

	//Does the person wish to be fed from bots?
	var/bot_feeding = FALSE

	///What is the max weight that the person wishes to be? If set to FALSE, there will be no max weight
	var/max_weight = FALSE

	var/body_size = 1					//Body Size in percent
	var/starting_weight = 0				//how thicc you wanna be at start
	var/permanent_fat = 0				//If it isn't the consequences of your own actions
	var/wg_rate = 0.5
	var/wl_rate = 0.5
	var/ckeyslot

	var/aaaaaaaaaaaaa
