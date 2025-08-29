#define DIG_UNDEFINED 	(1<<0) //when the scrap chunk is dug by an item with no dig depth.
#define DIG_DELETE 		(1<<1) //when the scrap chunk is dug too deep and gets destroyed in the process.
#define DIG_ROCK		(1<<2) //when the scrap chunk is just dug, with no additional effects.

#define BRUSH_DELETE	(2<<0) //when the scrap chunk is brushed and the scrap chunk gets destroyed.
#define BRUSH_UNCOVER	(2<<1) //when the scrap chunk is brushed and the scrap chunk reveals what it held.
#define BRUSH_NONE		(2<<2) //when the scrap chunk is brushed, with no additional effects.

#define REWARD_ONE 1
#define REWARD_TWO 2
#define REWARD_THREE 3

/obj/item/scrap_chunk
	name = "scrap chunk"
	desc = "A chunk of scrap, ready to be picked apart for something salvageable."
	icon = 'local/icons/obj/salvage.dmi'
	icon_state = "scrap_chunk"
	pickup_sound = 'sound/items/handling/materials/metal_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'

	///The max depth a scrap chunk can be
	var/max_depth
	///The depth away/subtracted from the max_depth
	var/safe_depth
	//The depth chosen between the max and the max - safe depth
	var/item_depth
	//The depth that has been currently dug
	var/dug_depth = 0
	//The item that is hidden within the scrap chunk
	var/hidden_item
	///Whether the item has been measured, revealing the dug depth
	var/measured = FALSE
	///Whether the ite has been scanned, revealing the max and safe depth
	var/scanned = FALSE
	///Whether the ite has been advance scanned, revealing the true depth
	var/adv_scanned = FALSE
	///The tier of the item that was chosen, 1-100 then 1-3
	var/choose_tier
	/// Low-Value Rewards - ~75% Chance. Generic Scrap items.
	var/static/list/tier1_reward = list(
		/obj/effect/spawner/random/scrap_spawner = 5, \
		/obj/effect/spawner/random/scrap_spawner/two = 10, \
		/obj/effect/spawner/random/scrap_spawner/four = 15, \
	)
	/// High-Value Rewards - ~15% Chance. Stuff that's actually useful to science in some form; if they're lucky.
	var/static/list/tier2_reward = list(
		/obj/item/salvage_handheld_scanner/advanced = 2, \
		/obj/item/salvaging_hammer/adv = 2, \
		/obj/item/salvaging_brush/adv = 2, \
		/obj/item/mod/construction/broken_core = 2, \
		/obj/effect/spawner/random/engineering/tool_advanced = 1, \
		/obj/effect/spawner/random/maintenance/no_decals/eight = 1, \
		/obj/effect/spawner/random/exotic/tool = 1, \
	)
	/// Ultimate Rewards - ~10% Chance. Tier 5 parts only.
	var/static/list/tier3_reward = list(
		/obj/item/stock_parts/capacitor/experimental = 10, \
		/obj/item/stock_parts/matter_bin/anomic = 10, \
		/obj/item/stock_parts/micro_laser/quintuple_bound = 10, \
		/obj/item/stock_parts/scanning_module/prototype = 5, \
		/obj/item/stock_parts/servo/atomic = 10, \
	)

/obj/item/scrap_chunk/Initialize(mapload)
	. = ..()
	create_item()
	create_depth()

/obj/item/scrap_chunk/examine(mob/user)
	. = ..()
	. += span_notice("[scanned ? "This item has been scanned. Max Depth: [max_depth] cm. Safe Depth: [safe_depth] cm." : "This item has not been scanned."]")
	if(adv_scanned)
		. += span_notice("The item depth is [item_depth] cm.")
	. += span_notice("[measured ? "This item has been measured. Dug Depth: [dug_depth]." : "This item has not been measured."]")
	if(measured && dug_depth > item_depth)
		. += span_warning("The chunk is crumbling apart, even just brushing it will destroy it!")

/obj/item/scrap_chunk/proc/create_item()
	choose_tier = rand(1,100)
	switch(choose_tier)
		if(1 to 74)
			hidden_item = pick_weight(tier1_reward)
			choose_tier = REWARD_ONE
		if(75 to 90)
			hidden_item = pick_weight(tier2_reward)
			choose_tier = REWARD_TWO
		if(91 to 100)
			hidden_item = pick_weight(tier3_reward)
			choose_tier = REWARD_THREE

/obj/item/scrap_chunk/proc/create_depth()
	max_depth = rand(21, (22 * choose_tier))
	safe_depth = rand(1, 10)
	item_depth = rand((max_depth - safe_depth), max_depth)
	dug_depth = rand(0, 10)

//returns true if the scrap chunk is measured
/obj/item/scrap_chunk/proc/get_measured()
	if(measured)
		return FALSE
	measured = TRUE
	return TRUE

//returns true if the scrap chunk is scanned
/obj/item/scrap_chunk/proc/get_scanned(use_advanced = FALSE)
	if(scanned)
		if(!adv_scanned && use_advanced)
			adv_scanned = TRUE
			return TRUE
		return FALSE
	scanned = TRUE
	if(use_advanced)
		adv_scanned = TRUE
	return TRUE

