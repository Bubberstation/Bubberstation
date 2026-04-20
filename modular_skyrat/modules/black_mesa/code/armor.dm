/obj/item/clothing/suit/armor/vest/hecu
	name = "combat vest"
	desc = "Vest designed to take heavy beating and probably keep the user alive in the process."
	armor_type = /datum/armor/vest_hecu
	icon_state = "ceramic_vest"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_digi.dmi'

/obj/item/clothing/suit/armor/vest/hecu/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hecu_vest)

/datum/atom_skin/hecu_vest
	abstract_type = /datum/atom_skin/hecu_vest

/datum/atom_skin/hecu_vest/basic
	preview_name = "Basic"
	new_icon_state = "ceramic_vest"

/datum/atom_skin/hecu_vest/corpsman
	preview_name = "Corpsman"
	new_icon_state = "ceramic_vest_medic"

/datum/atom_skin/hecu_vest/basic_black
	preview_name = "Basic Black"
	new_icon_state = "ceramic_vest_black"

/datum/atom_skin/hecu_vest/corpsman_black
	preview_name = "Corpsman Black"
	new_icon_state = "ceramic_vest_medic_black"

/datum/armor/vest_hecu
	melee = 40
	bullet = 40
	laser = 40
	energy = 40
	bomb = 40
	fire = 80
	acid = 100
	wound = 30

/obj/item/clothing/head/helmet/hecu
	name = "combat helmet"
	desc = "Helmet designed to take heavy beating and probably keep the user alive in the process."
	armor_type = /datum/armor/helmet_hecu
	icon_state = "ceramic_helmet"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_muzzled.dmi'

/obj/item/clothing/head/helmet/hecu/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hecu_helmet)

/datum/atom_skin/hecu_helmet
	abstract_type = /datum/atom_skin/hecu_helmet

/datum/atom_skin/hecu_helmet/basic
	preview_name = "Basic"
	new_icon_state = "ceramic_helmet"

/datum/atom_skin/hecu_helmet/corpsman
	preview_name = "Corpsman"
	new_icon_state = "ceramic_helmet_medic"

/datum/atom_skin/hecu_helmet/basic_black
	preview_name = "Basic Black"
	new_icon_state = "ceramic_helmet_black"

/datum/atom_skin/hecu_helmet/corpsman_black
	preview_name = "Corpsman Black"
	new_icon_state = "ceramic_helmet_medic_black"

/datum/armor/helmet_hecu
	melee = 30
	bullet = 30
	laser = 30
	energy = 30
	bomb = 30
	fire = 80
	acid = 100
	wound = 30
