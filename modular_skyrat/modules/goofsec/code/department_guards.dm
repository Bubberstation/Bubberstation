//Most related code is in this file; uniform icons are in the relevant department's .dmi

//SORT ORDER: Sci, Generic, Med, Engi, Cargo, Serv

/*
	UNIFORMS
*/
/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	name = "science guard's uniform"

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	name = "orderly uniform"
	desc = "White scrubs with gray pants underneath. Be warned, wearers of this uniform may only take the Hippocratic Oath as a suggestion."
	icon_state = "orderly_uniform"
	worn_icon_state = "orderly_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/medical_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	name = "engineering guard uniform"
	desc = "Effectively just padded hi-vis coveralls, they do the trick both inside of, and while keeping people out of, a hardhat zone."
	icon_state = "engineering_guard_uniform"
	worn_icon_state = "engineering_guard_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	name = "customs agent uniform"
	desc = "A cargo-brown short-sleeve shirt, and cargo shorts in an authoritative charcoal color. Only for the FTU's finest strong-hands."
	icon_state = "customs_uniform"
	worn_icon_state = "customs_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/bouncer
	name = "bouncer uniform"
	desc = "Short-sleeves and jeans, for that aura of cool that makes the drunk people listen."
	icon_state = "bouncer"
	worn_icon_state = "bouncer"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi'

/*
	SUITS
*/
/obj/item/clothing/suit/armor/vest/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/guard //Badge-less version of the blueshirt vest
	icon_state = "guard_armor"
	worn_icon_state = "guard_armor"

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	name = "armored orderly coat"
	desc = "An armored coat, in a deep paramedic blue. It'll keep you padded while dealing with troublesome patients."
	icon_state = "medical_coat"
	worn_icon_state = "medical_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	name = "armored engineering guard coat"
	desc = "An armored coat whose hazard strips are worn to the point of uselessness. It'll keep you protected while clearing hazard zones at least."
	icon_state = "engineering_coat"
	worn_icon_state = "engineering_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	name = "armored customs agent coat"
	desc = "An armored coat, with intricately woven patterns and details. This should help keep you safe from unruly customers."
	icon_state = "customs_coat"
	worn_icon_state = "customs_coat"

/*
	HEAD
*/
/obj/item/clothing/head/helmet/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	//The base one is used for science guards, and the sprite is unchanged

/obj/item/clothing/head/helmet/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/head/helmet/blueshirt/skyrat/guard //Version of the blueshirt helmet without a blue line. Used by all dept guards right now.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "mallcop_helm"
	worn_icon_state = "mallcop_helm"

/obj/item/clothing/head/beret/sec/science
	name = "science guard beret"
	desc = "A robust beret with an Erlenmeyer flask emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/science"
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#8D008F#F2F2F2"

/obj/item/clothing/head/beret/sec/medical
	name = "medical officer beret"
	desc = "A robust beret with a Medical insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/medical"
	greyscale_colors = "#16313D#F2F2F2" //Paramed blue to (mostly) match their vest (as opposed to medical white)

/obj/item/clothing/head/beret/sec/engineering
	name = "engineer officer beret"
	desc = "A robust beret with a hazard symbol emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/engineering"
	greyscale_colors = "#FFBC30#F2F2F2"

/obj/item/clothing/head/beret/sec/cargo
	name = "cargo officer beret"
	desc = "A robust beret with a Crate emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/cargo"
	greyscale_colors = "#c99840#F2F2F2"

/obj/item/clothing/head/beret/sec/service
	name = "bouncer beret"
	desc = "A robust beret with a simple badge emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/beret/sec/service"
	greyscale_colors = "#5E8F2D#F2F2F2"

