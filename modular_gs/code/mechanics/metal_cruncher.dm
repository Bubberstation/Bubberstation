/datum/quirk/metal_cruncher
	name = "Metal Cruncher"
	desc = "You can eat most minerals. Brush your teeth."
	value = 0 //ERP quirk
	gain_text = "<span class='notice'>You feel like you could eat steel.</span>"
	lose_text = "<span class='notice'>Your teeth hurt too much...</span>"
	mob_trait = TRAIT_METAL_CRUNCHER

/obj/item/stack
	var/crunch_value = 0

/obj/item/stack/attack(mob/living/M, mob/living/user)
	if(HAS_TRAIT(M, TRAIT_METAL_CRUNCHER))
		if(crunch_value > 0)
			if(M == user)
				user.visible_message("<span class='notice'>[user] crunches on some of [src].</span>", "<span class='notice'>You crunch on some of [src].</span>")
			else
				M.visible_message("<span class='danger'>[user] attempts to feed some of [src] to [M].</span>", "<span class='userdanger'>[user] attempts to feed some of [src] to [M].</span>")
			playsound(M,'sound/items/eatfood.ogg', rand(10,50), 1)
			use(1)
			M.nutrition += crunch_value
			//if(HAS_TRAIT(M, TRAIT_VORACIOUS))
			//	M.changeNext_move(CLICK_CD_MELEE * 0.5)
		return
	. = ..()

/obj/item/stack/cable_coil
	crunch_value = 2
/obj/item/stack/sheet/metal
	crunch_value = 4
/obj/item/stack/rods
	crunch_value = 2
/obj/item/stack/sheet/glass
	crunch_value = 2
/obj/item/stack/sheet/rglass
	crunch_value = 4
/obj/item/stack/sheet/plasmaglass
	crunch_value = 12
/obj/item/stack/sheet/plasmarglass
	crunch_value = 14
/obj/item/stack/sheet/titaniumglass
	crunch_value = 27
/obj/item/stack/sheet/plastitaniumglass
	crunch_value = 37
/obj/item/stack/sheet/plasteel
	crunch_value = 14
/obj/item/stack/sheet/durathread
	crunch_value = 10
/obj/item/stack/sheet/plastic
	crunch_value = 2
/obj/item/stack/sheet/micro_bricks
	crunch_value = 1
/obj/item/stack/sheet/cardboard
	crunch_value = 1
/obj/item/stack/sheet/mineral/calorite
	crunch_value = 100
/obj/item/stack/sheet/mineral/sandstone
	crunch_value = 1
/obj/item/stack/sheet/mineral/uranium
	crunch_value = 50
/obj/item/stack/sheet/mineral/plasma
	crunch_value = 10
/obj/item/stack/sheet/mineral/gold
	crunch_value = 20
/obj/item/stack/sheet/mineral/silver
	crunch_value = 15
/obj/item/stack/sheet/mineral/titanium
	crunch_value = 25
/obj/item/stack/sheet/mineral/plastitanium
	crunch_value = 35
/obj/item/stack/sheet/mineral/adamantine
	crunch_value = 75
/obj/item/stack/sheet/mineral/mythril
	crunch_value = 75
/obj/item/stack/sheet/mineral/coal
	crunch_value = 50
/obj/item/stack/sheet/mineral/wood
	crunch_value = 4
/obj/item/stack/sheet/mineral/bamboo
	crunch_value = 10
/obj/item/stack/sheet/mineral/shadoww
	crunch_value = 15
/obj/item/stack/sheet/mineral/gmushroom
	crunch_value = 15
/obj/item/stack/sheet/mineral/plaswood
	crunch_value = 15
/obj/item/stack/sheet/mineral/diamond
	crunch_value = 25


