//WEAPON CHOICE BEACONS FOR THE PERSISTENCE SHIP

//standard pistol
/obj/item/choice_beacon/syndicateoffstation
	name = "Standard Syndicate sidearm beacon"
	desc = "A single use beacon to deliver a weapon kit of your choice. Please use this or store it in your safe."
	company_source = "Gorlex Marauders"
	company_message = span_bold("Supply pod incoming, please stand by.")

/obj/item/choice_beacon/syndicateoffstation/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Makarov" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov,
		"M1911" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911,
		"Energy Dagger" = /obj/item/pen/edagger,
		"Ansem Pistol Kit" = /obj/item/storage/toolbox/guncase/clandestine,
	)

	return selectable_gun_types

//engineers kit because the crossbow is funny and will probably end up with them dead
/obj/item/choice_beacon/syndicateoffstation/engineer
	name = "Engineering Officer's Syndicate sidearm beacon"

/obj/item/choice_beacon/syndicateoffstation/engineer/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Makarov" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov,
		"M1911" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911,
		"Energy Dagger" = /obj/item/pen/edagger,
		"Syndicate Crossbow" = /obj/item/storage/toolbox/guncase/skyrat/opfor/rebar_crossbow,
		"Ansem Pistol Kit" = /obj/item/storage/toolbox/guncase/clandestine,
	)

	return selectable_gun_types


//MAA kit, they get an actual selection of weapons
/obj/item/choice_beacon/syndicateoffstation/maa
	name = "Master At Arms Syndicate weapon beacon"

/obj/item/choice_beacon/syndicateoffstation/maa/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"M90-GL" = /obj/item/storage/toolbox/guncase/m90gl,
		"Bulldog" = /obj/item/storage/toolbox/guncase/bulldog,
		"Energy Sword" = /obj/item/melee/energy/sword/saber,
	)

	return selectable_gun_types

/obj/item/choice_beacon/syndicateoffstation/command
	name = "Syndicate command staff weapon beacon"

/obj/item/choice_beacon/syndicateoffstation/command/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Stechkin APS" = /obj/item/storage/toolbox/guncase/skyrat/pistol/aps,
		"Ansem Pistol Kit" = /obj/item/storage/toolbox/guncase/clandestine,
		"C-20r SMG" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/c20r,
		"Energy Sword" = /obj/item/melee/energy/sword/saber,

	)

	return selectable_gun_types

/obj/item/choice_beacon/syndicateoffstation/morale
	name = "Syndicate Admiral weapon beacon"

/obj/item/choice_beacon/syndicateoffstation/morale/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Stechkin APS" = /obj/item/storage/toolbox/guncase/skyrat/pistol/aps,
		"Ansem Pistol Kit" = /obj/item/storage/toolbox/guncase/clandestine,
		"Energy Sword" = /obj/item/melee/energy/sword/saber,
		"Waffle Co. Revolver" = /obj/item/storage/toolbox/guncase/revolver
	)

	return selectable_gun_types
