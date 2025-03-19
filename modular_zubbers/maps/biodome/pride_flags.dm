
/obj/item/sign/set_sign_type(obj/structure/sign/fake_type)
	. = ..()
	icon = initial(fake_type.icon)


// HORIZONTAL

/obj/structure/sign/flag/pride
	name = "coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_zubbers/icons/maps/biodome/pride_flags.dmi'

/obj/structure/sign/flag/pride/gay
	name = "gay pride flag"
	desc = "The flag of gay pride."
	icon_state = "flag_pride"
	item_flag = /obj/item/sign/flag/pride/gay

/obj/structure/sign/flag/pride/gay/click_alt(mob/user)
	icon_state = "flag_pride_vertical"
	.=..()

/obj/structure/sign/flag/pride/ace
	name = "asexual pride flag"
	desc = "The flag of asexual pride."
	icon_state = "flag_ace"
	item_flag = /obj/item/sign/flag/pride/ace

/obj/structure/sign/flag/pride/ace/click_alt(mob/user)
	icon_state = "flag_ace_vertical"
	.=..()

/obj/structure/sign/flag/pride/bi
	name = "bisexual pride flag"
	desc = "The flag of bisexual pride."
	icon_state = "flag_bi"
	item_flag = /obj/item/sign/flag/pride/bi

/obj/structure/sign/flag/pride/bi/click_alt(mob/user)
	icon_state = "flag_bi_vertical"
	.=..()

/obj/structure/sign/flag/pride/lesbian
	name = "lesbian pride flag"
	desc = "The flag of lesbian pride."
	icon_state = "flag_lesbian"
	item_flag = /obj/item/sign/flag/pride/lesbian

/obj/structure/sign/flag/pride/lesbian/click_alt(mob/user)
	icon_state = "flag_lesbian_vertical"
	.=..()

/obj/structure/sign/flag/pride/pan
	name = "pansexual pride flag"
	desc = "The flag of pansexual pride."
	icon_state = "flag_pan"
	item_flag = /obj/item/sign/flag/pride/pan

/obj/structure/sign/flag/pride/pan/click_alt(mob/user)
	icon_state = "flag_pan_vertical"
	.=..()

/obj/structure/sign/flag/pride/trans
	name = "trans pride flag"
	desc = "The flag of trans pride."
	icon_state = "flag_trans"
	item_flag = /obj/item/sign/flag/pride/trans

/obj/structure/sign/flag/pride/trans/click_alt(mob/user)
	icon_state = "flag_trans_vertical"
	.=..()

// FOLDED

/obj/item/sign/flag/pride
	name = "folded coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_zubbers/icons/maps/biodome/pride_flags.dmi'

/obj/item/sign/flag/pride/gay
	name = "folded gay pride flag"
	desc = "The folded flag of gay pride."
	icon_state = "folded_pride"
	sign_path = /obj/structure/sign/flag/pride/gay

/obj/item/sign/flag/pride/ace
	name = "folded asexual pride flag"
	desc = "The folded flag of asexual pride."
	icon_state = "folded_pride_ace"
	sign_path = /obj/structure/sign/flag/pride/ace

/obj/item/sign/flag/pride/bi
	name = "folded bisexual pride flag"
	desc = "The folded flag of bisexual pride."
	icon_state = "folded_pride_bi"
	sign_path = /obj/structure/sign/flag/pride/bi

/obj/item/sign/flag/pride/lesbian
	name = "folded lesbian pride flag"
	desc = "The folded flag of lesbian pride."
	icon_state = "folded_pride_lesbian"
	sign_path = /obj/structure/sign/flag/pride/lesbian

/obj/item/sign/flag/pride/pan
	name = "folded pansexual pride flag"
	desc = "The folded flag of pansexual pride."
	icon_state = "folded_pride_pan"
	sign_path = /obj/structure/sign/flag/pride/pan

/obj/item/sign/flag/pride/trans
	name = "folded trans pride flag"
	desc = "The folded flag of trans pride."
	icon_state = "folded_pride_trans"
	sign_path = /obj/structure/sign/flag/pride/trans
