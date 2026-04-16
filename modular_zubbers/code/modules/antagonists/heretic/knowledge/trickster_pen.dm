/datum/heretic_knowledge/trickster_pen
	name = "Trickster's Pen"
	desc = "Allows you to transmute a pen, a sheet of plasma, and a set of eyes into a trickster's pen that can change \
	any ID's name, job, and appearance. Clicking the pen turns you partially transparent for a moment. Best used with the Trickster's Mask."
	gain_text = "The Bleeding Trickster rewrites language and form to better hide itself. An A becomes a Z, red becomes blue, and suddenly \
	the smiling god appears no different than anything else."
	required_atoms = list(
		/obj/item/pen = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
		/obj/item/organ/eyes = 1,
	)
	result_atoms = list(/obj/item/pen/trickster)
	drafting_cost = 1
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/service/bureaucracy.dmi'
	research_tree_icon_state = "pen"

/obj/item/pen/trickster
	name = "strange pen"
	desc = "A shifting, morphing pen - and yet you find purchase in its form as you grasp it."
	COOLDOWN_DECLARE(stealth_cooldown)
	var/static/list/chameleon_whitelist
	var/static/list/chameleon_blacklist
	var/static/list/pickable_trims

/obj/item/pen/trickster/Initialize(mapload)
	. = ..()

	apply_wibbly_filters(src)
	RegisterSignal(src, COMSIG_ITEM_INTERACTING_WITH_ATOM, PROC_REF(on_atom_interact))

	if (isnull(pickable_trims))
		chameleon_whitelist = typecacheof(list(
				/datum/id_trim/battlecruiser,
				/datum/id_trim/bit_avatar,
				/datum/id_trim/bounty_hunter,
				/datum/id_trim/centcom,
				/datum/id_trim/job,
				/datum/id_trim/pirate,
				/datum/id_trim/syndicom,
				/datum/id_trim/technician_id,
			))
		chameleon_blacklist = typecacheof(/datum/id_trim/centcom/corpse)
		pickable_trims = list()

		for(var/trim_path in chameleon_whitelist)
			if(is_type_in_typecache(trim_path, chameleon_blacklist))
				continue

			var/datum/id_trim/trim = SSid_access.trim_singletons_by_path[trim_path]

			if(trim && trim.trim_state && trim.assignment)
				pickable_trims[trim.assignment] = trim_path

/obj/item/pen/trickster/examine(mob/user)
	. = ..()
	if (IS_HERETIC_OR_MONSTER(user))
		. += span_notice("This is the trickster's pen, a gift from the titular Bleeding Trickster. Use it on a ID to change \
		its name, job, and more.")
		. += span_notice("It can also be clicked to become briefly partially transparent.")

/obj/item/pen/trickster/attack_self(mob/user, modifiers)
	. = ..()

	if (!IS_HERETIC_OR_MONSTER(user))
		return
	if (COOLDOWN_FINISHED(src, stealth_cooldown))
		animate(user, alpha = 25, 0.5 SECONDS)
		to_chat(user, span_warning("As you click the pen, you find yourself fading from view."))
		COOLDOWN_START(src, stealth_cooldown, 30 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(clear_stealth), user), 10 SECONDS)

/obj/item/pen/trickster/proc/clear_stealth(mob/user)
	animate(user, alpha = initial(user.alpha), 0.5 SECONDS)
	to_chat(user, span_warning("The magic obscuring your form fades!"))

/obj/item/pen/trickster/proc/on_atom_interact(datum/source, mob/living/user, atom/interacting_with, list/modifiers)
	SIGNAL_HANDLER

	if (!istype(interacting_with, /obj/item/card/id/advanced))
		return NONE
	if (!IS_HERETIC_OR_MONSTER(user))
		return NONE

	INVOKE_ASYNC(src, PROC_REF(do_id_rename), user, interacting_with)

	return ITEM_INTERACT_SUCCESS

/obj/item/pen/trickster/proc/do_id_rename(mob/living/user, obj/item/card/id/advanced/id_card)
	///forge the ID if not forged.
	var/input_name = tgui_input_text(user, "What name would you like to put on this card? Leave blank to randomise.", "New Name", id_card.registered_name ? id_card.registered_name : (ishuman(user) ? user.real_name : user.name), max_length = MAX_NAME_LEN, encode = FALSE)

	if(!id_card.after_input_check(user))
		return NONE

	if(input_name)
		input_name = sanitize_name(input_name, allow_numbers = TRUE)
	if(!input_name)
		// Invalid/blank names give a randomly generated one.
		if(user.gender == MALE)
			input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
		else if(user.gender == FEMALE)
			input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]"
		else
			input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

	var/target_occupation = tgui_input_text(user, "What occupation would you like to put on this card?\nNote: This will not grant any access levels.", "Agent card job assignment", id_card.assignment ? id_card.assignment : "Assistant", max_length = MAX_NAME_LEN)
	if(!id_card.after_input_check(user))
		return NONE
	var/default_age = AGE_MIN
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		default_age = human_user.age ? clamp(human_user.age, AGE_MIN, AGE_MAX) : AGE_MIN
	var/new_age = tgui_input_number(user, "Choose the ID's age", "Age", default_age, AGE_MAX, AGE_MIN)
	if(!id_card.after_input_check(user))
		return NONE

	var/new_trim_name = tgui_input_list(user, "Choose the ID's trim", "Trim", pickable_trims)
	var/new_trim = pickable_trims[new_trim_name]
	if(!id_card.after_input_check(user))
		return NONE

	var/wallet_spoofing = tgui_alert(user, "Activate wallet ID spoofing, allowing this card to force itself to occupy the visible ID slot in wallets?", "Wallet ID Spoofing", list("Yes", "No"))
	if(!id_card.after_input_check(user))
		return NONE

	id_card.registered_name = input_name
	if(target_occupation)
		id_card.assignment = sanitize(target_occupation)
	if(new_age)
		id_card.registered_age = new_age
	if(wallet_spoofing == "Yes")
		ADD_TRAIT(id_card, TRAIT_MAGNETIC_ID_CARD, CHAMELEON_ITEM_TRAIT)
	if (new_trim)
		SSid_access.apply_trim_override(id_card, new_trim)

	id_card.update_label()
	id_card.update_appearance()
	to_chat(user, span_notice("The card shimmers and morphs around your pen. Soon, it is something new."))
	user.log_message("forged \the [initial(id_card.name)] with name \"[id_card.registered_name]\", occupation \"[id_card.assignment]\" and trim \"[id_card.trim?.assignment]\" with [src].", LOG_GAME)
