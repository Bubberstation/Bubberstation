// -------------------------
// ------ SUIT JACKET ------
// -------------------------

/obj/item/clothing/suit/jacket/det_suit/noir/blueshield
	name = "bulletproof suit jacket"
	desc = "One of Nanotrasen's finest developments in defensive fashion; a truely bulletproof suit jacket. Designed to stop incoming bullets meant for more important people."
	armor_type = /datum/armor/armor_bulletproof

// -------------------------
// ---------- TIE ----------
// -------------------------

/obj/item/clothing/neck/tie/blue/blueshield
	name = "blueshield tie"
	desc = "Allegedly the source of the power for blueshields, as it teaches them advanced wrestling techniques when worn. Don't lose this."
	var/datum/martial_art/wrestling/style

//Stolen from krav maga gloves
/obj/item/clothing/neck/tie/blue/blueshield/Initialize(mapload)
	. = ..()
	style = new()
	style.allow_temp_override = FALSE

/obj/item/clothing/neck/tie/blue/blueshield/Destroy()
	QDEL_NULL(style)
	return ..()

/obj/item/clothing/neck/tie/blue/blueshield/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_NECK)
		style.teach(user, TRUE)

/obj/item/clothing/neck/tie/blue/blueshield/dropped(mob/user)
	. = ..()
	style.fully_remove(user)

/obj/item/clothing/neck/tie/blue/blueshield/tied
	is_tied = TRUE

// -------------------------
// --------- GLOVE ---------
// -------------------------

/obj/item/clothing/gloves/tackler/rocket/blueshield
	name = "blueshield rocket gloves"
	desc = "Responsible for 99% of active duty discharges, these more concealed and fashionable rocket gloves are designed to take down (literally) threats from a distance. Has extra safety measures in place to prevent you from snapping your spine in half, but note that it is not completely safe. Totally not a pair of supercharged improvised gripper gloves, we promise."
	icon_state = "fingerless"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	oopsie_override = 75

// -------------------------
// --------- SHOES ---------
// -------------------------

/obj/item/clothing/shoes/laceup/blueshield
	name = "steel-toed dress shoes"
	desc = "For when you want to work on a construction site and still be fashionable. Also used by stylish bodyguards."
	armor_type = /datum/armor/shoes_jackboots



// -------------------------
// ------ GUN HOLSTER ------
// -------------------------

/obj/item/storage/belt/holster/detective/blueshield
	name = "blueshield's holster"


/obj/item/storage/belt/holster/detective/blueshield/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/gun/ballistic/automatic/pistol/m1911/blueshield/no_mag = 1,
		/obj/item/ammo_box/magazine/m45 = 3,
	), src)



// -------------------------
// ---------- GUN ----------
// -------------------------

/obj/item/gun/ballistic/automatic/pistol/m1911/blueshield
	name = "battle-worn M1911"
	desc = "A classic .45 handgun with a small magazine capacity. Has seen better days."
	projectile_damage_multiplier = 0.75
	projectile_wound_bonus = -6

/obj/item/gun/ballistic/automatic/pistol/m1911/blueshield/no_mag
	spawnwithmagazine = FALSE

// -------------------------
// ------- BRIEFCASE -------
// -------------------------

/obj/item/storage/briefcase/blueshield
	name = "robust briefcase"
	desc = "It's made of AUTHENTIC assistant-leather and has a price-tag still attached. Its owner must be a real professional. Seems unusually heavy."
	force = 13
	throwforce = 13
	throw_speed = 2
	throw_range = 7
	demolition_mod = 1.25