
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
	sound = 'sound/effects/emotes/assslap.ogg'

/datum/action/cooldown/spell/touch/smite/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)

	blind_everyone_nearby(victim, caster)

	victim.investigate_log("has been yeeted by the smite spell", INVESTIGATE_DEATHS)

	var/turf/target_turf = get_edge_target_turf(victim, get_dir(caster,victim))
	victim.throw_at(target_turf, 255, 4, caster, force = MOVE_FORCE_OVERPOWERING, callback = TYPE_PROC_REF(/mob/living/, tram_slam_land)) //Shamelessly copied from tram throw code.

	victim.death(FALSE)

	return TRUE

// Laughter Demon. They're basically hugboxed slaughter demons (hence the name), but are still really powerful.
// While you're basically put in gay baby jail until it's killed, it's not TOO bad, but it should still be limited to 1.
/datum/spellbook_entry/item/hugbottle
	cost = 2
	limit = 1

// Lichdom. Imbue an object and that object is basically your mobile respawn point.
// Funny mechanic, but it was INSANELY generous on what you could imbue, causing near immortality. Mechanical changes are in the non-modular file of lichdom.dm
/datum/spellbook_entry/lichdom
	name = "Bind Fiery Soul"
	desc = "An infernal necromantic pact that can forever bind your soul to a bulky item of your choosing, \
		turning you into an immortal Lich. So long as the item remains intact, you will revive from death, \
		no matter the circumstances. Be wary - with each revival, your body will become weaker, and \
		it will become easier for others to find your item of power. \
		Note that the fiery nature of the spell also requires it to be cast on a non-fireproof item, as the magic can't penetrate that way."

/datum/action/cooldown/spell/lichdom
	desc = "A fiery spell from the depths of hell that binds your soul to an item in your hands. \
		Binding your soul to an item will turn you into an immortal Lich. \
		So long as the item remains intact, you will revive from death, \
		no matter the circumstances. \
		Cannot be used on objects smaller than bulky or fireproof objects."


// High Frequency Spellblade. Holy fuck just looking at the code is nonsense holy fuck. Can slash through walls, and also gib people who are dead. Absolutely silly.
// Replaces it with a banhammer that can send you to the perma brig because that's funnier.
/datum/spellbook_entry/item/highfrequencyblade
	name = "REAL Banhammer"
	desc = "A completely REAL Banhammer that sends anyone it hits to the void for a short period of time. Stonger hits send people to the station's permabrig, if one exists."
	item_path = /obj/item/banhammer/real
	category = "Offensive"
	cost = 2
