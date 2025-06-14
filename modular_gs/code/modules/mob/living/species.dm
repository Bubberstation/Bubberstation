
/mob/living/carbon/human/proc/update_body_size(mob/living/carbon/human/H, size_change)
	if(!istype(H))
		return

/*
	var/obj/item/organ/genital/butt/butt = H.getorganslot(ORGAN_SLOT_BUTT)
	var/obj/item/organ/genital/belly/belly = H.getorganslot(ORGAN_SLOT_BELLY)
	var/obj/item/organ/genital/breasts/breasts = H.getorganslot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/genital/taur_belly/tbelly = H.getorganslot(ORGAN_SLOT_TAUR_BELLY)

	if(butt)
		if(butt.max_size > 0)
			if((butt.size + size_change) <= butt.max_size)
				butt.modify_size(size_change)
		else
			butt.modify_size(size_change)
	if(belly)
		if(belly.max_size > 0)
			if((belly.size + size_change) <= belly.max_size)
				belly.modify_size(size_change)
		else
			belly.modify_size(size_change)
	if(tbelly)
		if(tbelly.max_size > 0)
			if((tbelly.size + size_change) <= tbelly.max_size)
				tbelly.modify_size(size_change)
		else
			tbelly.modify_size(size_change)
	if(breasts)
		if(breasts.max_size > 0)
			if((breasts.cached_size + size_change) <= breasts.max_size)
				breasts.modify_size(size_change)
		else
			breasts.modify_size(size_change)

	H.genital_override = TRUE
	H.update_body()
	H.update_inv_w_uniform()
	H.update_inv_wear_suit()

Do this later.
*/

/mob/living/carbon/human/proc/handle_fatness_trait(trait, trait_lose, trait_gain, fatness_lose, fatness_gain, chat_lose, chat_gain)
	var/mob/living/carbon/human/H = src
	if(H.fatness < fatness_lose)
		if (chat_lose)
			to_chat(H, chat_lose)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_lose)
			ADD_TRAIT(H, trait_lose, OBESITY)
		update_body_size(H, -1)
	else if(H.fatness >= fatness_gain)
		if (chat_gain)
			to_chat(H, chat_gain)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_gain)
			ADD_TRAIT(H, trait_gain, OBESITY)
		update_body_size(H, 1)

