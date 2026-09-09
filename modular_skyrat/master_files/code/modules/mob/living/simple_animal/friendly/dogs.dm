/mob/living/basic/pet/dog/markus
	name = "\proper Markus"
	desc = "The supply department's overfed yet still beloved dog."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "markus"
	icon_dead = "markus_dead"
	icon_living = "markus"
	butcher_results = list(
		/obj/item/food/burger/cheese = 1,
		/obj/item/food/meat/slab = 2,
		/obj/item/trash/syndi_cakes = 1,
		)
	ai_controller = /datum/ai_controller/basic_controller/dog/corgi
	gender = MALE
	gold_core_spawnable = FRIENDLY_SPAWN
	///can this mob breed?
	var/can_breed = TRUE

	/// List of possible dialogue options. This is both used by the AI and as an override when a sentient Markus speaks.
	var/static/list/markus_speak = list("Borf!", "Boof!", "Bork!", "Bowwow!", "Burg?")

/mob/living/basic/pet/dog/markus/Initialize(mapload)
	. = ..()
	if(!can_breed)
		return
	AddComponent(\
		/datum/component/breed,\
		can_breed_with = typecacheof(list(/mob/living/basic/pet/dog/corgi)),\
		baby_paths = list(/mob/living/basic/pet/dog/corgi/puppy),\
	) // no mixed breed puppies sadly
	RemoveElement(/datum/element/can_be_held)

/mob/living/basic/pet/dog/markus/treat_message(message)
	if(client)
		message = pick(markus_speak) // markus only talks business
	return ..()

/mob/living/basic/pet/dog/markus/update_dog_speech(list/speech_data)
	. = ..()
	speech_data[BB_EMOTE_SAY] = markus_speak

/datum/chemical_reaction/mark_reaction
	results = list(/datum/reagent/consumable/liquidgibs = 15)
	required_reagents = list(
		/datum/reagent/blood = 20,
		/datum/reagent/medicine/omnizine = 20,
		/datum/reagent/medicine/c2/synthflesh = 20,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/ketchup = 5,
		/datum/reagent/consumable/mayonnaise = 5,
		/datum/reagent/colorful_reagent/powder/yellow/crayon = 5,
	)

	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)
	required_temp = 480

/datum/chemical_reaction/mark_reaction/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /mob/living/basic/pet/dog/markus(location)
	playsound(location, 'modular_skyrat/master_files/sound/effects/dorime.ogg', vol = 100, vary = FALSE, extrarange = 7)

/mob/living/basic/pet/dog/corgi/borgi
	name = "E-N"
	desc = "It's a borgi."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "borgi"
	icon_living = "borgi"
	icon_dead = "borgi_dead"
	gender = NEUTER
	unique_pet = TRUE
	maxHealth = 150
	health = 150
	butcher_results = list(
		/obj/item/clothing/head/costume/skyrat/en = 1,
		/obj/item/clothing/suit/corgisuit/en = 1,
	)
	death_message = "beeps, its mechanical parts hissing before the chassis collapses in a loud thud."
	gold_core_spawnable = NO_SPAWN
	can_be_shaved = FALSE
	ai_controller = /datum/ai_controller/basic_controller/dog/borgi
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	can_breed = FALSE

	// These lights enable when E-N is emagged
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_color = COLOR_RED
	light_range = 2
	light_power = 0.8
	light_on = FALSE

	/// Has E-N been emagged already?
	var/emagged = FALSE
	/// A list of the things dropped when it dies
	var/static/list/borgi_drops = list(/obj/effect/decal/cleanable/blood/oil/slippery)
	/// The threshold of HP before the borgi attacks non-friends
	var/rage_hp = 30
	/// The chance to spark (on life)
	var/spark_chance = 5

