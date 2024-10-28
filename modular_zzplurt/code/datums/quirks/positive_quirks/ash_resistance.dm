// UNIMPLEMENTED QUIRK!
/datum/quirk/ash_resistance
	name = "Ashen Resistance"
	desc = "Your body is adapted to the burning sheets of ash that coat volcanic worlds. The heavy downpours of silt will still tire you."
	value = 2 //Is not actually THAT good. Does not grant breathing and does stamina damage to the point you are unable to attack. Crippling on lavaland, but you'll survive. Is not a replacement for SEVA suits for this reason. Can be adjusted.
	gain_text = span_notice("Your body has adapted to the harsh climates of volcanic worlds.")
	lose_text = span_notice("Your body has lost its ashen adaptations.")
	medical_record_text = "Patient has an abnormally thick epidermis."
	mob_trait = TRAIT_ASHRESISTANCE
	hardcore_value = -1
	icon = FA_ICON_FIRE

/* Uses stamina, so we'll have to find a better way to apply it
/* --FALLBACK SYSTEM INCASE THE TRAIT FAILS TO WORK. Do NOT enable this without editing ash_storm.dm to deal stamina damage with ash immunity.
/datum/quirk/ashresistance/add()
	quirk_holder.weather_immunities |= "ash"

/datum/quirk/ashresistance/remove()
	if(!quirk_holder)
		return
	quirk_holder.weather_immunities -= "ash"
*/
*/
