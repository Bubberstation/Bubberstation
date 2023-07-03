
/obj/item/sign/set_sign_type(obj/structure/sign/fake_type)
	. = ..()
	icon = initial(fake_type.icon)

/obj/structure/sign/flag/pride
	name = "flag of Gay Pride"
	desc = "The flag of Gay Pride. Hang that rainbow up with pride!"
	icon = 'modular_zubbers/maps/biodome/pride_flags.dmi'
	icon_state = "flag_pride"
	is_editable = TRUE
	sign_change_name = "Pride Flag - Rainbow"

/obj/structure/sign/flag/pride/ace
	name = "flag of Asexual Pride"
	desc = "The flag of Asexual Pride."
	icon_state = "flag_ace"
	sign_change_name = "Pride Flag - Asexual"

/obj/structure/sign/flag/pride/bi
	name = "flag of Bisexual Pride"
	desc = "The flag of Bisexual Pride."
	icon_state = "flag_bi"
	sign_change_name = "Pride Flag - Bisexual"

/obj/structure/sign/flag/pride/lesbian
	name = "flag of Lesbian Pride"
	desc = "The flag of Lesbian Pride."
	icon_state = "flag_lesbian"
	sign_change_name = "Pride Flag - Lesbian"

/obj/structure/sign/flag/pride/pan
	name = "flag of Pansexual Pride"
	desc = "The flag of Pansexual Pride."
	icon_state = "flag_pan"
	sign_change_name = "Pride Flag - Pansexual"

/obj/structure/sign/flag/pride/trans
	name = "flag of Transgender Pride"
	desc = "The flag of Transgender Pride."
	icon_state = "flag_trans"
	sign_change_name = "Pride Flag - Transgender"

