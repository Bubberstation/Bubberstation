/mob/living/carbon/Drain()

	var/obj/item/bodypart/head = carbon_victim.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		src.cause_wound_of_type_and_severity(WOUND_PIERCE, head, WOUND_SEVERITY_SEVERE, wound_source = "inhuman puncture")

	src.adjustOrganLoss(ORGAN_SLOT_BRAIN, BRAIN_DAMAGE_DEATH, BRAIN_DAMAGE_DEATH)

	src.blood_volume = round(src.blood_volume*0.5,1) //Halves the CURRENT blood volume. Easier to suck more blood when there is more of it.

	ADD_TRAIT(affected_mob, TRAIT_DISFIGURED, TRAIT_GENERIC) //Fixed via cryoxadone!

	return TRUE
