/datum/quirk/sodium_sensetivity
	name = "Sodium Sensitivity"
	desc = "Your body is sensitive to sodium, and is burnt upon contact. Ingestion or contact with it is not advised."
	value = 0
	gain_text = "You remember that advice about reducing your sodium intake."
	lose_text = "You remember how good salt makes things taste!"
	medical_record_text = "Patient is highly allergic to to sodium, and should not come into contact with it under any circumstances."
	mob_trait = TRAIT_SALT_SENSITIVE
	hardcore_value = 1
	icon = FA_ICON_BIOHAZARD

/datum/reagent/consumable/salt/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_SALT_SENSITIVE)) // haha snails go brrr
		M.adjustFireLoss(2)
		M.emote("scream")

/datum/reagent/consumable/salt/on_mob_life(mob/living/M)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_SALT_SENSITIVE))
		M.adjustFireLoss(1) // equal to a standard toxin
