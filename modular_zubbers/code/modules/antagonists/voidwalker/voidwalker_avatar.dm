/datum/species/voidwalker_avatar
	id = SPECIES_VOIDWALKER //Species define unused in tg since they made them simple mobs
	name = "Voidwalker Avatar"
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_RESISTCOLD,
		TRAIT_NOBREATH,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NODISMEMBER,
		TRAIT_NOHUNGER,
		TRAIT_NOBLOOD,
		TRAIT_NO_DNA_COPY,
		TRAIT_NODISMEMBER,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NODEATH,
		TRAIT_SPACEWALK,
		TRAIT_MADNESS_IMMUNE,
		TRAIT_HARD_SOLES,
	)

/datum/species/voidwalker_avatar/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	human_who_gained_species.gain_trauma(/datum/brain_trauma/voided/avatar)




/datum/action/cooldown/spell/pointed/voidwalker_avatar_summon
	name = "Conjure Avatar"
	desc = "Conjure a humanoid avatar to easier interact with the unenlightened, or transfer you consciousness to your existing avatar."
	spell_requirements = null
	cooldown_time = 10 SECONDS
	var/mob/living/carbon/human/current_avatar

/datum/action/cooldown/spell/pointed/voidwalker_avatar_summon/on_activation(mob/on_who)
	. = ..()
	if(!isnull(current_avatar))
		unset_click_ability(on_who, FALSE)
		owner.mind.transfer_to(current_avatar)


/datum/action/cooldown/spell/pointed/voidwalker_avatar_summon/cast(atom/cast_on)
	. = ..()
	var/client/caster_client = owner.client
	var/list/character_list = caster_client.prefs.create_character_profiles()
	var/target_char_name = tgui_input_list(
		owner,
		"What form will your avatar take?",
		"Character",
		character_list,
		timeout = 30 SECONDS
	)
	if (isnull(target_char_name))
		owner.balloon_alert(owner, "no selection!")
		return
	var/datum/preferences/prefs = caster_client.prefs
	prefs.load_character(character_list.Find(target_char_name))
	var/mob/living/carbon/human/avatar = new(get_turf(cast_on))
	current_avatar = avatar
	prefs.safe_transfer_prefs_to(avatar)
	avatar.set_species(/datum/species/voidwalker_avatar)
	avatar.dna.update_dna_identity()
	new /obj/effect/temp_visual/circle_wave/unsettle(get_turf(avatar))

	//TODO: Insert granting of return abilities
	var/datum/action/dissolve_voidwalker_avatar/dissolve = new()
	dissolve.real_body = owner
	dissolve.summon_action = src
	dissolve.Grant(avatar)

	var/datum/action/voidwalker_swap_bodies/swap = new()
	swap.real_body = owner
	swap.Grant(avatar)

	owner.mind.transfer_to(avatar)



/datum/action/dissolve_voidwalker_avatar
	name = "Dissolve Avatar"
	desc = "Destroys your avatar and returns your consciousness to your real voidwalker body."
	var/mob/living/basic/voidwalker/real_body
	var/datum/action/cooldown/spell/pointed/voidwalker_avatar_summon/summon_action

/datum/action/dissolve_voidwalker_avatar/Grant(mob/grant_to)
	. = ..()
	RegisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_take_damage))

/datum/action/dissolve_voidwalker_avatar/proc/on_take_damage()
	SIGNAL_HANDLER
	Trigger(owner)
	return

/datum/action/dissolve_voidwalker_avatar/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(owner.mind)
		owner.mind.transfer_to(real_body)
	real_body = null
	summon_action.current_avatar = null
	UnregisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE)
	new /obj/effect/temp_visual/circle_wave/unsettle(get_turf(owner))

	qdel(owner)

/datum/action/voidwalker_swap_bodies
	name = "Transfer Consciousness"
	desc = "Transfer you consciousness back to your real voidwalker body while still hearing what this avatar hears."
	var/mob/living/basic/voidwalker/real_body

/datum/action/voidwalker_swap_bodies/Grant(mob/grant_to)
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_HEAR, PROC_REF(relay_speech))

/datum/action/voidwalker_swap_bodies/proc/relay_speech(atom/source, list/hear_args)
	SIGNAL_HANDLER

	if(!real_body?.client)
		return

	var/list/new_args = hear_args.Copy()
	new_args[HEARING_RANGE] = INFINITY // so we can hear it from any distance away
	real_body.Hear(arglist(new_args))

/datum/action/voidwalker_swap_bodies/Trigger(mob/clicker, trigger_flags)
	. = ..()
	owner.mind.transfer_to(real_body)
