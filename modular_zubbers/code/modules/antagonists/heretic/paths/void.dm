// rework void chill to like, cause sleep and healing at max stacks? But if you touch them at all they break out
// possinly also make it just not do damage bc sleep is kinda strong
// damage resistance on the wakeup attack?

/datum/action/cooldown/spell/pointed/void_phase
	cooldown_time = 40 SECONDS // extra thick cooldown for a very strong teleport ability

/datum/heretic_knowledge_tree_column/void
	knowledge_tier3 = /datum/heretic_knowledge/spell/void_stealth
	description = list(
		"The Path of Void focuses on stealth, freezing cold, mobility and cold healing.",
		"Pick this path if you enjoy being a mobile assassin who freezes their enemies in place before phasing away.",
	)
	pros = list(
		"Protection from the hazards of space.",
		"Your spells apply a stacking debuff that chills and slows targets.",
		"Possesses a powerful mobility spell.",
		"Highly stealthy.",
	)
	cons = list(
		"Though protected from space, you are not nearly as mobile in it as you are on foot.",
		"Has a difficult time fighting opponents immune to cold effects.",
		"Has a difficult time with silicon-based lifeforms.",
		"Your void chill can be exploited by your opponents to heal themselves. If you see someone sleeping in a fight, attack them to cancel the healing.",
	)
	tips = list(
		"Your Mansus Grasp allows you to mute your targets, making it ideal for silent assassinations (keep in mind that it won't short circuit their suit sensors, make sure you turn them off after you kill them). The grasp also applies a mark that when triggered by the void blade will apply the maximum amount of stacks of void chill to your target, slowing them down to a crawl.",
		"Void chill is a debuff applied by your spells, your grasp, your mark and your blade once you unlock the upgrade. Each stack slows your target movement speed by 10% and make them gradually colder, up to a maximum of 5 stacks.",
		"If someone falls asleep while under void chill, they enter an eldritch sleep that heals them and closes their wounds. Hitting them cancels this process.",
		"At 5 stacks void chill will also prevent your target from heating up.",
		"Cloak of the dark makes you completely invisible for an indefinite period, as long as you are not attacked. Use it for ambushes and escaping pursuers.",
		"Void Prison can put a target in stasis for 10 seconds. Ideal if you are fighting multiple opponents and need to isolate one target at a time.",
		"Void Prison can be self-cast and will slowly heal whoever is inside. You can use it to block incoming damage at the cost of incapacitating yourself.",
		"Void Conduit is your signature ability. It freezes the air around it, while putting nearby enemies to sleep. Use it to expand your chilled domain and incapacitate attackers.",
	)

/datum/heretic_knowledge/spell/void_pull
	unreachable = TRUE

/datum/heretic_knowledge/spell/void_stealth
	name = "Cloak of the dark"
	desc = "Cloaks you in inpermeable void, rendering you invisible to observers. You chill the air around you in this state, so don't stay in \
	one place for too long or people will start to realize. Attacking or being attacked will break the cloak."
	gain_text = "The Aristocrat walks as gentle as a mouse, leaving nary a wave in the inky expanse of the void. Soon, then, I close my eyes - \
	and there they are, the gravity of their pull inescapable."
	action_to_add = /datum/action/cooldown/spell/void_stealth
	cost = 2

/datum/action/cooldown/spell/void_stealth
	name = "Cloak of the dark"
	desc = "Cloaks you in inpermeable void, rendering you invisible to observers. You chill the air around you in this state, so don't stay in \
	one place for too long or people will start to realize. You cannot attack while cloaked, and being attacked will end it immediately."
	/// The cloak currently active
	var/datum/status_effect/void_stealth/active_cloak
	/// The cooldown applied after our cloak is removed.
	var/remove_time = 2 MINUTES

	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "voidpull"

	sound = null
	school = SCHOOL_FORBIDDEN
	invocation_type = INVOCATION_NONE // sneaky spell
	spell_requirements = NONE

	cooldown_time = 2 SECONDS

/datum/action/cooldown/spell/void_stealth/before_cast(mob/living/cast_on)
	. = ..()
	// We handle the CD on our own
	return . | SPELL_NO_IMMEDIATE_COOLDOWN

/datum/action/cooldown/spell/void_stealth/cast(atom/cast_on)
	. = ..()

	if(active_cloak)
		uncloak_mob(cast_on)
		StartCooldown(remove_time)

	else
		cloak_mob(cast_on)
		StartCooldown()

