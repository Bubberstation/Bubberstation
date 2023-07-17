/datum/contractor_item
	/// Name of the item datum
	var/name
	/// Description of the item datum
	var/desc
	/// Item path to spawn, no item path means you need to override `handle_purchase()`
	var/item
	/// fontawesome icon to use inside the hub - https://fontawesome.com/icons/
	var/item_icon = "broadcast-tower"
	/// Any number above 0 for how many times it can be bought in a round for a single traitor. -1 is unlimited.
	var/limited = -1
	/// Cost of the item in contract rep.
	var/cost

/// Subtract cost, and spawn if it's an item.
/datum/contractor_item/proc/handle_purchase(datum/contractor_hub/hub, mob/living/user)

	if(hub.contract_rep >= cost)
		hub.contract_rep -= cost
	else
		return FALSE

	if(limited >= 1)
		limited -= 1
	else
		return FALSE

	hub.purchased_items.Add(src)

	user.playsound_local(user, 'sound/machines/uplinkpurchase.ogg', 100)

	if(item)
		var/atom/item_to_create = new item(get_turf(user))
		if(user.put_in_hands(item_to_create))
			to_chat(user, span_notice("Your purchase materializes into your hands!"))
		else
			to_chat(user, span_notice("Your purchase materializes onto the floor."))

	return TRUE

/datum/contractor_item/contract_reroll
	name = "Contract Reroll"
	desc = "Request a reroll of your current contract list. Will generate a new target, payment, and dropoff for the contracts you currently have available."
	item_icon = "dice"
	limited = 3
	cost = 0

/datum/contractor_item/contract_reroll/handle_purchase(datum/contractor_hub/hub)
	. = ..()

	if(!(.))
		return
	// We're not regenerating already completed/aborted/extracting contracts, but we don't want to repeat their targets.
	var/list/new_target_list = list()
	for(var/datum/syndicate_contract/contract_check as anything in hub.assigned_contracts)
		if (contract_check.status != CONTRACT_STATUS_ACTIVE && contract_check.status != CONTRACT_STATUS_INACTIVE)
			if (contract_check.contract.target)
				new_target_list.Add(contract_check.contract.target)
			continue

	// Reroll contracts without duplicates
	for(var/datum/syndicate_contract/rerolling_contract as anything in hub.assigned_contracts)
		if (rerolling_contract.status != CONTRACT_STATUS_ACTIVE && rerolling_contract.status != CONTRACT_STATUS_INACTIVE)
			continue

		rerolling_contract.generate(new_target_list)
		new_target_list.Add(rerolling_contract.contract.target)

	// Set our target list with the new set we've generated.
	hub.assigned_targets = new_target_list

/datum/contractor_item/contractor_pinpointer
	name = "Contractor Pinpointer"
	desc = "A pinpointer that finds targets even without active suit sensors. Due to taking advantage of an exploit within the system, it can't pinpoint to the same accuracy as the traditional models. Becomes permanently locked to the user that first activates it."
	item = /obj/item/pinpointer/crew/contractor
	item_icon = "search-location"
	limited = 2
	cost = 1

/datum/contractor_item/fulton_extraction_kit
	name = "Fulton Extraction Kit"
	desc = "For getting your target across the station to those difficult dropoffs. Place the beacon somewhere secure, and link the pack. Activating the pack on your target will send them over to the beacon - make sure they're not just going to run away though!"
	item = /obj/item/storage/box/contractor/fulton_extraction
	item_icon = "parachute-box"
	limited = 1
	cost = 1

/datum/contractor_item/contractor_partner
	name = "Reinforcements"
	desc = "Upon purchase we'll contact available units in the area. Should there be an agent free, we'll send them down to assist you immediately. If no units are free, we give a full refund."
	item_icon = "user-friends"
	limited = 1
	cost = 2
	var/datum/mind/partner_mind = null

/datum/contractor_item/contractor_partner/handle_purchase(datum/contractor_hub/hub, mob/living/user)
	. = ..()

	if(!.)
		return
	to_chat(user, span_notice("The uplink vibrates quietly, connecting to nearby agents..."))

	var/list/mob/dead/observer/candidates = poll_ghost_candidates("Do you want to play as the Contractor Support Unit for [user.real_name]?", ROLE_PAI, FALSE, 100, POLL_IGNORE_CONTRACTOR_SUPPORT)

	if(LAZYLEN(candidates))
		var/mob/dead/observer/picked_obs = pick(candidates)
		spawn_contractor_partner(user, picked_obs.key)
	else
		to_chat(user, span_notice("No available agents at this time, please try again later."))

		// refund and add the limit back.
		limited += 1
		hub.contract_rep += cost
		hub.purchased_items -= src

