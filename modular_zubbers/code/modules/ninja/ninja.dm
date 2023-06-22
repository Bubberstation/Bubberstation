/datum/outfit/ninja
	belt = /obj/item/melee/baton/telescopic/pocket_energy_tonfa
	implants = list(/obj/item/implant/krav_maga, /obj/item/implant/freedom)

/obj/item/mod/module/dna_lock/reinforced
	removable = FALSE

/obj/item/mod/module/weapon_recall
	accepted_type = /obj/item/melee/baton/telescopic/pocket_energy_tonfa

/obj/item/melee/baton/telescopic/pocket_energy_tonfa
	name = "pocket energy tonfa"
	desc = "A baton infused with strong energy. Retractable, portable, and least of all, deadly. "
	desc_controls = "Right-click to dash. Use to retract. Throw to boomerang. "
	icon = 'modular_zubbers/icons/obj/baton.dmi'
	force = 0
	throwforce = 5
	block_chance = 50
	armour_penetration = 50
	w_class = WEIGHT_CLASS_SMALL
	block_sound = 'sound/weapons/block_blade.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	max_integrity = 200
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/datum/effect_system/spark_spread/spark_system
	var/datum/action/innate/dash/ninja/jaunt


/obj/item/melee/baton/telescopic/pocket_energy_tonfa/Initialize(mapload)
	. = ..()
	jaunt = new(src)
	spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	AddComponent(/datum/component/boomerang, throw_range+2, TRUE)


/obj/item/melee/baton/telescopic/pocket_energy_tonfa/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!active)
		return ..()
	var/caught = hit_atom.hitby(src, skipcatch = FALSE, hitpush = FALSE, throwingdatum = throwingdatum)
	var/mob/thrown_by = thrownby?.resolve()
	if(isliving(hit_atom) && !iscyborg(hit_atom) && !caught && prob(99))//if they are a living creature and they didn't catch it
		finalize_baton_attack(hit_atom, thrown_by, in_attack_chain = FALSE)

/obj/item/melee/baton/telescopic/pocket_energy_tonfa/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!active && !target.density)
		jaunt?.teleport(user, target)
	var/mob/living/carbon/victim
	if(iscarbon(target))
		victim = target
	var/obj/item/bodypart/affecting = victim.get_bodypart(deprecise_zone(user.zone_selected))
	if(prob(50))
		affecting.force_wound_upwards(/datum/wound/blunt/severe)

/obj/item/melee/baton/telescopic/pocket_energy_tonfa/equipped(mob/user, slot, initial)
	. = ..()
	if(!QDELETED(jaunt))
		jaunt.Grant(user, src)

/obj/item/melee/baton/telescopic/pocket_energy_tonfa/dropped(mob/user)
	. = ..()
	if(!QDELETED(jaunt))
		jaunt.Remove(user)

/obj/item/melee/baton/telescopic/pocket_energy_tonfa/Destroy()
	QDEL_NULL(spark_system)
	QDEL_NULL(jaunt)
	return ..()

/datum/round_event/ghost_role/space_ninja/proc/apply_ninja_prefs(mob/living/carbon/human/ninja)
	ASYNC
		var/loadme = tgui_input_list(ninja, "Do you wish to load your character slot?", "Load Character?", list("Yes!", "No, I want to be random!"), default = "No, I want to be random!", timeout = 60 SECONDS)
		var/codename
		if(loadme == "Yes!")
			ninja.client?.prefs?.safe_transfer_prefs_to(ninja)
			codename = tgui_input_text(ninja.client, "What should your codename be?", "Agent Name", "[pick("Master", "Legendary", "Agent", "Shinobi", "Ninja")] [ninja.dna.species.name]", 42, FALSE, TRUE, 300 SECONDS)
			codename ? codename : (codename = "[pick("Master", "Legendary", "Agent", "Shinobi", "Ninja")] [ninja.dna.species.name]")
			ninja.name = codename
			ninja.real_name = codename
			ninja.dna.update_dna_identity()
		else
			ninja.randomize_human_appearance(~(RANDOMIZE_NAME|RANDOMIZE_SPECIES))
			ninja.dna.update_dna_identity()

