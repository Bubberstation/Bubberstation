//////////////////////////////////////
//			MODULAR ITEMS 2.0 		//
//	BETTER AND BIGGER THAN EVER		//
//////////////////////////////////////

//HOW TO CREATE A NEW MODULAR ITEM
// 1) DRAW THE SPRITES (see already made modular sprites)
// 2) FIND THE ITEM YOU WANT TO MAKE MODULAR (example: the grey jumpsuit is /obj/item/clothing/under/color/grey )
// 3) CHANGE IT'S modular_icon_location TO BE THE LOCATION OF THE SPRITES YOU'VE MADE (example: modular_icon_location = 'GainStation13/icons/mob/modclothes/modular_grey.dmi')
// 4) YOU ARE DONE. YOUR ITEM IS NOW MODULAR

//Many functions of the system can be customized by overloading the various procs
//If you know what you are doing then I encoourage you to tweak your item to work better for the idea you had in mind

/mob/living/carbon
	var/modular_items = list()


// Called by handle_fatness, this is called periodically to tell all items to check for sprites and, if needed, build new ones
/mob/living/carbon/proc/handle_modular_items(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM)
	for(var/obj/item/item in modular_items)
		item.update_modular_overlays(src)

/obj/item
	var/modular_icon_location = null	//Locates the sprites, null if it is not a modular item. Changing this makes the item modular
	var/mod_overlays = list()			//Keeps track of the modular sprite overlays for the item
	var/mod_breasts_rec					//Records the last used sprite for breasts to avoid building sprites if no change occurred
	var/mod_butt_rec					//^^^ for butt
	var/mod_belly_rec					//^^^ for belly

//General condition for activating modular sprites for an item.
//When equipped to that item's appropriate slot, if the item has modular icons then initialize it as a modular item
/obj/item/equipped(mob/user, slot)
	if(modular_icon_location != null && slot == slot_flags)
		add_modular_item(user)
	..()

//General condition for deactivating modular sprites for an item.
//When dropped. And/or moved to another slot, works together with equipped checking the approporiate slot
/obj/item/dropped(mob/user)
	remove_modular_item(user)
	..()

//Initialize a modular item by resetting any recorded sprite names and force a sprite update
/obj/item/proc/add_modular_item(mob/user)
	mod_breasts_rec = null
	mod_butt_rec = null
	mod_belly_rec = null
	update_modular_overlays(user)

//Remove a modular item by deleting it from the user's list of tracked modular items
//and forcing sprite deletion
/obj/item/proc/remove_modular_item(mob/user)
	if(!iscarbon(user))
		return
	delete_modular_overlays(user)
	var/mob/living/carbon/U = user
	if(src in U.modular_items)
		U.modular_items -= src

//The meat of the system, checks the genitals, compares to recorded size and request
//the sprites if new ones are needed
/obj/item/proc/update_modular_overlays(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/U = user

	var/list/genitals_list
	var/build_modular = FALSE

	//Before requesting sprites we must make sure new ones are actually needed
	//Go through the genitals of the user to detect belly, butt and breasts (individually, not all 3 are needed)
	//Add it to a list of found genitals to not go through all organs again
	//Get the sprite name of the sprites needed and compare it to the ones recorded
	//If they are different, record the sprites and build_modular to TRUE to signal that new sprites are needed
	var/obj/item/organ/genital/O
	for(O in U.internal_organs)
		if(istype(O, /obj/item/organ/genital/belly))
			genitals_list += list(O)
			var/belly = get_modular_belly(O)
			if(belly != mod_belly_rec)
				mod_belly_rec = belly
				build_modular = TRUE
		if(istype(O, /obj/item/organ/genital/butt))
			genitals_list += list(O)
			var/butt = get_modular_butt(O)
			if(butt != mod_butt_rec)
				mod_butt_rec = butt
				build_modular = TRUE
		if(istype(O, /obj/item/organ/genital/breasts))
			genitals_list += list(O)
			var/breasts = get_modular_breasts(O)
			if(breasts != mod_breasts_rec)
				mod_breasts_rec = breasts
				build_modular = TRUE
	if(!build_modular)	//Stop early if no new sprites are needed
		return
	delete_modular_overlays(U)	//Delete the old sprites

	if(!(src in U.modular_items))	//Make sure the item is inside the user's tracked modular items
		U.modular_items += src		//used on the first sprite request and to ensure it's being tracked for future updates

	//Go through the list of genitals previously found and for each add the modular sprite overlays to the user
	var/obj/item/organ/genital/G
	for(G in genitals_list)
		if(istype(G, /obj/item/organ/genital/belly))
			add_modular_overlay(U, mod_belly_rec, MODULAR_BELLY_LAYER, color)
			add_modular_overlay(U, "[mod_belly_rec]_SOUTH", BELLY_FRONT_LAYER, color)
		if(istype(G, /obj/item/organ/genital/butt))
			add_modular_overlay(U, mod_butt_rec, MODULAR_BUTT_LAYER, color)
			add_modular_overlay(U, "[mod_butt_rec]_NORTH", BUTT_BEHIND_LAYER, color)
		if(istype(G, /obj/item/organ/genital/breasts))
			add_modular_overlay(U, mod_breasts_rec, MODULAR_BREASTS_LAYER, color)
			add_modular_overlay(U, "[mod_breasts_rec]_NORTH", BREASTS_BEHIND_LAYER, color)
			add_modular_overlay(U, "[mod_breasts_rec]_SOUTH", BREASTS_FRONT_LAYER, color)

//Remove the previously built modular sprite overlays and empty the list of tracked overlays
/obj/item/proc/delete_modular_overlays(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/U = user
	if(!(src in U.modular_items))
		return
	for(var/mutable_appearance/overlay in mod_overlays)
		U.cut_overlay(overlay)
	mod_overlays -= mod_overlays

//Function to easily add a requested overlay
//Create the appropriate sprite object (mod_overlay) using the icon previously found, from the item's modular sprites file, on the appropriate overlay and with the item's color
//The sprite is then added to the item's list of built modular sprites overlay
//Added to the appropriate layer of the user
//Then the layer is applied
//
// Why is the layer in mutable appearance entered as its negative version?
// No. Damn. Clue. SS13, I don't question it further.
//
/obj/item/proc/add_modular_overlay(mob/living/carbon/U, modular_icon, modular_layer, sprite_color)
	var/mutable_appearance/mod_overlay = mutable_appearance(modular_icon_location, modular_icon, -(modular_layer), color = sprite_color)
	mod_overlays += mod_overlay
	U.overlays_standing[modular_layer] =  mod_overlay
	U.apply_overlay(modular_layer)

//General function to generate the right icon_state for belly modular sprites
/obj/item/proc/get_modular_belly(obj/item/organ/genital/G)
	return "belly_[get_belly_size(G)][get_belly_alt()]"

//General function to get the appropriate shape and size for the belly, accounting for fullness
/obj/item/proc/get_belly_size(obj/item/organ/genital/G)
	var/size = G.size
	if(G.size > 9)
		size = 9
	var/shape
	if(G.owner.fullness <= FULLNESS_LEVEL_BLOATED)
		switch(G.shape)
			if("Soft Belly")
				shape = "soft"
			if("Round Belly")
				shape = "round"
	else
		shape = "stuffed"
		var/stuffed_modifier
		switch(G.owner.fullness)
			if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG) // Take the stuffed sprite of the same size
				stuffed_modifier = 0
			if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ) // Take the stuffed sprite of size + 1
				stuffed_modifier = 1
			if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)// Take the stuffed sprite of size + 2
				stuffed_modifier = 2
		size = size + stuffed_modifier

	return "[shape]_[size]"

