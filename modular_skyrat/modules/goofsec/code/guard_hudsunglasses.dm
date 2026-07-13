#define HONK_CURSE_COOLDOWN (90 SECONDS)
#define HONK_CURSE_EMAGGED_COOLDOWN (30 SECONDS)
#define HONK_CURSE_DURATION (5 MINUTES)
#define HONK_CURSE_KNOCKDOWN (7 SECONDS)
#define HONK_CURSE_PARALYZE (2 SECONDS)
#define HONK_GAG_HONK "Honk"
#define HONK_GAG_SLIP "Slip"
#define GUN_SPOTTER_RANGE 7
#define GUN_SPOTTER_ICON_OFFSET -8
#define EXECUTIVE_SWITCH_COOLDOWN (2 SECONDS)
#define EXECUTIVE_ABUSE_LIMIT 5
#define EXECUTIVE_MALFUNCTION_INTERVAL (4 SECONDS)
#define EXECUTIVE_REPAIR_TIME (6 SECONDS)
#define EXECUTIVE_REPAIR_CABLE 5
#define EXECUTIVE_PINPOINTER_DIRECT 1
#define EXECUTIVE_MODE_MEDICAL 1
#define EXECUTIVE_MODE_DIAGNOSTIC 2
#define EXECUTIVE_MODE_RESEARCH 3
#define EXECUTIVE_MODE_REAGENT 4
#define EXECUTIVE_MODE_MESON 5
#define EXECUTIVE_MODE_BOOZE 6
#define EXECUTIVE_MODE_FORTUNE 7
#define EXECUTIVE_MODE_APPRAISAL 8

/datum/greyscale_config/guard_hudsunglasses
	name = "Guard HUDsunglasses"
	icon_file = 'modular_skyrat/modules/goofsec/icons/guard_hudsunglasses.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/guard_hudsunglasses/guard_hudsunglasses.json'

/datum/greyscale_config/guard_hudsunglasses/worn
	name = "Guard HUDsunglasses (Worn)"
	icon_file = 'modular_skyrat/modules/goofsec/icons/guard_hudsunglasses_worn.dmi'

/datum/client_colour/glass_colour/guard/medical
	color = "#b0d8f8"

/datum/client_colour/glass_colour/guard/science
	color = "#dba6ff"

/datum/client_colour/glass_colour/guard/engineering
	color = "#afd0bb"

/datum/client_colour/glass_colour/guard/service
	color = "#edc9b8"

/datum/client_colour/glass_colour/guard/customs
	color = "#c1d2e1"

/datum/client_colour/glass_colour/guard/command
	color = "#eddcb4"

/datum/client_colour/glass_colour/guard/blueshield
	color = "#c3cade"

/datum/client_colour/glass_colour/guard/silly
	color = "#ffd6e8"

/obj/item/clothing/glasses/hud/security/sunglasses/guard
	gender = PLURAL
	name = "guard HUDsunglasses"
	desc = "Sunglasses with a security HUD. The mirrored grey lenses are perfect for acquiring strange developer items you aren't supposed to have."
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard"
	post_init_icon_state = "guard_hudsunglasses"
	greyscale_config = /datum/greyscale_config/guard_hudsunglasses
	greyscale_config_worn = /datum/greyscale_config/guard_hudsunglasses/worn
	greyscale_colors = "#585858#9aa0a6"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/glasses/hud/security/sunglasses/guard/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_EYES))
		return
	update_extras(user)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/dropped(mob/living/user)
	. = ..()
	clear_extras(user)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/toggle_hud_display(mob/living/carbon/eye_owner)
	. = ..()
	update_extras(eye_owner)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/proc/update_extras(mob/living/wearer)
	return

/obj/item/clothing/glasses/hud/security/sunglasses/guard/proc/clear_extras(mob/living/wearer)
	return

