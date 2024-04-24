/obj/item/ectoplasm/revenant/attack_self(mob/user)
	var/mob/living/carbon/carbon = user || usr
	if(carbon.can_block_magic(MAGIC_RESISTANCE_HOLY) || carbon.reagents.has_reagent(/datum/reagent/water/holywater, needs_metabolizing = FALSE))	 // Anyone with Holy Properties can kill the revenant for good.
		. = ..()
	else
		return

/obj/item/ectoplasm/revenant/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	return FALSE

/datum/action/cooldown/spell/aoe/revenant/narrate
	name = "Revenant Narrate"
	panel = "Revenant Abilities"
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	reveal_duration = 1 SECONDS
	stun_duration = 1 SECONDS

	antimagic_flags = MAGIC_RESISTANCE_HOLY|MAGIC_RESISTANCE_MIND
/datum/action/cooldown/spell/aoe/revenant/after_cast(mob/living/basic/revenant/cast_on)
	cast_on.narrate_to_as_revenant()

/mob/living/basic/revenant/proc/narrate_to_as_revenant(range = 7)

	var/msg = input("Message:", "Enter the text you wish to appear to everyone within view:") as text|null
	if (!msg)
		return
	for(var/mob/M in view(range, src))
		to_chat(M, msg, confidential = TRUE)
