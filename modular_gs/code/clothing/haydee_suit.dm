/obj/item/clothing/head/helmet/space/hardsuit/engine/haydee
	name = "Haydee Helmet"
	desc = "A strange helmet. Offers little to no protection."
	icon = 'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	mob_overlay_icon = 'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	icon_state = "haydee_helmet"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 10, "energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 25, "fire" = 25, "acid" = 25)
	slowdown = 0
	mutantrace_variation = NONE
	actions_types = list()

/obj/item/clothing/suit/space/hardsuit/engine/haydee
	name = "Haydee Suit"
	desc = "A strangely voluptous suit. Offers little to no protection. It also appears to have minor flab-compressing properties."
	icon = 'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	mob_overlay_icon =  'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	anthro_mob_worn_overlay = 'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	icon_state = "haydee_suit1"
	item_state = "item_haydee"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 25, "fire" = 5, "acid" = 5)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals)
	actions_types = list(/datum/action/item_action/toggle_helmet)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/engine/haydee
	slowdown = 0
	mutantrace_variation = NONE
	var/icon_location = 'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	var/mob/living/carbon/U

//haydee gun
/obj/item/gun/ballistic/automatic/pistol/haydee
	name = "Simplistic Pistol"
	desc = "10mm handgun. It seems to be clad in overly simplistic white shell."
	icon = 'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	icon_state = "pistol"
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/toy/pistol/haydee
	name = "Simplistic Toy Pistol"
	desc = "A small, easily concealable toy handgun."
	icon = 'GainStation13/icons/obj/clothing/haydee_modular.dmi'
	icon_state = "pistol"


/obj/item/clothing/suit/space/hardsuit/engine/haydee/equipped(mob/user, slot) //whenever the clothes are in someone's inventory the clothes keep track of who that user is
    ..()
    U = user

/obj/item/clothing/suit/space/hardsuit/engine/haydee/dropped() //whenever the clothes leave a person's inventory, they forget who held them
    ..()
    U = null

/obj/item/clothing/suit/space/hardsuit/engine/haydee/worn_overlays(isinhands = FALSE)
	if(U)
		if(!isinhands)
			. = list()
			if(U.fatness <= 439)
				. += mutable_appearance(icon_location, "haydee_suit1", GENITALS_UNDER_LAYER)
			if(U.fatness >= 440)
				. += mutable_appearance(icon_location, "haydee_suit2", GENITALS_UNDER_LAYER)
			if(U.fatness >= 1240)
				. += mutable_appearance(icon_location, "haydee_suit3", GENITALS_UNDER_LAYER)
			if(U.fatness >= 3440)
				. += mutable_appearance(icon_location, "haydee_suit4", GENITALS_UNDER_LAYER)
			if(damaged_clothes)
				. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
			if(blood_DNA)
				. += mutable_appearance('icons/effects/blood.dmi', "uniformblood", color = blood_DNA_to_color())
