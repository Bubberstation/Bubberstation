/datum/job/nanotrasen_consultant
	title = JOB_NT_REP
	rpg_title = "Guild Adviser"
	description = "Represent Nanotrasen on the station, argue with the HoS about why he can't just field execute people for petty theft, get drunk in your office."
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command"
	minimal_player_age = 14
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "NANOTRASEN_CONSULTANT"

	department_for_prefs = /datum/job_department/captain

	departments_list = list(
		/datum/job_department/command,
	)

	outfit = /datum/outfit/job/nanotrasen_consultant
	plasmaman_outfit = /datum/outfit/plasmaman/nanotrasen_consultant
	akula_outfit = /datum/outfit/akula

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CMD

	display_order = JOB_DISPLAY_ORDER_NANOTRASEN_CONSULTANT
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)

	mail_goodies = list(
		/obj/item/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 10
	)

	job_flags = STATION_JOB_FLAGS | JOB_BOLD_SELECT_TEXT | HEAD_OF_STAFF_JOB_FLAGS
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE
	alt_titles = list(
		"Nanotrasen Consultant",
		"Nanotrasen Advisor",
		"Nanotrasen Diplomat",
		"Nanotrasen Representative",
		"Nanotrasen Liaison",
		"Command Consultant",
		"Command Advisor",
		"Corporate Diplomat",
		"Corporate Representative",
		"Corporate Liaison",
		"Corporate Interest Officer",
	)

/datum/outfit/job/nanotrasen_consultant
	name = "Nanotrasen Consultant"
	jobtype = /datum/job/nanotrasen_consultant

	belt = /obj/item/modular_computer/pda/nanotrasen_consultant
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/nanotrasen_consultant
	gloves = /obj/item/clothing/gloves/combat
	uniform =  /obj/item/clothing/under/rank/nanotrasen_consultant
	suit = /obj/item/clothing/suit/armor/vest/nanotrasen_consultant
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/nanotrasen_consultant
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/consultant/weapon_case = 1
		)

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	implants = list(/obj/item/implant/mindshield)
	accessory = /obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom

	chameleon_extras = list(/obj/item/stamp/centcom)

	id = /obj/item/card/id/advanced/platinum
	id_trim = /datum/id_trim/job/nanotrasen_consultant

/obj/item/radio/headset/heads/nanotrasen_consultant
	name = "\proper the Nanotrasen consultant's headset"
	desc = "An official Central Command headset."
	icon_state = "cent_headset"
	keyslot = new /obj/item/encryptionkey/headset_com
	keyslot2 = new /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/heads/nanotrasen_consultant/alt
	name = "\proper the Nanotrasen consultant's bowman headset"
	desc = "An official Central Command headset. Protects ears from flashbangs."
	icon_state = "cent_headset_alt"

/obj/item/radio/headset/heads/nanotrasen_consultant/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/effect/landmark/start/nanotrasen_consultant
	name = "Nanotrasen Consultant"
	icon_state = "Nanotrasen Consultant"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/item/clothing/accessory/medal/gold/nanotrasen_consultant
	name = "medal of diplomacy"
	desc = "A golden medal awarded exclusively to those promoted to the rank of Nanotrasen Consultant. It signifies the diplomatic abilities of said individual and their sheer dedication to Nanotrasen."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/datum/outfit/plasmaman/nanotrasen_consultant
	name = "Nanotrasen Consultant Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/centcom_official
	gloves = /obj/item/clothing/gloves/captain //Too iconic to be replaced with a plasma version
	head = /obj/item/clothing/head/helmet/space/plasmaman/centcom_official

/obj/item/modular_computer/pda/nanotrasen_consultant
	name = "nanotrasen consultant's PDA"
	icon_state = "/obj/item/modular_computer/pda/nanotrasen_consultant"
	inserted_disk = /obj/item/disk/computer/command/captain
	inserted_item = /obj/item/pen/fountain/green
	greyscale_colors = "#017941#0060b8"
	starting_programs = list(
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/faxbond,
	)