/datum/action/cooldown/spell/void_stealth/proc/cloak_mob(mob/living/cast_on)
	active_cloak = cast_on.apply_status_effect(/datum/status_effect/void_stealth)
	RegisterSignal(cast_on, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING), PROC_REF(on_focus_lost))
	to_chat(cast_on, span_notice("The void surrounds you, and you find yourself invisible to the mortal world."))

/datum/action/cooldown/spell/void_stealth/proc/uncloak_mob(mob/living/cast_on, show_message = TRUE)
	if(!QDELETED(active_cloak))
		UnregisterSignal(active_cloak, COMSIG_QDELETING)
		qdel(active_cloak)
	active_cloak = null

	UnregisterSignal(cast_on, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING))
	if(show_message)
		cast_on.visible_message(
			span_warning("[cast_on] appears from nothing!"),
			span_notice("The void wrapping your form unravels, revealing you to the mortal world once more."),
		)

/// Signal proc for [SIGNAL_REMOVETRAIT] via [TRAIT_ALLOW_HERETIC_CASTING], losing our focus midcast will throw us out.
/datum/action/cooldown/spell/void_stealth/proc/on_focus_lost(mob/living/source)
	SIGNAL_HANDLER

	uncloak_mob(source, show_message = FALSE)
	source.visible_message(
		span_warning("[source] suddenly appears from nothing!"),
		span_userdanger("As you lose your focus, the void around your form unravels!"),
	)
	StartCooldown(remove_time)

/// Shadow cloak effect. Sets the owner's alpha to zero while also chilling the area around them
/// If hit at all, the cloak is cancelled and put on cooldown
/datum/status_effect/void_stealth
	id = "void_stealth"
	alert_type = null
	// in kelvin, the rate we cool the tile we're on
	var/cooling_per_sec = 10

/datum/status_effect/void_stealth/tick(seconds_between_ticks)
	. = ..()

	var/turf/location = get_turf(owner)
	if(location)
		var/datum/gas_mixture/enviro = location.return_air()
		enviro.temperature = max(enviro.temperature - cooling_per_sec * seconds_between_ticks, 50)
		location.air_update_turf(FALSE, FALSE)

