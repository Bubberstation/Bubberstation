/obj/item/slimecross/regenerative/silver/core_effect(mob/living/target, mob/user)
	target.set_thirst(THIRST_LEVEL_THRESHOLD - 1)
	. = ..()