/mob/living/basic/pet/dog/corgi/borgi/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/death_drops, borgi_drops)

	var/datum/component/overlay_lighting/lighting_object = src.GetComponent(/datum/component/overlay_lighting)
	var/image/cone = lighting_object.cone
	cone.transform = cone.transform.Translate(0, -8)

	// Defense protocol
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(src, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(src, COMSIG_ATOM_HITBY, PROC_REF(on_hitby))
	// For traitor objectives
	RegisterSignal(src, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emag_act))

	RemoveElement(/datum/element/can_be_held)

/**
 * Try to harass a target, considering if they are a friend.
 *
 * Arguments:
 * * target - the target to harrass
 * * always_shoot - always shoot the target, as opposed to only if not a friend.
 */
/mob/living/basic/pet/dog/corgi/borgi/proc/harass_target(mob/living/target, always_shoot = FALSE)
	var/datum/ai_controller/basic_controller/dog/borgi = ai_controller
	if(!borgi)
		return

	var/list/friends_list = borgi.blackboard[BB_FRIENDS_LIST]
	var/is_friend = friends_list && friends_list[WEAKREF(target)]

	if(always_shoot || !is_friend)
		INVOKE_ASYNC(src, PROC_REF(shoot_at), target)

	if(health > rage_hp || is_friend)
		return

/mob/living/basic/pet/dog/corgi/borgi/proc/on_attack_hand(datum/source, mob/living/target)
	SIGNAL_HANDLER

	if(!target.combat_mode || health <= 0)
		return

	harass_target(target, always_shoot = TRUE)

/mob/living/basic/pet/dog/corgi/borgi/proc/on_attackby(datum/source, obj/item/used_item, mob/living/target, list/modifiers)
	SIGNAL_HANDLER

	if(!used_item.force || used_item.damtype == STAMINA || health <= 0)
		return

	harass_target(target, always_shoot = TRUE)

