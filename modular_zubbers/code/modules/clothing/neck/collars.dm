/obj/item/clothing/neck/human_petcollar/locked/ringbell
	name = "ringing bell collar"
	desc = "A soft collar that chimes for your little pet!"
	icon_state = "ringbell"
	greyscale_config = /datum/greyscale_config/collar/ringbell
	greyscale_config_worn = /datum/greyscale_config/collar/ringbell/worn
	greyscale_colors = "#FF4F66#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/ringbell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/misc/collarbell1.ogg'=1,'modular_zubbers/sound/misc/collarbell2.ogg'=1), 50, 100, 8)

/** Requirements:
 * [x] Send-only GPS
 * [ ] Add to premium Lustwish
 * [ ] Collar name is GPS signal name
 * [ ] alt clicking it turns it on and off
 * [ ] locking it prevents toggling the GPS on/off status or changing the name
 */
/obj/item/clothing/neck/kink_collar/locked/gps
	name = "tracking collar"
	desc = "A collar that lets you find your pet anywhere!"
	//icon_state = // TODO
	//greyscale_config = // TODO
	//greyscale_config_worn = // TODO
	//greyscale_colors = // TODO

/obj/item/clothing/neck/kink_collar/locked/gps/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, name)
