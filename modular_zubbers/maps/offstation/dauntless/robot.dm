/obj/item/borg/upgrade/dauntless
	name = "Syndicate cyborg access override"
	desc = "Makes any model of cyborg appear as a syndicate cyborg to syndicate targetting systems, additionally giving them access to syndicate airlocks. \
	\n\nFOR OPERATIVES: Handle with extreme care to prevent rogue cyborgs on your designated ship/station"

	// It is not module specific
	one_use = TRUE

/obj/item/borg/upgrade/dauntless/action(mob/living/silicon/robot/R, user)
	. = ..()
	// Turns out this is all you need for access to the doors. See code\game\machinery\_machinery.dm
	R.faction += ROLE_SYNDICATE
	to_chat(R, span_alert("Additional access detected!"))
	to_chat(user, span_warning("The cyborg whirrs a bit as additional access levels are added."))


/obj/item/borg/upgrade/dauntless/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	R.faction = initial(R.faction)