/obj/item/clothing/glasses/hud/security/sunglasses/guard/medical
	name = "medsec HUDsunglasses"
	desc = "Sunglasses with a combined medical and security HUD. The ice blue mirror lenses are perfect for knowing precisely how hard to beat someone without landing yourself a malpractice suit."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/medical"
	clothing_traits = list(TRAIT_SECURITY_HUD, TRAIT_MEDICAL_HUD)
	greyscale_colors = "#585858#1d8fec"
	glass_colour_type = /datum/client_colour/glass_colour/guard/medical
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/science
	name = "scisec HUDsunglasses"
	desc = "Sunglasses with a combined research and security HUD. The deep purple mirror lenses are perfect for working out exactly how far away you should be from whatever station-killing disaster the lab boys are cooking up today."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/science"
	clothing_traits = list(TRAIT_SECURITY_HUD, TRAIT_RESEARCH_SCANNER)
	greyscale_colors = "#585858#9900ff"
	glass_colour_type = /datum/client_colour/glass_colour/guard/science
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.85, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 1)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/engineering
	name = "meson HUDsunglasses"
	desc = "Sunglasses with a combined meson and security HUD. The forest green mirror lenses see straight through walls, which turns out to be less useful for catching criminals than you'd hope."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/engineering"
	greyscale_colors = "#585858#1a7a3e"
	vision_flags = SEE_TURFS
	glass_colour_type = /datum/client_colour/glass_colour/guard/engineering
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/engineering/update_extras(mob/living/wearer)
	vision_flags = display_active ? SEE_TURFS : NONE
	wearer.update_sight()

/obj/item/clothing/glasses/hud/security/sunglasses/guard/engineering/clear_extras(mob/living/wearer)
	wearer.update_sight()

/obj/item/clothing/glasses/hud/security/sunglasses/guard/service
	name = "service HUDsunglasses"
	desc = "Sunglasses with a combined bartending and security HUD. The amber mirror lenses are perfect for figuring out what the clown just spiked all the drinks with."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/service"
	clothing_traits = list(TRAIT_SECURITY_HUD, TRAIT_BOOZE_SLIDER, TRAIT_REAGENT_SCANNER)
	greyscale_colors = "#585858#cc6633"
	glass_colour_type = /datum/client_colour/glass_colour/guard/service

/obj/item/clothing/glasses/hud/security/sunglasses/guard/customs
	name = "customs HUDsunglasses"
	desc = "Sunglasses with a combined appraisal and security HUD. The steely blue mirror lenses are scientifically proven to intimidate 20% of assistants out of smuggling plasma."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/customs"
	greyscale_colors = "#585858#4d7ea8"
	glass_colour_type = /datum/client_colour/glass_colour/guard/customs

