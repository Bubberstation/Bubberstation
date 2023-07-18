GLOBAL_LIST_INIT(KNITABLES, typecacheof(list(
	/obj/item/clothing/head/beret/knitted,
	/obj/item/clothing/suit/costume/ianshirt,
	/obj/item/clothing/suit/toggle/jacket/sweater,
	/obj/item/clothing/suit/costume/ghost_sheet,
	/obj/item/clothing/neck/scarf/knitted,
	/obj/item/clothing/head/beanie/knitted,
	/obj/item/clothing/gloves/color/grey/protects_cold,
	/obj/item/clothing/suit/hooded/wintercoat/skyrat,
	/obj/item/clothing/neck/mantle,
	/obj/item/clothing/accessory/armband/knitted,
	/obj/item/clothing/under/misc/pj,)))//When adding more, make sure the thumbnails work!

/obj/item/knittingneedles
	name = "knitting needles"
	desc = "Silver knitting needles used for stitching yarn."
	icon = 'knitting.dmi'
	inhand_icon_state = "knittingneedles"
	lefthand_file = "knittingneedles_lh"
	righthand_file = "knittingneedles_rh"
	belt_icon_state = "knittingneedles"
	icon_state = "knittingneedles"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb_continuous = list("stabs")
	attack_verb_simple = list("stab")
	sharpness = SHARP_POINTY

	var/working = FALSE
	var/obj/item/yarn/ball
	var/list/name2knit

/obj/item/knittingneedles/verb/remove_yarn()
	set name = "Remove Yarn"
	set category = "Object"
	set src in usr

	if(!ball)
		to_chat(usr, span_warning("There is no yarn on \the [src]!"))
		return

	if(working == TRUE)
		to_chat(usr, span_warning("You can't remove \the [ball] while using \the [src]!"))
		return

	var/mob/living/carbon/human/H = usr

	H.put_in_hands(ball)
	ball = null
	to_chat(usr, span_warning("You remove \the [ball] from \the [src]."))

/obj/item/knittingneedles/Destroy()
	if(ball)
		QDEL_NULL(ball)
	return ..()

/obj/item/knittingneedles/examine(mob/user)
	if(..(user, 1))
		if(ball)
			to_chat(user, "There is \the [ball] between the needles.")

	if(ball)
		var/mutable_appearance/yarn_overlay = mutable_appearance(icon, "[ball.icon_state]")
		if(ball.color)
			yarn_overlay.color = ball.color
		else
			yarn_overlay.appearance_flags = RESET_COLOR
		add_overlay(yarn_overlay)
	else
		cut_overlays()

/obj/item/knittingneedles/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/yarn))
		if(!ball)
			O.forceMove(src)
			ball = O
			to_chat(user, span_notice("You place \the [O] in \the [src]"))
		return TRUE

/obj/item/knittingneedles/attack_self(mob/user as mob)
	if(!ball) //if there is no yarn ball, nothing happens
		to_chat(user, span_warning("You need a yarn ball to stitch."))
		return

	if(working)
		to_chat(user, span_warning("You are already sitching something."))
		return

	if (!name2knit)
		name2knit = list()
		for(var/obj/thing as anything in GLOB.KNITABLES)
			name2knit[initial(thing.name)] = thing

	var/list/options = list()
	for (var/obj/item/clothing/i as anything in GLOB.KNITABLES)
		var/image/radial_button = image(icon = initial(i.icon), icon_state = initial(i.icon_state))
		options[initial(i.name)] = radial_button
	var/knit_name = show_radial_menu(user, user, options, radius = 42, tooltips = TRUE)
	if(!knit_name)
		return
	var/type_path = name2knit[knit_name]

	user.visible_message("<b>[user]</b> begins knitting something soft and cozy.")
	working = TRUE

	if(!do_after(user,2 MINUTES))
		to_chat(user, span_warning("Your concentration is broken!"))
		working = FALSE
		return

	var/obj/item/clothing/S = new type_path(get_turf(user))
	user.put_in_hands(S)
	S.color = ball.color
	qdel(ball)
	ball = null
	working = FALSE
	user.visible_message("<b>[user]</b> finishes working on \the [S].")



/obj/item/knittingneedles/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] stabs their [src] into [user.p_their()] [pick("temple", "heart")]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS


/obj/item/yarn
	name = "ball of yarn"
	desc = "A ball of yarn, this one is white."
	icon = 'knitting.dmi'
	icon_state = "white_ball"
	w_class = WEIGHT_CLASS_TINY

/obj/item/yarn/red
	desc = "A ball of yarn, this one is red."
	icon_state = "red_ball"
	color = "#a03a53"

/obj/item/yarn/blue
	desc = "A ball of yarn, this one is blue."
	icon_state = "blue_ball"
	color = "#3a5591"

/obj/item/yarn/green
	desc = "A ball of yarn, this one is green."
	icon_state = "green_ball"
	color = "#69a03c"

/obj/item/yarn/purple
	desc = "A ball of yarn, this one is purple."
	icon_state = "purple_ball"
	color = "#533079"

/obj/item/yarn/yellow
	desc = "A ball of yarn, this one is yellow."
	icon_state = "yellow_ball"
	color = "#f0bd77"

/obj/item/storage/box/knitting //a bunch of things, so it goes into the box
	name = "knitting supplies"

/obj/item/storage/box/knitting/PopulateContents()
	new /obj/item/knittingneedles(src)
	new /obj/item/yarn(src)
	new /obj/item/yarn/red(src)
	new /obj/item/yarn/blue(src)
	new /obj/item/yarn/green(src)
	new /obj/item/yarn/purple(src)
	new /obj/item/yarn/yellow(src)

/obj/item/storage/box/yarn
	name = "yarn box"

/obj/item/storage/box/yarn/PopulateContents()
	new /obj/item/yarn(src)
	new /obj/item/yarn/red(src)
	new /obj/item/yarn/blue(src)
	new /obj/item/yarn/green(src)
	new /obj/item/yarn/purple(src)
	new /obj/item/yarn/yellow(src)

/datum/supply_pack/knittingsupplies
	name = "Knitting Supplies"
	desc = "A crate full of knitting supplies. You'd have to be planning some serious knitting to want this. Contains three boxes of yarn and two pairs of knitting needles."
	group = "Miscellaneous Supplies"
	cost = CARGO_CRATE_VALUE * 1.8
	contains = list(/obj/item/storage/box/yarn,
	/obj/item/storage/box/yarn,
	/obj/item/storage/box/yarn,
	/obj/item/knittingneedles,
	/obj/item/knittingneedles)
	crate_name = "Knitting Supplies"
	crate_type = /obj/structure/closet/crate/wooden
//https://github.com/Aurorastation/Aurora.3/pull/4749 is the main originator of the art from what I can tell. If others are responsible, please alert me!
