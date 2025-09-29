/obj/item/borg/upgrade/transform/ntjack
	name = "borg module picker (Centcom)"
	desc = "Allows you to to turn a cyborg into a experimental nanotrasen cyborg."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/centcom

/obj/item/borg/upgrade/transform/ntjack/action(mob/living/silicon/robot/cyborg, user = usr)
	return ..()

/obj/item/borg/upgrade/transform/security
	name = "borg model picker (Security)"
	desc = "Allows you to to turn a cyborg into a Security model, shitsec abound."
	icon_state = "module_security"
	new_model = /obj/item/robot_model/security

//Research borg upgrades

//ADVANCED ROBOTICS REPAIR
/obj/item/borg/upgrade/healthanalyzer
	name = "Research cyborg advanced Health Analyzer"
	desc = "An upgrade to the Research model cyborg's standard health analyzer."
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/healthanalyzer/advanced)
	items_to_remove = list(/obj/item/healthanalyzer)


//Science inducer
/obj/item/borg/upgrade/inducer_sci
	name = "Research integrated power inducer"
	desc = "An integrated inducer that can charge a device's internal cell from power provided by the cyborg."
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/inducer/cyborg/sci)

//Bluespace RPED
/obj/item/borg/upgrade/brped
	name = "Research cyborg Rapid Part Exchange Device Upgrade"
	desc = "An upgrade to the Research model cyborg's standard RPED."
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_remove = list(/obj/item/storage/part_replacer)

// Drapes upgrades
/obj/item/borg/upgrade/processor/Initialize(mapload)
	. = ..()
	model_type += /obj/item/robot_model/sci
	model_flags += BORG_MODEL_RESEARCH

// Engineering BRPED
/obj/item/borg/upgrade/rped/Initialize(mapload)
	. = ..()
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_add -= list(/obj/item/storage/part_replacer)

//Upgrade for the experi scanner
/obj/item/borg/upgrade/experi_scanner
	name = "Research cyborg BlueSpace Experi-Scanner"
	desc = "An upgrade to the Research model cyborg's standard health analyzer."
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/experi_scanner/bluespace)
	items_to_remove = list(/obj/item/experi_scanner)

// Borg Dom Aura :)
/obj/item/borg/upgrade/dominatrixmodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("This unit already has a 'recreational' module installed!"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/dominant_aura)

/obj/item/borg/upgrade/dominatrixmodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE
		borg.remove_quirk(/datum/quirk/dominant_aura)

// Engineering RLD
/obj/item/borg/upgrade/rld
	name = "Engineering Cyborg Rapid Lighting Device Upgrade"
	desc = "An upgrade to allow a cyborg to use a Rapid Lighting Device."
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering)
	model_flags = BORG_MODEL_ENGINEERING
	items_to_add = list(/obj/item/construction/rld/cyborg)

// Borg Advanced Xenoarchaeology Bag

/obj/item/borg/upgrade/xenoarch/adv
	name = "Cyborg Advanced Xenoarchaeology Bag"
	desc = "An improved bag to pick up strange rocks for science"
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner, /obj/item/robot_model/sci)
	model_flags = list(BORG_MODEL_MINER, BORG_MODEL_RESEARCH)
	items_to_add = list(/obj/item/storage/bag/xenoarch/adv)


// Mining Borg Vent Pinpointer

/obj/item/borg/upgrade/pinpointer/vent
	name = "Vent Pinpointer"
	desc = "A modularized tracking device. It will locate and point to nearby vents."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/pinpointer/vent)

//Borg Proto-Kinetic Accelerators

/obj/item/borg/upgrade/modkit/action(mob/living/silicon/robot/mining_mods)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/recharge/kinetic_accelerator/pkamods in mining_mods.model.modules)
			return install(pkamods, usr, FALSE)

/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg
	desc = "Portable particle accelerator. Only Usable on lavaland"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg
	desc = "A PKA with a three shot magazine"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg
	desc = "A PKA that fires three shots with a longer cooldown."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg
	desc = "A Snub Nosed PKA with more mode capacity but less damage and range."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg
	desc = "Creates a shockwave around the user, with the same power as the base PKA."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg
	desc = "Fires the same bombs used by the mining modsuit. Only usable on lavaland"
	holds_charge = TRUE
	unique_frequency = TRUE

// Mining Borg PKA Upgrades