/obj/item/clothing/glasses/hud/security/sunglasses/guard/customs/update_extras(mob/living/wearer)
	if(display_active)
		wearer.AddComponent(/datum/component/money_sense/customs)
		return
	clear_extras(wearer)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/customs/clear_extras(mob/living/wearer)
	qdel(wearer.GetComponent(/datum/component/money_sense/customs))

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command
	name = "executive HUDsunglasses"
	desc = "Sunglasses that incorporate a security HUD, along with every other possible HUD, and then two more nobody asked for. The gold mirror lenses cycle through eleven proprietary Nanotrasen sensor suites at the touch of a button and are perfect for letting people know you're the king. They're worth as much as some frontier colonies and twice as fragile, so don't accidentally sit on them."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/command"
	greyscale_colors = "#585858#d4a23a"
	glass_colour_type = /datum/client_colour/glass_colour/guard/command
	actions_types = list(/datum/action/item_action/toggle_wearable_hud, /datum/action/item_action/toggle/executive_hud)
	var/mode = EXECUTIVE_MODE_MEDICAL
	var/malfunctioning = FALSE
	var/abuse_count = 0
	COOLDOWN_DECLARE(switch_cooldown)
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/examine(mob/user)
	. = ..()
	. += span_notice("Auxiliary suite: [get_mode_name()].")
	if(malfunctioning)
		. += span_warning("Some idiot broke it. You could try resetting it to factory settings with a <b>Multitool</b> and some <b>cable</b>.")

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/proc/get_mode_name()
	switch(mode)
		if(EXECUTIVE_MODE_DIAGNOSTIC)
			return "Diagnostic"
		if(EXECUTIVE_MODE_RESEARCH)
			return "Research"
		if(EXECUTIVE_MODE_REAGENT)
			return "Reagent"
		if(EXECUTIVE_MODE_MESON)
			return "Structural"
		if(EXECUTIVE_MODE_BOOZE)
			return "Refreshment Locator"
		if(EXECUTIVE_MODE_FORTUNE)
			return "Asset Locator"
		if(EXECUTIVE_MODE_APPRAISAL)
			return "Appraisal"
	return "Medical"

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/update_extras(mob/living/wearer)
	if(!iscarbon(wearer))
		return
	wearer.remove_status_effect(/datum/status_effect/agent_pinpointer/executive/booze)
	wearer.remove_status_effect(/datum/status_effect/agent_pinpointer/executive/fortune)

	vision_flags = NONE
	qdel(wearer.GetComponent(/datum/component/money_sense/customs))
	if(!display_active)
		wearer.update_sight()
		return

	switch(mode)
		if(EXECUTIVE_MODE_MESON)
			vision_flags = SEE_TURFS
		if(EXECUTIVE_MODE_BOOZE)
			wearer.apply_status_effect(/datum/status_effect/agent_pinpointer/executive/booze)
		if(EXECUTIVE_MODE_FORTUNE)
			wearer.apply_status_effect(/datum/status_effect/agent_pinpointer/executive/fortune)
		if(EXECUTIVE_MODE_APPRAISAL)
			wearer.AddComponent(/datum/component/money_sense/customs)
	wearer.update_sight()

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/clear_extras(mob/living/wearer)
	wearer.remove_status_effect(/datum/status_effect/agent_pinpointer/executive/booze)
	wearer.remove_status_effect(/datum/status_effect/agent_pinpointer/executive/fortune)
	qdel(wearer.GetComponent(/datum/component/money_sense/customs))
	wearer.update_sight()

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/proc/apply_mode(mob/living/carbon/wearer)
	if(!istype(wearer) || wearer.glasses != src)
		return

	for(var/trait in clothing_traits)
		REMOVE_CLOTHING_TRAIT(wearer, trait)

	clothing_traits = list(TRAIT_SECURITY_HUD)
	switch(mode)
		if(EXECUTIVE_MODE_MEDICAL)
			clothing_traits += TRAIT_MEDICAL_HUD
		if(EXECUTIVE_MODE_DIAGNOSTIC)
			clothing_traits += TRAIT_DIAGNOSTIC_HUD
		if(EXECUTIVE_MODE_RESEARCH)
			clothing_traits += TRAIT_RESEARCH_SCANNER
		if(EXECUTIVE_MODE_REAGENT)
			clothing_traits += TRAIT_REAGENT_SCANNER

	if(display_active)
		for(var/trait in clothing_traits)
			ADD_CLOTHING_TRAIT(wearer, trait)

	update_extras(wearer)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/proc/cycle_mode(mob/living/carbon/wearer, silent = FALSE)
	mode++
	if(mode > EXECUTIVE_MODE_APPRAISAL)
		mode = EXECUTIVE_MODE_MEDICAL
	apply_mode(wearer)
	if(silent)
		return
	balloon_alert(wearer, get_mode_name())
	playsound(src, 'sound/machines/terminal/terminal_select.ogg', 25, vary = TRUE)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/proc/on_action(mob/living/carbon/wearer)
	if(malfunctioning)
		balloon_alert(wearer, "selector jammed!")
		return

	if(!COOLDOWN_FINISHED(src, switch_cooldown))
		abuse_count++
		if(abuse_count >= EXECUTIVE_ABUSE_LIMIT)
			start_malfunction(wearer)
			return
	else
		abuse_count = 0

	COOLDOWN_START(src, switch_cooldown, EXECUTIVE_SWITCH_COOLDOWN)
	cycle_mode(wearer)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/proc/start_malfunction(mob/living/carbon/wearer)
	malfunctioning = TRUE
	abuse_count = 0
	playsound(src, 'sound/effects/snap.ogg', 60, vary = TRUE)
	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 40, vary = TRUE)
	to_chat(wearer, span_warning("Something inside [src] gives a distinctly unpremium snap."))
	START_PROCESSING(SSprocessing, src)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/process(seconds_per_tick)
	if(!malfunctioning)
		STOP_PROCESSING(SSprocessing, src)
		return
	if(!COOLDOWN_FINISHED(src, switch_cooldown))
		return

	COOLDOWN_START(src, switch_cooldown, EXECUTIVE_MALFUNCTION_INTERVAL)
	var/mob/living/carbon/wearer = loc
	if(!istype(wearer) || wearer.glasses != src)
		return
	mode = rand(EXECUTIVE_MODE_MEDICAL, EXECUTIVE_MODE_APPRAISAL)
	apply_mode(wearer)
	balloon_alert(wearer, get_mode_name())