/*
	LANDMARKS
*/
/obj/effect/landmark/start/science_guard
	name = "Science Guard"
	icon_state = "Science Guard"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/orderly
	name = "Orderly"
	icon_state = "Orderly"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/engineering_guard
	name = "Engineering Guard"
	icon_state = "Engineering Guard"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/customs_agent
	name = "Customs Agent"
	icon_state = "Customs Agent"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/bouncer
	name = "Bouncer"
	icon_state = "Bouncer"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/*
	SCIENCE GUARD DATUMS
*/
/datum/job/security_officer/science_guard
	title = JOB_SECURITY_OFFICER_SCIENCE
	alt_title_department_suffix = "Science"
	alternate_titles = list(JOB_SCIENCE_GUARD)
	job_spawn_title = JOB_SCIENCE_GUARD
	rpg_title = "Secrets Keeper"
	description = "Figure out why the emails aren't working, keep an eye on the eggheads, protect them from their latest mistakes."
	total_positions = 2
	spawn_positions = 2
	supervisors = "your departments Sergeant and the Research Director"
	config_tag = "SCIENCE_GUARD"

	outfit = /datum/outfit/job/security/science_guard
	plasmaman_outfit = /datum/outfit/plasmaman/science

	display_order = JOB_DISPLAY_ORDER_SCIENCE_GUARD
	bounty_types = CIV_JOB_SCI
	departments_list = list(
		/datum/job_department/science,
		/datum/job_department/security,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/science)

	mail_goodies = list(
	/obj/item/food/donut/caramel = 10,
	/obj/item/food/donut/matcha = 10,
	/obj/item/food/donut/blumpkin = 5,
	/obj/item/clothing/mask/whistle = 10,
	/obj/item/melee/baton = 5
	)

/datum/outfit/job/security/science_guard
	name = JOB_SECURITY_OFFICER_SCIENCE
	jobtype = /datum/job/security_officer/science_guard

	ears = /obj/item/radio/headset/headset_sec/alt/department/science
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	shoes = /obj/item/clothing/shoes/jackboots
	head =  /obj/item/clothing/head/beret/sec/science
	suit = /obj/item/clothing/suit/armor/vest/alt

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/science
	duffelbag = /obj/item/storage/backpack/duffelbag/science
	messenger = /obj/item/storage/backpack/messenger/science

	id_trim = /datum/id_trim/job/security_officer/science_guard

/datum/id_trim/job/security_officer/science_guard
	assignment = JOB_SECURITY_OFFICER_SCIENCE
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_calhoun"
	department_color = COLOR_SCIENCE_PINK
	subdepartment_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENCE_GUARD
	additional_extra_access = list(
		ACCESS_AUX_BASE,
		ACCESS_MECH_SCIENCE,
	)
	additional_minimal_access = list(
		ACCESS_GENETICS,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_RESEARCH,
		ACCESS_ROBOTICS,
		ACCESS_SCIENCE,
		ACCESS_XENOBIOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)
	job = /datum/job/security_officer/science_guard

/*
	MEDICAL GUARD DATUMS
*/
/datum/job/security_officer/orderly
	title = JOB_SECURITY_OFFICER_MEDICAL
	alt_title_department_suffix = "Medical"
	alternate_titles = list(JOB_ORDERLY)
	job_spawn_title = JOB_ORDERLY
	rpg_title = "Praetorian"
	description = "Defend the medical department, hold down idiots who refuse the vaccine, assist medical with prep and/or cleanup."
	total_positions = 2
	spawn_positions = 2
	supervisors = "your departments Sergeant and the Chief Medical Officer"
	config_tag = "ORDERLY"

	outfit = /datum/outfit/job/security/orderly
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	display_order = JOB_DISPLAY_ORDER_ORDERLY
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		/datum/job_department/security,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/medical)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

/datum/outfit/job/security/orderly
	name = JOB_SECURITY_OFFICER_MEDICAL
	jobtype = /datum/job/security_officer/orderly

	ears = /obj/item/radio/headset/headset_sec/alt/department/medical
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/beret/sec/medical
	glasses = /obj/item/clothing/glasses/hud/medsechud/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	messenger = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/security_officer/orderly

