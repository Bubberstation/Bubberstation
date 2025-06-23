/datum/surgery/cavity_implant/mechanic //new surgery path for augments and synths so they can have cavity implants.
	name = "Robotic cavity implant"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/handle_cavity,
		/datum/surgery_step/close_cavity,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close)

/datum/surgery_step/close_cavity  //new surgery step used solely for the mechanical variant. Used to seal the cavity so the surgery can progress to the proper surgery end point for synthetics.
	name = "solder  cavity (cautery or welder)"
	implements = list(
		TOOL_CAUTERY = 100,
		/obj/item/gun/energy/laser = 90,
		TOOL_WELDER = 100,
		/obj/item = 30) // 30% success with any hot item.
	time = 24
	preop_sound = 'sound/items/handling/surgery/cautery1.ogg'
	success_sound = 'sound/items/handling/surgery/cautery2.ogg'

/datum/surgery_step/close_cavity/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to solder the electronics around [target]'s cavity..."),
		span_notice("[user] begins to solder [target]'s internal cavity with [tool]!"),
		span_notice("[user] begins to solder [target]'s internal cavity!"),
	)
	display_pain(target, "The pain in your chest is unbearable! You can barely take it anymore!")
