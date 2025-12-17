/datum/quirk/loose_limbs
	name = "Loose Limbs"
	desc = "Your limbs aren't as resilient as others! When you die, they are likely to fall off."
	icon = FA_ICON_USER_INJURED
	value = -2
	gain_text = span_danger("Your joints feel weak.")
	lose_text = span_notice("Your joints feel strengthened.")
	medical_record_text = "Patient's joints are quite weak and may fall off."
	hardcore_value = 2

/datum/quirk/loose_limbs/add(client/client_source)
	quirk_holder.AddComponent(/datum/component/omen/loose_limbs)
