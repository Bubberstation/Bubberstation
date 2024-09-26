/datum/design/surgery/necrotic_revival
	name = "Changeling Zombie Revival"
	desc = "An experimental surgical procedure that stimulates the growth of a Changeling Zombie virus inside the patient's head. Requires zombie powder or rezadone."

/datum/surgery/advanced/necrotic_revival
	name = "Changeling Zombie Revival"
	desc = "An experimental surgical procedure that stimulates the growth of a Changeling Zombie virus inside the patient's head. Requires zombie powder or rezadone."
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/changeling_zombie,
		/datum/surgery_step/close,
	)

/datum/surgery_step/changeling_zombie
	name = "start changeling zombie growth (syringe)"
	implements = list(
		/obj/item/reagent_containers/syringe = 100,
		/obj/item/pen = 30
	)
	time = 50
	chems_needed = list(/datum/reagent/toxin/zombiepowder, /datum/reagent/medicine/rezadone)
	require_all_chems = FALSE

/datum/surgery_step/changeling_zombie/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)

	display_results(
		user,
		target,
		span_notice("You begin to stimulate growth on [target]'s brain..."),
		span_notice("[user] begins to tinker with [target]'s brain..."),
		span_notice("[user] begins to perform surgery on [target]'s brain."),
	)

	display_pain(target, "Your head pounds with unimaginable pain!") // Same message as other brain surgeries

/datum/surgery_step/changeling_zombie/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)

	display_results(
		user,
		target,
		span_notice("You succeed in stimulate growth in [target]'s brain."),
		span_notice("[user] successfully stimulates growth on [target]'s brain!"),
		span_notice("[user] completes the surgery on [target]'s brain."),
	)

	display_pain(target, "Your head goes totally numb for a moment, the pain is overwhelming!")

	target.AddComponent(/datum/component/changeling_zombie_infection)

	return ..()
