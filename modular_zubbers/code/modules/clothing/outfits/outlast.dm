/obj/item/clothing/suit/leatherapron //Sprite by pacertest#0001
	name = "Leather Apron"
	desc = "A somewhat sterile apron made from thick leather, perfect for sawing limbs off without getting your uniform bloody."
	icon = 'modular_zubbers/icons/obj/clothing/outlast.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/outlast.dmi'
	icon_state = 'longrubber'
	inhand_icon_state = NULL
	allowed = list(
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/flashlight/pen,
		/obj/item/healthanalyzer,
		/obj/item/hemostat,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/retractor,
		/obj/item/scalpel,
		/obj/item/surgical_drapes,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
	)
/obj/item/clothing/glasses/surgerygoggles //Sprite by pacertest#0001
	name = "Surgery Goggles"
	desc = "A pair of goggles worn to protect the eyes from viscera flying off a patient, a wonderful development in medical technology."
	icon = 'modular_zubbers/icons/obj/clothing/outlast.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/outlast.dmi'
	icon_state = "surgerygoggles"
/obj/item/clothing/gloves/longrubbergloves //Sprite by pacertest#0001
    name = "Long Rubber Gloves"
    desc = "Pricy somewhat sterile gloves that are thicker than latex, these ones extend almost past the elbow. Excellent grip ensures very fast carrying of patients along with the faster use time of various chemical related items."
	icon = 'modular_zubbers/icons/obj/clothing/outlast.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/outlast.dmi'
    icon_state = "longrubber"
    clothing_traits = list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED)
