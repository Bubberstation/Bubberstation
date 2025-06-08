//////////////////////
//////METAL FOOD//////
//////////////////////


/obj/item/metal_food
	icon = 'modular_gs/icons/obj/food/metal_food.dmi'
	desc = "Looks shiny."
	w_class = WEIGHT_CLASS_SMALL
	var/crunch_value = 0 // value per bite
	var/crunch_left = 2 // means 3 bites left


// Maybe I should not put it here or making separate object for that...
/obj/item/metal_food/attack(mob/living/M, mob/living/user)
	if(HAS_TRAIT(M, TRAIT_METAL_CRUNCHER))
		if(crunch_value > 0)
			if(M == user)
				user.visible_message("<span class='notice'>[user] crunches on some of [src].</span>", "<span class='notice'>You crunch on some of [src].</span>")
			else
				M.visible_message("<span class='danger'>[user] attempts to feed some of [src] to [M].</span>", "<span class='userdanger'>[user] attempts to feed some of [src] to [M].</span>")
			playsound(M,'sound/items/eatfood.ogg', rand(10,50), 1)
			use(1)
			M.nutrition += crunch_value
			if(crunch_left == 0)
				qdel(src)
			else
				crunch_left -= 1
	else
		if(M == user)
			user.visible_message("<span class='userdanger'>[user] fails to crunch some of [src].</span>", "<span class='userdanger'>Your teeth feel sore when you try to crunch on some of [src].</span>")
		else
			M.visible_message("<span class='danger'>[user] attempts to feed some of [src] to [M].</span>", "<span class='userdanger'>[user] attempts to feed some of [src] to [M].</span>")
	return . = ..()


/obj/item/metal_food/Initialize(mapload)
	. = ..()

/obj/item/metal_food/mburger
	name = "Metal Burger"
	icon_state = "mburger"
	crunch_value = 15

/obj/item/metal_food/mburger_calorite
	name = "Calorite Burger"
	icon_state = "mburger_calorite"
	crunch_value = 35

/obj/item/metal_food/mram
	name = "Old RAM module"
	desc = "It's an obsolete RAM module. You can see some dust on it and spoiled electronics"
	icon_state = "mRAM"
	crunch_value = 1
	crunch_left = 4

/obj/item/metal_food/mfries
	name = "Fried rods"
	desc = "It looks like fries, but made out of metal. Can we call it french rods?"
	icon_state = "mfrench_rods"
	crunch_value = 1
	crunch_left = 9
