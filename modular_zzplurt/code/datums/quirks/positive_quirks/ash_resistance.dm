/datum/quirk/ash_resistance
	name = "Ashen Resistance"
	desc = "Your body is adapted to the burning sheets of ash that coat volcanic worlds. The heavy downpours of silt will still tire you."
	value = 2
	gain_text = span_notice("Your body has adapted to the harsh climates of volcanic worlds.")
	lose_text = span_notice("Your body has lost its ashen adaptations.")
	medical_record_text = "Patient has an abnormally thick epidermis."
	mob_trait = TRAIT_ASHRESISTANCE
	hardcore_value = -1
	icon = FA_ICON_FIRE_FLAME_SIMPLE

// Without the stamina penalty, this quirk can replace SEVA suits
// Please increase the cost if you use the code below

/*
/datum/quirk/ashresistance/add()
	// Add ash storm immunity
	ADD_TRAIT(quirk_holder, TRAIT_ASHSTORM_IMMUNE, TRAIT_ASHRESISTANCE)

/datum/quirk/ashresistance/remove()
	// Remove ash storm immunity
	REMOVE_TRAIT(quirk_holder, TRAIT_ASHSTORM_IMMUNE, TRAIT_ASHRESISTANCE)
*/
