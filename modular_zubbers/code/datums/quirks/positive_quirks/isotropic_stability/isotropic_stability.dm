/datum/quirk/isotropic_stability
	name = "Isotropic Stability"
	desc = "Nuka Cola lovers rejoice! Your body is highly resistant to the effects of radiation poisoning, and radiation will never cause burns, vomiting, mutations, or hairloss. Active sources of radiation still metabolize into harmful toxins."
	value = 4
	medical_record_text = "Patient's body is highly resistant to radiation poisoning."
	icon = FA_ICON_ATOM
	// Blacklisted for species which are already immune to radiation
	species_blacklist = list(
		SPECIES_ANDROID,
		SPECIES_SYNTH,
		SPECIES_PLASMAMAN,
		SPECIES_ZOMBIE,
		SPECIES_GHOUL,
		SPECIES_PROTEAN,
		SPECIES_SKELETON,
		SPECIES_SHADOW,
		SPECIES_GOLEM,
		SPECIES_NIGHTMARE,
		SPECIES_MUTANT,
	)

/datum/quirk/isotropic_stability/add(client/client_source)
	quirk_holder.add_traits(list(
		TRAIT_RAD_RESISTANCE,
		TRAIT_BYPASS_EARLY_IRRADIATED_CHECK,
	), QUIRK_TRAIT)
	RegisterSignal(quirk_holder, COMSIG_IN_RANGE_OF_IRRADIATION, PROC_REF(on_pre_potential_irradiation))

/datum/quirk/isotropic_stability/remove(client/client_source)
	quirk_holder.remove_traits(list(
		TRAIT_RAD_RESISTANCE,
		TRAIT_BYPASS_EARLY_IRRADIATED_CHECK,
	), QUIRK_TRAIT)
	UnregisterSignal(quirk_holder, COMSIG_IN_RANGE_OF_IRRADIATION)

///Records if the mob was recently hit with a dangerous radiation pulse
/datum/quirk/isotropic_stability/proc/on_pre_potential_irradiation(datum/source, datum/radiation_pulse_information/pulse_information, insulation_to_target)
	SIGNAL_HANDLER

	var/datum/component/irradiated/irradiated_component = quirk_holder.GetComponent(/datum/component/irradiated)
	if(isnull(irradiated_component))
		return
	var/radiation_danger = get_perceived_radiation_danger(pulse_information, insulation_to_target)
	if (radiation_danger >= PERCEIVED_RADIATION_DANGER_HIGH)
		irradiated_component.exposed_to_danger = TRUE
