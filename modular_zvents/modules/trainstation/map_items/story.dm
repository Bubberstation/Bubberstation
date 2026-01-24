/obj/item/keycard/important/trainstation
	color = COLOR_GOLD

/obj/item/keycard/important/trainstation/lab_key
	name = "Lab Keycard"
	desc = "A keycard granting access to the laboratory."



/obj/structure/prop/big/bigdice/radiosphere
	name = "\imporer The Radiosphere"
	desc = "A massive array of sensors and signal amplifiers enclosed in a \
			shell resembling a symmetrical octahedron. A faint noise emanates from this object."
	density = TRUE
	uses_integrity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/structure/prop/big/bigdice/radiosphere/Initialize(mapload)
	. = ..()
	var/matrix/M = matrix()
	M.Scale(8, 8)
	transform = M
	pixel_x = -128
	pixel_y = -128
