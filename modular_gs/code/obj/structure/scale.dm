/obj/structure/scale
	name = "weighing scale"
	desc = "You can weigh yourself with this."
	icon = 'GainStation13/icons/obj/scale.dmi'
	icon_state = "scale"
	anchored = TRUE
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 25
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 3
	layer = OBJ_LAYER
	//stores the weight of the last person to step on in Lbs
	var/lastreading = 0
	//the conversion ratio for how much a point of fatness weighs on a 6' person
	var/fatnessToWeight = 0.25

/obj/structure/scale/deconstruct()
	// If we have materials, and don't have the NOCONSTRUCT flag
	if(buildstacktype && (!(flags_1 & NODECONSTRUCT_1)))
		new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/scale/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct()
	else if(istype(W, /obj/item/assembly/shock_kit))
		if(!user.temporarilyRemoveItemFromInventory(W))
			return
		var/obj/item/assembly/shock_kit/SK = W
		var/obj/structure/chair/e_chair/E = new /obj/structure/chair/e_chair(src.loc)
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
		E.setDir(dir)
		E.part = SK
		SK.forceMove(E)
		SK.master = E
		qdel(src)
	else
		return ..()

/obj/structure/scale/examine(mob/user)
	. = ..()
	. += "Its last reading was: [src.lastreading]Lbs"
	. += "<span class='notice'>It's held together by a couple of <b>bolts</b>.</span>"

/obj/structure/scale/proc/weighEffect(mob/living/carbon/human/fatty)
	to_chat(fatty, "<span class='notice'>You weigh yourself.</span>")
	to_chat(fatty, "<span class='notice'>The numbers on the screen tick up and eventually settle on:</span>")
	//The appearance of the numbers changes with the fat level of the character
	if (HAS_TRAIT(fatty, TRAIT_BLOB))
		to_chat(fatty, "<span class='userdanger'><span class='big'>[round(src.lastreading/2000, 0.01)]TONS!!!</span></span>")

	else if (HAS_TRAIT(fatty, TRAIT_IMMOBILE))
		to_chat(fatty, "<span class='boldannounce'>[src.lastreading]Lbs!</span>")

	else if(HAS_TRAIT(fatty, TRAIT_OBESE) || HAS_TRAIT(fatty, TRAIT_MORBIDLYOBESE))
		to_chat(fatty, "<span class='alert'>[src.lastreading]Lbs!</span>")

	else
		to_chat(fatty, "<span class='notice'>[src.lastreading]Lbs.</span>")

	visible_message("<span class='notice'>The numbers on the screen read out: [fatty] has a BFI of [fatty.fatness].</span>")

/obj/structure/scale/Crossed(AM as mob|obj)
	if(isturf(loc))
		//need to be sure the thing that just crossed the scale is human
		if(ishuman(AM))
			var/mob/living/carbon/human/HM = AM
			if(!(HM.movement_type & FLYING))
				weighperson(HM)

/obj/structure/scale/proc/weighperson(mob/living/carbon/human/fatty)
	src.lastreading = fatty.calculate_weight_in_pounds() 
	weighEffect(fatty)
	visible_message("<span class='notice'>[fatty] weighs themselves.</span>")
	visible_message("<span class='notice'>The numbers on the screen settle on: [src.lastreading]Lbs.</span>")
	visible_message("<span class='notice'>The numbers on the screen read out: [fatty] has a BFI of [fatty.fatness].</span>")

/mob/living/carbon/proc/calculate_weight_in_pounds()
	return round((140 + (fatness*FATNESS_TO_WEIGHT_RATIO))*(size_multiplier**2)*((dna.features["taur"] != "None") ? 2.5: 1))