/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/multitool_act(mob/living/user, obj/item/multitool/tool)
	. = ..()
	if(!malfunctioning)
		return

	var/obj/item/stack/cable_coil/coil = locate() in user.get_all_contents()
	if(!coil)
		balloon_alert(user, "no cable!")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "resetting...")
	if(!do_after(user, EXECUTIVE_REPAIR_TIME, target = src))
		return ITEM_INTERACT_BLOCKING
	if(!malfunctioning)
		return ITEM_INTERACT_BLOCKING
	if(!coil.use(EXECUTIVE_REPAIR_CABLE))
		balloon_alert(user, "not enough cable!")
		return ITEM_INTERACT_BLOCKING

	malfunctioning = FALSE
	STOP_PROCESSING(SSprocessing, src)
	balloon_alert(user, "selector reseated")
	playsound(src, 'sound/machines/terminal/terminal_select.ogg', 25, vary = TRUE)
	return ITEM_INTERACT_SUCCESS

/datum/action/item_action/toggle/executive_hud
	name = "Cycle Sensor Suite"

/datum/action/item_action/toggle/executive_hud/do_effect(trigger_flags)
	var/obj/item/clothing/glasses/hud/security/sunglasses/guard/command/shades = target
	if(!istype(shades) || !iscarbon(owner))
		return
	shades.on_action(owner)
	return TRUE

GLOBAL_LIST_EMPTY(executive_refreshments)
GLOBAL_LIST_EMPTY(executive_valuables)

/obj/item/reagent_containers/cup/Initialize(mapload, vol)
	. = ..()
	GLOB.executive_refreshments += src

/obj/item/reagent_containers/cup/Destroy()
	GLOB.executive_refreshments -= src
	return ..()

/obj/item/holochip/Initialize(mapload, amount = 1)
	. = ..()
	GLOB.executive_valuables += src

/obj/item/holochip/Destroy()
	GLOB.executive_valuables -= src
	return ..()

/obj/item/coin/Initialize(mapload)
	. = ..()
	GLOB.executive_valuables += src

/obj/item/coin/Destroy()
	GLOB.executive_valuables -= src
	return ..()

/obj/item/stack/spacecash/Initialize(mapload, new_amount, merge = TRUE, list/mat_override = null, mat_amt = 1)
	. = ..()
	GLOB.executive_valuables += src

/obj/item/stack/spacecash/Destroy()
	GLOB.executive_valuables -= src
	return ..()

/atom/movable/screen/alert/status_effect/agent_pinpointer/executive
	icon = 'modular_skyrat/modules/goofsec/icons/executive_pinpointer.dmi'

/atom/movable/screen/alert/status_effect/agent_pinpointer/executive/booze
	name = "Refreshment Locator"
	desc = "A proprietary Nanotrasen sensor suite. It points, unerringly, at the nearest alcohol."

/atom/movable/screen/alert/status_effect/agent_pinpointer/executive/fortune
	name = "Asset Locator"
	desc = "A proprietary Nanotrasen sensor suite. It points, unerringly, at the nearest loose credits."

/datum/status_effect/agent_pinpointer/executive
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/executive
	minimum_range = EXECUTIVE_PINPOINTER_DIRECT
	range_fuzz_factor = 0

/datum/status_effect/agent_pinpointer/executive/on_apply()
	. = ..()
	if(!.)
		return
	scan_for_target()
	point_to_target()

/datum/status_effect/agent_pinpointer/executive/scan_for_target()
	scan_target = null
	var/turf/here = get_turf(owner)
	if(!here)
		return

	var/closest = INFINITY
	for(var/atom/movable/candidate as anything in get_candidates())
		var/turf/there = get_turf(candidate)
		if(!there || there.z != here.z)
			continue
		var/distance = get_dist(here, there)
		if(distance >= closest)
			continue
		if(!matches(candidate))
			continue
		closest = distance
		scan_target = candidate

/datum/status_effect/agent_pinpointer/executive/proc/get_candidates()
	return list()

/datum/status_effect/agent_pinpointer/executive/proc/matches(atom/movable/thing)
	return FALSE

