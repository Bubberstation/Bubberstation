/datum/uplink_item/species_restricted/lycan_booster
	name = "Lycanthropy Booster"
	desc = "A highly advanced mix of nanomachines and general 'bad vibes' that will significantly boost the combat performance of your \
	Lycan form, granting significant damage resistance, baton resistance, regeneration, and further sharpening your claws. Additionally grants you expert fitness."
	cost = 15
	item = /obj/item/lycan_booster
	restricted_species = list(SPECIES_CURSEKIN)
	surplus = 0

/obj/item/lycan_booster
	name = "lycanthropy booster"
	desc = "A highly advanced mix of nanomachines and general 'bad vibes' that will significantly boost the combat performance of your \
	Lycan form, granting significant damage resistance, baton resistance, regeneration, and further sharpening your claws, along other improvements. \
	Additionally grants you expert fitness."
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "dnainjector"
	inhand_icon_state = "dnainjector"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY

/obj/item/lycan_booster/attack_self(mob/user, modifiers)
	. = ..()

	if (!ishuman(user))
		return

	var/mob/living/carbon/human/human_user = user

	if (!istype(human_user.dna?.species, /datum/species/human/cursekin))
		to_chat(human_user, span_warning("You get the feeling your current physiology wouldn't support this booster."))
		return

	ADD_TRAIT(human_user, TRAIT_GAIAN_PHYSIQUE, SPECIES_TRAIT)

	balloon_alert(human_user, "lycan form boosted")
	to_chat(human_user, span_bolddanger("As you inject yourself with the serum, you begin to feel more in tune with your lycan curse than ever before. Your claws sharpen, your teeth lengthen..."))
	to_chat(human_user, span_boldnotice("Your lycan form is now resistant to damage, batons, and immune to damage slowdown. Additionally, your unarmed attacks are far deadlier, and ridiculously strong on grabbed opponents. Consider finding gripper gloves."))
	human_user.emote("growl")

	human_user.mind?.adjust_experience(/datum/skill/athletics, SKILL_EXP_MASTER, FALSE)

	qdel(src)
