/////GS13 - reflavoring of random items into GATO corp, mostly seperated variants so we don't overwrite NT

/obj/item/storage/fancy/cigarettes/gatito
	name = "\improper HumoGatitos packet"
	desc = "Strangely tasty for a cigarette."
	icon = 'modular_gs/icons/obj/cigarettes.dmi'
	icon_state = "smokegatitos"
	spawn_type = /obj/item/clothing/mask/cigarette/gatito

/obj/item/clothing/mask/cigarette/gatito
	desc = "A HumoGatitos brand cigarette."

/obj/item/banner/gato
	name = "GATO banner"
	desc = "The banner of GATO, our corporate overlords."
	icon = 'modular_gs/icons/obj/items_and_weapons.dmi'
	icon_state = "banner_gato"
	job_loyalties = list("Command")
	warcry = "FOR THE INTEREST OF GATO!!"
	lefthand_file = 'modular_gs/icons/mob/inhands/equipment/banners_lefthand.dmi'
	righthand_file = 'modular_gs/icons/mob/inhands/equipment/banners_righthand.dmi'
