/obj/item/clothing/neck/heretic_focus
	name = "amber focus"
	desc = "An amber focusing glass that provides a link to the world beyond. The necklace seems to twitch, but only when you look at it from the corner of your eye."
	icon_state = "eldritch_necklace"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/heretic_focus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/clothing/neck/heretic_focus/crimson_medallion
	name = "crimson medallion"
	desc = "A blood-red focusing glass that provides a link to the world beyond, and worse. Its eye is constantly twitching and gazing in all directions. It almost seems to be silently screaming..."
	icon_state = "crimson_medallion"
	/// The aura healing component. Used to delete it when taken off.
	var/datum/component/component
	/// If active or not, used to add and remove its cult and heretic buffs.
	var/active = FALSE

/obj/item/clothing/neck/heretic_focus/crimson_medallion/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_NECK))
		return

	var/team_color = COLOR_ADMIN_PINK
	if(IS_CULTIST(user))
		var/datum/action/innate/cult/blood_magic/magic_holder = locate() in user.actions
		team_color = COLOR_CULT_RED
		magic_holder.magic_enhanced = TRUE
	else if(IS_HERETIC_OR_MONSTER(user) && !active)
		for(var/datum/action/cooldown/spell/spell_action in user.actions)
			spell_action.cooldown_time *= 0.5
			active = TRUE
		team_color = COLOR_GREEN
	else
		team_color = pick(COLOR_CULT_RED, COLOR_GREEN)

	user.add_traits(list(TRAIT_MANSUS_TOUCHED, TRAIT_BLOODY_MESS), REF(src))
	to_chat(user, span_alert("Your heart takes on a strange yet soothing irregular rhythm, and your blood feels significantly less viscous than it used to be. You're not sure if that's a good thing."))
	component = user.AddComponent( \
		/datum/component/aura_healing, \
		range = 3, \
		brute_heal = 1, \
		burn_heal = 1, \
		blood_heal = 2, \
		suffocation_heal = 5, \
		simple_heal = 0.6, \
		requires_visibility = FALSE, \
		limit_to_trait = TRAIT_MANSUS_TOUCHED, \
		healing_color = team_color, \
	)

/obj/item/clothing/neck/heretic_focus/crimson_medallion/dropped(mob/living/user)
	. = ..()

	if(!istype(user))
		return

	if(HAS_TRAIT_FROM(user, TRAIT_MANSUS_TOUCHED, REF(src)))
		to_chat(user, span_notice("Your heart and blood return to their regular old rhythm and flow."))

	if(IS_HERETIC_OR_MONSTER(user) && active)
		for(var/datum/action/cooldown/spell/spell_action in user.actions)
			spell_action.cooldown_time *= 2
			active = FALSE
	QDEL_NULL(component)
	user.remove_traits(list(TRAIT_MANSUS_TOUCHED, TRAIT_BLOODY_MESS), REF(src))

	// If boosted enable is set, to prevent false dropped() calls from repeatedly nuking the max spells.
	var/datum/action/innate/cult/blood_magic/magic_holder = locate() in user.actions
	// Remove the last spell if over new limit, as we will reduce our max spell amount. Done beforehand as it causes a index out of bounds runtime otherwise.
	if(magic_holder?.magic_enhanced)
		QDEL_NULL(magic_holder.spells[ENHANCED_BLOODCHARGE])
	magic_holder?.magic_enhanced = FALSE


/obj/item/clothing/neck/heretic_focus/crimson_medallion/attack_self(mob/living/user, modifiers)
	. = ..()
	to_chat(user, span_danger("You start tightly squeezing [src]..."))
	if(!do_after(user, 1.25 SECONDS, src))
		return
	to_chat(user, span_danger("[src] explodes into a shower of gore and blood, drenching your arm. You can feel the blood seeping into your skin. You inmediately feel better, but soon, the feeling turns hollow as your veins itch."))
	new /obj/effect/gibspawner/generic(get_turf(src))
	var/heal_amt = user.adjustBruteLoss(-50)
	user.adjustFireLoss( -(50 - abs(heal_amt)) ) // no double dipping

	// I want it to poison the user but I also think it'd be neat if they got their juice as well. But that cancels most of the damage out. So I dunno.
	user.reagents?.add_reagent(/datum/reagent/fuel/unholywater, rand(6, 10))
	user.reagents?.add_reagent(/datum/reagent/eldritch, rand(6, 10))
	qdel(src)

/obj/item/clothing/neck/heretic_focus/crimson_medallion/examine(mob/user)
	. = ..()

	var/magic_dude
	if(IS_CULTIST(user))
		. += span_cult_bold("This focus will allow you to store one extra spell and halve the empowering time, alongside providing a small regenerative effect.")
		magic_dude = TRUE
	if(IS_HERETIC_OR_MONSTER(user))
		. += span_notice("This focus will halve your spell cooldowns, alongside granting a small regenerative effect to any nearby heretics or monsters, including you.")
		magic_dude = TRUE

	if(magic_dude)
		. += span_red("You can also squeeze it to recover a large amount of health quickly, at a cost...")

/obj/item/clothing/neck/eldritch_amulet
	name = "warm eldritch medallion"
	desc = "A strange medallion. Peering through the crystalline surface, the world around you melts away. You see your own beating heart, and the pulsing of a thousand others."
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "eye_medalion"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// A secondary clothing trait only applied to heretics.
	var/heretic_only_trait = TRAIT_THERMAL_VISION