/datum/contractor_item/contractor_partner/proc/spawn_contractor_partner(mob/living/user, key)
	var/mob/living/carbon/human/partner = new()
	var/datum/outfit/contractor_partner/partner_outfit = new()

	partner_outfit.equip(partner)

	var/obj/structure/closet/supplypod/arrival_pod = new(null, STYLE_SYNDICATE)
	arrival_pod.explosionSize = list(0,0,0,1)
	arrival_pod.bluespace = TRUE

	var/turf/free_location = find_obstruction_free_location(2, user)

	// We really want to send them - if we can't find a nice location just land it on top of them.
	if (!free_location)
		free_location = get_turf(user)

	partner.forceMove(arrival_pod)
	partner.ckey = key

	/// We give a reference to the mind that'll be the support unit
	partner_mind = partner.mind
	partner_mind.make_contractor_support()

	to_chat(partner_mind.current, "\n[span_alertwarning("[user.real_name] is your superior. Follow any, and all orders given by them. You're here to support their mission only.")]")
	to_chat(partner_mind.current, "[span_alertwarning("Should they perish, or be otherwise unavailable, you're to assist other active agents in this mission area to the best of your ability.")]\n\n")

	new /obj/effect/pod_landingzone(free_location, arrival_pod)

/datum/contractor_item/blackout
	name = "Blackout"
	desc = "Request Syndicate Command to distrupt the station's powernet. Disables power across the station for a short duration."
	item_icon = "bolt"
	limited = 2
	cost = 2

/datum/contractor_item/blackout/handle_purchase(datum/contractor_hub/hub)
	. = ..()

	if(!.)
		return
	power_fail(35, 50)
	priority_announce("Abnormal activity detected in [station_name()]'s powernet. As a precautionary measure, the station's power will be shut off for an indeterminate duration.", "Critical Power Failure", ANNOUNCER_POWEROFF)

/datum/contractor_item/comms_blackout
	name = "Comms Outage"
	desc = "Request Syndicate Command to disable station Telecommunications. Disables telecommunications across the station for a medium duration."
	item_icon = "phone-slash"
	limited = 2
	cost = 2

/datum/contractor_item/comms_blackout/handle_purchase(datum/contractor_hub/hub)
	. = ..()

	if(!.)
		return
	var/datum/round_event_control/event = locate(/datum/round_event_control/communications_blackout) in SSevents.control
	event.run_event()

/datum/contractor_item/mod_baton_holster
	name = "Baton Holster Module"
	desc = "Never worry about dropping your baton again with this holster module! Simply insert your baton into the module, put it in your MODsuit, and the baton will retract whenever dropped."
	item = /obj/item/mod/module/baton_holster
	item_icon = "wrench" //I cannot find anything better, replace if you find something more fitting
	limited = 1
	cost = 1

/datum/contractor_item/baton_upgrade_cuff
	name = "Baton Cuff Upgrade"
	desc = "Using technology reverse-engineered from some alien batons we had lying around, you can now cuff people using your baton with the secondary attack. Due to technical limitations, only cable cuffs and zipties work, and they need to be loaded into the baton manually."
	item = /obj/item/baton_upgrade/cuff
	item_icon = "bacon" //ditto
	limited = 1
	cost = 1

/datum/contractor_item/baton_upgrade_mute
	name = "Baton Mute Upgrade"
	desc = "A relatively new advancement in completely proprietary baton technology, this baton upgrade will mute anyone hit for ten seconds, maximizing at twenty seconds."
	item = /obj/item/baton_upgrade/mute
	item_icon = "comment-slash"
	limited = 1
	cost = 2

/datum/contractor_item/baton_upgrade_focus
	name = "Baton Focus Upgrade"
	desc = "When applied to a baton, it will exhaust the target even more, should they be the target of your current contract."
	item = /obj/item/baton_upgrade/focus
	item_icon = "eye"
	limited = 1
	cost = 2

/datum/contractor_item/mod_magnetic_suit
	name = "Magnetic Deployment Module"
	desc = "A module that utilizes magnets to largely reduce the time needed to deploy and retract your MODsuit."
	item = /obj/item/mod/module/springlock/contractor
	item_icon = "magnet"
	limited = 1
	cost = 2

/datum/contractor_item/mod_scorpion_hook
	name = "SCORPION Hook Module"
	desc = "A module that allows you to launch a hardlight hook from your MODsuit, pulling a target into range of your baton."
	item = /obj/item/mod/module/scorpion_hook
	item_icon = "arrow-left" //replace if fontawesome gets an actual hook icon
	limited = 1
	cost = 3
