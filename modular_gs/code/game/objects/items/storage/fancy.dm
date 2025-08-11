/obj/item/storage/fancy/large_donut_box // not inheriting from a regular box of donuts for now because I don't want the icon changes...
	name = "large donut box"
	desc = "For when security just can't get enough."
	icon = 'modular_gs/icons/obj/food/containers.dmi'
	icon_state = "large_donut_box"
	spawn_type = /obj/item/food/donut
	fancy_open = FALSE
	custom_price = PRICE_NORMAL
	appearance_flags = KEEP_TOGETHER

/obj/item/storage/fancy/large_donut_box/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 16
	STR.max_combined_w_class = WEIGHT_CLASS_SMALL * 16
	STR.can_hold = typecacheof(list(/obj/item/food/donut))

/obj/item/storage/fancy/large_donut_box/update_icon_state()
	if(fancy_open)
		icon_state = "large_donut_box_open"
	else
		icon_state = "large_donut_box"

#define DONUT_INBOX_SPRITE_WIDTH 7
#define DONUT_FULL_INBOX_SPRITE_HEIGHT 7
// #define DONUT_HALF_INBOX_SPRITE_HEIGHT 4 // suprise suprise, it's not actually half

/obj/item/storage/fancy/large_donut_box/update_overlays()
	. = ..()

	if (!fancy_open)
		return

	var/donuts = 0

	for (var/_donut in contents)
		var/obj/item/food/donut/donut = _donut
		if (!istype(donut))
			continue

		if (donuts < 4)
			. += image(icon = initial(icon), icon_state = "donut_box_donut", pixel_x = donuts * DONUT_INBOX_SPRITE_WIDTH)
		else if (donuts < 8)
			. += image(icon = initial(icon), icon_state = "donut_box_donut", pixel_x = (donuts - 4) * DONUT_INBOX_SPRITE_WIDTH, pixel_y = -4)
		else if (donuts >= 12)
			break
		else
			. += image(icon = initial(icon), icon_state = "donut_box_donut_half", pixel_x = (donuts - 8) * DONUT_INBOX_SPRITE_WIDTH)

		donuts += 1

	// . += image(icon = initial(icon), icon_state = "donutbox_top")

#undef DONUT_INBOX_SPRITE_WIDTH
#undef DONUT_FULL_INBOX_SPRITE_HEIGHT