/obj/item/scrap_chunk/proc/try_dig(dig_amount)
	if(!dig_amount)
		return DIG_UNDEFINED
	dug_depth += dig_amount
	if(dug_depth > item_depth)
		qdel(src)
		return DIG_DELETE
	return DIG_ROCK

/obj/item/scrap_chunk/proc/try_uncover()
	if(dug_depth > item_depth)
		qdel(src)
		return BRUSH_DELETE
	if(dug_depth == item_depth)
		new hidden_item(get_turf(src))
		qdel(src)
		return BRUSH_UNCOVER
	try_dig(1)
	return BRUSH_NONE

/obj/item/scrap_chunk/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/salvaging_hammer))
		var/obj/item/salvaging_hammer/salv_hammer = I
		to_chat(user, span_notice("You begin carefully using your hammer to pry off parts of the metal..."))
		var/our_dig_speed = (salv_hammer.dig_speed * (10 * min(user.mind.get_skill_modifier(/datum/skill/salvaging, SKILL_SPEED_MODIFIER), 0.1)))
		if(!do_after(user, our_dig_speed, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the chunk in the process!"))
			user.mind?.adjust_experience(/datum/skill/salvaging, round(SALVAGE_SKILL_DOAFTER_PENALTY))
			dug_depth += rand(1,5)
			return
		switch(try_dig(salv_hammer.dig_amount))
			if(DIG_UNDEFINED)
				message_admins("[ADMIN_LOOKUPFLW(user)]'s hammer has somehow pried in a way that shouldn't happen! Tell a coder!")
				return
			if(DIG_DELETE)
				to_chat(user, span_warning("The chunk crumbles away, leaving nothing behind."))
				user.mind?.adjust_experience(/datum/skill/salvaging, round(-salv_hammer.dig_amount)) // Overshot your reward; lose proportional XP
				return
			if(DIG_ROCK)
				to_chat(user, span_notice("You successfully pry further around the relatively interesting part of the chunk."))
				user.mind?.adjust_experience(/datum/skill/salvaging, round(salv_hammer.dig_amount)) // We're giving out XP rewards proportional to dug depth; so that riskier hammer usage is rewarded earlygame.

	if(istype(I, /obj/item/salvaging_brush))
		var/obj/item/salvaging_brush/salv_brush = I
		to_chat(user, span_notice("You begin carefully using your brush."))
		var/our_brush_speed = (salv_brush.dig_speed * (10 * min(user.mind.get_skill_modifier(/datum/skill/salvaging, SKILL_SPEED_MODIFIER), 0.1)))
		if(!do_after(user, our_brush_speed, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the chunk in the process!"))
			user.mind?.adjust_experience(/datum/skill/salvaging, round(SALVAGE_SKILL_DOAFTER_PENALTY))
			dug_depth += rand(1,5)
			return
		switch(try_uncover())
			if(BRUSH_DELETE)
				to_chat(user, span_warning("The chunk crumbles away, leaving nothing behind."))
				return
			if(BRUSH_UNCOVER)
				to_chat(user, span_notice("You successfully brush around the relatively interesting part, and it falls free!"))
				return
			if(BRUSH_NONE)
				to_chat(user, span_notice("You brush around the relatively interesting part, but your search wields no results yet."))

	if(istype(I, /obj/item/salvaging_tape_measure))
		to_chat(user, span_notice("You begin carefully using your measuring tape."))
		var/our_tape_speed = (4 SECONDS * (10 * min(user.mind.get_skill_modifier(/datum/skill/salvaging, SKILL_SPEED_MODIFIER), 0.1)))
		if(!do_after(user, our_tape_speed, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the chunk in the process!"))
			user.mind?.adjust_experience(/datum/skill/salvaging, round(SALVAGE_SKILL_DOAFTER_PENALTY))
			dug_depth += rand(1,5)
			return
		if(get_measured())
			to_chat(user, span_notice("You successfully measure the chunk; noting it's depth against how far it's fallen apart."))
			return
		to_chat(user, span_warning("This chunk has already been measured."))

	if(istype(I, /obj/item/salvage_handheld_scanner))
		var/obj/item/salvage_handheld_scanner/item_scanner = I
		to_chat(user, span_notice("You begin to scan [src] using [item_scanner]."))
		var/our_scan_speed = (item_scanner.scanning_speed * (10 * min(user.mind.get_skill_modifier(/datum/skill/salvaging, SKILL_SPEED_MODIFIER), 0.1)))
		if(!do_after(user, our_scan_speed, target = src))
			to_chat(user, span_warning("You interrupt your scanning, damaging the chunk in the process!"))
			user.mind?.adjust_experience(/datum/skill/salvaging, round(SALVAGE_SKILL_DOAFTER_PENALTY))
			dug_depth += rand(1,5)
			return
		if(get_scanned(item_scanner.scan_advanced))
			to_chat(user, span_notice("Your scanner pings; printing the depth of the chunk against how far it's fallen apart!"))
			if(adv_scanned)
				to_chat(user, span_notice("The chunk's depth is already being reported!"))
			return
		to_chat(user, span_warning("The chunk was already scanned."))

#undef DIG_UNDEFINED
#undef DIG_DELETE
#undef DIG_ROCK

#undef BRUSH_DELETE
#undef BRUSH_UNCOVER
#undef BRUSH_NONE

#undef REWARD_ONE
#undef REWARD_TWO
#undef REWARD_THREE
