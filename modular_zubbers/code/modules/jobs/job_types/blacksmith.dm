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
	glasses = /obj/item/clothing/glasses/hud/gun_permit
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
	The <b>wall mounted A/C unit</b> will cool down the excess heat that your forge leaks, so that you do not boil yourself alive. <b>Remember to turn it on!</b></n>\n\
	The <b>anvil</b> can hold a heated, incomplete item.\n\
	The <b>quenching basin</b> allows you to cool a heated item.\n\
	The <b>workbench</b> is where you will finish crafting your equipment.\n\
	The <b>billows</b> blow air into your forge to accelerate its heating process.\n\
	The <b>tongs</b> let you safely insert a sheet of material into your forge, and safely handle hot items.\n\
	The <b>forging mallet</b> is used alongside an anvil to work an item into shape.\n\
	If you lack a dedicated department room, almost all of the above can be crafted using basic wood and iron. Use the crafting menu (the hammer icon -- bottom right of your screen) to take a look.\n\
	\
	How to heat your forge:\
	-1: Acquire a fuel source. You can use coal or wood for this purpose. \
	-2: Insert your fuel into the forge.\
	-3: Use your billows to blow air into the forge, accelerating its heating process.\
	-3a: If you don't blow air into the forge then the burning fuel will heat by itself.\
	\n\
	How to make a weapon:\
	-1: Pick up a sheet of iron or glass (or a different smithable material) using your tongs, then insert it into your heated forge.\
	-2: Decide on what you want to craft. Then, use tongs to pull the heated item from your forge and place it on your anvil. \
	-3: Hit it a whole bunch with your hammer! Pay attention to your timing; <b>swing with the correct pace, and you'll smith it perfectly</b>.\
	-3a: Your heated metal might cool down before it's ready, if you're too slow. If this happens, pick it up with your tongs and reheat them at your forge. \
	-4: Once you think it's ready, use a smithing basin to quench your metal.\
	-5: Pick up the quenched weapon head and secure it onto your crafting table. Have some wood set aside to use as a base, then use your hammer at the bench to finish the weapon!\
	\n\
	How to make other equipment:\
	-1: With a bare hand, click on your crafting table to check what you can craft.\
	-2: Once you decide on what to craft, the table should now have that recipe selected. Examine the table (shift + click) to see what ingredients are required.\
	-3: Obtain your ingredients and set them aside next to the table.\
	-3a: The most common ingredients will be wooden planks (produced by botany, or ordered via cargo), leather (from botany or cargo) and smithed plates (crafted at your forge and table).\
	-4: Once all your material is placed next to the table, get your hammer ready and start working at the table to produce your equipment!\
	\n\
	Reforging/Repairing Smithed Equipment:\
	-1: Insert your equipment into the forge using tongs or your bare hands.\
	-2: Once heated, place it onto the smithing table and work it like you'd work an incomplete smithed item.\
	-3: Once it sounds done, quench it at a basin to cool it.\
	Reagent Imbuing:\
	This is an ancient technique used to imbue most smithed equipment with properties from a chosen liquid reagent. Using reagents other than smithing oil will cause the equipment to be less effective, but depending on what chemical is imbued, the tradeoff may be worth it.\
	Be warned; reagent imbuing stresses the material and will wear it down whenever its imbue effect activates!\
	Normally, anything that can be imbued will be imbued upon being quenched in liquid. However, reagent imbue effects can be changed by reforging the equipment, or by manually imbuing it:\
	-1: Prepare at least [MAX_PRE_IMBUE_STORAGE] units of chemical solution to imbue.\
	-2: Transfer those chemicals into your smithed equipment.\
	-3: Insert your equipment into a heated forge to set the chemicals into the material.
	"

