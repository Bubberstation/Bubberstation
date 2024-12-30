/obj/item/razor
	var/extended = 1

/obj/item/razor/straightrazor
	name = "straight razor"
	icon = 'modular_zzplurt/icons/obj/items_and_weapons.dmi'
	icon_state = "straightrazor"
	desc = "An incredibly sharp razor used to shave chins, make surgical incisions, and slit the throats of unpaying customers"
	obj_flags = CONDUCTS_ELECTRICITY
	force = 3
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 6
	hitsound = 'sound/items/weapons/genhit.ogg'
	attack_verb_simple = list("stubb", "poke")
	attack_verb_continuous = list("stubbs", "pokes")
	extended = 0
	var/extended_force = 17 //I decided to not add bleeding but because of that, but increased damage, wounds will kill the guy pretty quickly anyways
	var/extended_throwforce = 10
	var/extended_icon_state = "straightrazor_open"

/obj/item/razor/straightrazor/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is slitting [user.p_their()] own throat with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)

/obj/item/razor/straightrazor/attack_self(mob/user)
	extended = !extended
	playsound(src.loc, 'sound/items/weapons/batonextend.ogg', 50, 1)
	if(extended)
		force = extended_force
		w_class = WEIGHT_CLASS_SMALL //if it becomes normal you can decapitate a guy with a straight razor
		throwforce = extended_throwforce
		icon_state = extended_icon_state
		attack_verb_simple = list("slash", "stabb", "slice", "slit", "shave", "dice", "cut")
		attack_verb_continuous = list("slashes", "stabbs", "slices", "slits", "shaves", "dices", "cuts")
		hitsound = 'sound/items/weapons/bladeslice.ogg'
		sharpness = SHARP_EDGED
		tool_behaviour = TOOL_SCALPEL
	else
		force = initial(force)
		w_class = WEIGHT_CLASS_TINY
		throwforce = initial(throwforce)
		icon_state = initial(icon_state)
		attack_verb_simple = list("stubb", "poke")
		attack_verb_continuous = list("stubbs", "pokes")
		hitsound = 'sound/items/weapons/genhit.ogg'
		sharpness = null
		tool_behaviour = null
