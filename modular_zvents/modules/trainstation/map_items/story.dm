/obj/item/keycard/important/trainstation
	color = COLOR_GOLD

/obj/item/keycard/important/trainstation/lab_key
	name = "Lab Keycard"
	desc = "A keycard granting access to the laboratory."



/obj/structure/prop/big/bigdice/radiosphere
	name = "The Radiosphere"
	desc = "A massive array of sensors and signal amplifiers enclosed in a \
			shell resembling a symmetrical octahedron. A faint noise emanates from this object."
	icon = 'modular_zvents/icons/structures/radiosphere.dmi'
	icon_state = "main"
	density = TRUE
	uses_integrity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1
	pixel_x = -240
	pixel_x = -32

	plane = MASSIVE_OBJ_PLANE
	plane = ABOVE_LIGHTING_PLANE
	appearance_flags = LONG_GLIDE
