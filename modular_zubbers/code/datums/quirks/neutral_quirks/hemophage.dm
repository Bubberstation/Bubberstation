#define COFFIN_HEALING_COST 0.5

/datum/quirk/hemophage
	name = "Hemophagia"
	desc = "You have the organs and abilities of someone suffering from the hemophage virus."
	icon = FA_ICON_TEETH
	value = 0
	medical_record_text = "During physical examination, patient was found to have corrupted organs and other abilities commonly found in those suffering \
		from the hemophage virus."
	hardcore_value = 0
	mail_goodies = list(/obj/item/reagent_containers/blood/random)
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	// Most of these are Halloween species but we still have them once a year.
	species_blacklist = list(
		SPECIES_ABDUCTOR_STATION,
		SPECIES_ZOMBIE,
		SPECIES_SKELETON,
		SPECIES_SHADOW,
		SPECIES_PLASMAMAN,
		SPECIES_GOLEM,
		SPECIES_SPIRIT,
		SPECIES_ANDROID,
		SPECIES_ABDUCTOR,
		SPECIES_VAMPIRE,
		SPECIES_PROTEAN,
		SPECIES_SLIMEPERSON,
	)
	COOLDOWN_DECLARE(sun_burn)

	var/datum/blood_type/old_blood_type = null

/datum/quirk/hemophage/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	quirk_holder.add_traits(list(
		TRAIT_DRINKS_BLOOD,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
	), QUIRK_TRAIT)

	old_blood_type = human_holder.dna.blood_type.get_type()
	human_holder.dna.blood_type = get_blood_type(BLOOD_TYPE_UNIVERSAL)

	if(client_source?.prefs.read_preference(/datum/preference/toggle/masquerade))
		ADD_TRAIT(quirk_holder, TRAIT_MASQUERADE_FOOD, QUIRK_TRAIT)

	if(client_source?.prefs.read_preference(/datum/preference/toggle/sol_weakness))
		RegisterSignal(quirk_holder, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK, PROC_REF(on_blood_healing))
		if(!quirk_holder.hud_used)
			RegisterSignal(quirk_holder, COMSIG_MOB_HUD_CREATED, PROC_REF(add_sun_timer_hud))
			return
		add_sun_timer_hud()

/datum/quirk/hemophage/post_add()
	if(quirk_holder.client?.prefs.read_preference(/datum/preference/toggle/pseudo_respiration))
		REMOVE_TRAIT(quirk_holder, TRAIT_NOBREATH, QUIRK_TRAIT)

