#define AI_CONTROL 0
#define WEARER_CONTROL 1

/obj/item/mod/module/borg_takeover
	name = "MOD Silicon Takeover module"
	removable = FALSE

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


