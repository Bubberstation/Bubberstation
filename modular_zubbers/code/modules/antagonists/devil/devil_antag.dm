#define INNATE_DEVIL_TRAITS list(\
	TRAIT_NO_SOUL, \
	TRAIT_NOFIRE, \
	TRAIT_NOBREATH, \
	TRAIT_RESISTCOLD, \
	TRAIT_RESISTLOWPRESSURE, \
	TRAIT_RESISTHIGHPRESSURE, \
)

/**
 * The devil, an agent of hell that listens only to himself and upper devils
 *
 * Basic gameplay: Go up to people with custom-made contracts and scam them out of their soul
 *
 * Do note contracts the devil makes are "sticky", in a way that most abilities will transfer bodies.
 * If you make a deal with the devil, better expect that blindness to still affect you whilst in a borg body.
 **/
/datum/antagonist/devil
	name = "\improper Devil"
	show_in_antagpanel = TRUE
	roundend_category = "devils"
	antagpanel_category = ANTAG_GROUP_DEVILS
	pref_flag = ROLE_DEVIL
	antag_hud_name = "devil"
	show_name_in_check_antagonists = TRUE
	hud_icon = 'modular_zubbers/icons/mob/huds/antag_hud.dmi'
	ui_name = "AntagInfoDevil"
	preview_outfit = /datum/outfit/devil

	/// Every single ability the devil has should be here.
	var/list/current_abilities = list()

	/// A list of all possible devil clauses when the antag is created
	/// Keep in mind these are shared between the people who took them
	var/list/clauses = list()
	/// A list of clauses that will be automatically applied when making a new contract
	var/list/default_clauses = list()
	/// The list of people we've made contracts with linked with the clauses they took
	/// Mind = list(/datum/devil_clause/immortality)
	var/list/contracted = list()
	/// The UI used to edit contract clauses
	var/datum/contract_ui/contract_ui = null

	/// The true name of the devil, speaking it outloud will stun the devil
	var/true_name = ""
	/// The regex of the true name, so we don't have to create it every single time someone speaks
	var/regex/name_regex = null
	/// Cooldown for the name stun, so it isn't quite instant victory
	COOLDOWN_DECLARE(true_name_cooldown)

/datum/antagonist/devil/proc/create_objectives()
	var/datum/team/devils_team = new(owner)
	devils_team.show_roundend_report = FALSE

	var/datum/objective/collect_souls/soul_objective = new
	soul_objective.team = devils_team
	objectives += soul_objective

/datum/antagonist/devil/on_gain()
	create_objectives()
	create_true_name()
	var/list/default_abilities = list(
		/datum/action/cooldown/spell/jaunt/ethereal_jaunt/shift/demon,
		/datum/action/cooldown/spell/devil/contract,
	)
	for(var/datum/action/ability as anything in default_abilities)
		current_abilities += new ability(src)
	. = ..()

	var/list/clauses_to_take = subtypesof(/datum/devil_clause)
	clauses_to_take -= list(/datum/devil_clause/trait_giver, /datum/devil_clause/ability_giver)
	for(var/datum/devil_clause/clause as anything in clauses_to_take)
		new clause(src)

	if(isnull(contract_ui))
		contract_ui = new(src)
	RegisterSignal(owner, COMSIG_MIND_TRANSFERRED, PROC_REF(on_devil_transferred))
	RegisterSignal(owner.current, COMSIG_QDELETING, PROC_REF(on_devil_deleted))

/datum/antagonist/devil/on_removal()
	for(var/datum/mind/mind as anything in contracted)
		on_mind_deleted(mind)

	default_clauses = null
	QDEL_LIST(clauses)
	QDEL_LIST(current_abilities)
	QDEL_NULL(contract_ui)
	QDEL_NULL(name_regex)
	return ..()

/datum/antagonist/devil/apply_innate_effects(mob/living/target = owner.current)
	RegisterSignal(target, COMSIG_MOVABLE_HEAR, PROC_REF(handle_hearing))
	target.add_traits(INNATE_DEVIL_TRAITS, DEVIL_TRAIT)
	for(var/datum/action/ability as anything in current_abilities)
		ability.Grant(target)

