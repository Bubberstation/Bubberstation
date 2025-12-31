/obj/item/clothing/head/blastwave
	name = "blastwave helmet"
	desc = "A plastic helmet with paint applied. Protects as much as cardboard box named 'Bomb Shelter'."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "blastwave_helmet"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/blastwave/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_helmet)

/datum/atom_skin/blastwave_helmet
	abstract_type = /datum/atom_skin/blastwave_helmet

/datum/atom_skin/blastwave_helmet/default
	preview_name = "Default (Purple)"
	new_icon_state = "blastwave_helmet"

/datum/atom_skin/blastwave_helmet/red
	preview_name = "Red"
	new_icon_state = "blastwave_helmet_r"

/datum/atom_skin/blastwave_helmet/green
	preview_name = "Green"
	new_icon_state = "blastwave_helmet_g"

/datum/atom_skin/blastwave_helmet/blue
	preview_name = "Blue"
	new_icon_state = "blastwave_helmet_b"

/datum/atom_skin/blastwave_helmet/yellow
	preview_name = "Yellow"
	new_icon_state = "blastwave_helmet_y"

/obj/item/clothing/head/blastwave/officer
	name = "blastwave peaked cap"
	desc = "A simple, militaristic cap."
	icon_state = "blastwave_offcap"
	flags_inv = 0

/obj/item/clothing/head/blastwave/officer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_officer_cap)

/datum/atom_skin/blastwave_officer_cap
	abstract_type = /datum/atom_skin/blastwave_officer_cap

/datum/atom_skin/blastwave_officer_cap/default
	preview_name = "Default (Purple)"
	new_icon_state = "blastwave_offcap"

/datum/atom_skin/blastwave_officer_cap/red
	preview_name = "Red"
	new_icon_state = "blastwave_offcap_r"

/datum/atom_skin/blastwave_officer_cap/green
	preview_name = "Green"
	new_icon_state = "blastwave_offcap_g"

/datum/atom_skin/blastwave_officer_cap/blue
	preview_name = "Blue"
	new_icon_state = "blastwave_offcap_b"

/datum/atom_skin/blastwave_officer_cap/yellow
	preview_name = "Yellow"
	new_icon_state = "blastwave_offcap_y"
