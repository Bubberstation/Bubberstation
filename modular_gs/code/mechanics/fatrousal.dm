/datum/quirk/fatrousal
	name = "Adiposexual Response"
	desc = "Your adipose tissue develops and shrinks depending on your arousal."
	value = 0 //ERP quirk
	gain_text = "<span class='notice'>Your body feels like it could grow at any moment.</span>"
	lose_text = "<span class='notice'>The feeling of impending growth is gone...</span>"
	mob_trait = TRAIT_FATROUSAL

/datum/quirk/fatrousal/add()
	if(iscarbon(quirk_holder))
		var/mob/living/carbon/C = quirk_holder
		C.hider_add(src)

/datum/quirk/fatrousal/remove()
	if(iscarbon(quirk_holder))
		var/mob/living/carbon/C = quirk_holder
		C.hider_remove(src)


/datum/quirk/fatrousal/proc/fat_hide(var/mob/living/carbon/human/user)
	var/mob/living/carbon/human/aroused_human = quirk_holder
	if(!istype(aroused_human))
		return FALSE


	return aroused_human.get_arousal()*35


/mob/living/carbon/human/proc/get_arousal()
	//Put code here :)

///mob/living/adjust_arousal(amount, updating_arousal=1)
//	if(HAS_TRAIT(src, TRAIT_FATROUSAL))
//		amount = amount * 0.2
//	..()
//