/datum/status_effect/void_stealth/on_apply()
	animate(owner, alpha = 0, 0.5 SECONDS)
	// Add the relevant traits and modifiers
	owner.add_traits(list(TRAIT_UNKNOWN_APPEARANCE), TRAIT_STATUS_EFFECT(id))
	// Register signals to cause effects
	RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_change))
	RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(on_block_check))
	RegisterSignal(owner, COMSIG_USER_PRE_ITEM_ATTACK, PROC_REF(before_attack))
	RegisterSignal(owner, COMSIG_USER_ITEM_INTERACTION, PROC_REF(on_item_interaction))
	RegisterSignal(owner, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(owner, COMSIG_MOB_BEFORE_SPELL_CAST, PROC_REF(before_spell_cast))
	return TRUE

/datum/status_effect/void_stealth/proc/before_spell_cast(datum/source, datum/spell)
	SIGNAL_HANDLER
	if(!istype(spell, /datum/action/cooldown/spell/void_stealth))
		owner.balloon_alert(owner, "cant cast spells while cloaked!")
		return SPELL_CANCEL_CAST


/datum/status_effect/void_stealth/on_remove()
	// Remove traits and modifiers
	owner.remove_traits(list(TRAIT_UNKNOWN_APPEARANCE), TRAIT_STATUS_EFFECT(id))
	animate(owner, alpha = initial(owner.alpha), 0.5 SECONDS)
	// Clear signals
	UnregisterSignal(owner, list(
		COMSIG_MOB_STATCHANGE,
		COMSIG_LIVING_CHECK_BLOCK,
		COMSIG_USER_PRE_ITEM_ATTACK,
		COMSIG_USER_ITEM_INTERACTION,
		COMSIG_LIVING_UNARMED_ATTACK,
		COMSIG_MOB_BEFORE_SPELL_CAST
	))

/// Signal proc for [COMSIG_USER_PRE_ITEM_ATTACK], disallows the use of weapons while stealth is active
/datum/status_effect/void_stealth/proc/before_attack(datum/source, obj/item/weapon, atom/target, list/modifiers, list/attack_modifiers)
	SIGNAL_HANDLER

	if (isliving(target))
		return COMPONENT_CANCEL_ATTACK_CHAIN

/// Signal proc for [COMSIG_LIVING_CHECK_BLOCK], any attack at all cancels the stealth
/datum/status_effect/void_stealth/proc/on_block_check(datum/source, atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	SIGNAL_HANDLER

	qdel(src)

/// Signal proc for [COMSIG_MOB_STATCHANGE], going past soft crit will stop the effect
/datum/status_effect/void_stealth/proc/on_stat_change(datum/source, new_stat, old_stat)
	SIGNAL_HANDLER

	// Going above unconscious will self-delete
	if(new_stat >= UNCONSCIOUS)
		qdel(src)

/datum/status_effect/void_stealth/proc/on_item_interaction(datum/source, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	return ITEM_INTERACT_BLOCKING

/datum/status_effect/void_stealth/proc/on_unarmed_attack(datum/signal_source, mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/heretic_knowledge/spell/void_prison
	desc = "Grants you Void Prison, a spell that places your victim into a ball. In this state, \
	the target is undamageable and slowly heals. If cast on a heathen with combat mode, chills them when they exit. Can be self-cast."

/datum/action/cooldown/spell/pointed/void_prison
	desc = "Sends a target into the void for 10 seconds. \
		They will be unable to perform any actions for the duration, and will be untouchable and slowly heal. \
		Afterwards, they will be chilled (if cast with combat mode) and returned to the mortal plane. Can be self-cast."

/datum/action/cooldown/spell/pointed/void_prison/is_valid_target(atom/cast_on)
	return TRUE // self cast

/datum/status_effect/void_prison
	var/healing_per_second = -2

/datum/status_effect/void_prison/tick(seconds_between_ticks)
	. = ..()

	owner.adjust_brute_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_fire_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_tox_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_oxy_loss(healing_per_second * seconds_between_ticks)

	// TODO heal wounds

/atom/movable/screen/alert/status_effect/void_chill
	desc = "There's something freezing you from within and without. You've never felt cold this oppressive before... and yet theres something soothing about it. \
	Click this alert to enter a deep sleep that will heal you using cryoxadone. Be warned - You will only wake up if attacked or when this status disappears."

/atom/movable/screen/alert/status_effect/void_chill/Click(location, control, params)
	. = ..()

	if (!isliving(owner))
		return
	var/mob/living/living_owner = owner
	if (living_owner.IsSleeping())
		return
	if (living_owner.stat != CONSCIOUS)
		return
	if (!tgui_alert(living_owner, "Enter a soothing sleep? (You will be awakened if you are attacked)", "Void Sleep", list("Yes", "No"), timeout = 5 SECONDS))
		return
	if (living_owner.IsSleeping())
		return
	if (living_owner.stat != CONSCIOUS)
		return
	if (QDELETED(src))
		return

	if(!istype(attached_effect, /datum/status_effect/void_chill))
		return
	var/datum/status_effect/void_chill/chill_effect = attached_effect

	chill_effect.put_to_bed(owner)

/datum/status_effect/void_chill
	VAR_PROTECTED/in_eldritch_sleep = FALSE
	/// Makes choosing to sleep a commitment that can take you out of any fight.
	var/bonus_sleepy_time = 150 SECONDS
	var/should_reduce_timer_on_wakeup = FALSE

/datum/status_effect/void_chill/proc/put_to_bed(mob/living/sleepy_boy)
	if (sleepy_boy.IsSleeping())
		return
	if (sleepy_boy.stat != CONSCIOUS)
		return
	if (QDELETED(src))
		return
	set_sleep_status(TRUE)

/datum/status_effect/void_chill/proc/set_sleep_status(new_value, silent = FALSE, forced = FALSE)
	if (in_eldritch_sleep == new_value)
		return

	in_eldritch_sleep = new_value

	if (in_eldritch_sleep)
		if (!forced)
			duration += bonus_sleepy_time
			should_reduce_timer_on_wakeup = TRUE

		owner.AdjustSleeping(60 SECONDS) // removes when void chill goes away as well
		RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_changed))
		RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(on_block_check))
		if (!silent)
			to_chat(owner, span_hypnophrase("You drift away into a deep, dark dream, of death, void, and a comforting cold..."))
	else
		if (should_reduce_timer_on_wakeup)
			duration -= bonus_sleepy_time
		should_reduce_timer_on_wakeup = FALSE
		owner.SetSleeping(0)
		owner.adjust_drowsiness(-60 SECONDS)
		UnregisterSignal(owner, list(COMSIG_MOB_STATCHANGE, COMSIG_LIVING_CHECK_BLOCK))
		if (!iscarbon(owner))
			return
		var/mob/living/carbon/carbon_owner = owner
		var/datum/reagents/reagents = carbon_owner.reagents
		reagents.remove_reagent(/datum/reagent/medicine/cryoxadone/heretic, 500) // just get it alllll out

/datum/status_effect/void_chill/proc/on_stat_changed(datum/signal_source, new_stat, old_stat)
	SIGNAL_HANDLER

	if (new_stat != UNCONSCIOUS)
		set_sleep_status(FALSE)

/datum/status_effect/void_chill/proc/on_block_check(datum/signal_source, atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	SIGNAL_HANDLER

	owner.visible_message(
		span_warning("[owner] jolts awake from [owner.p_their()] deep sleep!"),
		span_userdanger("You jolt awake from your deep sleep!")
	)
	set_sleep_status(FALSE, silent = TRUE)
	//return SUCCESSFUL_BLOCK // TODO reenable if we make it so you can fall into the sleep due to cold involuntarily

/datum/status_effect/void_chill/get_examine_text()
	if (in_eldritch_sleep)
		return span_boldnotice("[owner.p_They()] [owner.p_are()] in an especially deep sleep, tendrils of sparkling void sealing [owner.p_their()] wounds... waking [owner.p_them()] might pause this process.")
	return ..()

/datum/status_effect/void_chill/Destroy()
	set_sleep_status(FALSE)

	return ..()

/datum/status_effect/void_chill/tick(seconds_between_ticks)
	. = ..()

	if (in_eldritch_sleep)
		if (!iscarbon(owner))
			return
		var/mob/living/carbon/carbon_owner = owner
		var/datum/reagents/reagents = carbon_owner.reagents
		reagents.add_reagent(/datum/reagent/medicine/cryoxadone/heretic, 0.8 * seconds_between_ticks)
	else
		if (stacks >= 5)
			if (SPT_PROB(5, seconds_between_ticks))
				to_chat(owner, span_hypnophrase("The cold slows you down, slows your mind, your heart... you want to take a nap."))
			if (SPT_PROB(5, seconds_between_ticks))
				owner.emote("yawn")
		if (owner.IsSleeping())
			set_sleep_status(TRUE, forced = TRUE)

/datum/reagent/medicine/cryoxadone/heretic
	name = "Voidtouch"
	description = "A strange substance similar in property to cryoxadone."
	color = "#00c878"
	metabolization_rate = 0.75
	overdose_threshold = 0
	chemical_flags = NONE
	process_flags = REAGENT_ORGANIC|REAGENT_SYNTHETIC // yes synths. u get healing 2

/datum/heretic_knowledge/spell/void_conduit
	desc = "Grants you Void Conduit, a spell which summons a pulsing gate to the Void itself. Every pulse freezes the air, while afflicting heathens with void chill and drowsiness. Heretics instead receive low pressure resistance."

/datum/action/cooldown/spell/conjure/void_conduit
	desc = "Opens a gate to the Void; it releases an intermittent pulse that afflicts Heathens with void chill and drowsiness, while freezing the air around it. \
		Heathens that fall asleep under the effects of the conduit enter a deep eldritch sleep that heals them, but incapacitates them for a while. \
		Affected Heretics instead receive low pressure resistance."

/obj/structure/void_conduit
	var/cooling_per_pulse = 5

/obj/structure/void_conduit/handle_effects(list/turfs)
	// no parent call. bESPOKE behavior
	for(var/turf/affected_turf as anything in turfs)
		var/datum/gas_mixture/enviro = affected_turf.return_air()
		enviro.temperature = max(enviro.temperature - cooling_per_pulse, 20)
		affected_turf.air_update_turf(FALSE, FALSE)
		for(var/atom/thing_to_affect as anything in affected_turf.contents)
			if(isliving(thing_to_affect))
				var/mob/living/affected_mob = thing_to_affect
				if(affected_mob.can_block_magic(MAGIC_RESISTANCE))
					continue
				if(IS_HERETIC_OR_MONSTER(affected_mob) || HAS_TRAIT(affected_mob, TRAIT_MANSUS_TOUCHED))
					affected_mob.apply_status_effect(/datum/status_effect/void_conduit)
				else
					affected_mob.apply_status_effect(/datum/status_effect/void_chill, 1)
					affected_mob.adjust_drowsiness_up_to(10 SECONDS, 70 SECONDS)
					if (!affected_mob.IsSleeping())
						var/datum/status_effect/drowsiness/drowsiness = affected_mob.has_status_effect(/datum/status_effect/drowsiness)
						if (drowsiness.duration >= 60 SECONDS && prob(40))
							affected_mob.AdjustSleeping(5 SECONDS) // ko
						if (prob(15))
							to_chat(affected_mob, span_warning("The cold makes you sleepy..."))
