
/datum/component/tameable/try_tame(atom/source, obj/item/food, mob/living/attacker)
	. = ..()
	SEND_SIGNAL(source, COMSIG_MOB_TRY_TAME, food, attacker)
