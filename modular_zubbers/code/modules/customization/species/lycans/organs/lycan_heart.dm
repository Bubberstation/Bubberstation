/obj/item/organ/heart/lycan
	name = "lupine heart"
	desc = "A large heart that beats powerfully. The veins on it are far larger than normal."

/obj/item/organ/heart/lycan/on_mob_insert(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(islycan(organ_owner))
		human_owner.physiology.brute_mod *= 0.5
		human_owner.physiology.burn_mod *= 0.8

/obj/item/organ/heart/lycan/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	var/mob/living/carbon/human/human_owner = organ_owner

	if(human_owner.physiology)
		human_owner.physiology.brute_mod /= 0.5
		human_owner.physiology.burn_mod /= 0.8
