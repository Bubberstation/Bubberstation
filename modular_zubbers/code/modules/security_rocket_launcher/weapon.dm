/obj/item/gun/ballistic/rocketlauncher/security

	//Text
	name = "\improper \"VARS\" Variable Active Radar Missile System"
	desc = "A (relatively) cheap, reusable missile launcher cooked up by the crackpots in the Nanotrasen weapons development labs meant to deal with those pesky space bandits. \
	Uses special patented 69mm \"fire and fuhgeddaboudit\" missiles that home in on targets with large radar signatures, including walls, floors, and most importantly, people."
	cartridge_wording = "missile"

	//Icons
	icon = 'modular_zubbers/icons/obj/weapons/guns/sec_missile.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	worn_icon_state = "rocketlauncher"

	//Sound
	fire_sound = 'modular_zubbers/sound/weapons/gun/sec_missile/shoot.ogg'
	load_sound = 'modular_zubbers/sound/weapons/gun/sec_missile/insert.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_pickup1.ogg'

	//Internal code
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/security_rocketlauncher
	pin = /obj/item/firing_pin

	//Stats
	backblast = FALSE
	gun_flags = TURRET_INCOMPATIBLE
	fire_delay = 2 SECONDS
	weapon_weight = WEAPON_HEAVY
	slot_flags = null

	//The funny
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "Using a cryptographic sequencer on this should overload the radar systems."

	var/self_targeting = FALSE //emag interaction

	var/warning_label //Generated on examine for the first time.

/obj/item/gun/ballistic/rocketlauncher/security/proc/generate_warning_label()

	. = ""

	var/list/possible_good_instructions = list(
		"CHECK COVER FOR DAMAGE BEFORE FIRING",
		"CHECK BACKBLAST BEFORE FIRING",
		"FRONT TOWARDS ENEMY",
		"SHOULDER FIRE ONLY",
		"DO NOT USE INDOORS",
		"DO NOT INHALE CONTENTS OF TUBE",
		"DO NOT INSERT FOREIGN OBJECTS INTO TUBE",
		"USE EYE PROTECTION",
		"USE HEARING PROTECTION",
		"KEEP LEVEL WHILE FIRING",
		"KEEP STILL WHILE FIRING",
		"DO NOT TAMPER WITH ELECTRONICS"
	)

	var/list/possible_bad_instructions = list(
		"DO NOT EAT",
		"DO NOT INSERT FOREIGN SUBSTANCES INTO TUBE",
		"KEEP AWAY FROM ELECTRICAL INFETTERENCE", //I saw Ryan Gosling at a grocery store in Los Angeles yesterday.
		"ALWAYS READ THE WARNING LABEL BEFORE USE",
		"FOR EXTERNAL USE ONLY",
		"FLAMMABLE",
		"AVOID CONTACT WITH EYES",
		"DO NOT STORE ABOVE 313.15 KELVIN",
		"CLOWNS SHOULD BE SUPERVISED WHEN USING THIS PRODUCT",
		"DO NOT GIVE TO CLOWN",
		"KEEP AWAY FROM CLOWNS",
		"DO NOT SUBMERGE",
		"DO NOT SWALLOW.",
		"HARMFUL IF SWALLOWED",
		"IF SWALLOWED, CONTACT A PHYSICIAN",
		"DO NOT APPLY TO BROKEN SKIN",
		"IF RASH OR IRRITATION DEVELOPS, DISCONTINUE USE",
		"ONLY USE AS DIRECTED",
		"DO NOT OPERATE WHILE USING HEAVY MACHINERY",
		"MAY CAUSE DROWSINESS",
		"NEVER USE A LIT MATCH OR OPEN FLAME TO CHECK IF LOADED",
		"DO NOT USE WHILE SLEEPING",
		"THIS PRODUCT MAY CONTAIN: EGGS, NUTS, SOY, AND TREE NUTS",
		"DO NOT INSERT LIMBS INTO TUBE",
		"NOT TO BE USED FOR NAVIGATION",
		"NOT FIT FOR HUMAN CONSUMPTION",
		"DO NOT USE FOR PERSONAL HYGINE",
		"CHOKING HAZARD: MAY CONTAIN SMALL PARTS",
		"DO NOT ATTEMPT",
		"MAY IRRITATE EYES",
		"FIRE HAZARD WHEN LOADED",
		"WARRANTY VOID IF READ",
		"WARRANTY VOID",
		"MAY IRRITATE CREWMEMBERS",
		"MAY CONTAIN EXPLOSIVES",
		"DO NO HARM",
		"DO NOT SWEAR",
		"DO NOT",
		"NOT A TELESCOPE",
		"NOT FOR INDIVIDUAL SALE",
		"DO NOT REPOST"
	)

	if(!CONFIG_GET(flag/disable_erp_preferences))
		possible_bad_instructions += list(
			"DO NOT USE DURING SEX",
			"DO NOT USE WHILE PREGNANT OR BREASTFEEDING",
			"KEEP OUT OF DORMS",
			"KEEP AWAY FROM SIZE QUEENS",
		)

	var/total_good_length_mod = FLOOR(length(possible_good_instructions) * 0.5, 1)

	//Generate the first half. Always useful.
	for(var/i in 1 to total_good_length_mod)
		. += "[pick_n_take(possible_good_instructions)]<br>"

	//As for the second half... well...
	for(var/i in 1 to total_good_length_mod)
		if(!prob(80)) // lore optimization
			. += "[pick_n_take(possible_bad_instructions)]<br>"
		else
			. += "[pick_n_take(possible_good_instructions)]<br>"

