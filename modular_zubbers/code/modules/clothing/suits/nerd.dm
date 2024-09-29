
#define SOUND_BEEP(sound) add_queue(##sound, 20)
#define MORPHINE_INJECTION_DELAY (30 SECONDS)

/obj/item/clothing/suit/armor/nerd
	name = "\improper D.O.T.A. suit"
	desc = "The Defenseless Operator Traversal Assistance suit is a highly experimental Nanotrasen designed \
		protective full body harness designed to prolong the lifespan (and thus productivity) of an employee \
		via surplus medical technology found in the abandoned part of maintenance no one seems to want to talk about. \
		Unfortunately the research department couldn't design a helmet before the third quarter so this is definitely not spaceproof. \
		One size fits most."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	icon_state = "nerd"
	blood_overlay_type = "suit"

	w_class = WEIGHT_CLASS_BULKY
	clothing_flags = THICKMATERIAL

	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDEGLOVES

	armor_type = /datum/armor/nerdsuit
	resistance_flags = FIRE_PROOF | ACID_PROOF

	strip_delay = 70
	equip_delay_other = 70

	var/static/list/suit_signals = list(
		COMSIG_LIVING_DEATH = PROC_REF(handle_death),
		COMSIG_LIVING_IGNITED = PROC_REF(handle_ignite),
		COMSIG_LIVING_ELECTROCUTE_ACT = PROC_REF(handle_shock),
		COMSIG_LIVING_MINOR_SHOCK = PROC_REF(handle_shock),
		COMSIG_CARBON_GAIN_WOUND = PROC_REF(handle_wound_add),
		COMSIG_MOB_APPLY_DAMAGE = PROC_REF(handle_damage)
	)

	var/static/list/wound_to_sound = list(
		/datum/wound/blunt/bone/severe = 'modular_zubbers/sound/voice/nerdsuit/major_fracture.ogg',
		/datum/wound/blunt/bone/critical = 'modular_zubbers/sound/voice/nerdsuit/major_fracture.ogg',
		/datum/wound/slash/flesh/moderate = 'modular_zubbers/sound/voice/nerdsuit/minor_lacerations.ogg',
		/datum/wound/slash/flesh/severe = 'modular_zubbers/sound/voice/nerdsuit/major_lacerations.ogg',
		/datum/wound/slash/flesh/critical = 'modular_zubbers/sound/voice/nerdsuit/major_lacerations.ogg',
	)

	var/list/sound_queue = list()

	var/mob/living/carbon/owner

	var/obj/item/geiger_counter/stored_geiger_counter

	COOLDOWN_DECLARE(next_damage_notify)
	COOLDOWN_DECLARE(next_morphine)

	slowdown = 0

/datum/armor/nerdsuit
	acid = 50
	bio = 100
	bullet = 25
	energy = 25
	laser = 25
	fire = 50
	melee = 25
	wound = 10

/obj/item/clothing/suit/armor/nerd/Initialize(mapload)
	. = ..()
	stored_geiger_counter = new(src)
	stored_geiger_counter.scanning = TRUE
	update_appearance(UPDATE_ICON)

/obj/item/clothing/suit/armor/nerd/Destroy()
	QDEL_NULL(stored_geiger_counter)
	owner = null
	return ..()

/obj/item/clothing/suit/armor/nerd/proc/process_sound_queue()

	var/list/sound_data = sound_queue[1]
	var/sound_file = sound_data[1]
	var/sound_delay = sound_data[2]

	playsound(src, sound_file, 50)

	sound_queue.Cut(1,2)

	if(!length(sound_queue))
		return

	addtimer(CALLBACK(src, PROC_REF(process_sound_queue)), sound_delay)

/obj/item/clothing/suit/armor/nerd/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "already emagged!")
		return FALSE
	if(owner)
		balloon_alert(user, "take it off first!")
		return FALSE
	obj_flags |= EMAGGED
	do_sparks(8, FALSE, get_turf(src))
	return TRUE

/obj/item/clothing/suit/armor/nerd/proc/add_queue(desired_file, desired_delay, purge_queue=FALSE)

	var/was_empty_sound_queue = !length(sound_queue)

	if(purge_queue)
		sound_queue.Cut()

	sound_queue += list(list(desired_file,desired_delay)) //BYOND is fucking weird so you have to do this bullshit if you want to add a list to a list.

	if(was_empty_sound_queue)
		addtimer(CALLBACK(src, PROC_REF(process_sound_queue)), 1 SECONDS)

	return TRUE

