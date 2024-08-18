/* needs genital fluids and also to affect more than just your balls
/datum/quirk/cum_plus
	name = "Extra-Productive Genitals"
	desc = "Your genitals produce and hold more than normal."
	value = 0
	gain_text = span_notice("You feel pressure in your groin.")
	lose_text = span_notice("You feel a weight lifted from your groin.")
	medical_record_text = "Patient exhibits increased production of sexual fluids."
	var/increasedcum

/datum/quirk/cum_plus/add()
	var/mob/living/carbon/M = quirk_holder
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult += 0.5 //Base is 1
		T.fluid_max_volume *= 1.75 //Fixes this.

/datum/quirk/cum_plus/remove()
	var/mob/living/carbon/M = quirk_holder
	if(!M)
		return
	if(quirk_holder.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult -= 0.5 //Base is 1
		T.fluid_max_volume *= 0.25 //Base is 50

/datum/quirk/cum_plus/on_process()
	var/mob/living/carbon/M = quirk_holder //If you get balls later, then this will still proc
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		if(!increasedcum)
			T.fluid_mult = 1.5 //Base is 0.133
			T.fluid_max_volume *= 1.75
			increasedcum = TRUE
*/
