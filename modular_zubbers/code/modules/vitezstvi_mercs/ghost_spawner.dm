/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc
	name = "Vítězství Arms contractor bunk"
	desc = "A stasis pod with a Vítězství Arms label. It's hard at work containing the smells of cheap tobacco and vodka; you can see what appears to be a PSC soldier sleeping almost comically peacefully inside, clad in full combat gear."
	prompt_name = "Vítězství Arms contractor"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	faction = list(FACTION_NEUTRAL, FACTION_VITEZSTVI)
	you_are_text = "You are a Vítězství Arms contractor."
	flavour_text = "You and your comrades have been running guns in this sector for years right under GalFed's nose. A friend of yours in the station's Cargo Department called in a favor, said favor was simple; \"GET US THE FUCK OUT OF HERE.\" The VARS-7 'Provodnik' has answered. You and the rest of its contractors are here to secure the vessel, collect every surviving crew member you can reach, and leave before whatever is happening to the station gets you too. The landing will be rough on account of the fact that your blood contains enough vodka to kill a Terran."
	important_text = "You are friendly to the station crew and are NOT an antagonist. You are also extremely drunk."
	outfit = /datum/outfit/vitezstvi_merc
	allow_custom_character = GHOSTROLE_TAKE_PREFS_SPECIES | GHOSTROLE_TAKE_PREFS_APPEARANCE
	random_appearance = FALSE
	show_flavor = TRUE

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/allow_spawn(mob/user, silent = FALSE)
	// inert until the shuttle commits; the deploy poll offers the role at that same moment
	if(!EMERGENCY_PAST_POINT_OF_NO_RETURN)
		if(!silent)
			to_chat(user, span_warning("The contractor inside is still sleeping off a professional quantity of vodka! They will awaken on approach..."))
		return FALSE
	return ..()

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[callsign] [number]")
	stamp_contractor_id(spawned_human)
	// prefs can hand the mob a fresh card after this, so stamp again once settled
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(stamp_contractor_id), spawned_human), 1 SECONDS)

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_human.grant_language(/datum/language/spinwarder, source = LANGUAGE_SPAWNER)
	apply_codename(spawned_human)
	spawned_human.mind?.add_antag_datum(/datum/antagonist/ert/vitezstvi)

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)
