//Choice Beacon for blueshield, old.

/obj/item/choice_beacon/blueshield
	name = "blueshield weapon beacon"
	desc = "A single use beacon to deliver a weapon of your choice. Please only call this in your office"
	company_source = "Sol Security Solution"
	company_message = span_bold("Supply pod incoming, please stand by.")

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Energy Revolver" = /obj/item/gun/energy/e_gun/blueshield,
		"Energy Carbine" = /obj/item/gun/energy/e_gun/stun/blueshield
	)

	return selectable_gun_types


//Both of these are defunk but still exist for archival purpose incase someone want to re-visit them later, or as references


/obj/item/choice_beacon/ntc
	name = "gunset beacon"
	desc = "A single use beacon to deliver a gunset of your choice. Please only call this in your office"
	company_source = "Trappiste Fabriek Company"
	company_message = span_bold("Supply pod incoming, please stand by.")

/obj/item/choice_beacon/ntc/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Takbok" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/takbok,
		"Skild" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild
	)

	return selectable_gun_types

//Station Central Command Staff

/obj/item/choice_beacon/station_magistrate
	name = "nanotrasen dignitaries weapon beacon"
	desc = "A single use beacon to deliver a weapon of your choice. Please only call this in your office"
	company_source = "Romulus Armoury"
	company_message = span_bold("Supply pod incoming, please stand by.")

/obj/item/choice_beacon/station_magistrate/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Energy Revolver" = /obj/item/gun/energy/e_gun/blueshield,
		".38 Battle Rifle" = /obj/item/gun/ballistic/automatic/battle_rifle,
	)

	return selectable_gun_types
