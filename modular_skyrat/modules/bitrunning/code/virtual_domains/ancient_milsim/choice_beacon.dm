/obj/item/choice_beacon/ancient_milsim
	name = "early access equipment beacon"
	desc = "Summon a gear closet for your contributions in the early access testing. Synchronises with the current game version to give you the most up-to-date class equipment."
	company_source = "'Time Of Valor 2' development team"
	company_message = span_bold("Thanks, and have fun!")

/obj/item/choice_beacon/ancient_milsim/generate_display_names()
	var/static/list/gear_options
	if(!gear_options)
		gear_options = list()
		for(var/obj/structure/closet/crate/secure/weapon/milsim/crate as anything in subtypesof(/obj/structure/closet/crate/secure/weapon/milsim))
			gear_options[initial(crate.name)] = crate
	return gear_options

/obj/structure/closet/crate/secure/weapon/milsim
	desc = "(ToV 2 Playtester Reward) UNIF Counter-Insurgency Detachment bundle: featuring equipment provided to field operators in medium-intensity firefights. <br>\
	'VCIM (Void Combat Identification Measures) camo' Skin (Alt 1/Strobeless, Opaque Glass)."

/obj/structure/closet/crate/secure/weapon/milsim/PopulateContents()
	. = ..()
	new /obj/item/knife/combat(src)
	new /obj/item/gun/energy/modular_laser_rifle/carbine(src)
	new /obj/item/radio/headset/headset_faction(src)

/obj/structure/closet/crate/secure/weapon/milsim/after_open()
	qdel(src)

/obj/structure/closet/crate/secure/weapon/milsim/mechanic
	name = "mechanic (abductor toolbelt/cable coil dispenser/medHUD)"

/obj/structure/closet/crate/secure/weapon/milsim/mechanic/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/mechanic(src)

/obj/structure/closet/crate/secure/weapon/milsim/marksman
	name = "marksman (barricade box/throwing knife dispenser/NVG-sonar)"

/obj/structure/closet/crate/secure/weapon/milsim/marksman/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/marksman(src)

/obj/structure/closet/crate/secure/weapon/milsim/medic
	name = "medic (combat hypospray/combat hypovials dispenser/medHUD)"

/obj/structure/closet/crate/secure/weapon/milsim/medic/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/medic(src)

/obj/structure/closet/crate/secure/weapon/milsim/trapper
	name = "trapper (chameleon projector/stealth landmine dispenser/thermals)"

/obj/structure/closet/crate/secure/weapon/milsim/trapper/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/trapper(src)

/obj/structure/closet/crate/secure/weapon/milsim/saboteur
	name = "saboteur (Binyat implanter/EMP grenade dispenser/material scanner-mesons)"

/obj/structure/closet/crate/secure/weapon/milsim/sentinel
	name = "sentinel (heavy machinegun/burger dispenser/NVG-sonar)"

/obj/structure/closet/crate/secure/weapon/milsim/sentinel/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/sentinel(src)

/obj/structure/closet/crate/secure/weapon/milsim/trooper
	name = "trooper (Sol rifle/Sol rifle magazine dispenser/NVG-sonar)"

/obj/structure/closet/crate/secure/weapon/milsim/trooper/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/trooper(src)
