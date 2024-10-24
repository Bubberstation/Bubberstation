/obj/item/sbeacondrop/carrot
	name = "carrot phone"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "suspiciousphone"
	desc = "A cell phone with an in-coming call from someone simply labelled 'Lady Jab'. A small sticker on the back notes that any calls to French overlords will incur a 5 credit service charge."
	w_class = WEIGHT_CLASS_SMALL
	droptype = /obj/item/storage/backpack/satchel/bunnysatchel

/obj/item/sbeacondrop/carrot/attack_self(mob/user)
	if(user)
		to_chat(user, span_notice("Thank you for choosing the Jab TM for your clothing purchase!"))
		new droptype( user.loc )
		playsound(src, 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg', 100, TRUE, TRUE)
		qdel(src)
	return
