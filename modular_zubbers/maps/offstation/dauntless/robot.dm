/obj/item/borg/upgrade/syndicate_access
	name = "Syndicate cyborg access override"
	desc = "Makes any model of cyborg appear as a syndicate cyborg to syndicate targetting systems, additionally giving them access to syndicate airlocks. \
	\n\nFOR OPERATIVES: Handle with extreme care to prevent rogue cyborgs on your designated ship/station"

	// It is not module specific
	one_use = TRUE

/obj/item/borg/upgrade/syndicate_access/action(mob/living/silicon/robot/R, user)
	. = ..()
	// Turns out this is all you need for access to the doors. See code\game\machinery\_machinery.dm
	R.faction += ROLE_SYNDICATE
	to_chat(R, span_alert("Additional access detected! Remote camera interface destroyed."))
	to_chat(user, span_warning("The cyborg whirrs a bit as additional access levels are added, and the remote camera module shorts out a fuse."))
	// Remove the camera, much like how the camera is removed for ghost cafe cyborgs
	if(!QDELETED(R.builtInCamera))
		QDEL_NULL(R.builtInCamera)


/obj/item/borg/upgrade/syndicate_access/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	R.faction = initial(R.faction)

/obj/item/borg/upgrade/syndicate_access/dauntless/examine_more(mob/user)
	. = ..()
	. += span_notice("This one seems to include an Interdyne communication chip. How neat!")

/obj/item/borg/upgrade/syndicate_access/dauntless/action(mob/living/silicon/robot/R, user)
	. = ..()

	// Yes, this forces out and removes any other keys. Which it should, in this case.
	R.radio.keyslot = new /obj/item/encryptionkey/headset_syndicate/cybersun(src)
	R.radio.recalculateChannels()
