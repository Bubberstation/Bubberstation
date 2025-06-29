/datum/interaction/lewd/grindface
	name = "Grind Face"
	description = "Feet grind their face."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_FEET, INTERACTION_REQUIRE_TARGET_MOUTH)
	message = list(
		"grinds their %FEET% into %TARGET%'s face.",
		"presses their %FEET% down hard on %TARGET%'s face.",
		"rubs off the dirt from their %FEET% onto %TARGET%'s face.",
		"plants their %FEET% ontop of %TARGET%'s face.",
		"rests their %FEET% on %TARGET%'s face and presses down hard.",
		"harshly places their %FEET% atop %TARGET%'s face."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/foot_dry1.ogg',
		'modular_zzplurt/sound/interactions/foot_dry2.ogg',
		'modular_zzplurt/sound/interactions/foot_dry3.ogg',
		'modular_zzplurt/sound/interactions/foot_dry4.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 3
	target_arousal = 3

/datum/interaction/lewd/grindface/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/list/original_messages = message.Copy()
	// Get shoes or barefoot text
	var/obj/item/clothing/shoes/worn_shoes = user.get_item_by_slot(ITEM_SLOT_FEET)
	var/feet_text = worn_shoes?.name || pick("bare feet", "soles")

	var/chosen_message = pick(message)
	chosen_message = replacetext(chosen_message, "%FEET%", feet_text)
	message = list(chosen_message)
	. = ..()
	message = original_messages

/datum/interaction/lewd/grindmouth
	name = "Grind Mouth"
	description = "Feet grind their mouth."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_FEET, INTERACTION_REQUIRE_TARGET_MOUTH)
	message = list(
		"roughly shoves their %FEET% deeper into %TARGET%'s mouth.",
		"harshly forces another inch of their %FEET% into %TARGET%'s mouth.",
		"presses their weight down, their %FEET% prying deeper into %TARGET%'s mouth.",
		"forces their %FEET% deep into %TARGET%'s mouth.",
		"presses the tip of their %FEET% against %TARGET%'s lips and shoves inwards.",
		"readies themselves and in one swift motion, shoves their %FEET% into %TARGET%'s mouth."
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/foot_wet1.ogg',
		'modular_zzplurt/sound/interactions/foot_wet2.ogg',
		'modular_zzplurt/sound/interactions/foot_wet3.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 3
	target_arousal = 3

/datum/interaction/lewd/grindmouth/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/list/original_messages = message.Copy()
	var/obj/item/clothing/shoes/worn_shoes = user.get_item_by_slot(ITEM_SLOT_FEET)
	var/feet_text = worn_shoes?.name || pick("bare feet", "toes", "soles")

	var/chosen_message = pick(message)
	chosen_message = replacetext(chosen_message, "%FEET%", feet_text)
	message = list(chosen_message)
	. = ..()
	message = original_messages

/datum/interaction/lewd/footjob
	name = "Footjob"
	description = "Jerk them off with your foot."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_FEET)
	target_required_parts = list(ORGAN_SLOT_PENIS = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_PENIS)
	cum_target = list(CLIMAX_POSITION_TARGET = null)
	message = list(
		"jerks %TARGET% off with their %FEET%.",
		"rubs their %FEET% on %TARGET%'s shaft.",
		"works their %FEET% up and down on %TARGET%'s cock."
	)
	cum_message_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"cums all over %USER%'s %FEET%.",
			"covers %USER%'s %FEET% in cum.",
			"shoots their load onto %USER%'s %FEET%."
		)
	)
	cum_self_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"you cum all over %USER%'s %FEET%.",
			"you cover %USER%'s %FEET% in cum.",
			"you shoot your load onto %USER%'s %FEET%."
		)
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"%TARGET% cums all over your %FEET%.",
			"%TARGET% covers your %FEET% in cum.",
			"%TARGET% shoots their load onto your %FEET%."
		)
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/foot_dry1.ogg',
		'modular_zzplurt/sound/interactions/foot_dry3.ogg',
		'modular_zzplurt/sound/interactions/foot_wet1.ogg',
		'modular_zzplurt/sound/interactions/foot_wet2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	target_pleasure = 4
	user_pleasure = 0
	user_arousal = 3
	target_arousal = 6

