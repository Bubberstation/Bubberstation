/obj/item/clothing/suit/hooded/cultrobes/eldritch/moon
	damage_modifier = 1.2

/obj/projectile/moon_parade
	range = 40

/obj/item/clothing/neck/heretic_focus/moon_amulet/examine(mob/user)
	. = ..()

	. += span_notice("Increases moon Acolyte brain regeneration. Can afflict targets with Moon Insanity, driving them into a blind rage.")