/datum/status_effect/agent_pinpointer/executive/booze
	id = "executive_booze"
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/executive/booze

/datum/status_effect/agent_pinpointer/executive/booze/get_candidates()
	return GLOB.executive_refreshments

/datum/status_effect/agent_pinpointer/executive/booze/matches(atom/movable/thing)
	var/obj/item/reagent_containers/cup/container = thing
	return container.reagents?.has_reagent(/datum/reagent/consumable/ethanol, check_subtypes = TRUE)

/datum/status_effect/agent_pinpointer/executive/fortune
	id = "executive_fortune"
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/executive/fortune

/datum/status_effect/agent_pinpointer/executive/fortune/get_candidates()
	return GLOB.executive_valuables

/datum/status_effect/agent_pinpointer/executive/fortune/matches(atom/movable/thing)
	return TRUE

/datum/objective_item/steal/executive_hudsunglasses
	name = "the captain's executive HUDsunglasses"
	targetitem = /obj/item/clothing/glasses/hud/security/sunglasses/guard/command
	excludefromjob = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "Gold-plated sunglasses, worn by the Captain. Eleven sensor suites, two of which find booze and money."

/obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield
	name = "blueshield HUDsunglasses"
	desc = "Sunglasses with a security HUD. The midnight blue mirror lenses are perfect for reflecting the terrified faces of your victims, right up until Central Command court-martials you for dereliction of your duty to LARP as a SWAT officer instead of a bodyguard. A threat detection suite flags anyone holding a gun."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield"
	greyscale_colors = "#585858#3f52a8"
	glass_colour_type = /datum/client_colour/glass_colour/guard/blueshield
	actions_types = list(/datum/action/item_action/toggle_wearable_hud, /datum/action/item_action/toggle/blueshield_tds)
	var/threat_detection = TRUE
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield/examine(mob/user)
	. = ..()
	. += span_notice("The threat detection suite is [threat_detection ? "armed" : "standing down"].")

/obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield/update_extras(mob/living/wearer)
	if(!display_active || !threat_detection)
		clear_extras(wearer)
		return
	wearer.AddComponent(/datum/component/gun_spotter)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield/clear_extras(mob/living/wearer)
	qdel(wearer.GetComponent(/datum/component/gun_spotter))

/obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield/proc/toggle_threat_detection(mob/living/wearer)
	threat_detection = !threat_detection
	update_extras(wearer)
	balloon_alert(wearer, threat_detection ? "threat detection armed" : "threat detection off")
	playsound(src, 'sound/machines/terminal/terminal_select.ogg', 25, vary = TRUE)

/datum/action/item_action/toggle/blueshield_tds
	name = "Toggle Threat Detection"

/datum/action/item_action/toggle/blueshield_tds/do_effect(trigger_flags)
	var/obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield/shades = target
	if(!istype(shades) || !isliving(owner))
		return
	shades.toggle_threat_detection(owner)
	return TRUE

