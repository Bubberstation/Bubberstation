#define CUMPLUS_MULT_GLOBAL 1.75
#define CUMPLUS_MULT_TESTI 2
#define CUMPLUS_MULT_VAGI 2
#define CUMPLUS_MULT_BOOBI 2

/datum/quirk/cum_plus
	name = "Extra-Productive Genitals"
	desc = "Your genitals can hold twice the amount of fluid expected for their size, and produce slightly faster."
	value = 0
	gain_text = span_purple("You feel pressure in your groin.")
	lose_text = span_purple("You feel a weight lifted from your groin.")
	medical_record_text = "Patient exhibits increased production of sexual fluids."
	icon = FA_ICON_HEART_CIRCLE_PLUS
	erp_quirk = TRUE

// Note: Increasing size increases production rate
// Production scales based on size and mob arousal

// Increase fluids
/datum/quirk/cum_plus/add(client/client_source)
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Define potential fluid producing organ
	// Check if it exists
	// Multiply maximum fluid

	// Testicles
	var/obj/item/organ/external/genital/testicles/mob_testi = quirk_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)
	if(mob_testi)
		mob_testi.internal_fluid_maximum *= CUMPLUS_MULT_TESTI

	// Vagina
	var/obj/item/organ/external/genital/vagina/mob_vagi = quirk_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	if(mob_vagi)
		mob_vagi.internal_fluid_maximum *= CUMPLUS_MULT_VAGI

	// Breasts
	var/obj/item/organ/external/genital/testicles/mob_boobi = quirk_mob.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(mob_boobi)
		mob_boobi.internal_fluid_maximum *= CUMPLUS_MULT_BOOBI

// Reduce fluids
/datum/quirk/cum_plus/remove()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Identical to above but divides

	// Testicles
	var/obj/item/organ/external/genital/testicles/mob_testi = quirk_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)
	if(mob_testi)
		mob_testi.internal_fluid_maximum /= CUMPLUS_MULT_TESTI

	// Vagina
	var/obj/item/organ/external/genital/vagina/mob_vagi = quirk_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	if(mob_vagi)
		mob_vagi.internal_fluid_maximum /= CUMPLUS_MULT_VAGI

	// Breasts
	var/obj/item/organ/external/genital/testicles/mob_boobi = quirk_mob.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(mob_boobi)
		mob_boobi.internal_fluid_maximum /= CUMPLUS_MULT_BOOBI

#undef CUMPLUS_MULT_GLOBAL
#undef CUMPLUS_MULT_TESTI
#undef CUMPLUS_MULT_VAGI
#undef CUMPLUS_MULT_BOOBI
