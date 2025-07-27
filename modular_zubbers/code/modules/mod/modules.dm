/obj/item/mod/module/mind_swap
	name = "MOD Neural Transference module"
	desc = "Swaps the MOD wearer's and Assistant AI's neural pathways."
	removable = FALSE
	required_slots = list(ITEM_SLOT_FEET, ITEM_SLOT_GLOVES, ITEM_SLOT_OCLOTHING, ITEM_SLOT_HEAD)
	module_type = MODULE_ACTIVE
	//Who's in control of the wearer's body
	var/ai_control = FALSE
	//Ckey of the original AI
	var/ai_key
	//Ckey of the original wearer
	var/wearer_key
	cooldown_time = 30 SECONDS

/obj/item/mod/module/mind_swap/on_select()
	if(!mod.ai_assistant)
		balloon_alert(mod.wearer, "no AI present")
		return
	if(isnull(mod.wearer.client))
		balloon_alert(mod.ai_assistant, "host is unresponsive")
		return
	if(isnull(mod.ai_assistant.client))
		balloon_alert(mod.wearer, UNLINT("AI is unresponsive"))
		return
	return ..()

/obj/item/mod/module/mind_swap/on_activation()
	swap_minds()

/obj/item/mod/module/mind_swap/on_deactivation(display_message, deleting)
	swap_minds()

/obj/item/mod/module/mind_swap/on_part_activation()
	ai_key = mod.ai_assistant?.key
	wearer_key = mod.wearer.key
	ai_control = FALSE

/obj/item/mod/module/mind_swap/on_part_deactivation(deleting = FALSE)
	if(wearer_key != mod.wearer.key)
		swap_minds()

/obj/item/mod/module/mind_swap/proc/swap_minds()
	if(!mod.ai_assistant)
		mod.wearer.ghostize(FALSE)
		mod.ai_assistant.key = ai_key
		return
	mod.wearer.ghostize(FALSE)
	mod.ai_assistant.ghostize(FALSE)
	if(ai_control)
		mod.wearer.key = wearer_key
		mod.ai_assistant.key = ai_key
	else
		mod.wearer.key = ai_key
		mod.ai_assistant.key = wearer_key
	ai_control = !ai_control