//Placeholder function for alternate variants of the shape and size sprites for belly
/obj/item/proc/get_belly_alt()
	return ""

//General function to get the appropriate shape and size for the butt
/obj/item/proc/get_modular_butt(obj/item/organ/genital/G)
	return "butt_[(G.size <= 10 ) ? "[G.size]" : "10"][get_butt_alt()]"

//General function to get the alternate variants for butt sprites, used for digitigrade characters
/obj/item/proc/get_butt_alt()
	return "[(mutantrace_variation == STYLE_DIGITIGRADE) ? "_l" : ""]"

//General function to get the appropriate size for the breasts
/obj/item/proc/get_modular_breasts(obj/item/organ/genital/G)
	var/size
	if(G.size <= "o")
		size = G.size
	else
		switch(G.size)
			if("huge")
				size = "huge"
			if("massive")
				size = "massive"
			if("giga")
				size = "giga"
			if("impossible")
				size = "impossible"
	return "breasts_[size][get_breasts_alt()]"

//Placeholder function for alternate variants of the breasts
/obj/item/proc/get_breasts_alt()
	return ""

//The modular grey jumpsuit. The foundation of modular items and our holy grail
/obj/item/clothing/under/color/grey
	name = "grey jumpsuit (Modular)"												//(Modular) to tell players it is modular
	modular_icon_location = 'GainStation13/icons/mob/modclothes/modular_grey.dmi'	//Location of the sprites, to make it modular
	desc = "A tasteful grey jumpsuit that reminds you of the good old days."

//Overload of the alt belly sprites function, for adjusteable clothing
/obj/item/clothing/under/get_belly_alt()
	return "[(adjusted) ? "_d" : ""]"

//The placeholder colored jumpsuits
/obj/item/clothing/under/color/grey/service
	name = "service grey jumpsuit (Modular)"
	desc = "Grey only in name"
	color = "#6AD427"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0, WOUND = 5)

/obj/item/clothing/under/color/grey/medical
	name = "medical grey jumpsuit (Modular)"
	desc = "Grey only in name"
	color = "#5A96BB"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0, WOUND = 5)

/obj/item/clothing/under/color/grey/cargo
	name = "cargo grey jumpsuit (Modular)"
	desc = "Grey only in name"
	color = "#BB9042"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 0, WOUND = 10)

/obj/item/clothing/under/color/grey/engi
	name = "engineering grey jumpsuit (Modular)"
	desc = "Grey only in name"
	color = "#FF8800"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 10, FIRE = 60, ACID = 20, WOUND = 5)

/obj/item/clothing/under/color/grey/science
	name = "science grey jumpsuit (Modular)"
	desc = "Grey only in name"
	color = "#9900FF"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 10, BIO = 0, RAD = 0, FIRE = 0, ACID = 0, WOUND = 5)

/obj/item/clothing/under/color/grey/security
	name = "security grey jumpsuit (Modular)"
	desc = "Grey only in name"
	color = "#F4080C"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10)

/obj/item/clothing/under/color/grey/command
	name = "command grey jumpsuit (Modular)"
	desc = "Grey only in name"
	color = "#004B8F"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0, WOUND = 15)