/obj/item/clothing/neck/eldritch_amulet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/clothing/neck/eldritch_amulet/equipped(mob/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_NECK))
		return
	if(!ishuman(user) || !IS_HERETIC_OR_MONSTER(user))
		return

	ADD_TRAIT(user, heretic_only_trait, "[CLOTHING_TRAIT]_[REF(src)]")
	user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, heretic_only_trait, "[CLOTHING_TRAIT]_[REF(src)]")
	user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/piercing
	name = "piercing eldritch medallion"
	desc = "A strange medallion. Peering through the crystalline surface, the light refracts into new and terrifying spectrums of color. You see yourself, reflected off cascading mirrors, warped into impossible shapes."
	heretic_only_trait = TRAIT_XRAY_VISION

// Cosmetic-only version
/obj/item/clothing/neck/fake_heretic_amulet
	name = "religious icon"
	desc = "A strange medallion, which makes its wearer look like they're part of some cult."
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "eye_medalion"
	w_class = WEIGHT_CLASS_SMALL


// The amulet conversion tool used by moon heretics
/obj/item/clothing/neck/heretic_focus/moon_amulet
	name = "moonlight amulet"
	desc = "A piece of the mind, the soul and the moon. Gazing into it makes your head spin and hear whispers of laughter and joy."
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "moon_amulette"
	w_class = WEIGHT_CLASS_SMALL
	// How much damage does this item do to the targets sanity?
	var/sanity_damage = 20

/obj/item/clothing/neck/heretic_focus/moon_amulet/equipped(mob/living/user, slot)
	. = ..()
	if(!IS_HERETIC(user))
		channel_amulet(user) // Putting it on will give you the mood debuff
		return
	if(!(slot_flags & slot))
		// Make sure to restore the values of any blades we might be holding when our amulet is removed
		on_dropped_item(user, user.get_active_held_item())
		on_dropped_item(user, user.get_inactive_held_item())
		return
	RegisterSignal(user, COMSIG_HERETIC_BLADE_ATTACK, PROC_REF(channel_amulet))
	RegisterSignal(user, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_item))
	RegisterSignal(user, COMSIG_MOB_DROPPED_ITEM, PROC_REF(on_dropped_item))
	// Just make sure we pacify blades potentially in our hands when we put on the amulet
	on_equip_item(user, user.get_active_held_item(), ITEM_SLOT_HANDS)
	on_equip_item(user, user.get_inactive_held_item(), ITEM_SLOT_HANDS)

/obj/item/clothing/neck/heretic_focus/moon_amulet/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_HERETIC_BLADE_ATTACK, COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_DROPPED_ITEM))

/obj/item/clothing/neck/heretic_focus/moon_amulet/attack(mob/living/target, mob/living/user, params)
	if(channel_amulet(user, target))
		return
	return ..()

/// Makes whoever the target is a bit more insane. If they are insane enough, they will be zombified into a moon zombie
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/channel_amulet(mob/user, atom/target)
	SIGNAL_HANDLER
	if(!isliving(user) || !ishuman(target))
		return
	var/mob/living/living_user = user
	var/mob/living/carbon/human/human_target = target
	if(!IS_HERETIC_OR_MONSTER(living_user))
		living_user.balloon_alert(living_user, "you feel a presence watching you")
		living_user.add_mood_event("Moon Amulet Insanity", /datum/mood_event/amulet_insanity)
		living_user.mob_mood.set_sanity(living_user.mob_mood.sanity - 50)
		return FALSE
	if(human_target.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
		return FALSE
	if(!human_target.mob_mood)
		return FALSE
	if(human_target.mob_mood.sanity_level < SANITY_LEVEL_UNSTABLE)
		living_user.balloon_alert(living_user, "their mind is too strong!")
		human_target.add_mood_event("Moon Amulet Insanity", /datum/mood_event/amulet_insanity)
		human_target.mob_mood.set_sanity(human_target.mob_mood.sanity - sanity_damage)
	else
		living_user.balloon_alert(living_user, "their mind bends to see the truth!")
		human_target.apply_status_effect(/datum/status_effect/moon_converted)
		living_user.log_message("made [human_target] insane.", LOG_GAME)
		human_target.log_message("was driven insane by [living_user]")

/// Modifies any blades that we equip while wearing the amulet
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/on_equip_item(mob/user, obj/item/blade, slot)
	SIGNAL_HANDLER
	if(!istype(blade, /obj/item/melee/sickly_blade))
		return // We only care about modifying blades
	if(slot & ITEM_SLOT_HANDS)
		blade.force = 0
		blade.wound_bonus = 0
		blade.bare_wound_bonus = 0
		blade.armour_penetration = 200
		return
	blade.force = initial(blade.force)
	blade.wound_bonus = initial(blade.wound_bonus)
	blade.bare_wound_bonus = initial(blade.bare_wound_bonus)
	blade.armour_penetration = initial(blade.armour_penetration)

/// Modifies any blades that we drop while wearing the amulet
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/on_dropped_item(mob/user, obj/item/dropped_item)
	SIGNAL_HANDLER
	if(!istype(dropped_item, /obj/item/melee/sickly_blade))
		return // We only care about modifying blades
	dropped_item.force = initial(dropped_item.force)
	dropped_item.wound_bonus = initial(dropped_item.wound_bonus)
	dropped_item.bare_wound_bonus = initial(dropped_item.bare_wound_bonus)
	dropped_item.armour_penetration = initial(dropped_item.armour_penetration)
