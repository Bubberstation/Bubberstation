/obj/item/radio/intercom
	icon = 'modular_skyrat/modules/aesthetics/intercom/icons/intercom.dmi'

/obj/item/wallframe/intercom
	icon = 'modular_skyrat/modules/aesthetics/intercom/icons/intercom.dmi'

/obj/item/radio/intercom/syndicate
	icon_state = "intercom_syndicate"
	icon_off = "intercom_syndicate-p"

/obj/item/radio/intercom/departmental
	var/stripe_color = null

/obj/item/radio/intercom/departmental/update_overlays()
	. = ..()

	if(!stripe_color)
		return

	var/mutable_appearance/stripe = mutable_appearance(icon, "intercom_stripe")
	stripe.color = stripe_color
	. += stripe

/obj/item/radio/intercom/departmental/cargo
	stripe_color = "#956929"

/obj/item/radio/intercom/departmental/command
	stripe_color = "#486091"

/obj/item/radio/intercom/departmental/engineering
	stripe_color = "#EFB341"

/obj/item/radio/intercom/departmental/medical
	stripe_color = "#52B4E9"

/obj/item/radio/intercom/departmental/science
	stripe_color = "#D381C9"

/obj/item/radio/intercom/departmental/security
	stripe_color = "#DE3A3A"

/obj/item/radio/intercom/departmental/service
	stripe_color = "#83ca41"
