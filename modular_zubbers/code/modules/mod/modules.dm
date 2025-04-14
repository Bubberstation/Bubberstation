/obj/item/mod/module/armor_booster/nanotrasen //An "armour booster" for security grade modsuits, to reduce the effectiveness of armoured combat in EVA.
	desc = "A retrofitted series of retractable armor plates, allowing the suit to function as essentially power armor, \
		giving the user incredible protection against conventional firearms, or everyday attacks in close-quarters. \
		However, the additional plating cannot deploy alongside parts of the suit used for vacuum sealing, \
		so this extra armor provides zero ability for extravehicular activity while deployed. \
		This module has been partially reverse engineered from competing combat MOD technology, \
		and does not help reduce the bulkiness of many of the suits it is installed in."
	space_slowdown = 0 //This is to nerf your armour, not buff your modsuit speed
	icon = 'icons/obj/clothing/suits/armor.dmi'
	icon_state = "heavy" //SWAT suit icon, because I want to change the action buttons and these aren't meant to be obtainable outside the suits

//every security, command, etc mod theme has its own armour booster now, taking half the armour values of their current modsuit armour
//see modular_zubbers/code/datums/armor_overrides for modsuit changes
/obj/item/mod/module/armor_booster/nanotrasen/security //secoff modsuits, ERT modsuits also
	armor_mod = /datum/armor/mod_module_armor_boost_security

/datum/armor/mod_module_armor_boost_security
	melee = 20
	bullet = 15
	laser = 15
	energy = 20

/obj/item/mod/module/armor_booster/nanotrasen/security/safeguard //HoS
	desc = "A retrofitted series of retractable armor plates, allowing the suit to function as essentially power armor, \
		giving the user incredible protection against conventional firearms, or everyday attacks in close-quarters. \
		However, the additional plating cannot deploy alongside parts of the suit used for vacuum sealing, \
		so this extra armor provides zero ability for extravehicular activity while deployed. \
		This module has been partially reverse engineered from competing combat MOD technology, \
		though Apadyne has partially mitigated some of the excess power towards improved actuators in the suit."
	space_slowdown = 0.5 //better actuators on the HoS model

/obj/item/mod/module/armor_booster/nanotrasen/magnate //Captain
	armor_mod = /datum/armor/mod_module_armor_boost_magnate

/datum/armor/mod_module_armor_boost_magnate
	melee = 20
	bullet = 20
	laser = 20
	energy = 20

/obj/item/mod/module/armor_booster/nanotrasen/corporate //CENTCOM
	armor_mod = /datum/armor/mod_module_armor_boost_corporate

/datum/armor/mod_module_armor_boost_corporate
	melee = 25
	bullet = 25
	laser = 25
	energy = 25

/obj/item/mod/module/armor_booster/nanotrasen/blueshield
	armor_mod = /datum/armor/mod_module_armor_boost_blueshield

/datum/armor/mod_module_armor_boost_blueshield
	melee = 20
	bullet = 10
	laser = 10
	energy = 15

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

