/**
 * Yes, this is some incredibly cursed meme code but I figured it would be funny. This handles all the items related to dollification.
 * See [modular_zubbers/code/datums/components/dollification.dm] for component handling
*/

/// CLOTHING

/obj/item/clothing/mask/muzzle/ring/doll
	name = "fused opened lips"
	desc = "Your lips are stuck open like this. No matter how much you prod at them, you can't close them!"

/obj/item/clothing/shoes/fancy_heels/black/doll
	name = "attached high heels"
	desc = "These obsidian heels refuse to detatch from your feet. They feel like a part of you now."

/// DOLLIFICATION VILE
/obj/item/dollification_vial
	name = "mysterious shiny liquid"
	desc = "sleek liquid contained inside an hallariously fragile capsule of glass. A <span class ='danger'>CONTACT HAZARD</span> sticker is slapped on it haphazardly."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "vial-green"

/obj/item/dollification_vial/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(process_step))

/obj/item/dollification_vile/Destroy()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()

/obj/item/dollification_vial/proc/process_step(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	SIGNAL_HANDLER

	var/list/clumsy_text = list(
		"<b><i>Fuck- fuck FUCK!</i> I almost dropped it!</b>",
		"<b>The vile slips out of your clumsy hands and you manage to catch it before it hits the floor!</b>",
		"<b>You stumble over your own feet like a clutz!</b>",
		"<b>You fumble with the vile and bounce it between both hands before managing to luckily catch it.</b>",
	)

	var/mob/living/carbon/human/doll = src.loc
	if(!iscarbon(doll))
		return

	if(doll.stat >= HARD_CRIT)
		return

	var/probability = rand(1,100)
	if(probability <= 30) // 1 in 10 chance. // Temp until I fix this
		if(probability <= 50 && pref_check(doll)) // 1/4 chance to actually drop it. // Temp until I fix this
			to_chat(doll, span_purple("Whoops... I think I broke it..."))
			shatter(doll)
			return

		to_chat(doll, span_purple(pick(clumsy_text)))

/obj/item/dollification_vial/proc/pref_check(mob/living/user)
	if(user.client?.prefs?.read_preference(/datum/preference/toggle/erp/transformation))
		return TRUE
	else
		return FALSE

/obj/item/dollification_vial/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	if(pref_check(target_mob))
		shatter(target_mob)

/obj/item/dollification_vial/proc/shatter(doll)
	var/mob/living/carbon/human/target = doll
	new /obj/item/shard(get_turf(src))
	playsound(src.loc, 'sound/effects/glassbr1.ogg', 50, TRUE)
	qdel(src)
	target.AddComponent(/datum/component/dollification)

