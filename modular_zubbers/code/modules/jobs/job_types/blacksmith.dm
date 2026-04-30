/datum/job/blacksmith
	title = JOB_BLACKSMITH
	description = "Smith wares, Sell them."
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_QM
	config_tag = "BLACKSMITH"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/blacksmith
	plasmaman_outfit = /datum/outfit/plasmaman/blacksmith

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_BLACKSMITH
	bounty_types = CIV_JOB_SMITH

	departments_list = list(
		/datum/job_department/cargo,
		)

	mail_goodies = list(
		/obj/item/stack/sheet/mineral/coal/ten = 20,
		/obj/item/stack/sheet/mineral/silver = 5,
		/obj/item/stack/sheet/mineral/gold = 5,
	)

	family_heirlooms = list(/obj/item/pen/fountain, /obj/item/forging/hammer, /obj/item/forging/tongs)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	job_spawn_title = JOB_ASSISTANT

	voice_of_god_silence_power = 3
	rpg_title = "Smithy"

/datum/outfit/job/blacksmith
	name = "Blacksmith"
	jobtype = /datum/job/blacksmith

	id_trim = /datum/id_trim/job/blacksmith
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/long
	suit = /obj/item/clothing/suit/leatherapron
	backpack_contents = list(
		/obj/item/forging/hammer = 1,
		/obj/item/forging/tongs = 1,
		/obj/item/forging/billow = 1,
		/obj/item/stack/sheet/mineral/wood = 25,
	)
	belt = /obj/item/modular_computer/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/brown
	skillchips = list(/obj/item/skillchip/job/blacksmith)

/obj/item/paper/pamphlet/blacksmith_tutorial
	name = "blacksmithing pamphlet"
	default_raw_text = "Blacksmiths are the ones responsible for fine craftsmanship of all types of equipment: swords, armor, toolbelts, and more. \
	If someone wants specialized equipment -- especially old stuff -- they should go to you. Here's a rundown on your equipment:<hr><br> \n\
	If you have a dedicated department room, it should come with the following: \n\
	The <b>forge</b> heats up sheets of metal to be worked into desired shapes. \n\
	The <b>wall mounted A/C unit</b> will cool down the excess heat that your forge leaks, so that you do not burn to death. <b>Remember to turn it on!</n>\n\
	The <b>anvil</b> can hold a heated, incomplete item.\n\
	The <b>quenching basin</b> allows you to cool a heated item.\n\
	The <b>workbench</b> is where you will finish crafting your equipment.\n\
	The <b>billows</b> blow air into your forge to accelerate its heating process.\n\
	The <b>tongs</b> let you safely insert a sheet of material into your forge, and safely handle hot items.\n\
	The <b>forging mallet</b> is used alongside an anvil to work an item into shape.\n\
	If you lack a dedicated department room, almost all of the above can be crafted using basic wood and iron. Use the crafting menu (the hammer icon -- bottom right of your screen) to take a look.\n\
	\
	<b>Epipens</b> are an effective treatment method for synthetic slash/pierce wounds!<br>\n\
	<b>Nanite Slurry</b> is used to heal minor synthetic <b>brute</b> and <b>burn</b> damage. \
	overdose is at <b>10u</b>. Overdose heals synthetic organ damage in exchange of overheating and brute damage.<br>\n\
	<b>Critical system repair pills</b> inside your medkit are used to purposely inflict an overdose of nanite slurry to heal ~ <b>240 organ damage</b> per pill. (You need to manage their brute and burn!)<br>\n\
	<b>Liquid Solder</b> is used to heal <b>positronic damage</b><br>\n\
	<b>System Cleaner</b> is used to heal synthetic <b>toxin damage</b><br>\n\
	<b>Dinitrogen Plasmide</b> is used to treat synthetic overheating wounds safely.<br>\n\
	<b>Blank Synthetic Shells</b> can be produced at the exofab for practice if mining has been gathering resources.<br>\n\
	<b>Oil</b> functions as a synthetic creatures blood. It can be obtained from Chemistry, or if you're crafty, scooped off the floor."
