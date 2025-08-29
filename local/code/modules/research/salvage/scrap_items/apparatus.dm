/obj/item/scrap/apparatus
	icon_state = "apparatus"
	name = "apparatus"
	desc = "Perfectly safe to handle; though it looks like it was once hot." // I'm sorry; I had to shoehorn it
	force = 5
	pickup_sound = 'sound/items/handling/materials/metal_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'
	attack_verb_continuous = list("smacks", "bonks", "whacks")
	attack_verb_simple = list("smack", "bonk", "whack")

/obj/item/scrap/apparatus/randomize_credit_cost()
	return 80 // Static value

/obj/item/scrap/apparatus/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_unwielded = 5, force_wielded = 5)
	set_light(4, 1.75, "#FFD800")

/obj/item/scrap/apparatus/afterattack(atom/target, mob/user, params)
	if(isliving(target))
		damtype = pick(BRUTE, TOX)
	switch(damtype)
		if(BRUTE)
			hitsound = 'sound/items/weapons/genhit1.ogg'
			attack_verb_continuous = string_list(list("smacks", "bonks", "whacks"))
			attack_verb_simple = string_list(list("smack", "bonk", "whack"))
		if(TOX)
			hitsound = 'sound/items/geiger/ext1.ogg'
			attack_verb_continuous = string_list(list("radiates", "doses"))
			attack_verb_simple = string_list(list("radiate", "dose"))