/datum/id_trim/job/security_officer/orderly
	assignment = JOB_SECURITY_OFFICER_MEDICAL
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_orderly"
	department_color = COLOR_MEDICAL_BLUE
	subdepartment_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_ORDERLY
	additional_extra_access = list(
		ACCESS_MECH_MEDICAL,
		ACCESS_PLUMBING,
		ACCESS_VIROLOGY,
	)
	additional_minimal_access = list(
		ACCESS_MEDICAL,
		ACCESS_MORGUE,
		ACCESS_PARAMEDIC,
		ACCESS_PHARMACY,
		ACCESS_SURGERY,
		ACCESS_PSYCHOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)
	job = /datum/job/security_officer/orderly

/*
	ENGINEERING GUARD DATUMS
*/
/datum/job/security_officer/engineering_guard
	title = JOB_SECURITY_OFFICER_ENGINEERING
	alt_title_department_suffix = "Engineering"
	alternate_titles = list(JOB_ENGINEERING_GUARD)
	job_spawn_title = JOB_ENGINEERING_GUARD
	rpg_title = "Crystal Guardian"
	description = "Monitor the supermatter, keep an eye on atmospherics, make sure everyone is wearing Proper Protective Equipment."
	total_positions = 2
	spawn_positions = 2
	supervisors = "your departments Sergeant and the Chief Engineer"
	config_tag = "ENGINEERING_GUARD"

	outfit = /datum/outfit/job/security/engineering_guard
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	display_order = JOB_DISPLAY_ORDER_ENGINEER_GUARD
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		/datum/job_department/security,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/engineering)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

/datum/outfit/job/security/engineering_guard
	name = JOB_SECURITY_OFFICER_ENGINEERING
	jobtype = /datum/job/security_officer/engineering_guard

	ears = /obj/item/radio/headset/headset_sec/alt/department/engineering
	shoes = /obj/item/clothing/shoes/workboots
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	head =  /obj/item/clothing/head/beret/sec/engineering
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	messenger = /obj/item/storage/backpack/messenger/eng
	box = /obj/item/storage/box/survival/engineer

	id_trim = /datum/id_trim/job/security_officer/engineering_guard

/datum/id_trim/job/security_officer/engineering_guard
	assignment = JOB_SECURITY_OFFICER_ENGINEERING
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_engiguard"
	department_color = COLOR_ENGINEERING_ORANGE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_ENGINEERING_GUARD
	additional_extra_access = list(
		ACCESS_AUX_BASE,
		ACCESS_MECH_ENGINE,
		ACCESS_TCOMMS,
	)
	additional_minimal_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_TECH_STORAGE,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)
	job = /datum/job/security_officer/engineering_guard

/*
	CARGO GUARD DATUMS
*/
/datum/job/security_officer/customs_agent
	title = JOB_SECURITY_OFFICER_SUPPLY
	alt_title_department_suffix = "Cargo"
	alternate_titles = list(JOB_CUSTOMS_AGENT)
	job_spawn_title = JOB_CUSTOMS_AGENT
	rpg_title = "Vault Keeper"
	description = "Inspect the packages coming to and from the station, protect the cargo department, beat the shit out of people trying to ship Cocaine to the Spinward Stellar Coalition."
	total_positions = 2
	spawn_positions = 2
	supervisors = "your departments Sergeant and the Quartermaster"
	config_tag = "CUSTOMS_AGENT"

	outfit = /datum/outfit/job/security/customs_agent
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	display_order = JOB_DISPLAY_ORDER_CUSTOMS_AGENT
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		/datum/job_department/security,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/cargo)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

/datum/outfit/job/security/customs_agent
	name = JOB_SECURITY_OFFICER_SUPPLY
	jobtype = /datum/job/security_officer/customs_agent

	ears = /obj/item/radio/headset/headset_sec/alt/department/cargo
	shoes = /obj/item/clothing/shoes/sneakers/black
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	head = /obj/item/clothing/head/beret/sec/cargo
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	glasses = /obj/item/clothing/glasses/hud/gun_permit

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/security_officer/customs_agent

