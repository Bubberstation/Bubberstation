/datum/surgery/robot/lipoplasty
	name = "Nutrient Reserve Expulsion"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/cut_fat/mechanic,
		/datum/surgery_step/remove_fat/mechanic,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)

/datum/surgery/robot/lipoplasty/can_start(mob/user, mob/living/carbon/target)
	if(!HAS_TRAIT_FROM(target, TRAIT_FAT, OBESITY) || target.nutrition < NUTRITION_LEVEL_WELL_FED)
		return FALSE
	return ..()

/datum/surgery_step/cut_fat/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to open [target]'s fat containers..."),
		span_notice("[user] begin to open [target]'s fat containers."),
		span_notice("[user] begins to open [target]'s [target_zone] with [tool]."),
	)

/datum/surgery_step/cut_fat/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	display_results(
		user,
		target,
		span_notice("You open [target]'s fat containers."),
		span_notice("[user] opens [target]'s fat containers!"),
		span_notice("[user] finishes opening [target]'s [target_zone]."),
	)
	return TRUE

/datum/surgery_step/remove_fat/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to expel [target]'s loose fat..."),
		span_notice("[user] begins to exepel [target]'s loose fat!"),
		span_notice("[user] begins to expel something from [target]'s [target_zone]."),
	)

/datum/surgery_step/remove_fat/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You expel [target]'s fat."),
		span_notice("[user] expel [target]'s fat!"),
		span_notice("[user] expel [target]'s fat!"),
	)
	target.overeatduration = 0 //patient is unfatted
	var/removednutriment = target.nutrition
	target.set_nutrition(NUTRITION_LEVEL_WELL_FED)
	removednutriment -= NUTRITION_LEVEL_WELL_FED //whatever was removed goes into the meat
	var/mob/living/carbon/human/human = target
	var/typeofmeat = /obj/item/food/meat/slab/human

	if(target.flags_1 & HOLOGRAM_1)
		typeofmeat = null
	else if(human.dna && human.dna.species)
		typeofmeat = human.dna.species.meat

	if(typeofmeat)
		var/obj/item/food/meat/slab/human/newmeat = new typeofmeat
		newmeat.name = "fatty meat"
		newmeat.desc = "Extremely fatty tissue taken from a patient."
		newmeat.subjectname = human.real_name
		newmeat.subjectjob = human.job
		newmeat.reagents.add_reagent (/datum/reagent/consumable/nutriment, (removednutriment / 15)) //To balance with nutriment_factor of nutriment
		newmeat.forceMove(target.loc)
	return ..()