/obj/item/clothing/glasses/hud/security/sunglasses/guard/silly
	name = "silly HUDsunglasses"
	desc = "Sunglasses with a security HUD. The mirrored pink lenses are the clearest available evidence of an absent or malevolent god."
	icon_state = "/obj/item/clothing/glasses/hud/security/sunglasses/guard/silly"
	greyscale_colors = "#585858#ff69b4"
	glass_colour_type = /datum/client_colour/glass_colour/guard/silly
	COOLDOWN_DECLARE(honk_cooldown)
	custom_materials = list(/datum/material/bananium = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/silly/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/clothing/glasses/hud/security/sunglasses/guard/silly/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(!.)
		return
	balloon_alert(user, "safety interlock removed")

/obj/item/clothing/glasses/hud/security/sunglasses/guard/silly/attack_self(mob/user, modifiers)
	. = ..()
	playsound(src, 'sound/items/bikehorn.ogg', 50, vary = TRUE)
	user.visible_message(span_warning("[user] adjusts [src]. The lenses honk."), span_notice("You adjust [src]. The lenses honk. This is, somehow, load-bearing."))

// the sechud status field routes here while these are worn
/obj/item/clothing/glasses/hud/security/sunglasses/guard/silly/proc/issue_gag(mob/living/clown, mob/living/victim)
	if(!display_active)
		balloon_alert(clown, "hud disabled")
		return
	if(!COOLDOWN_FINISHED(src, honk_cooldown))
		balloon_alert(clown, "recharging")
		return

	var/chosen_gag = tgui_input_list(clown, "Specify a new criminal status for this person.", "Security HUD", list(HONK_GAG_HONK, HONK_GAG_SLIP))
	if(!chosen_gag || !COOLDOWN_FINISHED(src, honk_cooldown))
		return
	if(QDELETED(victim) || !(victim in view(clown)))
		return

	COOLDOWN_START(src, honk_cooldown, (obj_flags & EMAGGED) ? HONK_CURSE_EMAGGED_COOLDOWN : HONK_CURSE_COOLDOWN)
	victim.apply_status_effect(/datum/status_effect/honk_curse, chosen_gag)

/datum/status_effect/honk_curse
	id = "honk_curse"
	duration = HONK_CURSE_DURATION
	alert_type = null
	var/gag = HONK_GAG_HONK

/datum/status_effect/honk_curse/on_creation(mob/living/new_owner, chosen_gag = HONK_GAG_HONK)
	gag = chosen_gag
	return ..()

/datum/status_effect/honk_curse/on_apply()
	RegisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_overlays_updated))
	owner.update_appearance(UPDATE_OVERLAYS)
	addtimer(CALLBACK(src, PROC_REF(deliver_gag)), rand(1 SECONDS, HONK_CURSE_DURATION))
	return TRUE

/datum/status_effect/honk_curse/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS)
	owner.update_appearance(UPDATE_OVERLAYS)

/datum/status_effect/honk_curse/proc/on_overlays_updated(atom/source, list/overlays)
	SIGNAL_HANDLER

	var/mutable_appearance/sticker = mutable_appearance(
		'modular_skyrat/modules/goofsec/icons/honk_holograms.dmi',
		(gag == HONK_GAG_SLIP) ? "slip" : "honk",
		ABOVE_MOB_LAYER,
		appearance_flags = KEEP_APART | RESET_COLOR | RESET_ALPHA,
	)
	overlays += sticker

/datum/status_effect/honk_curse/proc/deliver_gag()
	if(QDELETED(owner))
		return

	playsound(owner, 'sound/items/bikehorn.ogg', 70, vary = TRUE)
	if(gag == HONK_GAG_SLIP)
		owner.slip(HONK_CURSE_KNOCKDOWN, lube_flags = SLIDE | GALOSHES_DONT_HELP, paralyze = HONK_CURSE_PARALYZE, force_drop = TRUE)
		owner.visible_message(span_warning("[owner] slips on absolutely nothing."), span_userdanger("You slip on absolutely nothing."))
	else
		owner.visible_message(span_warning("[owner] honks. Involuntarily. From somewhere."), span_userdanger("You honk. You do not know how, and you do not know why."))
	qdel(src)

// flags anyone in view holding a gun, wearer only. the clown is always a threat
/datum/component/gun_spotter
	var/list/image/spotted

/datum/component/gun_spotter/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	spotted = list()
	START_PROCESSING(SSprocessing, src)

/datum/component/gun_spotter/Destroy(force)
	STOP_PROCESSING(SSprocessing, src)
	clear_images()
	return ..()

/datum/component/gun_spotter/proc/clear_images()
	var/mob/living/watcher = parent
	if(watcher?.client)
		for(var/image/spot as anything in spotted)
			watcher.client.images -= spot
	spotted.Cut()

/datum/component/gun_spotter/proc/is_threat(mob/living/carbon/suspect)
	var/datum/job/their_job = suspect.mind?.assigned_role
	if(their_job?.title == JOB_CLOWN)
		return TRUE
	if(their_job?.job_flags & JOB_HEAD_OF_STAFF)
		return FALSE
	for(var/obj/item/held as anything in suspect.held_items)
		if(isgun(held))
			return TRUE
	return FALSE

/datum/component/gun_spotter/process(seconds_per_tick)
	var/mob/living/watcher = parent
	if(QDELETED(watcher) || !watcher.client)
		return

	clear_images()
	for(var/mob/living/carbon/suspect in view(GUN_SPOTTER_RANGE, watcher))
		if(suspect == watcher || !is_threat(suspect))
			continue
		var/image/spot = image('icons/mob/huds/hud.dmi', suspect, "hudalert-red")
		spot.plane = ABOVE_LIGHTING_PLANE
		spot.pixel_x = GUN_SPOTTER_ICON_OFFSET
		animate(spot, alpha = 90, time = 0.6 SECONDS, loop = -1)
		animate(alpha = 255, time = 0.6 SECONDS)
		spotted += spot
		watcher.client.images += spot

