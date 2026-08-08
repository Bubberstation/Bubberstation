#define OVERSIZED_SPEED_SLOWDOWN 0.25
/// 50% hungrier
#define OVERSIZED_HUNGER_MOD 1.5

/datum/quirk/oversized
	name = "Oversized"
	desc = "You, for whatever reason, are FAR too tall, and will encounter some rough situations because of it."
	gain_text = span_notice("That airlock looks small...")
	lose_text = span_notice("Is it still the same size...?") //Lol
	medical_record_text = "Patient is abnormally tall."
	value = 0
	mob_trait = TRAIT_OVERSIZED
	icon = FA_ICON_EXPAND_ARROWS_ALT
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	/// The action that allows seeing yourself at normal size
	var/datum/action/oversized_self_view/self_view_action

/datum/quirk/oversized/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.update_transform(2 * RESIZE_DEFAULT_SIZE / human_holder.current_size)
	human_holder.maxHealth = HUMAN_MAXHEALTH * OVERSIZED_HEALTH_BUFF
	human_holder.health += ((HUMAN_MAXHEALTH * OVERSIZED_HEALTH_BUFF) - HUMAN_MAXHEALTH)

	RegisterSignal(human_holder, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(on_gain_limb)) // make sure we handle this when new ones are applied

	// just dummy call our current limbs to have less duplication (by having more duplication ahueheu)
	for(var/obj/item/bodypart/bodypart as anything in human_holder.bodyparts)
		on_gain_limb(src, bodypart, special = FALSE)

	human_holder.blood_volume_normal = BLOOD_VOLUME_OVERSIZED
	human_holder.physiology.hunger_mod *= OVERSIZED_HUNGER_MOD
	human_holder.add_movespeed_modifier(/datum/movespeed_modifier/oversized)
	var/obj/item/organ/stomach/stomach = human_holder.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(stomach)
		stomach.maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
		stomach.metabolism_efficiency = 0.07

	// Grant the self-view action
	self_view_action = new(human_holder)
	self_view_action.Grant(human_holder)

/datum/quirk/oversized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/body_size = human_holder.client?.prefs?.read_preference(/datum/preference/numeric/body_size)
	if(body_size && body_size != RESIZE_DEFAULT_SIZE)
		human_holder.update_transform(RESIZE_DEFAULT_SIZE / body_size)
	else
		human_holder.update_transform(RESIZE_DEFAULT_SIZE / human_holder.current_size)
	human_holder.maxHealth = HUMAN_MAXHEALTH
	human_holder.health -= ((HUMAN_MAXHEALTH * OVERSIZED_HEALTH_BUFF) - HUMAN_MAXHEALTH)

	var/obj/item/organ/stomach/stomach = human_holder.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(stomach)
		stomach.maxHealth = STANDARD_ORGAN_THRESHOLD / 1.5
		stomach.metabolism_efficiency = initial(stomach.metabolism_efficiency)

	for(var/obj/item/bodypart/arm/arm in human_holder.get_bodyparts())
		arm.unarmed_damage_high = initial(arm.unarmed_damage_high)

	for(var/obj/item/bodypart/leg/leg in human_holder.get_bodyparts())
		leg.unarmed_effectiveness = initial(leg.unarmed_effectiveness)

	for(var/obj/item/bodypart/bodypart as anything in human_holder.bodyparts)
		bodypart.name = replacetext(bodypart.name, "oversized ", "")

	UnregisterSignal(human_holder, COMSIG_CARBON_POST_ATTACH_LIMB)

	human_holder.blood_volume_normal = BLOOD_VOLUME_NORMAL
	human_holder.physiology.hunger_mod /= OVERSIZED_HUNGER_MOD
	human_holder.remove_movespeed_modifier(/datum/movespeed_modifier/oversized)

	// Remove the self-view action
	if(self_view_action)
		self_view_action.Remove(human_holder)
		QDEL_NULL(self_view_action)

/datum/quirk/oversized/proc/on_gain_limb(datum/source, obj/item/bodypart/gained, special)
	SIGNAL_HANDLER

	if(findtext(gained.name, "oversized"))
		return

	// Oversized arms have a higher damage maximum. Pretty simple.
	if(istype(gained, /obj/item/bodypart/arm))
		var/obj/item/bodypart/arm/new_arm = gained
		new_arm.unarmed_damage_high = initial(new_arm.unarmed_damage_high) + OVERSIZED_HARM_DAMAGE_BONUS

	// This brings their unarmed_effectiveness up to 20 from 15, which is on par with mushroom legs.
	else if(istype(gained, /obj/item/bodypart/leg))
		var/obj/item/bodypart/leg/new_leg = gained
		new_leg.unarmed_effectiveness = initial(new_leg.unarmed_effectiveness) + OVERSIZED_KICK_EFFECTIVENESS_BONUS

	gained.name = "oversized " + gained.name

/datum/movespeed_modifier/oversized
	multiplicative_slowdown = OVERSIZED_SPEED_SLOWDOWN

#undef OVERSIZED_HUNGER_MOD
#undef OVERSIZED_SPEED_SLOWDOWN
