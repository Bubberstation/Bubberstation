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
/obj/item/dollification_vile
	name = "mysterious shiny liquid"
	desc = "sleek liquid contained inside an hallariously fragile capsule of glass. A <span class ='danger'>CONTACT HAZARD</span> sticker is slapped on it haphazardly."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "vial_green"

/obj/item/dollification_vile/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_ATTACK, PROC_REF(attack_trigger))
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(process_step))

/obj/item/dollification_vile/Destroy()
	UnregisterSignal(src, COMSIG_ITEM_ATTACK)
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()

/obj/item/dollification_vile/proc/process_step(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
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

	if(doll.client?.prefs?.read_preference(/datum/preference/toggle/erp/transformation))
		return

	if(doll.stat >= HARD_CRIT)
		return

	if(prob(10)) // 1 in 10 chance.
		if(prob(25)) // 1/4 chance to actually drop it.
			to_chat(doll, span_purple("Whoops... I think I broke it..."))
			shatter(doll)
			return

		to_chat(doll, span_purple(pick(clumsy_text)))

/obj/item/dollification_vile/proc/attack_trigger()
	SIGNAL_HANDLER

	shatter(src.loc)

/obj/item/dollification_vile/proc/shatter(doll)
	var/mob/living/carbon/human/target = doll
	if(iscarbon(doll))
		return

	new /obj/item/shard(get_turf(src))
	target.AddComponent(/datum/component/dollification)
	playsound(src.loc, 'sound/effects/glassbr1.ogg', 50, TRUE)
	qdel(src)