// appraisal nifsoft's component plus a contraband sweep. the isobj() check keeps this off people
/datum/component/money_sense/customs

/datum/component/money_sense/customs/add_examine(mob/user, atom/target)
	. = ..()
	if(!isobj(target))
		return

	var/obj/examined_obj = target
	if(HAS_TRAIT(examined_obj, TRAIT_CONTRABAND))
		to_chat(parent, span_danger("Warning: contraband detected. Document this item and surrender it to Security immediately."))
		return

	if(isgun(examined_obj))
		to_chat(parent, span_warning("Firearm detected. Check the registration against the manifest."))
		return

	var/contraband_inside = FALSE
	var/firearm_inside = FALSE
	for(var/obj/item/stashed_item in examined_obj.get_all_contents_skipping_traits(TRAIT_CONTRABAND_BLOCKER))
		if(stashed_item == examined_obj)
			continue
		if(HAS_TRAIT(stashed_item, TRAIT_CONTRABAND))
			contraband_inside = TRUE
		if(isgun(stashed_item))
			firearm_inside = TRUE
		if(contraband_inside && firearm_inside)
			break

	if(contraband_inside)
		to_chat(parent, span_danger("Warning: contraband detected inside [examined_obj]. Document the container and surrender it to Security immediately."))
	if(firearm_inside)
		to_chat(parent, span_warning("Firearm detected inside [examined_obj]. Check the registration against the manifest."))

/datum/crafting_recipe/hudsunguardmed
	name = "Medsec HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/guard/medical
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_EQUIPMENT

/datum/crafting_recipe/hudsunguardsci
	name = "Scisec HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/guard/science
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/sunglasses/chemical = 1,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_EQUIPMENT

/datum/crafting_recipe/hudsunguardengi
	name = "Meson HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/guard/engineering
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/meson = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_EQUIPMENT

/datum/crafting_recipe/hudsunguardsrv
	name = "Service HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/guard/service
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/sunglasses/reagent = 1,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_EQUIPMENT

/datum/crafting_recipe/hudsunguardcargo
	name = "Customs HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/guard/customs
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/universal_scanner = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_EQUIPMENT

/datum/crafting_recipe/hudsunguardblueshield
	name = "Blueshield HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/guard/blueshield
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/sheet/mineral/diamond = 1,
		/obj/item/stack/sheet/mineral/silver = 5,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_EQUIPMENT

/datum/crafting_recipe/hudsunguardsilly
	name = "Silly HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/guard/silly
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/sheet/mineral/bananium = 5,
		/obj/item/stack/cable_coil = 5,
	)
	category = CAT_EQUIPMENT

#undef HONK_CURSE_COOLDOWN
#undef HONK_CURSE_EMAGGED_COOLDOWN
#undef HONK_CURSE_DURATION
#undef HONK_CURSE_KNOCKDOWN
#undef HONK_CURSE_PARALYZE
#undef HONK_GAG_HONK
#undef HONK_GAG_SLIP
#undef GUN_SPOTTER_RANGE
#undef GUN_SPOTTER_ICON_OFFSET
#undef EXECUTIVE_SWITCH_COOLDOWN
#undef EXECUTIVE_ABUSE_LIMIT
#undef EXECUTIVE_MALFUNCTION_INTERVAL
#undef EXECUTIVE_REPAIR_TIME
#undef EXECUTIVE_REPAIR_CABLE
#undef EXECUTIVE_PINPOINTER_DIRECT
#undef EXECUTIVE_MODE_MEDICAL
#undef EXECUTIVE_MODE_DIAGNOSTIC
#undef EXECUTIVE_MODE_RESEARCH
#undef EXECUTIVE_MODE_REAGENT
#undef EXECUTIVE_MODE_MESON
#undef EXECUTIVE_MODE_BOOZE
#undef EXECUTIVE_MODE_FORTUNE
#undef EXECUTIVE_MODE_APPRAISAL
