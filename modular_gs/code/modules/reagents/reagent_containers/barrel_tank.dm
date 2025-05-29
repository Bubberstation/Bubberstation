//chug tank
/obj/item/reagent_containers/barrel_tank
	name = "barrel tank"
	desc = "A wooden barrely with straps and a tube attached. One can only wonder what it's for."
	icon = 'GainStation13/icons/obj/barrel_tank.dmi'
	icon_state = "barrel_tank"
	item_state = "barrel_tank"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	reagent_flags = REFILLABLE | TRANSPARENT
	actions_types = list(/datum/action/item_action/toggle_tube)

	var/mob/living/carbon/U = null
	var/transfer_amount = 1

	amount_per_transfer_from_this = 0
	possible_transfer_amounts = list(0)
	volume = 500
	spillable = FALSE

/datum/action/item_action/toggle_tube //GS13
	name = "Toggle Tube"

/obj/item/reagent_containers/barrel_tank/ui_action_click(mob/user)
	toggle_tube(user)

/obj/item/reagent_containers/barrel_tank/proc/toggle_tube(mob/living/user)
	if(!istype(user))
		return
	if(user.get_item_by_slot(user.getBackSlot()) != src)
		to_chat(user, "<span class='warning'>The barrel must be worn properly to use!</span>")
		return
	if(user.incapacitated())
		return

	if(!U)
		to_chat(user, "<span class='notice'>You put the barrel's tube in your mouth.</span>")
		U = user
		START_PROCESSING(SSobj, src)
	else
		to_chat(user, "<span class='notice'>You remove the barrel's tube from your mouth.</span>")
		U = null

/obj/item/reagent_containers/barrel_tank/verb/toggle_tube_verb()
	set name = "Toggle Tube"
	set category = "Object"
	toggle_tube(usr)

/obj/item/reagent_containers/barrel_tank/equipped(mob/user, slot)
	..()
	if(slot !=ITEM_SLOT_BACK && U != null)
		to_chat(user, "<span class='warning'>The barrel's tube slips out of your mouth!</span>")
		U = null

/obj/item/reagent_containers/barrel_tank/dropped(mob/user)
	..()
	U = null

/obj/item/reagent_containers/barrel_tank/process()
	if(U == null)
		return PROCESS_KILL

	if(reagents.total_volume)
		var/fraction = min(1/reagents.total_volume, 1)
		reagents.reaction(U, INGEST, fraction, FALSE)
		reagents.trans_to(U, transfer_amount, 2)
	else
		to_chat(U, "<span class='warning'>The barrel is empty!</span>")
		U = null

/obj/item/reagent_containers/barrel_tank/attack_self(mob/user)
	if(reagents.total_volume > 0)
		to_chat(user, "<span class='notice'>You empty [src] of all reagents.</span>")
		reagents.clear_reagents()

/datum/crafting_recipe/barrel_tank
	name = "Barrel tank"
	result = /obj/item/reagent_containers/barrel_tank
	tools = list(TOOL_CROWBAR)
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20)
	category = CAT_CLOTHING