/mob/living/carbon/human/proc/handle_helplessness()
	return TRUE
	/*
	Later
	var/mob/living/carbon/human/fatty = src
	var/datum/preferences/preferences = fatty?.client?.prefs
	if(!istype(preferences) || HAS_TRAIT(fatty, TRAIT_NO_HELPLESSNESS))
		return FALSE

	if(preferences.helplessness_no_movement)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_no_movement)
				to_chat(fatty, "<span class='warning'>You have become too fat to move anymore.</span>")
				ADD_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_no_movement)
			to_chat(fatty, "<span class='notice'>You have become thin enough to regain some of your mobility.</span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_clumsy)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clumsy)
				to_chat(fatty, "<span class='warning'>Your newfound weight has made it hard to manipulate objects.</span>")
				ADD_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_clumsy)
			to_chat(fatty, "<span class='notice'>You feel like you have lost enough weight to recover your dexterity.</span>")
			REMOVE_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_nearsighted)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_nearsighted)
				to_chat(fatty, "<span class='warning'>Your fat makes it difficult to see the world around you. </span>")
				fatty.become_nearsighted(HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_nearsighted)
			to_chat(fatty, "<span class='notice'>You are thin enough to see your enviornment again. </span>")
			fatty.cure_nearsighted(HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
			fatty.cure_nearsighted(HELPLESSNESS_TRAIT)


	if(preferences.helplessness_hidden_face)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_hidden_face)
				to_chat(fatty, "<span class='warning'>You have gotten fat enough that your face is now unrecognizable. </span>")
				ADD_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_hidden_face)
			to_chat(fatty, "<span class='notice'>You have lost enough weight to allow people to now recognize your face.</span>")
			REMOVE_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_mute)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_mute)
				to_chat(fatty, "<span class='warning'>Your fat makes it impossible for you to speak.</span>")
				ADD_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_mute)
			to_chat(fatty, "<span class='notice'>You are thin enough now to be able to speak again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_immobile_arms)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_immobile_arms)
				to_chat(fatty, "<span class='warning'>Your arms are now engulfed in fat, making it impossible to move your arms. </span>")
				ADD_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
				ADD_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
				fatty.update_disabled_bodyparts()

		else if(fatty.fatness < preferences.helplessness_immobile_arms)
			to_chat(fatty, "<span class='notice'>You are able to move your arms again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_disabled_bodyparts()

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_disabled_bodyparts()

	if(preferences.helplessness_clothing_jumpsuit)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_jumpsuit)
				ADD_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)

				var/obj/item/clothing/under/jumpsuit = fatty.w_uniform
				if(istype(jumpsuit) && jumpsuit.modular_icon_location == null)
					to_chat(fatty, "<span class='warning'>[jumpsuit] can no longer contain your weight!</span>")
					fatty.dropItemToGround(jumpsuit)

		else if(fatty.fatness < preferences.helplessness_clothing_jumpsuit)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on jumpsuits now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_clothing_misc)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_misc)
				ADD_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)

				var/obj/item/clothing/suit/worn_suit = fatty.wear_suit
				if(istype(worn_suit) && !istype(worn_suit, /obj/item/clothing/suit/mod))
					to_chat(fatty, "<span class='warning'>[worn_suit] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_suit)

				var/obj/item/clothing/gloves/worn_gloves = fatty.gloves
				if(istype(worn_gloves)&& !istype(worn_gloves, /obj/item/clothing/gloves/mod))
					to_chat(fatty, "<span class='warning'>[worn_gloves] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_gloves)

				var/obj/item/clothing/shoes/worn_shoes = fatty.shoes
				if(istype(worn_shoes) && !istype(worn_shoes, /obj/item/clothing/shoes/mod))
					to_chat(fatty, "<span class='warning'>[worn_shoes] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_shoes)

		else if(fatty.fatness < preferences.helplessness_clothing_misc)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on suits, shoes, and gloves now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_belts)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_belts)
				ADD_TRAIT(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT)

				// if(istype(fatty.belt, /obj/item/bluespace_belt))
				var/obj/item/bluespace_belt/primitive/PBS_belt = fatty.belt
				if(istype(PBS_belt) && fatty.fatness > preferences.helplessness_belts)
					// to_chat(fatty, "<span class='warning'>[PBS_belt] can no longer contain your weight!</span>")
					fatty.visible_message("<span class='warning'>[PBS_belt] fails as it's unable to contain [fatty]'s bulk!</span>", "<span class='warning'>[PBS_belt] fails as it's unable to contain your bulk!</span>")
					fatty.dropItemToGround(PBS_belt)

				var/obj/item/storage/belt/belt = fatty.belt
				if(istype(belt))
					// to_chat(fatty, "<span class='warning'>[belt] can no longer contain your weight!</span>")
					fatty.visible_message("<span class='warning'>With a loud ripping sound, [fatty]'s [belt] snaps open!</span>", "<span class='warning'>With a loud ripping sound, your [belt] snaps open!</span>")
					fatty.dropItemToGround(belt)

		else if(fatty.fatness < preferences.helplessness_belts)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on belts now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT)

	if(preferences.helplessness_clothing_back)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_back)
				ADD_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)
				var/obj/item/back_item = fatty.back
				if(istype(back_item) && !istype(back_item, /obj/item/mod))
					to_chat(fatty, "<span class='warning'>Your weight makes it impossible for you to carry [back_item].</span>")
					fatty.dropItemToGround(back_item)

		else if(fatty.fatness < preferences.helplessness_clothing_back)
			to_chat(fatty, "<span class='notice'>You feel thin enough to hold items on your back now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_no_buckle)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_no_buckle)
				to_chat(fatty, "<span class='warning'>You feel like you've gotten too big to fit on anything.</span>")
				ADD_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_no_buckle)
			to_chat(fatty, "<span class='notice'>You feel thin enough to sit on things again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)
*/

/datum/movespeed_modifier/fatness
	id = "fat"
	variable = TRUE

/mob/living/carbon
	var/list/fatness_delay_modifiers

/datum/fatness_delay_modifier
	var/name
	var/amount = 0
	var/multiplier = 1

/mob/living/carbon/proc/add_fat_delay_modifier(name = "", amount = 0, multiplier = 1)
	var/find_name = FALSE
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		if(modifier.name == name && find_name == FALSE)
			modifier.amount = amount
			modifier.multiplier = multiplier
			find_name = TRUE
	if(find_name == FALSE)
		var/datum/fatness_delay_modifier/new_modifier = new()
		new_modifier.name = name
		new_modifier.amount = amount
		new_modifier.multiplier = multiplier
		LAZYADD(fatness_delay_modifiers, new_modifier)

/mob/living/carbon/proc/remove_fat_delay_modifier(name)
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		if(modifier.name == name)
			LAZYREMOVE(fatness_delay_modifiers, modifier)

/mob/living/carbon/human/proc/apply_fatness_speed_modifiers(fatness_delay)
	var/mob/living/carbon/human/H = src
	var/delay_cap = FATNESS_MAX_MOVE_PENALTY
	if(HAS_TRAIT(H, TRAIT_WEAKLEGS))
		delay_cap = 60
	for(var/datum/fatness_delay_modifier/modifier in H.fatness_delay_modifiers)
		fatness_delay = fatness_delay + modifier.amount
	for(var/datum/fatness_delay_modifier/modifier in H.fatness_delay_modifiers)
		fatness_delay *= modifier.multiplier
	fatness_delay = max(fatness_delay, 0)
	fatness_delay = min(fatness_delay, delay_cap)
	return fatness_delay

