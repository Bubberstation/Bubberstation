var/charges = 3

/datum/species/golem/calorite //golems that heal people around them, and cook groovy food. essentially the support class of golems
	name = "Calorite Golem"
	id = "calorite golem"
	prefix = "Calorite"
	special_names = list("Callie Wright")
	info_text = "As a <span class='danger'>Calorite Golem</span>, you have all kinds of cool magical abilities that allow you to heal the wounded, make food more nourishing and boost people's speed! Unfortunately, you are also very flimsy, and can't dish out much damage with your hands."
	fixed_mut_color = "ffffff"
	limbs_id = "cal_golem" //special sprites
	attack_verb = "bop" //they don't hit too hard, so their attack verb is fittingly pretty soft
	armor = 25
	punchdamagelow = 5
	punchstunthreshold = 0 //no chance to stun
	punchdamagehigh = 5
	var/datum/action/innate/aura/heal
	var/datum/action/innate/bless/boost
	var/datum/action/innate/unburden/speed
	var/datum/action/innate/recharge/power

/datum/species/golem/calorite/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	if(ishuman(C))
		heal = new
		heal.Grant(C)
		boost = new
		boost.Grant(C)
		speed = new
		speed.Grant(C)
		power = new
		power.Grant(C)

/datum/species/golem/calorite/on_species_loss(mob/living/carbon/C)
	if(heal)
		heal.Remove(C)
	if(boost)
		boost.Remove(C)
	if(speed)
		speed.Remove(C)
	if(power)
		power.Remove(C)
	..()

/datum/action/innate/aura
	name = "Healing Pulse"
	desc = "Emit a healing pulse around yourself, curing the wounds of all around you."
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'modular_gs/icons/mob/action_icons.dmi'
	button_icon_state = "healing"

/datum/action/innate/unburden
	name = "Lift Burdens"
	desc = "Vitalise all those around you, giving them a boost of speed for a moment. The effects of this charm are more effective on those whom are heavily burdened"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'modular_gs/icons/mob/action_icons.dmi'
	button_icon_state = "boost"

/datum/action/innate/bless
	name = "Bless Food"
	desc = "infuse food near you with a fraction of your power to make it more nourishing"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'modular_gs/icons/mob/action_icons.dmi'
	button_icon_state = "cal_bless"

/datum/action/innate/recharge
	name = "Recharge"
	desc = "refresh and recharge your magical abilities"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'modular_gs/icons/mob/action_icons.dmi'
	button_icon_state = "cal_golem_sleepies"


/datum/action/innate/recharge/Activate()
	charges = 3
	if(ishuman(owner))
		to_chat(owner, "<span class='notice'>You recharge yourself with magical energy!</span>")


/datum/action/innate/bless/Activate()
	if(charges != 0)
		charges -= 1
		if(ishuman(owner))
			to_chat(owner, "<span class='notice'>You bless the food around you!</span>")

		for(var/obj/item/reagent_containers/food/O in view(1, owner))
			if(!O.blessed)
				O.reagents.add_reagent(/datum/reagent/consumable/nutriment, 10)
				O.desc += " It faintly glows with warm, orange energy..."
				O.blessed = 1
	else
		to_chat(owner, "<span class='notice'>You need to recharge...</span>")

/datum/action/innate/unburden/Activate()
	if(charges != 0)
		charges -= 1
		if(ishuman(owner))
			to_chat(owner, "<span class='notice'>You lift the burdens of those around you!</span>")

			for(var/mob/living/L in view(3, owner))
				if(iscarbon(L))
					if(!L.has_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants))
						L.reagents.add_reagent(/datum/reagent/consumable/caloriteblessing, 5)

	else
		to_chat(owner, "<span class='notice'>You need to recharge...</span>")




/datum/action/innate/aura/Activate()
	if(charges != 0)
		charges -= 1
		if(ishuman(owner))
			to_chat(owner, "<span class='notice'>You heal those around you!</span>")

			for(var/mob/living/L in view(3, owner))
				if(L.health < L.maxHealth)
					new /obj/effect/temp_visual/heal(get_turf(L), "#375637")
				if(iscarbon(L))
					L.adjustBruteLoss(-3)
					L.adjustFireLoss(-3)
					L.adjustToxLoss(-3, forced = TRUE) //Because Slime People are people too
					L.adjustOxyLoss(-3)
//					L.adjustStaminaLoss(-3)
//					L.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3)
					L.adjustCloneLoss(-1) //Becasue apparently clone damage is the bastion of all health
//				else if(issilicon(L))
//					L.adjustBruteLoss(-3)
//					L.adjustFireLoss(-3)
				else if(isanimal(L))
					var/mob/living/simple_animal/SM = L
					SM.adjustHealth(-3, forced = TRUE)




