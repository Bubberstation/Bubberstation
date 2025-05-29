/obj/item/implant/docile
	name = "docility implant"
	activated = FALSE
	/// What fatness level does the target need to be for the implant to work?
	var/required_fatness = FATNESS_LEVEL_BLOB
	/// What traits do we want to give the implanted mob?
	var/list/traits_list = list(
		TRAIT_WEIGHT_LOSS_IMMUNE,
		TRAIT_PACIFISM,
		TRAIT_CLUMSY,
		TRAIT_FAT_GOOD,
		TRAIT_HEAVY_SLEEPER,
		TRAIT_DOCILE,
	)

/obj/item/implant/docile/can_be_implanted_in(mob/living/target)
	var/mob/living/carbon/human/target_human = target
	if(!istype(target_human) || (target_human.fatness_real < required_fatness))
		return FALSE

	if(HAS_TRAIT(target_human, TRAIT_DOCILE))
		return FALSE //They probably already have an implant, they likely don't need this.

	return target?.client?.prefs?.fatness_vulnerable

/obj/item/implant/docile/implant(mob/living/target, mob/user, silent = FALSE)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/target_human = target
	if(!istype(target_human))
		return

	for(var/trait in traits_list)
		ADD_TRAIT(target, trait, src)

	target_human.nutri_mult += 1
	return TRUE

/obj/item/implant/docile/removed(mob/living/source, silent = FALSE, special = 0)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/target_human = source
	if(!istype(target_human))
		return

	for(var/trait in traits_list)
		REMOVE_TRAIT(target_human, trait, src)

	target_human.nutri_mult -= 1
	return TRUE


/obj/item/implant/docile/livestock
	name = "livestock implant"
	traits_list = list(
		TRAIT_WEIGHT_LOSS_IMMUNE,
		TRAIT_PACIFISM,
		TRAIT_CLUMSY,
		TRAIT_FAT_GOOD,
		TRAIT_HEAVY_SLEEPER,
		TRAIT_DOCILE,
		TRAIT_LIVESTOCK,
		TRAIT_NO_MISC,
		TRAIT_NORUNNING,
		TRAIT_MILKY,
	)
	/// What is the name of the mob before we change it?
	var/stored_name = ""
	/// What name do we want to give the mob before adding the randomized number
	var/name_to_give = "Livestock"
	/// How much do we want to modifiy the productivity stats of the mob's current sex organs by?
	var/productivity_mult = 4

/obj/item/implant/docile/livestock/justfat //gs13 - for admin fuckery
	name = "hacked livestock implant"
	required_fatness = 0
	traits_list = list(
		TRAIT_WEIGHT_LOSS_IMMUNE,
		TRAIT_PACIFISM,
		TRAIT_CLUMSY,
		TRAIT_FAT_GOOD,
		TRAIT_HEAVY_SLEEPER,
		TRAIT_DOCILE,
		TRAIT_LIVESTOCK,
		TRAIT_NO_MISC,
		TRAIT_NORUNNING,
		TRAIT_MILKY,
	)


/obj/item/implant/docile/livestock/can_be_implanted_in(mob/living/target)
	. = ..()
	if(!.)
		return FALSE

	return target?.client?.prefs?.extreme_fatness_vulnerable

/obj/item/implant/docile/livestock/implant(mob/living/target, mob/user, silent)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/target_human = target
	stored_name = target_human.real_name
	var/new_name = "[name_to_give] ([rand(0,999)])"

	target_human.real_name = new_name
	target_human.name = new_name

	if(target_human?.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/balls = target_human?.getorganslot("testicles")
		balls.fluid_mult = balls.fluid_mult * productivity_mult
		balls.fluid_max_volume = balls.fluid_max_volume * productivity_mult

	if(target_human?.getorganslot(ORGAN_SLOT_BREASTS))
		var/obj/item/organ/genital/breasts/boobs = target_human?.getorganslot(ORGAN_SLOT_BREASTS)
		boobs.fluid_mult = boobs.fluid_mult * productivity_mult
		boobs.fluid_max_volume = boobs.fluid_max_volume * productivity_mult

/obj/item/implant/docile/livestock/removed(mob/living/source, silent, special)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/human/target_human = source
	target_human.real_name = stored_name
	target_human.name = stored_name

	if(target_human?.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/balls = target_human?.getorganslot("testicles")
		balls.fluid_mult = balls.fluid_mult / productivity_mult
		balls.fluid_max_volume = balls.fluid_max_volume / productivity_mult

	if(target_human?.getorganslot(ORGAN_SLOT_BREASTS))
		var/obj/item/organ/genital/breasts/boobs = target_human?.getorganslot(ORGAN_SLOT_BREASTS)
		boobs.fluid_mult = boobs.fluid_mult / productivity_mult
		boobs.fluid_max_volume = boobs.fluid_max_volume / productivity_mult

/obj/item/implantcase/docile
	name = "implant case - 'Docility'"
	desc = "A glass case containing a docility implant. Used to make those at high weights docile."
	imp_type = /obj/item/implant/docile

/obj/item/implantcase/docile/livestock
	name = "implant case - 'Livestock'"
	desc = "A glass case containing a livestock implant. Functions similar to the docility implant, but changes the implantee's name and makes them even more helpless. cannot be combined with the docility implant."
	imp_type = /obj/item/implant/docile/livestock

/obj/item/implantcase/docile/livestock/justfat
	name = "implant case - 'Livestock - hacked ver'"
	desc = "A glass case containing a livestock implant. Functions similar to the docility implant, but changes the implantee's name and makes them even more helpless. cannot be combined with the docility implant. This one seems to apply to people who are just fat, rather than immobile."
	imp_type = /obj/item/implant/docile/livestock/justfat


//gs13 - techweb designs
/datum/design/docility_implant //currently in nutri tech tools
	name = "Docility Implant"
	id = "docility_implant"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1500, /datum/material/calorite = 1500, /datum/material/silver = 1500)
	build_path = /obj/item/implantcase/docile
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY

/datum/design/livestock_implant //currently in illegal tech web node
	name = "Livestock Implant"
	id = "livestock_implant"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 3000, /datum/material/calorite = 3000, /datum/material/silver = 1500)
	build_path = /obj/item/implantcase/docile/livestock
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY
