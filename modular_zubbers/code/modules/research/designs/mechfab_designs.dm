// Empty shell

/datum/design/synthclone
	name = "Blank synthetic shell"
	id = "blanksynth"
	build_type = MECHFAB
	construction_time = 60 SECONDS
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,
					/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
					/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.5,
					/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.25)
	category = list(RND_CATEGORY_MECHFAB_SYNTH + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS)

	build_path = /mob/living/carbon/human/species/synth/empty

/datum/design/borg_upgrade_advcutter
	name = "Advanced Plasma Cutter"
	id = "borg_upgrade_advcutter"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/advcutter
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

//research cyborg upgrades
/datum/design/borg_upgrade_advancedhealth
	name = "Research Advanced Health Analyzer"
	id = "borg_upgrade_advancedanalyzer"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/healthanalyzer
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH,
	)

//Blue space Rped upgrade
/datum/design/borg_upgrade_brped
	name = "Bluespace Rapid Part Exchange Device"
	id = "borg_upgrade_brped"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/brped
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_upgrade_inducer_sci
	name = "Research Cyborg inducer"
	id = "borg_upgrade_inducer_sci"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/inducer_sci
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/borg_dominatrix
	name = "Cyborg dominatrix module"
	id = "dominatrixmodule"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/dominatrixmodule
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_obedience
	name = "Cyborg Obedience Module"
	id = "obediencemodule"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/obediencemodule
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

//so we have our own category
/datum/design/borg_upgrade_surgical_processor_sci
	name = "Research Surgical Processor"
	id = "borg_upgrade_surgicalprocessor_sci"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/processor
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

//Some new toys
/datum/design/experi_scanner/bluespace_borg
	name = "Cyborg Bluespace Experimental Scanner"
	desc = "A version of the experiment scanner that allows for performing experiment scans from a distance."
	id = "bs_experi_scanner_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/experi_scanner
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_RESEARCH
	)

/datum/design/module/mind_transfer
	name = "Mind Transference Module"
	id = "mod_mind_transfer"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/mod/module/mind_swap
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/rld
	name = "Cyborg Rapid Lighting Device"
	desc = "A device that allows rapid, range deployment of lights and glowsticks."
	id = "rld_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/rld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/datum/design/xenoarch/equipment/bag_adv_borg
	name = "Cyborg Advanced Xenoarchaeology Bag"
	desc = "An improved bag to pick up strange rocks for science"
	id = "adv_xenoarchbag_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/borg/upgrade/xenoarch/adv
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/pinpointer/vent
	name = "Vent Pinpointer"
	desc = "A modularized tracking device. It will locate and point to nearby vents."
	id = "pinpointer_vent_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/pinpointer/vent
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/module/protean/servo
	name = "Protean Servo Module"
	id = "mod_protean_servo"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/protean_servo

/datum/design/module/hat_stabilizer
	name = "Hat Stabilizer Module"
	id = "mod_hat_stabilizer"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/mod/module/hat_stabilizer
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

//Borg PKAs

/datum/design/kinetic_accelerator/railgun/cyborg
	name = "proto-kinetic railgun"
	desc = "Before the nice streamlined and modern day Proto-Kinetic Accelerator was created, multiple designs were drafted by the Mining Research and Development \
	team. Many were failures, including this one, which came out too bulky and too ineffective. Well recently the MR&D Team got drunk and said 'fuck it we ball' and \
	went back to the bulky design, overclocked it, and made it functional, turning it into what is essentially a literal man portable particle accelerator. \
	The design results in a massive hard to control blast of kinetic energy, with the power to punch right through creatures and cause massive damage. The \
	only problem with the design is that it is so bulky you need to carry it with two hands, and the technology has been outfitted with a special firing pin \
	that denies use near or on the station, due to its destructive nature."
	id = "pka_railgun_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/railgun/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/repeater/cyborg
	name = "proto-kinetic repeater"
	desc = "During the pizza party celebrating the release of the new crusher designs, the Mining Research and Development team members were only allowed one slice. \
	One member exclaimed 'I wish we could have more than one slice' and another replied 'I wish we could shoot the accelerator more than once' and thus, the repeater \
	on the spot. The repeater trades a bit of power for the ability to fire three shots before becoming empty, while retaining the ability to fully recharge in one \
	go. The extra technology packed inside to make this possible unfortunately reduces mod space meaning you cant carry as many mods compared to a regular accelerator."
	id = "pka_repeater_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/repeater/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/shotgun/cyborg
	name = "proto-kinetic shotgun"
	desc = "During the crusher design pizza party, one member of the Mining Research and Development team brought out a real riot shotgun, and killed three \
	other research members with one blast. The R&D Director immedietly thought of a genuis idea, creating the proto-kinetic shotgun moments later, which he \
	immediately used to execute the research member who brought the real shotgun. The proto-kinetic shotgun trades off some mod capacity and cooldown in favor \
	of firing three shots at once with reduce range and power. The total damage of all three shots is higher than a regular PKA but the individual shots are weaker. \
	Looks like you need both hands to use it effectively."
	id = "pka_shotgun_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/shotgun/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/glock/cyborg
	name = "proto-kinetic pistol"
	desc = "During the pizza party for the Mining Research and Development team, one special snowflake researcher wanted a mini murphy instead of a regular \
	pizza slice, so reluctantly the Director bought him his mini murphy, which the dumbass immedietly dropped ontop of a PKA. Suddenly the idea to create \
	a 'build your own PKA' design was created. The proto-kinetic pistol is arguably worse than the base PKA, sporting lower damage and range. But this lack \
	of base efficiency allows room for nearly double the mods, making it truely 'your own PKA'."
	id = "pka_pistol_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/glock/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/shockwave/cyborg
	name = "proto-kinetic shockwave"
	desc = "Quite frankly, we have no idea how the Mining Research and Development team came up with this one, all we know is that alot of \
	beer was involved. This proto-kinetic design will slam the ground, creating a shockwave around the user, with the same power as the base PKA.\
	The only downside is the lowered mod capacity, the lack of range it offers, and the higher cooldown, but its pretty good for clearing rocks."
	id = "pka_shockwave_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/shockwave/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/kinetic_accelerator/m79/cyborg
	name = "proto-kinetic grenade launcher"
	desc = "Made in a drunk frenzy during the creation of the kinetic railgun, the kinetic grenade launcher fires the same bombs used by \
	the mining modsuit. Due to the technology needed to pack the bombs into this weapon, there is no space for modification."
	id = "pka_m79_cyborg"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/borg/upgrade/kinetic_accelerator/m79/cyborg
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)
