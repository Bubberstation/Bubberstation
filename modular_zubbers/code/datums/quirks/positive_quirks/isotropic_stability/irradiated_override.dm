/datum/component/irradiated
	///Set to TRUE if the mob was recently exposed to irradiating levels of radiation
	///Handled in [/datum/quirk/isotropic_stability/proc/on_pre_potential_irradiation()]
	var/exposed_to_danger = TRUE

//Runs when the mob is directly given irradiation more than once, e.g. Nuka Cola
/datum/component/irradiated/InheritComponent(datum/component/C, i_am_original)
	exposed_to_danger = TRUE

///Records if the mob was recently hit with a dangerous radiation pulse
/datum/component/irradiated/proc/on_pre_potential_irradiation(datum/source, datum/radiation_pulse_information/pulse_information, insulation_to_target)
	SIGNAL_HANDLER

	var/radiation_danger = get_perceived_radiation_danger(pulse_information, insulation_to_target)
	if (radiation_danger >= PERCEIVED_RADIATION_DANGER_HIGH)
		exposed_to_danger = TRUE
