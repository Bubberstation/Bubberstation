/datum/quirk/sodium_sensetivity
	name = "Sodium Sensitivity"
	desc = "Your body is sensitive to sodium, and is burnt upon contact. Ingestion or contact with it is not advised."
	value = -2
	gain_text = span_danger("You remember that advice about reducing your sodium intake.")
	lose_text = span_notice("You remember how good salt makes things taste!")
	medical_record_text = "Patient is highly allergic to to sodium, and should not come into contact with it under any circumstances."
	mob_trait = TRAIT_SALT_SENSITIVE
	hardcore_value = 1
	icon = FA_ICON_BIOHAZARD