/datum/quirk/hemophage/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/static/list/organ_slots = list(
		ORGAN_SLOT_HEART = /obj/item/organ/heart/hemophage,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/hemophage,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/hemophage,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/hemophage,
	)
	var/list/possible_organ_slots = organ_slots.Copy()
	if(!length(organ_slots)) //what the hell
		return

	for(var/organ_slot in possible_organ_slots)
		var/organ_path = possible_organ_slots[organ_slot]
		var/obj/item/organ/new_organ = new organ_path()
		new_organ.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/hemophage/remove(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder

	UnregisterSignal(quirk_holder, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK)
	SSsunlight.remove_sun_sufferer(quirk_holder)
	UnregisterSignal(SSsunlight, list(COMSIG_SOL_RISE_TICK, COMSIG_SOL_WARNING_GIVEN))

	if(QDELETED(quirk_holder))
		return

	quirk_holder.remove_traits(list(
		TRAIT_DRINKS_BLOOD,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
		TRAIT_MASQUERADE_FOOD,
	), QUIRK_TRAIT)

	human_holder.dna.blood_type = get_blood_type(old_blood_type)

	var/obj/item/organ/heart/new_heart = new human_holder.dna.species.mutantheart()
	new_heart.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	var/obj/item/organ/liver/new_liver = new human_holder.dna.species.mutantliver()
	new_liver.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	var/obj/item/organ/stomach/new_stomach = new human_holder.dna.species.mutantstomach()
	new_stomach.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	var/obj/item/organ/tongue/new_tongue = new human_holder.dna.species.mutanttongue()
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/hemophage/proc/on_blood_healing(mob/owner, seconds_between_ticks, datum/status_effect/blood_regen_active/effect)
	if(effect && in_coffin())
		// cheaper healing as long as you're in a coffin
		effect.cost_blood = COFFIN_HEALING_COST
	else
		effect.cost_blood = initial(effect.cost_blood)
	// prevent healing if sol is active
	return SSsunlight.sunlight_active ? COMSIG_CANCEL_MOB_HEMO_BLOOD_REGEN : NONE

/datum/quirk/hemophage/proc/add_sun_timer_hud()
	if(!quirk_holder.hud_used)
		CRASH("Sol Weakness quirk holder has no HUD")
	SSsunlight.add_sun_sufferer(quirk_holder)
	UnregisterSignal(quirk_holder, COMSIG_MOB_HUD_CREATED)
	RegisterSignal(SSsunlight, COMSIG_SOL_RISE_TICK, PROC_REF(sun_risen))
	RegisterSignal(SSsunlight, COMSIG_SOL_WARNING_GIVEN, PROC_REF(sun_warning))

/datum/quirk/hemophage/proc/sun_risen()
	SIGNAL_HANDLER
	if(!istype(quirk_holder.loc, /obj/structure))
		sun_burn()
	else
		if(in_coffin())
			quirk_holder.add_mood_event("vampsleep", /datum/mood_event/coffinsleep/quirk)
			sun_burn_message(span_warning("The sun is up, but you safely rest in your [quirk_holder.loc.name]."))
		else
			quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_bad_sleep)
			quirk_holder.adjust_fire_loss(1)
			sun_burn_message(span_warning("[quirk_holder.loc] is not a coffin, but it keeps you safe enough."))

/datum/quirk/hemophage/proc/sun_burn()
	quirk_holder.add_mood_event("vampsleep", /datum/mood_event/daylight_sun_scorched)
	if(quirk_holder.blood_volume > BLOOD_VOLUME_NORMAL * 0.71) // 397.6
		quirk_holder.blood_volume -= 5
		sun_burn_message(span_warning("The sun burns your skin, but your blood protects you from the worst of it..."))
		quirk_holder.adjust_fire_loss(1)
		return
	sun_burn_message(span_userdanger("THE SUN, IT BURNS!"))
	quirk_holder.adjust_fire_loss(2)
	quirk_holder.adjust_fire_stacks(1)
	quirk_holder.ignite_mob()

/datum/quirk/hemophage/proc/sun_burn_message(text)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, sun_burn))
		return
	to_chat(quirk_holder, text)
	COOLDOWN_START(src, sun_burn, 30 SECONDS)

/datum/quirk/hemophage/proc/sun_warning(atom/source, danger_level, vampire_warning_message, ghoul_warning_message)
	SIGNAL_HANDLER
	if(danger_level == DANGER_LEVEL_SOL_ROSE)
		vampire_warning_message = span_userdanger("Solar flares bombard the station with deadly UV light! Stay in cover for the next [TIME_BLOODSUCKER_DAY / 60] minutes or risk death!")
	SSsunlight.warn_notify(quirk_holder, danger_level, vampire_warning_message)

/datum/quirk/hemophage/proc/in_coffin()
	return istype(quirk_holder.loc, /obj/structure/closet/crate/coffin)

/datum/status_effect/blood_regen_active/tick(seconds_between_ticks)
	if(SEND_SIGNAL(owner, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK, seconds_between_ticks, src) & COMSIG_CANCEL_MOB_HEMO_BLOOD_REGEN)
		return
	. = ..()

/datum/quirk_constant_data/hemophage
	associated_typepath = /datum/quirk/hemophage
	customization_options = list(/datum/preference/toggle/masquerade,
		/datum/preference/toggle/sol_weakness,
		/datum/preference/toggle/pseudo_respiration,
	)

/datum/preference/toggle/masquerade
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "masquerade_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/masquerade/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/sol_weakness
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "sol_weakness_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/sol_weakness/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/pseudo_respiration
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "pseudo_respiration_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/pseudo_respiration/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

#undef COFFIN_HEALING_COST
