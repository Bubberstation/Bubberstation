/datum/symptom/berry
	name = "Berrification"
	desc = "The virus causes the host's biology to overflow with a blue substance. Infection ends if the substance is completely removed from their body, besides ordinary cures."
	stealth = -5
	resistance = -4
	stage_speed = 1
	transmittable = 6
	level = 7
	severity = 5
	base_message_chance = 100
	symptom_delay_min = 15
	symptom_delay_max = 45
	threshold_desc = list(
		"Stage Speed" = "Increases the rate of liquid production.",
	)
	var/datum/reagent/infection_reagent = /datum/reagent/blueberry_juice

/datum/symptom/berry/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.affected_mob?.client?.prefs?.blueberry_inflation)
		A.affected_mob.reagents.add_reagent(infection_reagent, max(1, A.totalStageSpeed()) * 10)
	..()

/datum/symptom/berry/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	if(!(M?.client?.prefs?.blueberry_inflation))
		return
	if(M.reagents.get_reagent_amount(infection_reagent) <= 0)
		A.remove_disease()
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(M, "<span class='warning'>[pick("You feel oddly full...", "Your stomach churns...", "You hear a gurgle...", "You taste berries...")]</span>")
		else
			to_chat(M, "<span class='warning'><i>[pick("A deep slosh comes from inside you...", "Your mind feels light...", "You think blue really suits you...", "Your skin feels so tight...")]</i></span>")
			M.reagents.add_reagent(infection_reagent, max(A.totalStageSpeed(), 1))

/obj/item/reagent_containers/glass/attack(mob/M, mob/user, obj/target)
	if(M.reagents && M.reagents.get_reagent_amount(/datum/reagent/blueberry_juice) > 0 && (reagents.total_volume + min(amount_per_transfer_from_this, 10)) <= volume)
		reagents.add_reagent(/datum/reagent/blueberry_juice, min(10, amount_per_transfer_from_this))
		M.reagents.remove_reagent(/datum/reagent/blueberry_juice, min(10, amount_per_transfer_from_this))
		if(M != user)
			to_chat(user, "<span class='warning'>You juice [M.name]...</span>")
			to_chat(M, "<span class='warning'>[user.name] juices you...</span>")
		else
			to_chat(user, "<span class='warning'>You get some juice out of you...</span>")
		if(prob(5))
			new /obj/effect/decal/cleanable/juice(M.loc)
			playsound(M.loc, 'sound/effects/splat.ogg',rand(10,50), 1)
		return
	..()

/obj/effect/decal/cleanable/juice
	name = "berry juice"
	desc = "It's blue and smells enticingly sweet."
	icon = 'GainStation13/icons/turf/berry_decal.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	blood_state = BLOOD_STATE_JUICE
	bloodiness = BLOOD_AMOUNT_PER_DECAL

/obj/effect/decal/cleanable/juice/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/blueberry_juice = 5)

/obj/effect/decal/cleanable/juice/streak
	random_icon_states = list("streak1", "streak2", "streak3", "streak4", "streak5")

/obj/effect/decal/cleanable/blood/update_icon()
	color = blood_DNA_to_color()
	if(blood_state == BLOOD_STATE_JUICE)
		color = BLOOD_COLOR_JUICE