/mob/living/basic/pet/dog/corgi/borgi/proc/on_hitby(datum/source, obj/item/used_item, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER

	if(!istype(used_item) || used_item.throwforce < 5 || health <= 0)
		return

	var/mob/living/carbon/human/thrown_by = throwingdatum.get_thrower()
	if(!ishuman(thrown_by))
		return

	harass_target(thrown_by)

/mob/living/basic/pet/dog/corgi/borgi/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()

	if(. != BULLET_ACT_HIT)
		return

	if(!istype(hitting_projectile, /obj/projectile/beam) && !istype(hitting_projectile, /obj/projectile/bullet))
		return

	var/mob/living/carbon/human/target = hitting_projectile.firer
	if(hitting_projectile.damage >= 10)
		if(hitting_projectile.damage_type != BRUTE && hitting_projectile.damage_type != BURN)
			return

		adjust_brute_loss(hitting_projectile.damage)
		if(!isliving(target) || health <= 0)
			return

		harass_target(target)
	else
		shoot_at(target, harmless = TRUE)

/mob/living/basic/pet/dog/corgi/borgi/proc/shoot_at(atom/movable/target, harmless = FALSE)
	var/turf/source_turf = get_turf(src)
	var/turf/target_turf = get_turf(target)
	if(!source_turf || !target_turf)
		return

	var/obj/projectile/fired_projectile
	var/fire_sound
	if(harmless)
		fired_projectile = new /obj/projectile/bullet/foam_dart(loc)
		fired_projectile.icon = 'icons/obj/weapons/guns/toy.dmi'
		fired_projectile.icon_state = "foamdart_proj"
		fire_sound = 'sound/items/syringeproj.ogg'
	else
		fired_projectile = new /obj/projectile/beam(loc)
		fired_projectile.icon = 'icons/mob/effects/genetics.dmi'
		fired_projectile.icon_state = "eyelasers"
		fire_sound = 'sound/items/weapons/taser.ogg'

	playsound(loc, fire_sound, vol = 75, vary = TRUE)
	fired_projectile.aim_projectile(target, source_turf)
	fired_projectile.firer = src
	fired_projectile.fired_from = src
	fired_projectile.fire()

/mob/living/basic/pet/dog/corgi/borgi/Life(seconds, times_fired)
	. = ..()

	// spark for no reason
	if(prob(spark_chance))
		do_sparks(3, 1, src)

/mob/living/basic/pet/dog/corgi/borgi/death(gibbed)
	// Only execute the below if we successfully died
	. = ..(gibbed)
	if(!.)
		return FALSE

	UnregisterSignal(src, COMSIG_ATOM_ATTACK_HAND)
	UnregisterSignal(src, COMSIG_ATOM_ATTACKBY)
	UnregisterSignal(src, COMSIG_ATOM_HITBY)
	UnregisterSignal(src, COMSIG_ATOM_EMAG_ACT)

	do_sparks(number = 3, cardinal_only = TRUE, source = src)

/mob/living/basic/pet/dog/corgi/borgi/proc/on_emag_act(mob/living/basic/pet/dog/target, mob/user)
	SIGNAL_HANDLER

	if(emagged)
		return FALSE

	emagged = TRUE

	// Emote sleeps.
	INVOKE_ASYNC(src, PROC_REF(emote), "exclaim")
	set_light_on(TRUE)

	add_fingerprint(user, TRUE)
	investigate_log("has been gibbed due to being emagged by [user].", INVESTIGATE_DEATHS)
	visible_message(span_boldwarning("[user] swipes a card through [target]!"), span_notice("You overload [target]s internal reactor..."))

	notify_ghosts("[user] has shortcircuited [target] to explode in 60 seconds!",
		source = target,
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
		header = "Borgi Emagged",
	)
	addtimer(CALLBACK(src, PROC_REF(explode_imminent)), 50 SECONDS)

	return TRUE

/mob/living/basic/pet/dog/corgi/borgi/proc/explode_imminent()
	visible_message(span_bolddanger("[src] makes an odd whining noise!"))
	do_jitter_animation(30)

	addtimer(CALLBACK(src, PROC_REF(explode)), 10 SECONDS)

/mob/living/basic/pet/dog/corgi/borgi/proc/explode()
	explosion(get_turf(src), 1, 2, 4, 4, 6) // Should this be changed?
	gib() // Yuck, robo-blood

/// Dog controller but with emag attack support
/datum/ai_controller/basic_controller/dog/borgi
	blackboard = list(
		BB_DOG_HARASS_HARM = TRUE,
		BB_VISION_RANGE = AI_DOG_VISION_RANGE,
		BB_DOG_IS_SLOW = TRUE,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

/mob/living/basic/pet/dog/dobermann
	name = "\improper dobermann"
	desc = "A larger breed of dog."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "dobber"
	icon_dead = "dobbydead"
	icon_living = "dobber"

/mob/living/basic/pet/dog/pitbull
	name = "\improper pitbull"
	desc = "Lover of Blood. Hater of Toddlers"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "pitbull"
	icon_dead = "pitbull_dead"
	icon_living = "pitbull"
	ai_controller = /datum/ai_controller/basic_controller/pitbull

/datum/ai_controller/basic_controller/pitbull
	behavior_tree_json = "modular_skyrat/master_files/code/modules/mob/living/simple_animal/friendly/pitbull.bt.json"
	blackboard = list(
		BB_DOG_HARASS_HARM = TRUE,
		BB_VISION_RANGE = AI_DOG_VISION_RANGE,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		// Find smaller mobs
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/of_size/smaller,
		// With tongs in hand!
		BB_TARGET_HELD_ITEM = /obj/item/kitchen/tongs,
		BB_BABIES_PARTNER_TYPES = list(/mob/living/basic/pet/dog),
	)

	ai_movement = /datum/ai_movement/dumb


/mob/living/basic/pet/dog/pitbull/Initialize(mapload)
	. = ..()
	if(prob(1))
		name = pick("Crayon", "Pimpy", "Staypuft", "Bape", "BLOODSKULL", "Baby G")
	AddElement(/datum/element/tiny_mob_hunter, MOB_SIZE_SMALL) //He eats anything that he sees as a toddler.
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)
	RemoveElement(/datum/element/can_be_held)