/datum/interaction/lewd/footjob/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/list/original_messages = message.Copy()
	var/obj/item/clothing/shoes/worn_shoes = user.get_item_by_slot(ITEM_SLOT_FEET)
	var/feet_text = worn_shoes?.name || pick("foot", "sole")

	var/chosen_message = pick(message)
	chosen_message = replacetext(chosen_message, "%FEET%", feet_text)
	message = list(chosen_message)
	. = ..()
	message = original_messages

/datum/interaction/lewd/footjob/show_climax(mob/living/carbon/human/cumming, mob/living/carbon/human/came_in, position)
	var/obj/item/clothing/shoes/worn_shoes = cumming.get_item_by_slot(ITEM_SLOT_FEET)
	var/feet_text = worn_shoes?.name || pick("foot", "sole")

	// Store original lists, with null checks
	var/list/original_message_overrides = cum_message_text_overrides[position]
	var/list/original_self_overrides = cum_self_text_overrides[position]
	var/list/original_partner_overrides = cum_partner_text_overrides[position]
	original_message_overrides = original_message_overrides?.Copy()
	original_self_overrides = original_self_overrides?.Copy()
	original_partner_overrides = original_partner_overrides?.Copy()

	// Pick and modify one message from each list
	var/message_override = replacetext(pick(cum_message_text_overrides[position]), "%FEET%", feet_text)
	var/self_override = replacetext(pick(cum_self_text_overrides[position]), "%FEET%", feet_text)
	var/partner_override = replacetext(pick(cum_partner_text_overrides[position]), "%FEET%", feet_text)

	// Set single message lists
	cum_message_text_overrides[position] = list(message_override)
	cum_self_text_overrides[position] = list(self_override)
	cum_partner_text_overrides[position] = list(partner_override)

	. = ..()

	// Restore original lists
	cum_message_text_overrides[position] = original_message_overrides
	cum_self_text_overrides[position] = original_self_overrides
	cum_partner_text_overrides[position] = original_partner_overrides

/datum/interaction/lewd/footjob/double
	name = "Double Footjob"
	description = "Jerk them off with both of your feet."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_FEET)
	message = list(
		"jerks %TARGET% off with their %FEET%.",
		"rubs their %FEET% on %TARGET%'s shaft.",
		"works their %FEET% up and down on %TARGET%'s cock."
	)
	user_pleasure = 0
	target_pleasure = 5
	user_arousal = 4
	target_arousal = 7

/datum/interaction/lewd/footjob/double/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/list/original_messages = message.Copy()
	var/obj/item/clothing/shoes/worn_shoes = user.get_item_by_slot(ITEM_SLOT_FEET)
	var/feet_text = worn_shoes?.name || "feet"

	var/chosen_message = pick(message)
	chosen_message = replacetext(chosen_message, "%FEET%", feet_text)
	message = list(chosen_message)
	. = ..()
	message = original_messages

/datum/interaction/lewd/footjob/vagina
	name = "Vaginal Footjob"
	description = "Rub their vagina with your foot."
	target_required_parts = list(ORGAN_SLOT_VAGINA = REQUIRE_GENITAL_EXPOSED)
	cum_genital = list(CLIMAX_POSITION_TARGET = CLIMAX_VAGINA)
	cum_target = list(CLIMAX_POSITION_TARGET = null)
	message = list(
		"rubs %TARGET%'s clit with their %FEET%.",
		"rubs their %FEET% on %TARGET%'s coochie.",
		"rubs their %FEET% on %TARGET%'s pussy.",
		"rubs their foot up and down on %TARGET%'s pussy."
	)
	cum_message_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"squirts all over %USER%'s %FEET%.",
			"orgasms on %USER%'s %FEET%.",
			"coats %USER%'s %FEET% with their juices."
		)
	)
	cum_self_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"you squirt all over %USER%'s %FEET%.",
			"you orgasm on %USER%'s %FEET%.",
			"you coat %USER%'s %FEET% with your juices."
		)
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"%TARGET% squirts all over your %FEET%.",
			"%TARGET% orgasms on your %FEET%.",
			"%TARGET% coats your %FEET% with their juices."
		)
	)
	sound_possible = list(
		'modular_zzplurt/sound/interactions/foot_dry1.ogg',
		'modular_zzplurt/sound/interactions/foot_dry3.ogg',
		'modular_zzplurt/sound/interactions/foot_wet1.ogg',
		'modular_zzplurt/sound/interactions/foot_wet2.ogg'
	)
	sound_range = 1
	sound_use = TRUE
	user_pleasure = 4
	target_pleasure = 0
	user_arousal = 6
	target_arousal = 2
