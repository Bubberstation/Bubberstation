/datum/chemical_reaction/mkultra
	results = list(/datum/reagent/mkultra = 5)
	required_reagents = list(/datum/reagent/consumable/coco = 1, /datum/reagent/bluespace = 1, /datum/reagent/toxin/mindbreaker = 1, /datum/reagent/medicine/psicodine = 1, /datum/reagent/drug/happiness = 1)
	required_temp = 720
	optimal_temp = 810
	overheat_temp = 840
	optimal_ph_min = 12
	optimal_ph_max = 13
	determin_ph_range = 2
	temp_exponent_factor = 0.5
	ph_exponent_factor = 4
	thermic_constant = 15
	H_ion_release = 0.05
	rate_up_lim = 1
	purity_min = 0.2
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_EXPLOSIVE | REACTION_TAG_OTHER | REACTION_TAG_DANGEROUS

/datum/chemical_reaction/mkultra/reaction_finish(datum/reagents/holder, datum/equilibrium/reaction, react_vol)
	. = ..()
	var/datum/reagent/mkultra/chemical = locate() in holder.reagent_list
	var/mob/living/user = chemical?.data["enchanter"]
	if(!user)
		holder.my_atom.visible_message(span_warning("The reaction sputters and fails to react properly!"))
		chemical.purity = 0
		return

/datum/chemical_reaction/mkultra/overheated(datum/reagents/holder, datum/equilibrium/equilibrium, step_volume_added)
	. = ..()
	enthrall_explosion(holder, equilibrium.reacted_vol)

/datum/chemical_reaction/mkultra/overly_impure(datum/reagents/holder, datum/equilibrium/equilibrium, step_volume_added)
	. = ..()
	enthrall_explosion(holder, equilibrium.reacted_vol)

/datum/chemical_reaction/mkultra/proc/enthrall_explosion(datum/reagents/holder, volume) // Copy pasted meth code
	var/power = 5 + round(volume/12, 1)
	if(power <= 0)
		return
	var/turf/explosion_turf = get_turf(holder.my_atom)
	var/inside_msg
	if(ismob(holder.my_atom))
		var/mob/failed_chemist = holder.my_atom
		inside_msg = " inside [ADMIN_LOOKUPFLW(failed_chemist)]"
		return
	var/lastkey = holder.my_atom.fingerprintslast
	var/touch_msg = "N/A"
	if(!istype(holder.my_atom, /obj/machinery/plumbing))
		message_admins("Reagent explosion reaction occurred at [ADMIN_VERBOSEJMP(explosion_turf)][inside_msg]. Last fingerprint: [touch_msg].")
	log_game("Reagent explosion reaction occured at [AREACOORD(explosion_turf)]. Last Fingerprint: [lastkey ? lastkey : "N/A"]")
	var/datum/effect_system/reagents_explosion/expl = new(explosion_turf, power, FALSE, FALSE)
	expl.start(holder.my_atom)
	holder.clear_reagents()