/mob/living/carbon/human/proc/handle_fatness()
	var/mob/living/carbon/human/H = src
	// update movement speed
	var/fatness_delay = 0
	if(H.fatness && !HAS_TRAIT(H, TRAIT_NO_FAT_SLOWDOWN))
		fatness_delay = (H.fatness / FATNESS_DIVISOR)
		fatness_delay = min(fatness_delay, FATNESS_MAX_MOVE_PENALTY)

		if(HAS_TRAIT(H, TRAIT_STRONGLEGS))
			fatness_delay = fatness_delay * FATNESS_STRONGLEGS_MODIFIER

		if(HAS_TRAIT(H, TRAIT_WEAKLEGS))
			if(H.fatness <= FATNESS_LEVEL_IMMOBILE)
				fatness_delay += fatness_delay * FATNESS_WEAKLEGS_MODIFIER / 100
			if(H.fatness > FATNESS_LEVEL_IMMOBILE)
				fatness_delay += (H.fatness / FATNESS_LEVEL_IMMOBILE) * FATNESS_WEAKLEGS_MODIFIER
				fatness_delay = min(fatness_delay, 60)

	if(fatness_delay)
		fatness_delay = apply_fatness_speed_modifiers(fatness_delay)
		H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/fatness, TRUE, fatness_delay)
	else
		H.remove_movespeed_modifier(/datum/movespeed_modifier/fatness)

	if(HAS_TRAIT(H, TRAIT_BLOB))
		handle_fatness_trait(
			TRAIT_BLOB,
			TRAIT_IMMOBILE,
			null,
			FATNESS_LEVEL_BLOB,
			INFINITY,
			"<span class='notice'>You feel like you've regained some mobility!</span>",
			null)
		return
	if(HAS_TRAIT(H, TRAIT_IMMOBILE))
		handle_fatness_trait(
			TRAIT_IMMOBILE,
			TRAIT_BARELYMOBILE,
			TRAIT_BLOB,
			FATNESS_LEVEL_IMMOBILE,
			FATNESS_LEVEL_BLOB,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_BARELYMOBILE))
		handle_fatness_trait(
			TRAIT_BARELYMOBILE,
			TRAIT_EXTREMELYOBESE,
			TRAIT_IMMOBILE,
			FATNESS_LEVEL_BARELYMOBILE,
			FATNESS_LEVEL_IMMOBILE,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel your belly smush against the floor!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_EXTREMELYOBESE))
		handle_fatness_trait(
			TRAIT_EXTREMELYOBESE,
			TRAIT_MORBIDLYOBESE,
			TRAIT_BARELYMOBILE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			FATNESS_LEVEL_BARELYMOBILE,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you can barely move!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_MORBIDLYOBESE))
		handle_fatness_trait(
			TRAIT_MORBIDLYOBESE,
			TRAIT_OBESE,
			TRAIT_EXTREMELYOBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			"<span class='notice'>You feel a bit less fat!</span>",
			"<span class='danger'>You feel your belly rest heavily on your lap!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_OBESE))
		handle_fatness_trait(
			TRAIT_OBESE,
			TRAIT_VERYFAT,
			TRAIT_MORBIDLYOBESE,
			FATNESS_LEVEL_OBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>Your thighs begin to rub against each other.</span>")
		return
	if(HAS_TRAIT(H, TRAIT_VERYFAT))
		handle_fatness_trait(
			TRAIT_VERYFAT,
			TRAIT_FATTER,
			TRAIT_OBESE,
			FATNESS_LEVEL_VERYFAT,
			FATNESS_LEVEL_OBESE,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>You feel like you're starting to get really heavy.</span>")
		return
	if(HAS_TRAIT(H, TRAIT_FATTER))
		handle_fatness_trait(
			TRAIT_FATTER,
			TRAIT_FAT,
			TRAIT_VERYFAT,
			FATNESS_LEVEL_FATTER,
			FATNESS_LEVEL_VERYFAT,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>Your clothes creak quietly!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_FAT))
		handle_fatness_trait(
			TRAIT_FAT,
			null,
			TRAIT_FATTER,
			FATNESS_LEVEL_FAT,
			FATNESS_LEVEL_FATTER,
			"<span class='notice'>You feel fit again!</span>",
			"<span class='danger'>You feel even plumper!</span>")
	else
		handle_fatness_trait(
			null,
			null,
			TRAIT_FAT,
			0,
			FATNESS_LEVEL_FAT,
			null,
			"<span class='danger'>You suddenly feel blubbery!</span>")
