/datum/quirk/sodiumsensetivity
	name = "Sodium Sensitivity"
	desc = "Your body is sensitive to sodium, and is burnt upon contact. Ingestion or contact with it is not advised."
	icon = FA_ICON_BIOHAZARD
	value = 0
	mob_trait = TRAIT_SALT_SENSITIVE
	medical_record_text = "Patient should not come into contact with sodium."

/datum/reagent/consumable/salt/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_SALT_SENSITIVE)) // haha snails go brrr
		M.adjustFireLoss(2)
		M.emote("scream")

/datum/reagent/consumable/salt/on_mob_life(mob/living/M)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_SALT_SENSITIVE))
		M.adjustFireLoss(1) // equal to a standard toxin