/datum/id_trim/job/security_officer/customs_agent
	assignment = JOB_SECURITY_OFFICER_SUPPLY
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_customs"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	sechud_icon_state = SECHUD_CUSTOMS_AGENT
	additional_extra_access = list(
		ACCESS_MINING_STATION,
		ACCESS_MECH_MINING,
	)
	additional_minimal_access = list(
		ACCESS_BLACKSMITH,
		ACCESS_CARGO,
		ACCESS_MINING,
		ACCESS_SHIPPING,
		ACCESS_BIT_DEN,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_QM, ACCESS_CHANGE_IDS)
	job = /datum/job/security_officer/customs_agent

/*
	SERVICE GUARD DATUMS
*/
/datum/job/security_officer/bouncer
	title = JOB_SECURITY_OFFICER_SERVICE
	alt_title_department_suffix = "Service"
	alternate_titles = list(JOB_BOUNCER)
	job_spawn_title = JOB_BOUNCER
	rpg_title = "Tavern Watch"
	description = "Make sure people don't jump the kitchen counter, stop Chapel vandalism, check bargoer's IDs, prevent the dreaded \"food fight\"."
	total_positions = 2
	spawn_positions = 2
	supervisors = "your departments Sergeant and the Head of Personnel"
	config_tag = "BOUNCER"

	outfit = /datum/outfit/job/security/bouncer
	plasmaman_outfit = /datum/outfit/plasmaman/party_bouncer

	display_order = JOB_DISPLAY_ORDER_BOUNCER
	bounty_types = CIV_JOB_DRINK
	departments_list = list(
		/datum/job_department/service,
		/datum/job_department/security,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/service)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

/datum/outfit/job/security/bouncer
	name = JOB_SECURITY_OFFICER_SERVICE
	jobtype = /datum/job/security_officer/bouncer

	ears = /obj/item/radio/headset/headset_sec/alt/department/service
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/bouncer
	shoes = /obj/item/clothing/shoes/sneakers/black
	head =  /obj/item/clothing/head/beret/sec/service
	suit = /obj/item/clothing/suit/armor/vest/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/security_officer/bouncer

/datum/id_trim/job/security_officer/bouncer
	assignment = JOB_SECURITY_OFFICER_SERVICE
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_bouncer"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME // Personally speaking I'd have one of these with sec colors but I'm being authentic
	sechud_icon_state = SECHUD_BOUNCER
	additional_minimal_access = list(
		ACCESS_BAR,
		ACCESS_SERVICE,
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_THEATRE,
		ACCESS_JANITOR,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/security_officer/bouncer

/*
* Garment Bags
*/

/obj/item/storage/bag/garment/science_guard
	name = "science guard's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the science guard."

/obj/item/storage/bag/garment/science_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_sci = 2,
		/obj/item/clothing/shoes/sneakers/black = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat = 2,
		/obj/item/clothing/head/beret/sec/science = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/science/guard = 1,
		/obj/item/clothing/glasses/hud/security = 2,
	), src)

/obj/item/storage/bag/garment/orderly
	name = "orderly's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the orderly."

/obj/item/storage/bag/garment/orderly/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_med = 1,
		/obj/item/clothing/shoes/sneakers/white = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly = 1,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 1,
		/obj/item/clothing/head/beret/sec/medical = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly = 1,
		/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/guard = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/black/guard = 1,
		/obj/item/clothing/under/rank/security/peacekeeper/miniskirt = 1,
		/obj/item/clothing/glasses/hud/medsechud = 1,
	), src)

/obj/item/storage/bag/garment/engineering_guard
	name = "engineering guard's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the engineering guard."

/obj/item/storage/bag/garment/engineering_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_eng = 2,
		/obj/item/clothing/shoes/workboots = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 2,
		/obj/item/clothing/head/beret/sec/engineering = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/engineer/guard = 1,
		/obj/item/clothing/glasses/hud/security = 2,
	), src)

/obj/item/storage/bag/garment/customs_agent
	name = "customs agent's garments"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the customs agent."

/obj/item/storage/bag/garment/customs_agent/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_cargo = 2,
		/obj/item/clothing/shoes/sneakers/black = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 2,
		/obj/item/clothing/head/beret/sec/cargo = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/cargo/guard = 1,
		/obj/item/clothing/glasses/hud/security = 2,
		/obj/item/clothing/glasses/hud/gun_permit = 2,
	), src)
