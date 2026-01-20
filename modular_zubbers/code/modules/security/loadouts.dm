/datum/job/security_officer
	total_positions = 8 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	spawn_positions = 8 //Handled in /datum/controller/occupations/proc/setup_officer_positions()

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/peacekeeper)


/obj/item/radio/headset/headset_sec/alt/department/Initialize(mapload)
	. = ..()
	set_wires(new/datum/wires/radio(src))
	secure_radio_connections = list()
	recalculateChannels()

/datum/outfit/job/security
	head = /obj/item/clothing/head/security_garrison
	suit_store = /obj/item/gun/energy/e_gun/advtaser
	glasses = /obj/item/clothing/glasses/hud/security
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/flashlight/seclite = 1)
