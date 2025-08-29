// HAMMERS

/obj/item/salvaging_hammer
	name = "hammer (1cm)"
	desc = "A hammer that can be used to pry off less-usable parts of scrap chunks."
	icon = 'local/icons/obj/salvage.dmi'
	icon_state = "hammer1"
	/// How deep do we dig into any one scrap chunk?
	var/dig_amount = 1
	/// The base speed we operate at.
	var/dig_speed = 0.5 SECONDS

/obj/item/salvaging_hammer/examine(mob/user)
	. = ..()
	. += span_notice("Current Digging Depth: [dig_amount]cm")

/obj/item/salvaging_hammer/cm2
	name = "hammer (2cm)"
	icon_state = "hammer2"
	dig_amount = 2
	dig_speed = 1 SECONDS

/obj/item/salvaging_hammer/cm3
	name = "hammer (3cm)"
	icon_state = "hammer3"
	dig_amount = 3
	dig_speed = 1.5 SECONDS

/obj/item/salvaging_hammer/cm4
	name = "hammer (4cm)"
	icon_state = "hammer4"
	dig_amount = 4
	dig_speed = 2 SECONDS

/obj/item/salvaging_hammer/cm5
	name = "hammer (5cm)"
	icon_state = "hammer5"
	dig_amount = 5
	dig_speed = 2.5 SECONDS

/obj/item/salvaging_hammer/cm6
	name = "hammer (6cm)"
	icon_state = "hammer6"
	dig_amount = 6
	dig_speed = 3 SECONDS

/obj/item/salvaging_hammer/cm10
	name = "hammer (10cm)"
	icon_state = "hammer10"
	dig_amount = 10
	dig_speed = 5 SECONDS

/obj/item/salvaging_hammer/adv
	name = "advanced hammer"
	icon_state = "adv_hammer"
	dig_amount = 1
	dig_speed = 1

/obj/item/salvaging_hammer/adv/examine(mob/user)
	. = ..()
	. += span_notice("This is an advanced hammer. It can change its digging depth from 1 to 30. Click to change depth.")

/obj/item/salvaging_hammer/adv/attack_self(mob/user, modifiers)
	. = ..()
	var/user_choice = input(user, "Choose the digging depth. 1 to 30", "Digging Depth Selection") as null|num
	if(!user_choice)
		dig_amount = 1
		dig_speed = 1
		return
	if(dig_amount <= 0)
		dig_amount = 1
		dig_speed = 1
		return
	var/round_dig = round(user_choice)
	if(round_dig >= 30)
		dig_amount = 30
		dig_speed = 30
		return
	dig_amount = round_dig
	dig_speed = round_dig * 0.5
	to_chat(user, span_notice("You change the hammer's digging depth to [round_dig]cm."))

// BRUSHES

/obj/item/salvaging_brush
	name = "brush"
	desc = "A brush that is used to more delicately uncover more usable parts from scrap chunks."
	icon = 'local/icons/obj/salvage.dmi'
	icon_state = "brush"
	var/dig_speed = 3 SECONDS

/obj/item/salvaging_brush/adv
	name = "advanced brush"
	icon_state = "adv_brush"
	dig_speed = 0.5 SECONDS

// Measures, Scanners

/obj/item/salvaging_tape_measure
	name = "measuring tape"
	desc = "Used to measure scrap chunks' damage. Who's shorter - the chunk of scrap you're working on, or Dick Gum, from the posters?"
	icon = 'local/icons/obj/salvage.dmi'
	icon_state = "tape"

/obj/item/salvage_handheld_scanner
	name = "handheld scanner"
	desc = "A handheld scanner for strange rocks. It tags the limits of the rock."
	icon = 'local/icons/obj/salvage.dmi'
	icon_state = "scanner"
	var/scanning_speed = 3 SECONDS
	var/scan_advanced = FALSE

/obj/item/salvage_handheld_scanner/advanced
	name = "advanced handheld scanner"
	icon_state = "adv_scanner"
	scanning_speed = 0.5 SECONDS
	scan_advanced = TRUE

/obj/item/storage/belt/utility/salvage
	name = "salvage toolbelt"
	desc = "Holds salvaging equipment, so you can yell; \"It's scrappin' time!\" and scrap all over the place."
	icon = 'local/icons/obj/salvage.dmi'
	icon_state = "salvage_belt"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_CREW * 2

/obj/item/storage/belt/utility/salvage/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 100
	atom_storage.max_slots = 15
	atom_storage.set_holdable(list(
		/obj/item/salvaging_hammer, \
		/obj/item/salvaging_brush, \
		/obj/item/salvaging_tape_measure, \
		/obj/item/salvage_handheld_scanner, \
		))

/obj/structure/closet/secure_closet/salvage
	name = "salvage equipment locker"
	icon_state = "science"
	req_access = list(ACCESS_SCIENCE)

/obj/structure/closet/secure_closet/salvage/PopulateContents()
	. = ..()
	new /obj/item/salvaging_hammer(src)
	new /obj/item/salvaging_hammer/cm2(src)
	new /obj/item/salvaging_hammer/cm3(src)
	new /obj/item/salvaging_hammer/cm4(src)
	new /obj/item/salvaging_hammer/cm5(src)
	new /obj/item/salvaging_hammer/cm6(src)
	new /obj/item/salvaging_hammer/cm10(src)
	new /obj/item/salvaging_brush(src)
	new /obj/item/salvaging_tape_measure(src)
	new /obj/item/salvage_handheld_scanner(src)
	new /obj/item/storage/belt/utility/salvage(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/clothing/glasses/science(src)
