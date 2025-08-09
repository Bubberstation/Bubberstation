/obj/item/reagent_containers/venom_milker
	name = "\improper venom siphon"
	desc = "A commercial grade venom siphon, made for use on larger - typically human sized - animals. \
	Has a built-in reagent neutralizer that inhibits the effects of most extracted toxins for safe handling, but it cannot be guaranteed to work."

	icon_state = "venom_milker"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'

	volume = 20

	reagent_flags = OPENCONTAINER
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/venom_milker/Initialize(mapload)
	. = ..()

	var/filter_immune_string = /datum/preference/choiced/aphrodisiacal_bite_venom::filter_immune_string
	if (length(filter_immune_string))
		desc += span_notice("\nThe following reagents cannot be filtered by the neutralizer: [filter_immune_string]")

/obj/item/reagent_containers/venom_milker/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()

	if (!can_milk(target_mob, user))
		return FALSE

	playsound(user, 'sound/effects/compressed_air/tank_insert_clunky.ogg', 50)
	user.balloon_alert_to_viewers("siphoning...")

	var/text = span_purple("[user] starts hooking up [src] to [target_mob]'s fangs...")
	var/self_text = span_purple("You start hooking up [src] to [target_mob]'s fangs...")
	var/victim_text = span_purple("[user] starts hooking up [src] to your fangs...")

	user.visible_message(text, self_text, ignored_mobs = target_mob)
	to_chat(target_mob, victim_text)

	if (!do_after(user, 3 SECONDS, target_mob, IGNORE_HELD_ITEM, extra_checks = CALLBACK(src, PROC_REF(can_milk), target_mob, user)))
		return FALSE
	playsound(user, 'sound/effects/compressed_air/tank_remove_thunk.ogg', 50)

	siphon(target_mob, user)

	return TRUE

/**
 *
 * Checks if we can milk the target. Returns TRUE/FALSE.
 *
 * Args:
 * * mob/living/target: The target. Non-nullable.
 * * mob/living/user: The user. Nullable.
 * * silent = FALSE: If TRUE, will not give user any feedback.
 */
/obj/item/reagent_containers/venom_milker/proc/can_milk(mob/living/target, mob/living/user, silent = FALSE)
	var/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/bite = locate() in target.actions
	if (isnull(bite))
		if (!silent)
			user?.balloon_alert(user, "no fangs!")
		return FALSE
	if (!bite.IsAvailable())
		if (!silent)
			user?.balloon_alert(user, "fangs empty!")
		return FALSE
	if (reagents.holder_full())
		if (!silent)
			user?.balloon_alert(user, "siphon full!")
		return FALSE

	if (iscarbon(user))
		var/mob/living/carbon/carbon_target = target
		if (carbon_target.is_mouth_covered())
			if (!silent)
				user.balloon_alert(user, "mouth covered!")
			return FALSE

	return TRUE

/**
 *
 * The actual siphon proc. Triggers the bite's effect, and puts its reagents in the milker.
 *
 * Args:
 * * mob/living/target: The target. Non-nullable.
 * * mob/living/user: The user. Nullable.
 *
 */
/obj/item/reagent_containers/venom_milker/proc/siphon(mob/living/target, mob/living/user)
	if (!can_milk(target, user))
		return FALSE
	var/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/bite = locate() in target.actions
	if (isnull(bite))
		return FALSE

	bite.StartCooldown()
	bite.add_reagents(reagents, TRUE)

	if (!isnull(user))
		user.balloon_alert_to_viewers("siphoned")
		var/text = span_purple("[user] siphons venom from [target]'s fangs with [src]!")
		var/self_text = span_purple("You siphon venom from [target]'s fangs with [src]!")
		var/victim_text = span_purple("[user] siphons venom from your fangs with [src]!")

		user.visible_message(text, self_text, ignored_mobs = target)
		to_chat(target, victim_text)

	return TRUE

/**
 * If a reagent milked from someone with the venom quirk is NOT in /datum/preference/choiced/aphrodisiacal_bite_venom::milkable_venoms, it will be transformed into this
 * generic chem that has no effects.
 */
/datum/reagent/generic_milked_venom
	name = "Neutralized Venom"
	description = "A venom siphon is capable of dampening most toxins extracted from a creature. \
	Those under that umbrella typically exhibit reduced effects, unless they undergo a long restoration process."
