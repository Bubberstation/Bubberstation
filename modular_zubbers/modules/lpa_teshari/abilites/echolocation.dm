#define ECHOLOCATION_MAX_CREATURE 5
#define ECHOLOCATION_BASE_COOLDWN_TIME 10 SECONDS
#define ECHOLOCATION_PING_COOLDOWN 5 SECONDS
#define ECHOLOCATION_RANGE 7

/datum/action/cooldown/raptor/echolocation
	name = "Toggle echolocation"
	desc = "Use your ears to hear the creatures around you."

	cooldown_time = ECHOLOCATION_BASE_COOLDWN_TIME
	var/active = FALSE
	var/cycle_cooldown = ECHOLOCATION_BASE_COOLDWN_TIME
	COOLDOWN_DECLARE(echolocation_ping_cooldown)

/datum/action/cooldown/raptor/echolocation/New(Target, original)
	. = ..()
	button_icon_state = "echolocation_off"

/datum/action/cooldown/raptor/echolocation/Destroy()
	. = ..()
	if(active)
		deisable_echolocation()

/datum/action/cooldown/raptor/echolocation/Activate(atom/target)
	if(!owner)
		return FALSE
	var/mob/living/carbon/human/tesh = owner
	cooldown_time = ECHOLOCATION_BASE_COOLDWN_TIME
	if(!tesh.can_hear())
		tesh.balloon_alert("Can't hear!")
		return TRUE

	if(active)
		deisable_echolocation()
		return TRUE

	enable_echolocation()
	return FALSE

/datum/action/cooldown/raptor/echolocation/proc/enable_echolocation()
	active = TRUE
	name = "Toggle echolocation : enabled"
	var/mob/living/carbon/human/tesh = owner

	tesh.visible_message(span_notice("[tesh.name], pricked up [tesh.p_their()] ears. Listening to the surroundings."), span_notice("You got your ears perked up listening to your surroundings."))
	tesh.balloon_alert(tesh, "Start echolocation!")

	update_button_state("echolocation_on")
	START_PROCESSING(SSobj, src)
	RegisterSignal(owner, COMSIG_CARBON_SOUNDBANG, PROC_REF(soundbang_act))
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(deisable_echolocation))

/datum/action/cooldown/raptor/echolocation/proc/deisable_echolocation()
	SIGNAL_HANDLER

	active = FALSE
	name = "Toggle echolocation"
	var/mob/living/carbon/human/tesh = owner

	tesh.visible_message(span_notice("[tesh.name], returned [tesh.p_their()] ears to normal. "), span_notice("You got your ears back to normal."))
	tesh.balloon_alert(tesh, "Stop echolocation!")

	update_button_state("echolocation_off")
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(owner, list(COMSIG_CARBON_SOUNDBANG, COMSIG_LIVING_DEATH))
	StartCooldown()

/datum/action/cooldown/raptor/echolocation/process(seconds_per_tick)
	. = ..()
	if(!active)
		return

	var/mob/living/carbon/human/tesh = owner
	if(!tesh.can_hear())
		tesh.balloon_alert("Can't hear!")
		deisable_echolocation()
		return

	if(!COOLDOWN_FINISHED(src, echolocation_ping_cooldown))
		return
	COOLDOWN_START(src, echolocation_ping_cooldown, ECHOLOCATION_PING_COOLDOWN)

	var/founding_creature = 0
	for(var/mob/living/creature in range(ECHOLOCATION_RANGE, owner))
		if(creature == owner || creature.stat == DEAD)
			continue
		if(HAS_TRAIT(creature, TRAIT_LIGHT_STEP))
			continue
		if(founding_creature >= ECHOLOCATION_MAX_CREATURE)
			break
		new /obj/effect/temp_visual/sonar_ping/tesh(owner.loc, owner, creature)
		founding_creature++

/datum/action/cooldown/raptor/echolocation/proc/soundbang_act(intensity)
	SIGNAL_HANDLER
	if(!owner || isdead(owner))
		return FALSE
	if(!active)
		return FALSE

	var/mob/living/carbon/human/tesh = owner
	var/stun_time = rand(4, 8) SECONDS

	cooldown_time *= (stun_time/20)
	tesh.Paralyze(stun_time/2)
	tesh.Knockdown(stun_time)
	var/obj/item/organ/internal/ears/E = tesh.get_organ_slot(ORGAN_SLOT_EARS)
	E.apply_organ_damage(40)

	to_chat(tesh, span_userdanger("Your ears fill with pain as the horrible noise hits them!"))
	deisable_echolocation()
	return TRUE

/obj/effect/temp_visual/sonar_ping/tesh
	real_icon_state = "blip"
	duration = 1 SECONDS

#undef ECHOLOCATION_MAX_CREATURE
#undef ECHOLOCATION_BASE_COOLDWN_TIME
#undef ECHOLOCATION_RANGE
#undef ECHOLOCATION_PING_COOLDOWN
