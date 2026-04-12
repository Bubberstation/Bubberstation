/datum/chemical_reaction/mkultra //check this
	results = list(/datum/reagent/mkultra = 5)
	required_reagents = list(/datum/reagent/consumable/coco = 1, /datum/reagent/bluespace = 1, /datum/reagent/toxin/mindbreaker = 1, /datum/reagent/medicine/psicodine = 1, /datum/reagent/drug/happiness = 1)
	required_catalysts = list(/datum/reagent/blood = 1)
	mix_message = "the reaction gives off a burgundy plume of smoke!"
	//FermiChem vars:
	required_temp 			= 780
	optimal_temp			= 820
	overheat_temp 			= 840
	optimal_ph_min 			= 12
	optimal_ph_max			= 13
	determin_ph_range 		= 2
	//CatalystFact 			= 0
	temp_exponent_factor 	= 0.5
	ph_exponent_factor 		= 4
	thermic_constant 		= 15
	H_ion_release 			= 0.1
	rate_up_lim 			= 1
	purity_min 				= 0.2
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_EXPLOSIVE | REACTION_TAG_OTHER | REACTION_TAG_DANGEROUS

/datum/chemical_reaction/mkultra/reaction_finish(datum/reagents/holder, atom/my_atom)
	var/datum/reagent/blood/mob_blood = locate(/datum/reagent/blood) in holder.reagent_list
	var/datum/reagent/mkultra/enthrall_chem = locate(/datum/reagent/mkultra) in holder.reagent_list
	if(!mob_blood || !enthrall_chem)
		return
	if(!mob_blood.data)
		my_atom.visible_message("<span class='warning'>The reaction splutters and fails to react properly.</span>") //Just in case
		enthrall_chem.purity = 0
		return
	if (mob_blood.data["gender"] == "female")
		enthrall_chem.data["enthrall_gender"] = "Mistress"
		enthrall_chem.enthrall_gender = "Mistress"
	else
		enthrall_chem.data["enthrall_gender"] = "Master"
		enthrall_chem.enthrall_gender = "Master"
	enthrall_chem.data["enthrall_name"] = mob_blood.data["real_name"]
	enthrall_chem.enthrall_name = mob_blood.data["real_name"]
	enthrall_chem.data["enthrall_ckey"] = mob_blood.data["ckey"]
	enthrall_chem.enthrall_ckey = mob_blood.data["ckey"]

//Kaboom
/datum/chemical_reaction/mkultra/overheated(datum/reagents/holder, datum/equilibrium/equilibrium, step_volume_added)
	. = ..()
	enthrall_explosion(holder, equilibrium.reacted_vol)

/datum/chemical_reaction/mkultra/overly_impure(datum/reagents/holder, datum/equilibrium/equilibrium, step_volume_added)
	. = ..()
	enthrall_explosion(holder, equilibrium.reacted_vol)

//My le bomb... It le killed people?? || Stolen meth code :)
/datum/chemical_reaction/mkultra/proc/enthrall_explosion(datum/reagents/holder, explode_vol)
	var/power = 5 + round(explode_vol/12, 1) //MKU strengthdiv is 12, same as meth.
	if(power <= 0)
		return
	var/turf/T = get_turf(holder.my_atom)
	var/inside_msg
	if(ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		inside_msg = " inside [ADMIN_LOOKUPFLW(M)]"
		return
	var/lastkey = holder.my_atom.fingerprintslast
	var/touch_msg = "N/A"
	if(lastkey)
		var/mob/toucher = get_mob_by_key(lastkey)
		touch_msg = "[ADMIN_LOOKUPFLW(toucher)]"
	if(!istype(holder.my_atom, /obj/machinery/plumbing)) //excludes standard plumbing equipment from spamming admins with this shit
		message_admins("Reagent explosion reaction occurred at [ADMIN_VERBOSEJMP(T)][inside_msg]. Last Fingerprint: [touch_msg].")
	log_game("Reagent explosion reaction occurred at [AREACOORD(T)]. Last Fingerprint: [lastkey ? lastkey : "N/A"]." )
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(power, T, 0, 0)
	e.start(holder.my_atom)
	holder.clear_reagents()
