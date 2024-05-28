/datum/component/changeling_zombie_infection

	var/zombified = FALSE
	var/can_cure = FALSE

	var/list/obj/item/melee/arm_blade_zombie/arm_blades = list()
	var/obj/item/clothing/suit/armor/changeling_zombie/armor

	var/list/bodypart_zones_to_regenerate = list()
	COOLDOWN_DECLARE(limb_regen_cooldown)

/datum/component/changeling_zombie_infection/Initialize()
	. = ..()
	if(!ishuman(parent) || HAS_TRAIT(parent,TRAIT_UNHUSKABLE) || HAS_TRAIT(parent,TRAIT_GENELESS))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/carbon/human/host = parent

	if(!host.dna)
		return COMPONENT_INCOMPATIBLE

	var/datum/species/host_species = host.dna.species

	if(host_species.no_equip_flags & ITEM_SLOT_OCLOTHING)
		return COMPONENT_INCOMPATIBLE

	if(length(host_species.custom_worn_icons) && host_species.custom_worn_icons[LOADOUT_ITEM_SUIT])
		return COMPONENT_INCOMPATIBLE

	START_PROCESSING(SSobj, src)

/datum/component/changeling_zombie_infection/Destroy(force, silent)

	QDEL_LIST(arm_blades)
	QDEL_NULL(armor)

	STOP_PROCESSING(SSobj, src)

	if(parent)
		var/mob/living/carbon/human/host = parent
		UnregisterSignal(host, COMSIG_LIVING_DEATH)
		UnregisterSignal(host, COMSIG_CARBON_REMOVE_LIMB)
		UnregisterSignal(host, COMSIG_CARBON_ATTACH_LIMB)
		UnregisterSignal(host, COMSIG_MOB_SAY)
		if(zombified)
			playsound(parent, 'sound/magic/demon_consume.ogg', 50, TRUE)
		REMOVE_TRAITS_IN(host,CHANGELING_ZOMBIE_TRAIT)
		host.remove_antag_datum(/datum/antagonist/changeling_zombie)

	zombified = FALSE

	. = ..()

/datum/component/changeling_zombie_infection/process(seconds_per_tick)

	var/mob/living/carbon/human/host = parent

	if(zombified)
		var/list/healing_options = list()
		if(host.getBruteLoss() > 0)
			healing_options += BRUTE
		if(host.getFireLoss() > 0)
			healing_options += BURN
		if(host.getToxLoss() > 0)
			healing_options += TOX
		if(length(healing_options))
			host.heal_damage_type(CHANGELING_ZOMBIE_PASSIVE_HEALING,pick(healing_options))

		if(host.blood_volume <= BLOOD_VOLUME_BAD)
			host.blood_volume += 3

		if(length(bodypart_zones_to_regenerate) && COOLDOWN_FINISHED(src,limb_regen_cooldown))
			var/selected_zone = pick_n_take(bodypart_zones_to_regenerate)
			if(host.regenerate_limb(selected_zone))
				var/obj/item/bodypart/regenerated_bodypart = host.get_bodypart(selected_zone)
				host.visible_message(
					span_danger("[host] reforms and regenerates their [regenerated_bodypart]!"),
					span_userdanger("You reform and regenerate your [regenerated_bodypart]!"),
					span_hear("You hear flesh growing!"),
					COMBAT_MESSAGE_RANGE
				)
				playsound(host, 'sound/effects/splat.ogg', 50)

	else
		var/current_toxin_damage = host.getToxLoss()
		if(can_cure && current_toxin_damage <= 0)
			qdel(src) //Cured!
		else if(current_toxin_damage >= 200 && host.stat == DEAD)
			make_zombie()
			can_cure = FALSE
		else
			if(current_toxin_damage >= 100 && host.stat && host.stat != DEAD) //If you are in crit (but not dead), it means that you can be cured now.
				can_cure = TRUE
			var/tox_to_remove = round(CHANGELING_ZOMBIE_BASE_TOXINS_PER_SECOND + (current_toxin_damage*CHANGELING_ZOMBIE_TOXINS_PER_1_TOXIN_PER_SECOND)/seconds_per_tick,1)
			host.adjustToxLoss(seconds_per_tick * tox_to_remove)
			if(SPT_PROB(8, seconds_per_tick))
				if(current_toxin_damage > 50)
					var/obj/item/bodypart/wound_area = host.get_bodypart(pick(BODY_ZONE_L_ARM,BODY_ZONE_R_ARM))
					if(wound_area)
						var/datum/wound/slash/flesh/moderate/flesh_wound = new
						flesh_wound.apply_wound(wound_area)
						host.visible_message(
							span_danger("[host]\s [wound_area] twists and contorts violently, like something is trying to break free!"),
							span_userdanger("Your [wound_area] twists and contorts violently! What's going on?!"),
							span_hear("You hear flesh breaking!"),
							COMBAT_MESSAGE_RANGE
						)
						host.emote("scream")
					else
						host.emote("groan")
				else if(current_toxin_damage > 25)
					host.visible_message(
						span_warning("[host] doesn't look too good..."),
						span_warning("You don't feel too good...")
					)
					host.emote("cough")




