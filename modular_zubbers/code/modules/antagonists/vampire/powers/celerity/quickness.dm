/datum/action/cooldown/vampire/exactitude
	name = "Exactitude"
	desc = "Focus your powers into your hands, enabling you to attack with preternatural precision."
	button_icon_state = "power_exactitude"
	power_explanation = "Imbues your hands with supernatural precision. Cannot be used with gloves on.\n\
						Use with combat mode. When punching, you will automatically hit the closest being. Best used without moving your mouse at all."
	vampire_power_flags = BP_AM_TOGGLE
	cooldown_time = 30 SECONDS
	vitaecost = 50
	constant_vitaecost = 5


/datum/action/cooldown/vampire/exactitude/can_use()
	. = ..()
	if(!.)
		return FALSE
	if(owner.get_item_by_slot(ITEM_SLOT_GLOVES))
		owner.balloon_alert(owner, "you're wearing gloves!")
		return FALSE

/datum/action/cooldown/vampire/exactitude/activate_power()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	ADD_TRAIT(owner, TRAIT_PERFECT_ATTACKER, REF(src))

/datum/action/cooldown/vampire/exactitude/deactivate_power()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK)
	REMOVE_TRAIT(owner, TRAIT_PERFECT_ATTACKER, REF(src))

/datum/action/cooldown/vampire/exactitude/continue_active()
	. = ..()
	if(owner.get_item_by_slot(ITEM_SLOT_GLOVES))
		return FALSE

/datum/action/cooldown/vampire/exactitude/proc/on_unarmed_attack(mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER
	if(!source.combat_mode || !currently_active)
		return NONE

	if(isliving(target) && target != source)
		var/mob/living/living_target = target
		if(living_target.stat != DEAD) // don't focus on dead targets
			return NONE

	for(var/mob/living/to_attack in oview(1, source))
		if(to_attack.stat == DEAD || to_attack.invisibility > source.see_invisible)
			continue
		source.face_atom(to_attack)
		INVOKE_ASYNC(to_attack, TYPE_PROC_REF(/atom, attack_hand), source, modifiers)
		source.changeNext_move(CLICK_CD_MELEE)
		return COMPONENT_CANCEL_ATTACK_CHAIN
