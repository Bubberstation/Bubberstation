/// Items the advanced broom can move per lane in one sweep, against 20 for a plain one
#define ADVANCED_BROOM_PUSH_LIMIT 15
/// Movement penalty while the bristles are charged
#define ADVANCED_BROOM_SLOWDOWN 0.5

/obj/item/pushbroom/advanced
	name = "advanced push broom"
	desc = "A compact push broom, the less-famous overall-clad brother of the advanced mop. Its powered bristles can be enabled to generate a broad electrostatic sweep, gathering loose debris across a much wider area than its size would suggest."
	icon = 'modular_zubbers/icons/obj/service/advanced_broom.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/advanced_broom_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/advanced_broom_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	push_limit = ADVANCED_BROOM_PUSH_LIMIT
	var/wide_sweep = FALSE

/obj/item/pushbroom/advanced/examine(mob/user)
	. = ..()
	. += span_notice("The bristle charge is set to <b>[wide_sweep ? "ON" : "OFF"]</b>.")

/obj/item/pushbroom/advanced/update_overlays()
	. = ..()
	if(!wide_sweep)
		return
	. += mutable_appearance(icon, "broom_charge")
	. += emissive_appearance(icon, "broom_charge", src)

/obj/item/pushbroom/advanced/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(slot & ITEM_SLOT_HANDS)
		ADD_TRAIT(user, TRAIT_NO_SLIP_WATER, REF(src))
	else
		REMOVE_TRAIT(user, TRAIT_NO_SLIP_WATER, REF(src))

/obj/item/pushbroom/advanced/dropped(mob/user, silent = FALSE)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_NO_SLIP_WATER, REF(src))
	set_wide_sweep(user, FALSE)

/obj/item/pushbroom/advanced/on_wield(obj/item/source, mob/user)
	. = ..()
	set_wide_sweep(user, TRUE)

/obj/item/pushbroom/advanced/on_unwield(obj/item/source, mob/user)
	. = ..()
	set_wide_sweep(user, FALSE)

/obj/item/pushbroom/advanced/proc/set_wide_sweep(mob/user, charged)
	if(wide_sweep == charged)
		return
	wide_sweep = charged
	slowdown = wide_sweep ? ADVANCED_BROOM_SLOWDOWN : initial(slowdown)
	update_appearance()
	if(!isliving(user))
		return
	var/mob/living/holder = user
	holder.update_equipment_speed_mods()
	playsound(holder, wide_sweep ? 'sound/machines/synth/synth_yes.ogg' : 'sound/machines/synth/synth_no.ogg', 40, TRUE, frequency = rand(5120, 8800))
	holder.balloon_alert(holder, "bristle charge [wide_sweep ? "on" : "off"]")

/obj/item/pushbroom/advanced/sweep(mob/user, atom/atom)
	. = ..()
	if(!wide_sweep)
		return
	var/turf/center = isturf(atom) ? atom : atom?.loc
	if(!isturf(center))
		return
	if(ISDIAGONALDIR(user.dir)) // a diagonal flank lands two tiles off the line
		return
	for(var/flank_dir in list(turn(user.dir, 90), turn(user.dir, -90)))
		var/turf/flank = get_step(center, flank_dir)
		if(!flank)
			continue
		do_sweep(src, user, flank, user.dir, push_limit)

/obj/item/pushbroom/advanced/augment
	always_braced = TRUE

// put_in_hand never calls pickup(), so this hooks equip instead
/obj/item/pushbroom/advanced/augment/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(slot & ITEM_SLOT_HANDS)
		RegisterSignal(user, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(sweep), override = TRUE)
	else
		UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)

/obj/item/pushbroom/advanced/augment/dropped(mob/user, silent = FALSE)
	. = ..()
	UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)

// deliberately skips parent so the implant never sees attack_self, same as the welder
/obj/item/pushbroom/advanced/augment/attack_self(mob/user, modifiers)
	set_wide_sweep(user, !wide_sweep)

/datum/design/advbroom
	name = "Advanced Push Broom"
	desc = "A compact push broom with powered bristles, able to sweep a wide path of debris at once."
	id = "advbroom"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/pushbroom/advanced
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

#undef ADVANCED_BROOM_PUSH_LIMIT
#undef ADVANCED_BROOM_SLOWDOWN