/datum/component/changeling_zombie_infection/proc/make_zombie()

	if(zombified)
		return FALSE

	var/mob/living/carbon/human/host = parent

	if(!host.mind)
		var/mob/canidate = SSpolling.poll_ghosts_for_target(
			"Do you want to play as a Changeling Zombie ([host.name])?", checked_target = host)
		if(istype(canidate))
			host.key = canidate.key
	else
		host.grab_ghost()

	zombified = TRUE

	to_chat(host, span_notice("You feel an itching, both inside and outside as your tissues knit and reknit."))

	host.add_traits(
		list(
			TRAIT_ILLITERATE,
			TRAIT_CHUNKYFINGERS,
			TRAIT_DISCOORDINATED_TOOL_USER,
			TRAIT_AIRLOCK_SHOCKIMMUNE,
			TRAIT_RESISTCOLD,
			TRAIT_RESISTLOWPRESSURE,
			TRAIT_NOHUNGER,
			TRAIT_NOBREATH,
			TRAIT_NO_ZOMBIFY,
			TRAIT_THERMAL_VISION,
			TRAIT_NEARSIGHTED_CORRECTED,
			TRAIT_TUMOR_SUPPRESSED,
			TRAIT_RDS_SUPPRESSED,
			TRAIT_EASYDISMEMBER
		),
		CHANGELING_ZOMBIE_TRAIT
	)

	host.cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
	host.revive(ADMIN_HEAL_ALL)

	host.do_jitter_animation(10 SECONDS)
	playsound(host, 'sound/hallucinations/far_noise.ogg', 50, TRUE)

	host.drop_all_held_items()

	//Give armblades.
	for(var/hand_index=1,hand_index<=length(host.held_items),hand_index++)
		var/obj/item/melee/arm_blade_zombie/arm_blade = new(host.loc)
		ADD_TRAIT(arm_blade, TRAIT_NODROP, CHANGELING_ZOMBIE_TRAIT)
		RegisterSignal(arm_blade, COMSIG_QDELETING, PROC_REF(on_armblade_delete))
		host.put_in_hand(arm_blade,hand_index,forced=TRUE)
		arm_blades += arm_blade

	//Give suit.
	if(host.wear_suit)
		host.temporarilyRemoveItemFromInventory(host.wear_suit,TRUE)
	armor = new(host.loc)
	ADD_TRAIT(armor, TRAIT_NODROP, CHANGELING_ZOMBIE_TRAIT)
	host.equip_to_slot_if_possible(armor,ITEM_SLOT_OCLOTHING,TRUE,TRUE,TRUE)

	//Extra boost
	host.SetKnockdown(0)
	host.setStaminaLoss(0)
	host.set_resting(FALSE)
	host.reagents.add_reagent(/datum/reagent/medicine/changelingadrenaline, 4)
	host.reagents.add_reagent(/datum/reagent/medicine/changelinghaste, 3)

	RegisterSignal(host, COMSIG_LIVING_DEATH, PROC_REF(on_owner_died))
	RegisterSignal(host, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(on_remove_limb))
	RegisterSignal(host, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(on_gain_limb))
	RegisterSignal(host, COMSIG_MOB_SAY, PROC_REF(handle_speech))

	if(host.mind)
		host.mind.add_antag_datum(/datum/antagonist/changeling_zombie)

	return TRUE

/datum/component/changeling_zombie_infection/proc/on_owner_died()

	SIGNAL_HANDLER

	//Death is a valid cure :)
	if(zombified)
		qdel(src)

/datum/component/changeling_zombie_infection/proc/on_remove_limb(datum/source, obj/item/bodypart/removed_limb, special, dismembered)

	SIGNAL_HANDLER

	if(removed_limb.body_zone == BODY_ZONE_HEAD || removed_limb.body_zone == BODY_ZONE_CHEST)
		return

	bodypart_zones_to_regenerate += removed_limb.body_zone
	COOLDOWN_START(src,limb_regen_cooldown,CHANGELING_ZOMBIE_LIMB_REGEN_TIME)


/datum/component/changeling_zombie_infection/proc/on_armblade_delete(datum/source)

	SIGNAL_HANDLER

	src.arm_blades -= source

/datum/component/changeling_zombie_infection/proc/on_gain_limb(datum/source, obj/item/bodypart/gained, special)

	SIGNAL_HANDLER

	if(!gained.held_index)
		return

	var/mob/living/carbon/human/host = parent

	var/obj/item/melee/arm_blade_zombie/arm_blade = new(host.loc)
	ADD_TRAIT(arm_blade, TRAIT_NODROP, CHANGELING_ZOMBIE_TRAIT)
	RegisterSignal(arm_blade, COMSIG_QDELETING, PROC_REF(on_armblade_delete))
	host.put_in_hand(arm_blade,gained.held_index,forced=TRUE)
	arm_blades += arm_blade

	COOLDOWN_START(src,limb_regen_cooldown,CHANGELING_ZOMBIE_LIMB_REGEN_TIME)

/datum/component/changeling_zombie_infection/proc/proc/handle_speech(datum/source, list/speech_args)

	SIGNAL_HANDLER

	speech_args[SPEECH_SPANS] |= SPAN_PAPYRUS
	speech_args[SPEECH_SPANS] |= SPAN_ITALICS
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE]," ","... ")
