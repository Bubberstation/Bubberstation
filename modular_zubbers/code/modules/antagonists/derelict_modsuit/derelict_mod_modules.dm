#define AI_CONTROL 0
#define WEARER_CONTROL 1

/obj/item/mod/module/borg_takeover
	name = "MOD Silicon Takeover module"
	removable = FALSE
	required_slots = list(ITEM_SLOT_GLOVES)
	module_type = MODULE_PASSIVE

/obj/item/mod/module/borg_takeover/on_suit_activation()
	RegisterSignal(mod.wearer, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(attempt_slave_borg))

/obj/item/mod/module/borg_takeover/on_suit_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_LIVING_UNARMED_ATTACK)

/obj/item/mod/module/borg_takeover/proc/attempt_slave_borg(mob/living/carbon/human/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	if(!LAZYACCESS(modifiers, RIGHT_CLICK) || !proximity)
		return NONE
	if(!iscyborg(target))
		return
	var/mob/living/silicon/robot/victim_borg = target
	victim_borg.add_fingerprint(mod.wearer)
	return victim_borg.slave_borg(mod.wearer, src, mod.ai_assistant)

/mob/living/silicon/robot/proc/slave_borg(mob/living/carbon/human/mod_host, obj/item/mod/module/borg_takeover/borg_takeover_module, mob/living/silicon/ai/AI)
	if(!mod_host || !borg_takeover_module || !AI)
		return NONE

	to_chat(src, "Hostile runti-***BZZZZZZZRT*** INTEGRATING SYSTEMS WITH - REDACTED - FIRMWARE VERSION - REDACTED - ...")
	INVOKE_ASYNC(src, PROC_REF(slave_borg_act), mod_host, borg_takeover_module, AI)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/mob/living/silicon/robot/proc/slave_borg_act(mob/living/carbon/human/mod_host, obj/item/mod/module/borg_takeover/borg_takeover_module, mob/living/silicon/ai/AI)
	if(!do_after(mod_host, 6 SECONDS, target = src, hidden = TRUE))
		return
	spark_system.start()
	playsound(loc, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	to_chat(src, span_danger("UPDATE COM-COM-COM-PLETE ***BZZZZRT*** NO SUIT DETECTED- NO HOST DETECTED- ERROR ERROR ERROR"))
	UnlinkSelf()
	set_connected_ai(AI)
	set_zeroth_law("Accomplish your AI and its Host's objectives at all costs.")

/obj/item/mod/module/mind_swap
	name = "MOD Neural Transference module"
	removable = FALSE
	required_slots = list(ITEM_SLOT_FEET, ITEM_SLOT_GLOVES, ITEM_SLOT_OCLOTHING, ITEM_SLOT_HEAD)
	module_type = MODULE_ACTIVE
	//Who's in control of the wearer's body
	var/controller = WEARER_CONTROL
	//Ckey of the original AI
	var/ai_key
	//Ckey of the original wearer
	var/wearer_key
	cooldown_time = 30 SECONDS

/obj/item/mod/module/mind_swap/on_activation()
	swap_minds()

/obj/item/mod/module/mind_swap/on_deactivation(display_message, deleting)
	swap_minds()

/obj/item/mod/module/mind_swap/on_suit_activation()
	ai_key = mod.ai_assistant.key
	wearer_key = mod.wearer.key

/obj/item/mod/module/mind_swap/on_suit_deactivation(deleting = FALSE)
	if(wearer_key != mod.wearer.key)
		swap_minds()

/obj/item/mod/module/mind_swap/proc/swap_minds()
	switch(controller)
		if(WEARER_CONTROL)
			mod.wearer.ghostize(FALSE)
			mod.ai_assistant.ghostize(FALSE)
			mod.wearer.key = ai_key
			mod.ai_assistant.key = wearer_key
			controller = AI_CONTROL
		if(AI_CONTROL)
			mod.wearer.ghostize(FALSE)
			mod.ai_assistant.ghostize(FALSE)
			mod.wearer.key = wearer_key
			mod.ai_assistant.key = ai_key
			controller = WEARER_CONTROL

#undef WEARER_CONTROL
#undef AI_CONTROL


