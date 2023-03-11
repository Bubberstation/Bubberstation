#define OVERSIZED_SPEED_SLOWDOWN 0.5
#define OVERSIZED_HUNGER_MOD 1.5

// Before making any changes to oversized, please see the module's readme.md file

/datum/quirk/oversized
	name = "Oversized"
	desc = "You, for whatever reason, are FAR too tall, and will encounter some rough situations because of it."
	gain_text = span_notice("That airlock looks small...")
	lose_text = span_notice("Is it still the same size...?") //Lol
	medical_record_text = "Patient is abnormally tall."
	value = 0
	mob_trait = TRAIT_OVERSIZED
	icon = "expand-arrows-alt"
	veteran_only = TRUE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE

/datum/quirk/oversized/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = 2
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"] //Adjust runechat height
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_LARGE
	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_damage_low += OVERSIZED_HARM_DAMAGE_BONUS
		left_arm.unarmed_damage_high += OVERSIZED_HARM_DAMAGE_BONUS

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_damage_low += OVERSIZED_HARM_DAMAGE_BONUS
		right_arm.unarmed_damage_high += OVERSIZED_HARM_DAMAGE_BONUS

	human_holder.blood_volume_normal = BLOOD_VOLUME_OVERSIZED
	human_holder.physiology.hunger_mod *= OVERSIZED_HUNGER_MOD //50% hungrier
	var/speed_mod = human_holder.dna.species.speedmod + OVERSIZED_SPEED_SLOWDOWN
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown = speed_mod)
	var/obj/item/organ/internal/stomach/old_stomach = human_holder.getorganslot(ORGAN_SLOT_STOMACH)
	if(!(old_stomach.type == /obj/item/organ/internal/stomach))
		return
	old_stomach.Remove(human_holder, special = TRUE)
	qdel(old_stomach)
	var/obj/item/organ/internal/stomach/oversized/new_stomach = new //YOU LOOK HUGE, THAT MUST MEAN YOU HAVE HUGE GUTS! RIP AND TEAR YOUR HUGE GUTS!
	new_stomach.Insert(human_holder, special = TRUE)
	to_chat(human_holder, span_warning("You feel your massive stomach rumble!"))

/datum/quirk/oversized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = human_holder?.client?.prefs ?human_holder?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) : 1
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"]
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_HUMAN

	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_damage_low -= OVERSIZED_HARM_DAMAGE_BONUS
		left_arm.unarmed_damage_high -= OVERSIZED_HARM_DAMAGE_BONUS

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_damage_low -= OVERSIZED_HARM_DAMAGE_BONUS
		right_arm.unarmed_damage_high -= OVERSIZED_HARM_DAMAGE_BONUS

	human_holder.blood_volume_normal = BLOOD_VOLUME_NORMAL
	human_holder.physiology.hunger_mod /= OVERSIZED_HUNGER_MOD
	var/speedmod = human_holder.dna.species.speedmod
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)

#undef OVERSIZED_HUNGER_MOD
#undef OVERSIZED_SPEED_SLOWDOWN
