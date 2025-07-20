/datum/mutation/lesser_hulk
	name = "Lesser Hulk (Werewolf)"
	desc = "What was once thought to be a curse, actually turned out to be a mutation in the genome, causing the affected person to spout hair and obtain superhuman strength every full moon."
	quality = POSITIVE
	locked = TRUE
	difficulty = 16
	text_gain_indication = span_notice("Your muscles hurt and your skin itches!")
	species_allowed = list(SPECIES_WEREWOLF) // This is hacky, but it's only for werewolves.
	health_req = 25
	instability = POSITIVE_INSTABILITY_MAJOR
	conflicts = list(/datum/mutation/hulk)
	/// List of traits to add/remove when someone gets this mutation.
	mutation_traits = list(
		TRAIT_CHUNKYFINGERS,
		TRAIT_LESSER_HULK,
		TRAIT_PUSHIMMUNE,
	)

/datum/mutation/lesser_hulk/New(datum/mutation/copymut)
	. = ..()
	add_speechmod()

/datum/mutation/lesser_hulk/proc/add_speechmod()
	AddComponent(/datum/component/speechmod, replacements = list("." = "!"), end_string = "!!", uppercase = TRUE)

/datum/mutation/lesser_hulk/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(on_attack_hand))

/datum/mutation/lesser_hulk/proc/on_attack_hand(mob/living/carbon/human/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	if(!source.combat_mode || !proximity || LAZYACCESS(modifiers, RIGHT_CLICK))
		return NONE
	if(!source.can_unarmed_attack())
		return COMPONENT_SKIP_ATTACK
	if(!target.attack_hulk(owner))
		return NONE

	log_combat(source, target, "punched", "werewolf powers")
	source.do_attack_animation(target, ATTACK_EFFECT_SMASH)
	source.changeNext_move(CLICK_CD_MELEE)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/mutation/lesser_hulk/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK)
	UnregisterSignal(owner, COMSIG_MOB_CLICKON)
