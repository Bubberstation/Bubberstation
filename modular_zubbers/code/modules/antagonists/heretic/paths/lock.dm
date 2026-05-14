/obj/item/heretic_labyrinth_handbook/examine(mob/user)
	. = ..()

	. += span_notice("Can be used to generate impenetrable barriers. Lasts for 8 seconds, 5 charges at a time.")

/datum/heretic_knowledge_tree_column/lock
	description = list(
		"The Path of Lock revolves around access, area denial, theft and gadgets.",
		"Pick this path if you are new to heretic, or want a less confrontational playstyle and more interested in being a slippery rat.",
	)

/obj/effect/lock_portal/Initialize(mapload, target, invert = FALSE)
	. = ..()

	RegisterSignal(src, COMSIG_ATOM_HOLYATTACK, PROC_REF(on_holy_attack))

/obj/effect/lock_portal/examine(mob/user)
	. = ..()

	. += span_notice("If a non-acolyte walks through the door, they will be teleported somewhere random. Acolytes, however, will be teleported to a second portal somewhere else.")
	. += span_notice("Can be removed with antimagic weaponry (holymelons/nullrods) or by removing the airlock.")

/obj/effect/lock_portal/proc/on_holy_attack(datum/source, obj/item/weapon)
	SIGNAL_HANDLER

	visible_message(span_warning("[weapon] dispels [src]!"))
	qdel(src)

/datum/status_effect/caretaker_refuge
	duration = 60 SECONDS

/datum/action/cooldown/spell/caretaker
	name = "Caretaker's Last Refuge"
	desc = "Shifts you into the Caretaker's Refuge, rendering you translucent and intangible. \
		While in the Refuge your movement is unrestricted, but you cannot use your hands or cast any spells. \
		You cannot enter the Refuge while near other sentient beings, \
		and you can be removed from it upon contact with antimagical artifacts. \
		Lasts for one minute."
