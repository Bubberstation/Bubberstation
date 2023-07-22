/obj/item/food/egg
	var/mob/living/egg_rper

/obj/item/food/egg/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] RPs as [src]!"))
	if(istype(user) && user.mind)
		egg_rper = new(src)
		egg_rper.real_name = name
		egg_rper.name = name
		egg_rper.set_stat(CONSCIOUS)
		user.mind.transfer_to(egg_rper)
	return BRUTELOSS


/obj/item/food/egg/Destroy()
	qdel(egg_rper)
	. = ..()
