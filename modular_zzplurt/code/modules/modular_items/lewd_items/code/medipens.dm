/obj/item/reagent_containers/hypospray/medipen/crocin
	name = "emergency aphrodisiac shot"
	volume = 30
	amount_per_transfer_from_this = 30
	desc = "A medipen made to treat people suffering from low libido, a terrible sickness no one should endure."
	icon = 'modular_zzplurt/icons/obj/syringe.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "crocinpen"
	inhand_icon_state = "crocinpen"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 30)

/obj/item/reagent_containers/hypospray/medipen/crocin/plus
	name = "shot of concentrated lust"
	volume = 30
	amount_per_transfer_from_this = 30
	desc = "Use this in case the case of low libido can't be cured using conventional aphrodisiacs."
	icon = 'modular_zzplurt/icons/obj/syringe.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "hcrocinpen"
	inhand_icon_state = "hcrocinpen"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = 30)

/obj/item/reagent_containers/hypospray/medipen/breastgrowth
	name = "succubus milk autoinjector"
	volume = 30
	amount_per_transfer_from_this = 30
	desc = "A medipen used to create stable sources of milk in little time. Side effects <b>will</b> include mammary swelling."
	icon = 'modular_zzplurt/icons/obj/syringe.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "succupen"
	inhand_icon_state = "succupen"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/succubus_milk = 30)

/obj/item/reagent_containers/hypospray/medipen/penisgrowth
	name = "incubus draft autoinjector"
	volume = 30
	amount_per_transfer_from_this = 30
	desc = "A medipen used to help with urgent cases of \"small cock\"."
	icon = 'modular_zzplurt/icons/obj/syringe.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "incupen"
	inhand_icon_state = "incupen"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/incubus_draft = 30)

//
/obj/item/reagent_containers/hypospray/medipen/lewdbomb
	name = "La Coom Bomb"
	desc = "Someone forgot what reagent was supposed to go in this one, so they just mixed all the funny ones into it's case... Oh my..."
	icon = 'modular_zzplurt/icons/obj/syringe.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "bombpen"
	inhand_icon_state = "bombpen"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list(
		/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = 10,
		/datum/reagent/drug/aphrodisiac/succubus_milk = 10,
		/datum/reagent/drug/aphrodisiac/incubus_draft = 10
	)

/obj/item/reagent_containers/hypospray/medipen/prospacillin
	name = "Extra height shot"
	desc = "Made to quickly treat individuals catalogued as \"manlets\" and help them reach the station's shelves."
	icon = 'modular_zzplurt/icons/obj/syringe.dmi'
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "prospen"
	inhand_icon_state = "prospen"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list(/datum/reagent/growthchem = 30)

/obj/item/reagent_containers/hypospray/medipen/prospacillin/Initialize()
	. = ..()
	if(prob(50))
		desc = "Macro haters' worst enemy"

/// Box with LEWD medipens ///
/obj/item/storage/box/medipens/lewd
	name = "Lewd medipen box"
	icon = 'modular_zzplurt/icons/obj/storage.dmi'
	icon_state = "box"
	desc = "A box full of medipens meant to cause interesting effects on people. None of them with a close to medical application."
	illustration = "syringe_lewd"

/obj/item/storage/box/medipens/lewd/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/crocin(src)
	new /obj/item/reagent_containers/hypospray/medipen/crocin/plus(src)
	new /obj/item/reagent_containers/hypospray/medipen/breastgrowth(src)
	new /obj/item/reagent_containers/hypospray/medipen/penisgrowth(src)
	new /obj/item/reagent_containers/hypospray/medipen/lewdbomb(src)
