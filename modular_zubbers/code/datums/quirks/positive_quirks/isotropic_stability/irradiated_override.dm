/datum/component/irradiated
	///Set to TRUE if the mob was recently exposed to irradiating levels of radiation
	///Handled in [/datum/quirk/isotropic_stability/proc/on_pre_potential_irradiation()]
	var/exposed_to_danger = TRUE

//Runs when mob is directly hit with irradiation, e.g. Nuka Cola
/datum/component/irradiated/InheritComponent(datum/component/C, i_am_original)
	exposed_to_danger = TRUE
