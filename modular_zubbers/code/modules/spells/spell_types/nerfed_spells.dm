
//Barnyard Curse. Clears the curse after 3 minutes.
/datum/spellbook_entry/barnyard
	name = "Lesser Barnyard Curse"
	desc = "This spell dooms an unlucky soul to possess the speech and facial attributes of a barnyard animal. Lasts 3 minutes."

/datum/action/cooldown/spell/pointed/barnyardcurse
	name = "Lesser Barnyard Curse"
	desc = "This spell dooms an unlucky soul to possess the speech and facial attributes of a barnyard animal. Lasts 3 minutes."

/obj/item/clothing/mask/animal/make_cursed()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(clear_curse)), 3 MINUTES, TIMER_UNIQUE | TIMER_DELETE_ME)



//Mind Transfer. Can no longer be used on targets with minds.
/datum/spellbook_entry/mindswap
	name = "Lesser Mind Swap"
	desc = "Allows you to switch bodies with a <b>soulless</b> target next to you. You will both fall asleep when this happens, and it will be quite obvious that you are the target's body if someone watches you do it."

/datum/action/cooldown/spell/pointed/mind_transfer
	name = "Lesser Mind Swap"
	desc = "This spell allows the user to switch bodies with a target next to them. Only works on \"soulless\" targets."
	target_requires_key = FALSE
	target_requires_mind = FALSE

/datum/action/cooldown/spell/pointed/mind_transfer/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return .
	var/mob/living/living_target = cast_on //We check if the target is living above.
	if(living_target.key)
		to_chat(owner, span_warning("[living_target.p_They()] [living_target.p_do()]n't appear to have a vacant mind to swap into!"))
		return FALSE

	return TRUE


//Smite. Can longer gib and just kills you and yeets you an insane distance.

/datum/spellbook_entry/disintegrate
	name = "Lesser Smite"
	desc = "Charges your hand with an unholy energy, causing a touched victim to instantly die and their corpse flung a great distance."

/datum/action/cooldown/spell/touch/smite
	name = "Lesser Smite"
	desc = "This spell charges your hand with an unholy energy, causing a touched victim to instantly die and their corpse flung a great distance."
	invocation = "YA'YEET!!"
	button_icon = 'icons/mob/nonhuman-player/cult.dmi'
	button_icon_state = "shade_wizard"
	sound = 'sound/effects/assslap.ogg'

/datum/action/cooldown/spell/touch/smite/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)

	blind_everyone_nearby(victim, caster)

	victim.investigate_log("has been yeeted by the smite spell", INVESTIGATE_DEATHS)

	var/turf/target_turf = get_edge_target_turf(victim, get_dir(caster,victim))
	victim.throw_at(target_turf, 255, 4, caster, force = MOVE_FORCE_OVERPOWERING, callback = TYPE_PROC_REF(/mob/living/, tram_slam_land)) //Shamelessly copied from tram throw code.

	victim.death(FALSE)

	return TRUE
