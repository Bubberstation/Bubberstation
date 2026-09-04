/datum/bounty/item/special/vitezstvi
	name = "Vítězství Arms Requisition"
	reward = CARGO_CRATE_VALUE * 12

/datum/bounty/item/special/vitezstvi/New()
	switch(rand(1, 3))
		if(1)
			name = "Vodka"
			description = "The VARS-7 'Provodnik' has reached critically low morale. Ship eight bottles of vodka before the crew begins experimenting with liquids that are not strictly speaking drinkable."
			required_count = 8
			wanted_types = list(/obj/item/reagent_containers/cup/glass/bottle/vodka = TRUE)
		if(2)
			name = "Miecz Submachine Guns"
			description = "We have... misplaced, several submachine guns during revelry comrade. Ask no questions. Ship us three Miecz SMGs so nobody has to find out, jasný?"
			required_count = 3
			wanted_types = list(/obj/item/gun/ballistic/automatic/miecz = TRUE)
		if(3)
			name = "CIN Surplus Vests"
			description = "Vítězství Arms has hired more contractors than it owns armor. Ship four CIN surplus vests so the interns can stop sharing."
			required_count = 4
			wanted_types = list(/obj/item/clothing/suit/armor/vest/cin_surplus_vest = TRUE)
	return ..()

/datum/bounty/item/special/vitezstvi/on_claimed(obj/item/card/id/id_card)
	. = ..()
	if(SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_VITEZSTVI])
		return
	SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_VITEZSTVI] = TRUE
	priority_announce(
		"VARS-7 'Provodnik' to Cargo. Shipment received in excellent condition. Quartermaster, you remain a bastard of exceptional quality and a true friend of Vítězství Arms. Should your station ever require assistance we will come running, perhaps faster than is wise.",
		"VARS-7 'Provodnik'",
	)