/obj/item/storage/bag/garment/nanotrasen_consultant
	name = "nanotrasen consultant's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the Nanotrasen consultant."

/obj/item/storage/bag/garment/nanotrasen_consultant/PopulateContents()
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/glasses/sunglasses/gar/giga(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/gloves/captain/centcom(src)
	new /obj/item/clothing/suit/hooded/wintercoat/centcom/nt_consultant(src)
	new /obj/item/clothing/under/rank/nanotrasen_consultant(src)
	new /obj/item/clothing/under/rank/nanotrasen_consultant/skirt(src)
	new /obj/item/clothing/under/rank/centcom/consultant(src)
	new /obj/item/clothing/under/rank/centcom/consultant/skirt(src)
	new /obj/item/clothing/under/rank/centcom/officer(src)
	new /obj/item/clothing/under/rank/centcom/officer_skirt(src)
	new /obj/item/clothing/under/rank/centcom/official(src)
	new /obj/item/clothing/under/rank/centcom/official/turtleneck(src)
	new /obj/item/clothing/head/nanotrasen_consultant(src)
	new /obj/item/clothing/head/nanotrasen_consultant/beret(src)
	new /obj/item/clothing/head/beret/centcom_formal/nt_consultant(src)
	new /obj/item/clothing/head/hats/centhat(src)
	new /obj/item/clothing/head/hats/consultant_cap(src)
	new /obj/item/clothing/suit/armor/centcom_formal/nt_consultant(src)
	new /obj/item/clothing/suit/armor/vest/officerfake(src)
	new /obj/item/clothing/under/rank/centcom/intern(src)
	new /obj/item/clothing/head/hats/intern(src)

/obj/structure/closet/secure_closet/nanotrasen_consultant
	name = "nanotrasen consultant's locker"
	req_access = list()
	req_one_access = list(ACCESS_CENT_GENERAL)
	icon_state = "cc"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'

/obj/structure/closet/secure_closet/nanotrasen_consultant/PopulateContents()
	..()
	new /obj/item/storage/backpack/satchel/leather(src)
	new /obj/item/storage/backpack/satchel/nanotrasen(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/disk/computer/command/captain(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant/alt(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant(src)
	new /obj/item/storage/photo_album/personal(src)
	new /obj/item/bedsheet/centcom(src)
	new /obj/item/storage/bag/garment/nanotrasen_consultant(src)


/obj/item/pen/fountain/green
	name = "nanotrasen fountain pen"
	desc = "It's an expensive green fountain pen. The case may be plastic, but that gold is real!"
	icon = 'modular_zubbers/icons/obj/service/bureaucracy.dmi'
	icon_state = "pen-fountain-nt"
	colour = "#18610D"
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*7.5)

/obj/item/storage/belt/holster/consultant
	name = "consultant's holster"
	desc = "A familiar-looking leather holster, with black, leather straps and padded jackets painted in an iconic CentCom green. This one belongs to the Nanotrasen consultant."
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	icon_state = "holster_ntc"
	storage_type = /datum/storage/holster/consultant

//Storage is the same as the regular holster but it can hold cigar(ette)s, lighters and stamps :)
/datum/storage/holster/consultant/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine/m9mm,
		/obj/item/ammo_box/magazine/m9mm_aps,
		/obj/item/ammo_box/magazine/m10mm,
		/obj/item/ammo_box/magazine/m45,
		/obj/item/ammo_box/magazine/m50,
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader,
		/obj/item/ammo_box/magazine/toy/pistol,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/gun/ballistic/rifle/boltaction,
		/obj/item/cigarette,
		/obj/item/lighter,
		/obj/item/stamp,
	)

	return ..()

/obj/item/storage/belt/holster/consultant/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/speedloader/c38/c32 = 1,
		/obj/item/gun/ballistic/revolver/consultant = 1,
		/obj/item/stamp/void = 1,
	), src)

