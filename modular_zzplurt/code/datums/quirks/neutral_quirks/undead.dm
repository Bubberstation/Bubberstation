/datum/quirk/undead
    name = "Undeath"
    desc = "Your body, be it anomalous, or just outright refusing to die - has indeed become undead. Due to this you may be hungrier."
    value = 0
    mob_trait = TRAIT_UNDEAD
    quirk_flags = /datum/quirk::quirk_flags | QUIRK_PROCESSES
	// Note: The Undead cannot take advantage of healing viruses and genetic mutations, since they have no DNA.
    var/list/zperks = list(TRAIT_STABLEHEART,TRAIT_EASYDISMEMBER,TRAIT_VIRUSIMMUNE,TRAIT_RADIMMUNE,TRAIT_FAKEDEATH,TRAIT_NOSOFTCRIT)

/datum/quirk/undead/add()
    . = ..()
    var/mob/living/carbon/human/H = quirk_holder
    if(H.mob_biotypes == MOB_ROBOTIC)
        return FALSE //Lol, lmao, even
    H.mob_biotypes += MOB_UNDEAD
    for(var/perk in zperks)
        ADD_TRAIT(H, perk, QUIRK_TRAIT)

/datum/quirk/undead/remove()
    . = ..()
    var/mob/living/carbon/human/H = quirk_holder
    H.mob_biotypes -= MOB_UNDEAD
    for(var/perk in zperks)
        REMOVE_TRAIT(H, perk, QUIRK_TRAIT)

/datum/quirk/undead/process(seconds_per_tick)
    . = ..()
    var/mob/living/carbon/human/H = quirk_holder
    H.adjust_nutrition(-0.025)//The Undead are Hungry.
    H.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy)
    H.adjustOxyLoss(-3) //Stops a defibrilator bug. Note to future self: Fix defib bug.