/obj/item/borg/upgrade/kinetic_accelerator/railgun/cyborg
	name = "proto-kinetic railgun"
	desc = "Before the nice streamlined and modern day Proto-Kinetic Accelerator was created, multiple designs were drafted by the Mining Research and Development \
	team. Many were failures, including this one, which came out too bulky and too ineffective. Well recently the MR&D Team got drunk and said 'fuck it we ball' and \
	went back to the bulky design, overclocked it, and made it functional, turning it into what is essentially a literal man portable particle accelerator. \
	The design results in a massive hard to control blast of kinetic energy, with the power to punch right through creatures and cause massive damage. The \
	only problem with the design is that it is so bulky you need to carry it with two hands, and the technology has been outfitted with a special firing pin \
	that denies use near or on the station, due to its destructive nature."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator/)

/obj/item/borg/upgrade/kinetic_accelerator/repeater/cyborg
	name = "proto-kinetic repeater"
	desc = "During the pizza party celebrating the release of the new crusher designs, the Mining Research and Development team members were only allowed one slice. \
	One member exclaimed 'I wish we could have more than one slice' and another replied 'I wish we could shoot the accelerator more than once' and thus, the repeater \
	on the spot. The repeater trades a bit of power for the ability to fire three shots before becoming empty, while retaining the ability to fully recharge in one \
	go. The extra technology packed inside to make this possible unfortunately reduces mod space meaning you cant carry as many mods compared to a regular accelerator."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator/)

/obj/item/borg/upgrade/kinetic_accelerator/shotgun/cyborg
	name = "proto-kinetic shotgun"
	desc = "During the crusher design pizza party, one member of the Mining Research and Development team brought out a real riot shotgun, and killed three \
	other research members with one blast. The R&D Director immedietly thought of a genuis idea, creating the proto-kinetic shotgun moments later, which he \
	immediately used to execute the research member who brought the real shotgun. The proto-kinetic shotgun trades off some mod capacity and cooldown in favor \
	of firing three shots at once with reduce range and power. The total damage of all three shots is higher than a regular PKA but the individual shots are weaker. \
	Looks like you need both hands to use it effectively."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator/)

/obj/item/borg/upgrade/kinetic_accelerator/glock/cyborg
	name = "proto-kinetic pistol"
	desc = "During the pizza party for the Mining Research and Development team, one special snowflake researcher wanted a mini murphy instead of a regular \
	pizza slice, so reluctantly the Director bought him his mini murphy, which the dumbass immedietly dropped ontop of a PKA. Suddenly the idea to create \
	a 'build your own PKA' design was created. The proto-kinetic pistol is arguably worse than the base PKA, sporting lower damage and range. But this lack \
	of base efficiency allows room for nearly double the mods, making it truely 'your own PKA'."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator/)

/obj/item/borg/upgrade/kinetic_accelerator/shockwave/cyborg
	name = "proto-kinetic shockwave"
	desc = "Quite frankly, we have no idea how the Mining Research and Development team came up with this one, all we know is that alot of \
	beer was involved. This proto-kinetic design will slam the ground, creating a shockwave around the user, with the same power as the base PKA.\
	The only downside is the lowered mod capacity, the lack of range it offers, and the higher cooldown, but its pretty good for clearing rocks."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator/)

/obj/item/borg/upgrade/kinetic_accelerator/m79/cyborg
	name = "proto-kinetic grenade launcher"
	desc = "Made in a drunk frenzy during the creation of the kinetic railgun, the kinetic grenade launcher fires the same bombs used by \
	the mining modsuit. Due to the technology needed to pack the bombs into this weapon, there is no space for modification."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator/)

/// "Good Borg" Obedience Training
/mob/living/silicon/robot
	var/hasToys = FALSE

/obj/item/borg/upgrade/obediencemodule
	name = "Cyborg Obedience Module"
	desc = "A module that greatly upgrades the ability of borgs to display affection."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_lust"
	custom_price = 0

	items_to_add = list(/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/spanking_pad,
						/obj/item/tickle_feather,
						/obj/item/clothing/erp_leash,
						)

// WellTrained Obedience Behaviour
/obj/item/borg/upgrade/obediencemodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("This unit already has a 'recreational' module installed!"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/well_trained)

/obj/item/borg/upgrade/obediencemodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE

		borg.remove_quirk(/datum/quirk/well_trained)
