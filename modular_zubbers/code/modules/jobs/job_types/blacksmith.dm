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
		/obj/item/crowbar = 1,
		/obj/item/forging/hammer = 1,
		/obj/item/forging/tongs = 1,
		/obj/item/forging/billow = 1,
		/obj/item/stack/sheet/mineral/wood = 25,
		/obj/item/choice_beacon/blacksmith = 1,
		/obj/item/paper/pamphlet/blacksmith_tutorial = 1,
	)
	glasses = /obj/item/clothing/glasses/hud/gun_permit
	belt = /obj/item/modular_computer/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/brown
	skillchips = list(/obj/item/skillchip/job/blacksmith)

/obj/item/paper/pamphlet/blacksmith_tutorial
	name = "blacksmithing pamphlet"
	default_raw_text = "Blacksmiths are the ones responsible for fine craftsmanship of all types of equipment: swords, armor, toolbelts, and more.<br>\n\
	If someone wants specialized equipment -- especially old stuff -- they should go to you.<br>\n\
	If you have a dedicated department room, it should come with the following:<br> \n\
	The <b>forge</b> heats up sheets of metal to be worked into desired shapes.<br> \n\
	The <b>wall mounted A/C unit</b> will cool down the excess heat that your forge leaks, so that you do not boil yourself alive. <b>Remember to turn it on!</b><br> \n\
	The <b>anvil</b> can hold a heated, incomplete item.<br>\n\
	The <b>quenching basin</b> allows you to cool a heated item.<br>\n\
	The <b>workbench</b> is where you will finish crafting your equipment.<br>\n\
	The <b>billows</b> blow air into your forge to accelerate its heating process.<br>\n\
	The <b>tongs</b> let you safely insert a sheet of material into your forge, and safely handle hot items.<br>\n\
	The <b>forging mallet</b> is used alongside an anvil to work an item into shape.<br>\n\
	If you lack a dedicated department room and cannot summon a package of these items via your summon beacon, almost all of the above can be crafted using basic wood and iron (except the anvil, which requires plastitanium). Use the crafting menu (the hammer icon -- bottom right of your screen) to take a look.<br>\n\
	<br> \
	How to heat your forge:<br>\n\
	-1: Acquire a fuel source. You can use coal or wood for this purpose.<br>\n\
	-2: Insert your fuel into the forge.<br>\n\
	-3: Use your billows to blow air into the forge, accelerating its heating process.<br>\n\
	-3a: If you don't blow air into the forge then the burning fuel will heat by itself.<br>\n\
	<br>\n\
	How to make a weapon:<br>\n\
	-1: Pick up a sheet of iron or glass (or a different smithable material) using your tongs, then insert it into your heated forge.<br>\n\
	-2: Decide on what you want to craft. Then, use tongs to pull the heated item from your forge and place it on your anvil. <br>\n\
	-3: Hit it a whole bunch with your hammer! Pay attention to your timing; <b>swing with the correct pace, and you'll smith it perfectly</b>.<br>\n\
	-3a: Your heated metal might cool down before it's ready, if you're too slow. If this happens, pick it up with your tongs and reheat them at your forge. <br>\n\
	-4: Once you think it's ready, use a smithing basin to quench your metal.<br>\n\
	-5: Pick up the quenched weapon head and secure it onto your crafting table. Have some wood set aside to use as a base, then use your hammer at the bench to finish the weapon!<br>\n\
	<br>\n\
	How to make other equipment:<br>\n\
	-1: With a bare hand, click on your crafting table to check what you can craft.<br>\n\
	-2: Once you decide on what to craft, the table should now have that recipe selected. Examine the table (shift + click) to see what ingredients are required.<br>\n\
	-3: Obtain your ingredients and set them aside next to the table.<br>\n\
	-3a: The most common ingredients will be wooden planks (produced by botany, or ordered via cargo), leather (from botany or cargo) and smithed plates (smithed from metal via your forge).<br>\n\
	-4: Once all your material is placed next to the table, get your hammer ready and start working at the table to produce your equipment!<br>\n\
	<br>\n\
	Reforging/Repairing Smithed Equipment:<br>\n\
	-1: Insert your equipment into the forge using tongs or your bare hands.<br>\n\
	-2: Once heated, place it onto the smithing table and work it like you'd work an incomplete smithed item.<br>\n\
	-3: Once it sounds done, quench it at a basin to cool it.<br>\n\
	<br>\n\
	Reagent Imbuing:<br>\n\
	This is an ancient technique used to imbue most smithed equipment with properties from a chosen liquid reagent. Using reagents other than smithing oil will cause the equipment to be less effective, but depending on what chemical is imbued, the tradeoff may be worth it.<br>\n\
	Be warned; reagent imbuing stresses the material and will wear it down whenever its imbue effect activates!<br>\n\
	Normally, anything that can be imbued will be imbued upon being quenched in liquid. However, reagent imbue effects can be changed by reforging the equipment, or by manually imbuing it:<br>\n\
	-1: Prepare at least 60 units of chemical solution to imbue.<br>\n\
	-2: Transfer those chemicals into your smithed equipment.<br>\n\
	-3: Insert your equipment into a heated forge to set the chemicals into the material.<br>\n\
	<br>\n\
	Other notes:<br>\n\
	-Use your eyes! If you <b>inspect</b> your equipment -- whether it's your crafting stations or handheld tools -- you'll usually be able to discern something useful.<br>\n\
	-Vary up what you make! You'll learn/relearn your skills fastest if you make new products each time.<br>\n\
	-Reagent imbuing is powerful, but if you don't know what chemical to imbue, smithing oil is a good fallback; it will enhance the expected capabilities of the equipment.<br>\n\
	-As you create weapons and equipment, your muscle memory will build over time -- which will let you make new equipment. Check your forge and your crafting bench for new items.<br>\n\
	-Be mindful of the material you use; material properties will change the usefulness of what you produce. Experiment, but don't expect a pizza katana to be worth more than a laugh.<br>\n\
	-You can build a two-handed hammer at your forge. Make it well, and it will work faster than your Nanotrasen-assigned hammer!"

/obj/item/choice_beacon/blacksmith
	name = "smithing supply beacon"
	desc = "Calls a supplypod containing all the required equipment for blacksmithing."
	icon_state = "sb_delivery"
	inhand_icon_state = "sb_delivery"

/obj/item/choice_beacon/blacksmith/generate_display_names()
	return list("Smithing Equipment Crate" = /obj/structure/closet/crate/large/smithing)

