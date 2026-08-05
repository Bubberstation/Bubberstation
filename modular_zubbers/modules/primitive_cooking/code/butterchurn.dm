#define CHURN_CREAM_RATIO 3 //3:1 milk:cream
#define CHURN_BUTTER_RATIO 10 // 10:1 cream:butter. Slightly worse than using technology.
#define CHURN_STAMINA_MINIMUM 51 //Can use it twice before you really gotta rest.
#define CHURN_STAMINA_USE 50 //Half that of the millstone, since making butter needs you to use it twice.

/obj/structure/butterchurn
	name = "butter churn"
	desc = "A small wooden barrel with a stick that thickens milk into a rich cream, or even butter. Just add an absolutely inordinate amount of effort."
	icon = 'modular_zubbers/icons/obj/structures/butterchurn.dmi'
	icon_state = "butterchurn"
	density = TRUE
	anchored = TRUE
	max_integrity = 120
	pass_flags = PASSTABLE
	resistance_flags = FLAMMABLE
	custom_materials = list(
		/datum/material/wood = SHEET_MATERIAL_AMOUNT  * 8,
	)
	drag_slowdown = 2
	var/busy = FALSE

/obj/structure/butterchurn/Initialize(mapload)
	. = ..()
	create_reagents(100, OPENCONTAINER)
	register_context()

/obj/structure/butterchurn/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(held_item?.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "Disassemble"

	if(!held_item)
		context[SCREENTIP_CONTEXT_LMB] = "Churn Liquid"

	context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = anchored ? "Unsecure" : "Secure"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/butterchurn/examine(mob/user)
	. = ..()
	. += span_notice("You can [anchored ? "un" : ""]secure [src] with <b>CTRL-Shift-Click</b>.")
	. += span_notice("With a <b>prying tool</b> of some sort, you could take [src] apart.")

/obj/structure/butterchurn/atom_deconstruct(disassembled)
	var/obj/item/stack/sheet/mineral/wood/plank = new (drop_location())
	plank.amount = 8
	plank.update_appearance(UPDATE_ICON)
	transfer_fingerprints_to(plank)
	return ..()

/obj/structure/butterchurn/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	balloon_alert_to_viewers("disassembling...")
	if(!do_after(user, 2 SECONDS, src))
		return
	deconstruct(TRUE)

/obj/structure/butterchurn/click_ctrl_shift(mob/user)
	set_anchored(!anchored)
	balloon_alert(user, "[anchored ? "secured" : "unsecured"]")

/obj/structure/butterchurn/attack_hand(mob/living/carbon/user, list/modifiers)
	if(!can_interact(user))
		return

	if(busy)
		to_chat(user, span_warning("Someone's already using \the [src]!"))
		return

	if(user.get_stamina_loss() > CHURN_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return

	if(!reagents.has_reagent(/datum/reagent/consumable/milk) && !reagents.has_reagent(/datum/reagent/consumable/cream))
		balloon_alert(user, "nothing to churn")
		return

	if(!reagents.has_reagent(/datum/reagent/consumable/milk) && reagents.has_reagent(/datum/reagent/consumable/cream) && reagents.get_reagent_amount(/datum/reagent/consumable/cream) < CHURN_BUTTER_RATIO)
		balloon_alert(user, "not enough cream")
		return

	balloon_alert_to_viewers("churning...")
	playsound(src, 'sound/items/tools/crowbar_prying.ogg', 50, TRUE)
	flick("churning", src)

	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	add_fingerprint(user)
	busy = TRUE
	if(!do_after(user, 5 SECONDS * skill_modifier, src))
		busy = FALSE
		balloon_alert_to_viewers("stopped churning")
		return

	var/stamina_use = CHURN_STAMINA_USE
	if(prob(user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
		stamina_use *= 0.5 //so it uses half the amount of stamina (25 instead of 50)
	user.adjust_stamina_loss(stamina_use) // Prevents spamming it
	busy = FALSE
	user.visible_message(span_notice("[user] churns \the [src]."), span_notice("You finish churning \the [src]."))
	var/cream_amt = reagents.get_reagent_amount(/datum/reagent/consumable/milk) / CHURN_CREAM_RATIO
	var/cream_purity = reagents.get_reagent_purity(/datum/reagent/consumable/milk)
	var/butter_amt = FLOOR(reagents.get_reagent_amount(/datum/reagent/consumable/cream) / CHURN_BUTTER_RATIO, 1)
	var/butter_purity = reagents.get_reagent_purity(/datum/reagent/consumable/cream)
	reagents.remove_reagent(/datum/reagent/consumable/cream, 10 * butter_amt)
	for(var/i in 1 to butter_amt)
		var/obj/item/food/butter/tasty_butter = new(drop_location())
		tasty_butter.reagents.set_all_reagents_purity(butter_purity)
	reagents.remove_reagent(/datum/reagent/consumable/milk, reagents.get_reagent_amount(/datum/reagent/consumable/milk))
	reagents.add_reagent(/datum/reagent/consumable/cream, cream_amt, added_purity = cream_purity)


#undef CHURN_CREAM_RATIO
#undef CHURN_BUTTER_RATIO
#undef CHURN_STAMINA_MINIMUM
#undef CHURN_STAMINA_USE
