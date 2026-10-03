/obj/item/organ/heart/lycan
	name = "lupine heart"
	desc = "A large heart that beats powerfully. The veins on it are far larger than normal."

/obj/item/organ/heart/lycan/on_mob_insert(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(islycan(organ_owner))
		MODIFY_PHYSIOLOGY(human_owner, BRUTE, 0.5)
		MODIFY_PHYSIOLOGY(human_owner, BURN, 0.8)

/obj/item/organ/heart/lycan/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(human_owner.physiology)
		MODIFY_PHYSIOLOGY(human_owner, BRUTE, 1/0.5)
		MODIFY_PHYSIOLOGY(human_owner, BURN, 1/0.8)
