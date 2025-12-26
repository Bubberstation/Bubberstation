/obj/effect/mob_spawn/ghost_role/robot
	name = "Ghost Role Robot"
	prompt_name = "a robot"
	you_are_text = "You are a robot. This probably shouldn't be happening."
	flavour_text = "You are a robot. This probably shouldn't be happening."
	mob_type = /mob/living/silicon/robot

/obj/effect/mob_spawn/ghost_role/robot/ghostcafe
	name = "Cafe Robotic Storage"
	prompt_name = "a ghost cafe robot"
	infinite_use = TRUE
	deletes_on_zero_uses_left = FALSE
	icon = 'modular_skyrat/modules/ghostcafe/icons/robot_storage.dmi'
	icon_state = "robostorage"
	anchored = TRUE
	density = FALSE
	spawner_job_path = /datum/job/ghostcafe
	you_are_text = "You are a Cafe Robot!"
	flavour_text = "Who could have thought? This awesome local cafe accepts cyborgs too!"
	mob_type = /mob/living/silicon/robot/model/roleplay
	random_appearance = FALSE
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/robot/ghostcafe/special(mob/living/silicon/robot/new_spawn)
	. = ..()
	if(new_spawn.client)
		new_spawn.custom_name = null
		new_spawn.updatename(new_spawn.client)
		new_spawn.transfer_emote_pref(new_spawn.client)
		new_spawn.gender = NEUTER
		var/area/A = get_area(src)
		//new_spawn.AddElement(/datum/element/ghost_role_eligibility, free_ghosting = TRUE) SKYRAT PORT -- Needs to be completely rewritten
		new_spawn.AddElement(/datum/element/dusts_on_catatonia)
		new_spawn.AddElement(/datum/element/dusts_on_leaving_area, list(A.type) + GLOB.ghost_cafe_areas)
		new_spawn.RegisterSignal(new_spawn, COMSIG_MOVABLE_USING_RADIO, TYPE_PROC_REF(/mob/living, on_using_radio))
		ADD_TRAIT(new_spawn, TRAIT_SIXTHSENSE, TRAIT_GHOSTROLE)
		ADD_TRAIT(new_spawn, TRAIT_FREE_GHOST, TRAIT_GHOSTROLE)
		to_chat(new_spawn,span_warning("<b>Ghosting is free!</b>"))
		var/datum/action/toggle_dead_chat_mob/D = new(new_spawn)
		D.Grant(new_spawn)

/obj/effect/mob_spawn/ghost_role/human/ghostcafe
	name = "Cafe Sleeper"
	prompt_name = "a ghost cafe human"
	infinite_use = TRUE
	deletes_on_zero_uses_left = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	density = FALSE
	spawner_job_path = /datum/job/ghostcafe
	outfit = /datum/outfit/ghostcafe
	you_are_text = "You are a Cafe Visitor!"
	flavour_text = "You are off-duty and have decided to visit your favourite cafe. Enjoy yourself."
	random_appearance = FALSE
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/ghostcafe/special(mob/living/carbon/human/new_spawn)
	. = ..()
	if(new_spawn.client)
		var/area/A = get_area(src)
		new_spawn.AddElement(/datum/element/dusts_on_catatonia)
		new_spawn.AddElement(/datum/element/dusts_on_leaving_area, list(A.type) + GLOB.ghost_cafe_areas)
		new_spawn.RegisterSignal(new_spawn, COMSIG_MOVABLE_USING_RADIO, TYPE_PROC_REF(/mob/living, on_using_radio))
		ADD_TRAIT(new_spawn, TRAIT_SIXTHSENSE, TRAIT_GHOSTROLE)
		ADD_TRAIT(new_spawn, TRAIT_FREE_GHOST, TRAIT_GHOSTROLE)
		to_chat(new_spawn,span_warning("<b>Ghosting is free!</b>"))
		var/datum/action/toggle_dead_chat_mob/D = new(new_spawn)
		D.Grant(new_spawn)

/mob/living/proc/on_using_radio(atom/movable/talking_movable)
	SIGNAL_HANDLER

	var/area/target_area = get_area(talking_movable)
	if(target_area.type in GLOB.ghost_cafe_areas)
		return COMPONENT_CANNOT_USE_RADIO

/datum/outfit/ghostcafe
	name = "Cafe Visitor"
	uniform = /obj/item/clothing/under/chameleon
	shoes = /obj/item/clothing/shoes/chameleon
	id = /obj/item/card/id/advanced/chameleon/ghost_cafe
	back = /obj/item/storage/backpack/chameleon
	backpack_contents = list(/obj/item/storage/box/syndie_kit/chameleon/ghostcafe = 1)
	skillchips = list(/obj/item/skillchip/job/roboticist, /obj/item/skillchip/job/engineer)

/datum/outfit/ghostcafe/pre_equip(mob/living/carbon/human/visitor, visuals_only = FALSE)
	..()
	if (isplasmaman(visitor))
		backpack_contents += list(/obj/item/tank/internals/plasmaman/belt/full = 2)
	if(isvox(visitor) || isvoxprimalis(visitor))
		backpack_contents += list(/obj/item/tank/internals/nitrogen/belt/full = 2)

/datum/action/toggle_dead_chat_mob
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"
	name = "Toggle deadchat"
	desc = "Turn off or on your ability to hear ghosts."

/datum/action/toggle_dead_chat_mob/Trigger(trigger_flags)
	if(!..())
		return 0
	var/mob/M = target
	if(HAS_TRAIT_FROM(M,TRAIT_SIXTHSENSE,TRAIT_GHOSTROLE))
		REMOVE_TRAIT(M,TRAIT_SIXTHSENSE,TRAIT_GHOSTROLE)
		to_chat(M,span_notice("You're no longer hearing deadchat."))
	else
		ADD_TRAIT(M,TRAIT_SIXTHSENSE,TRAIT_GHOSTROLE)
		to_chat(M,span_notice("You're once again hearing deadchat."))