/obj/item/consultant/weapon_case
	name = "consultant's weapon case"
	desc = "A secure case containing the consultant's trustworthy weapon."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "guncase"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/worn/cases.dmi'
	worn_icon_state = "darkcase"
	material_flags = NONE
	w_class = WEIGHT_CLASS_NORMAL
	var/redeemed = FALSE

/obj/item/consultant/weapon_case/click_alt(mob/user)
	try_redeem(user)
	return CLICK_ACTION_SUCCESS

/obj/item/consultant/weapon_case/attack_self(mob/user)
	try_redeem(user)

/obj/item/consultant/weapon_case/proc/try_redeem(mob/user)
	if(redeemed || QDELETED(src))
		return
	if(!isliving(user))
		return
	var/mob/living/redeemer = user
	if(redeemer.incapacitated)
		return

	var/static/list/options
	if(!options)

		var/datum/radial_menu_choice/centcomsabre_option = new
		centcomsabre_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/melee.dmi', icon_state = "cc-sheath-full")
		centcomsabre_option.info = span_boldnotice("A beautiful sabre, coming with a green leather sheath, fashioned after those granted to the Centcom Commanders. A status symbol for the true bureaucrat. For when the sword is mightier than the pen.")

		var/datum/radial_menu_choice/admiralsabre_option = new
		admiralsabre_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/melee.dmi', icon_state = "admiral-sheath-full")
		admiralsabre_option.info = span_boldnotice("A beautiful sabre, coming with a black leather sheath, fashioned after those granted to Nanotrasen Admirals. A status symbol for the true bureaucrat. For when the sword is mightier than the pen.")

		var/datum/radial_menu_choice/miniegun_option = new
		miniegun_option.image = image(icon = 'icons/obj/weapons/guns/energy.dmi', icon_state = "mini")
		miniegun_option.info = span_boldnotice("The classic, the mini e-gun. Fits in your pocket, has a disabler and a lethal mode, and includes a flashlight. Perfect for the consultant who doesn't want to draw too much attention to themselves, but still wants to be prepared for anything.")

		var/datum/radial_menu_choice/verdict_option = new
		verdict_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi', icon_state = "niimconsultantrevolver")
		verdict_option.info = span_boldnotice("The Verdict, a weapon reminiscent of the other Nanotrasen Armories revolvers. It's similar to the all-slavic Unica, but with a lovely nickel polish. It is, however, much weaker and lighter than one, and uses a unique .32 caliber. Comes with a holster. Now all you're missing is a fat cigar.")

		options = list(
			"Commander's Sabre Replica" = centcomsabre_option,
			"Admiral's Sabre Replica" = admiralsabre_option,
			"Miniature Energy Gun" = miniegun_option,
			"The Verdict" = verdict_option,
		)

	var/selection = show_radial_menu(redeemer, src, options, custom_check = CALLBACK(src, PROC_REF(check_redeem_menu), redeemer), radius = 38, require_near = TRUE, tooltips = TRUE)
	if(!selection || redeemed || QDELETED(src))
		return

	var/spawn_path
	switch(selection)
		if("Commander's Sabre Replica")
			spawn_path = /obj/item/storage/belt/sheath/sabre/ntc_commander
		if("Admiral's Sabre Replica")
			spawn_path = /obj/item/storage/belt/sheath/sabre/ntc_admiral
		if("Miniature Energy Gun")
			spawn_path = /obj/item/gun/energy/e_gun/mini
		if("The Verdict")
			spawn_path = /obj/item/storage/belt/holster/consultant
		else
			return

	redeemed = TRUE
	var/obj/item/chosen_item = new spawn_path(drop_location())
	redeemer.put_in_hands(chosen_item)
	balloon_alert(redeemer, "selected [LOWER_TEXT(selection)]")
	qdel(src)

/obj/item/consultant/weapon_case/proc/check_redeem_menu(mob/living/redeemer)
	if(!istype(redeemer))
		return FALSE
	if(redeemer.incapacitated)
		return FALSE
	if(QDELETED(src) || redeemed)
		return FALSE
	if(!redeemer.Adjacent(src))
		return FALSE
	return TRUE
