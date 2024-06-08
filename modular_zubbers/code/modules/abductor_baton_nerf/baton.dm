/obj/item/melee/baton/abductor
	sleep_time = 30 SECONDS
	time_to_cuff = 5 SECONDS
	knockdown_time = 4 SECONDS

/datum/action/cooldown/spell/summonitem/abductor
	name =  "Baton Recall"
	desc = "Activating this will trigger your baton's emergency translocation protocol, \
		recalling it to your hand. Takes a long time for the translocation crystals to reset after use. \
		Only works when you're on your ship!"

/datum/action/cooldown/spell/summonitem/abductor/try_recall_item(mob/living/caster)

	var/area/A = get_area(caster)

	if(!istype(A,/area/centcom/abductor_ship))
		to_chat(caster,span_warning("You can't use this here! You must be on your ship to recall your baton!"))
		return

	. = ..()
