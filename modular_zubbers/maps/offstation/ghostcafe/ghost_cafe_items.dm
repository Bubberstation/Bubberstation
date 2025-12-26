/obj/structure/showcase/fake_cafe_console
	name = "civilian console"
	desc = "A stationary computer. This one comes preloaded with generic programs."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fake_cafe_console/rd
	name = "R&D Console"
	desc = "A console used to interface with R&D tools."

/obj/structure/showcase/fake_cafe_console/rd/Initialize(mapload)
	. = ..()
	add_overlay("rdcomp")
	add_overlay("rd_key")


/obj/machinery/computer/camera_advanced/cafe
	name = "Human Observation Console"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "camera"
	icon_keyboard = null
	icon_screen = null

/obj/structure/closet/ghostcafe/build
	name = "construction closet"
	desc = "Management condemns using these tools to stab your friends."
	icon_state = "eng"
	icon_door = "eng_tool"

/obj/structure/closet/ghostcafe/build/PopulateContents()
	..()
	for(var/i in 1 to 4)
		new /obj/item/storage/belt/utility/full/powertools/ghostcafe(src)
	for(var/i in 1 to 4)
		new /obj/item/clothing/glasses/welding(src)
	new /obj/item/stack/tile/carpet/black/fifty(src)
	new /obj/item/stack/tile/carpet/blue/fifty(src)
	new /obj/item/stack/tile/carpet/blue/fifty(src)
	new /obj/item/stack/tile/carpet/green/fifty(src)
	new /obj/item/stack/tile/carpet/orange/fifty(src)
	new /obj/item/stack/tile/carpet/purple/fifty(src)
	new /obj/item/stack/tile/carpet/red/fifty(src)
	new /obj/item/stack/tile/carpet/royalblack/fifty(src)
	new /obj/item/stack/tile/carpet/royalblue/fifty(src)
	new /obj/item/stack/sheet/mineral/wood/fifty(src)

/obj/item/storage/box/syndie_kit/chameleon/ghostcafe
	name = "cafe costuming kit"
	desc = "Look just the way you did in life - or better!"
	icon_state = "ghostcostuming"

/obj/item/storage/box/syndie_kit/chameleon/ghostcafe/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_HUGE // This is ghost cafe only, balance is not given a shit about.
	atom_storage.max_slots = 14 // Holds all the starting stuff, plus a bit of change.
	atom_storage.max_total_storage = 50 // To actually acommodate the stuff being added.

/obj/item/storage/box/syndie_kit/chameleon/ghostcafe/PopulateContents() // Doesn't contain a PDA or radio, for isolation reasons.
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/suit/chameleon(src)
	new /obj/item/clothing/gloves/chameleon(src)
	new /obj/item/clothing/shoes/chameleon(src)
	new /obj/item/clothing/glasses/chameleon(src)
	new /obj/item/clothing/head/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/clothing/neck/chameleon(src)
	new /obj/item/storage/belt/chameleon(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/stamp/chameleon(src)
	new /obj/item/gun/energy/laser/chameleon(src) //Does no damage.
	new /obj/item/hhmirror/syndie(src)

/obj/item/card/id/advanced/chameleon/ghost_cafe
	name = "\improper Cafe ID"
	desc = "An ID straight from God."
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_age = null
	trim = /datum/id_trim/admin
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/storage/belt/utility/full/powertools/ghostcafe/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/wrench/bolter(src)
	new /obj/item/multitool/abductor(src)

/obj/machinery/photocopier/gratis/infinite
	starting_toner = /obj/item/toner/infinite
	starting_paper = 30