/datum/antagonist/devil/remove_innate_effects(mob/living/target = owner.current)
	if(QDELETED(target))
		return
	UnregisterSignal(target, COMSIG_MOVABLE_HEAR)
	target.remove_traits(INNATE_DEVIL_TRAITS, DEVIL_TRAIT)
	for(var/datum/action/ability as anything in current_abilities)
		ability.Remove(target)

/datum/antagonist/devil/ui_static_data()
	var/list/data = ..()
	data["true_name"] = true_name
	return data

/datum/antagonist/devil/vv_edit_var(var_name, var_value)
	. = ..()
	if(var_name == NAMEOF(src, true_name))
		if(name_regex)
			QDEL_NULL(name_regex)
		name_regex = regex(true_name, "i")

/datum/antagonist/devil/proc/create_true_name()
	if(name_regex)
		QDEL_NULL(name_regex)
	var/constructed_name = ""
	var/list/syllables = list("hal", "ve", "odr", "neit", "ci", "quon", "mya", "folth", "wren", "geyr", "hil", "niet", "twou", "phi", "coa")
	for(var/index in 1 to rand(3, 5))
		constructed_name += pick(syllables)
		if(prob(40))
			constructed_name += "'"
	true_name = constructed_name
	name_regex = regex(true_name, "i")

/datum/antagonist/devil/proc/handle_hearing(datum/source, list/hearing_args)
	SIGNAL_HANDLER
	var/mob/speaker = hearing_args[HEARING_SPEAKER]
	if(speaker == owner.current || !COOLDOWN_FINISHED(src, true_name_cooldown))
		return

	if(name_regex.Find(hearing_args[HEARING_RAW_MESSAGE]) != 0)
		COOLDOWN_START(src, true_name_cooldown, 1 MINUTES)
		var/holy_multiplier = (speaker?.mind?.holy_role ? 2 : 1)
		owner.current.adjust_fire_loss(15 * holy_multiplier)
		owner.current.Stun(3 SECONDS * holy_multiplier, ignore_canstun = TRUE)

/datum/antagonist/devil/proc/on_devil_transferred(datum/mind/mind, mob/living/old_current)
	SIGNAL_HANDLER
	if(old_current && !isbrain(old_current))
		UnregisterSignal(old_current, COMSIG_QDELETING)

	RegisterSignal(mind.current, COMSIG_QDELETING, PROC_REF(on_devil_deleted))

/datum/antagonist/devil/proc/on_devil_deleted(mob/living/devil_body)
	SIGNAL_HANDLER
	UnregisterSignal(devil_body, COMSIG_QDELETING)

/datum/antagonist/devil/get_preview_icon()
	var/mob/living/carbon/human/dummy/consistent/dummy = new()
	dummy.set_haircolor(COLOR_NEARLY_ALL_BLACK, update = FALSE)
	dummy.set_hairstyle("Business Hair 2", update = FALSE)
	dummy.dna.mutant_bodyparts[FEATURE_HORNS] = list(MUTANT_INDEX_NAME = "Who's Horns?", MUTANT_INDEX_COLOR_LIST = list("591916", "#FFFFFF", "#FFFFFF"))
	dummy.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Succubus", MUTANT_INDEX_COLOR_LIST = list("591916", "#FFFFFF", "#FFFFFF"))
	dummy.dna.mutant_bodyparts[FEATURE_WINGS] = list(MUTANT_INDEX_NAME = "Succubus", MUTANT_INDEX_COLOR_LIST = list("591916", "#FFFFFF", "#FFFFFF"))
	var/datum/universal_icon/dummy_icon = render_preview_outfit(preview_outfit, dummy)
	qdel(dummy)
	return finish_preview_icon(dummy_icon)

/datum/outfit/devil
	name = "Devil"
	uniform = /obj/item/clothing/under/rank/civilian/lawyer/red
	neck = /obj/item/clothing/neck/tie/black/tied
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset
	l_hand = /obj/item/storage/briefcase

#undef INNATE_DEVIL_TRAITS