//Signal handling.
/obj/item/clothing/suit/armor/nerd/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_OCLOTHING && iscarbon(user))
		for(var/signal_type in suit_signals)
			RegisterSignal(user, signal_type, suit_signals[signal_type])
		add_queue('modular_zubbers/sound/voice/nerdsuit/bell.ogg', 2 SECONDS, purge_queue=TRUE)
		owner = user
		if(prob(1))
			add_queue('modular_zubbers/sound/voice/nerdsuit/emag.ogg', 27 SECONDS)
		else
			add_queue('modular_zubbers/sound/voice/nerdsuit/welcome.ogg', 8 SECONDS)
	else
		for(var/signal_type in suit_signals)
			UnregisterSignal(user, signal_type) //Just in case.

/obj/item/clothing/suit/armor/nerd/dropped(mob/user, silent)
	. = ..()
	for(var/signal_type in suit_signals)
		UnregisterSignal(user, signal_type)

//Death
/obj/item/clothing/suit/armor/nerd/proc/handle_death(gibbed)

	SIGNAL_HANDLER

	add_queue('modular_zubbers/sound/voice/nerdsuit/death.ogg', 5 SECONDS, purge_queue=TRUE)

//Fire
/obj/item/clothing/suit/armor/nerd/proc/handle_ignite(mob/living)

	SIGNAL_HANDLER

	SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
	add_queue('modular_zubbers/sound/voice/nerdsuit/heat.ogg', 3 SECONDS)

//Shock
/obj/item/clothing/suit/armor/nerd/proc/handle_shock(mob/living)

	SIGNAL_HANDLER

	SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
	add_queue('modular_zubbers/sound/voice/nerdsuit/shock.ogg', 3 SECONDS)

//Wounds
/obj/item/clothing/suit/armor/nerd/proc/handle_wound_add(mob/living/carbon/victim, datum/wound/wound, obj/item/bodypart/limb)

	SIGNAL_HANDLER

	var/found_sound = wound_to_sound[wound.type]
	if(found_sound)
		SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
		add_queue(found_sound, 4 SECONDS)

	if(wound.severity >= WOUND_SEVERITY_MODERATE)
		SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
		add_queue('modular_zubbers/sound/voice/nerdsuit/seek_medical.ogg', 2 SECONDS)
		administer_morphine()

/obj/item/clothing/suit/armor/nerd/proc/administer_morphine()

	SIGNAL_HANDLER

	if(!owner.reagents)
		return

	if(!COOLDOWN_FINISHED(src, next_morphine))
		return

	if(obj_flags & EMAGGED)
		owner.reagents.add_reagent(/datum/reagent/medicine/stimulants, 5)
		owner.reagents.add_reagent(/datum/reagent/medicine/morphine, 3)
		SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
		add_queue('modular_zubbers/sound/voice/nerdsuit/stimulants.ogg', 2 SECONDS)
	else
		owner.reagents.add_reagent(/datum/reagent/medicine/morphine, 3)
		SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
		add_queue('modular_zubbers/sound/voice/nerdsuit/morphine.ogg', 2 SECONDS)

	COOLDOWN_START(src, next_morphine, MORPHINE_INJECTION_DELAY)

	return TRUE

//General Damage
/obj/item/clothing/suit/armor/nerd/proc/handle_damage(mob/living/carbon/victim, damage, damagetype, def_zone)

	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, next_damage_notify))
		return

	if(damage < 5 || owner.maxHealth <= 0)
		return

	var/health_percent = owner.health / owner.maxHealth
	if(health_percent > 0.6 || !prob(damage * 4))
		return

	if(health_percent <= 0.2)
		SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
		add_queue('modular_zubbers/sound/voice/nerdsuit/vital_signs_death.ogg', 3 SECONDS)
		administer_morphine()
	else if(health_percent <= 0.4)
		SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_3.ogg')
		add_queue('modular_zubbers/sound/voice/nerdsuit/vital_signs_critical.ogg', 3 SECONDS)
	else if(health_percent <= 0.6)
		SOUND_BEEP('modular_zubbers/sound/voice/nerdsuit/beep_2.ogg')
		add_queue('modular_zubbers/sound/voice/nerdsuit/vital_signs_dropping.ogg', 2 SECONDS)

	COOLDOWN_START(src, next_damage_notify, 5 SECONDS)

#undef MORPHINE_INJECTION_DELAY
#undef SOUND_BEEP
