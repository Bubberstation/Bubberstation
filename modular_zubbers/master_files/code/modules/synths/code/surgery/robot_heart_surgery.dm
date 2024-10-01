/datum/surgery_step/hydraulic/repair
	name = "tighten seals (screwdriver or wrench)"
	implements = list(
		TOOL_SCREWDRIVER = 90,
		TOOL_WRENCH = 90,
		TOOL_WIRECUTTER = 35,
		/obj/item/stack/package_wrap = 15,
		TOOL_SCALPEL = 45,
	)
	preop_sound = 'sound/items/ratchet_slow.ogg'
	success_sound = 'sound/machines/doorclick.ogg'