/obj/item/gun/ballistic/rocketlauncher/security/examine(mob/user)
	. = ..()

	if(isobserver(user))
		return

	//Shamelessly copied from /obj/structure/sign/eyechart
	if(!user.can_read(src, READING_CHECK_LITERACY, silent = TRUE) || !user.has_language(/datum/language/common, UNDERSTOOD_LANGUAGE))
		if(!user.is_blind())
			. += "<hr>You gaze at the warning label, trying to make sense of it..."
			. += span_warning("...But you don't actually know what any of it means.")
		return

	if(!user.can_read(src, READING_CHECK_LIGHT, silent = TRUE))
		. += "<hr>You squint at the warning label..."
		. += span_warning("...But it's too dark to make out anything.")
		return

	var/obj/item/organ/eyes/eye = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(isnull(eye))
		return

	if(eye.damage >= eye.low_threshold || user.has_status_effect(/datum/status_effect/eye_blur))
		. += "<hr>You squint at the warning label..."
		. += span_warning("...But it's too hard to read anything this small...")
		return

	if(!warning_label)
		warning_label = generate_warning_label()

	. += span_warning("A warning label on the side reads:")

	. += span_danger(warning_label)

/obj/item/gun/ballistic/rocketlauncher/security/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(self_targeting)
		return FALSE
	self_targeting = TRUE
	balloon_alert(user, "targeting systems tampered")
	do_sparks(2, FALSE, src)
	return TRUE

//Internal Magazine
/obj/item/ammo_box/magazine/internal/security_rocketlauncher
	name = "missile launcher internal magazine"
	ammo_type = /obj/item/ammo_casing/security_missile
	caliber = CALIBER_69MM
	max_ammo = 1



//Debug nonsense.
/obj/item/gun/ballistic/rocketlauncher/security/debug
	fire_delay = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/security_rocketlauncher/debug
	item_flags = NEEDS_PERMIT|ABSTRACT //ABSTRACT solely so it doesnt' spawn in random christmas gifts
	burst_size = 5
	burst_delay = 1

/obj/item/ammo_box/magazine/internal/security_rocketlauncher/debug
	max_ammo = 69
