
//
//item presets for donator items and other gunk
//
/obj/item/clothing/glasses/eyepatch/white
	icon ='GainStation13/icons/obj/clothing/glasses.dmi'
	mob_overlay_icon = 'GainStation13/icons/mob/eyes.dmi'
	name = "White eyepatch"
	desc = "Smells faintly of medicine and headaches."
	icon_state = "eyepatch_white"
	item_state = "eyepatch_white"

/obj/item/clothing/glasses/eyepatch/white/cabal
	name = "Cabal's Eyepatch"
	desc = "Vulpine sluts only."

/obj/item/toy/sword/chloesabre/halsey
	name = "Halsey's Sabre"
	desc = "An elegant weapon, similar in design to the Captain's Sabre, but with a platinum hilt and an adamantine blade. the hilt has an engraved hyena on it."
	force = 16

/obj/item/gun/ballistic/revolver/mateba/moka
	name = "\improper Custom Unica 6 revolver"
	desc = "An elegant and ornate revolver belonging to a certain hellcat commander. There are some words carved on its side: 'Dura Lex, Sed Lex'"

/obj/item/clothing/suit/chloe/halsey //sorry to whoever chloe is, but that coat is far too badass not to be used
	name = "Halsey's Commander Overcoat"
	desc = "A Ginormous red overcoat that looks fit for a commander. Has a tag on it that reads: 'Property of Halsey Harmonten. Please return if lost!'"
	armor = list("melee" = 20, "bullet" = 20, "laser" = 0,"energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 0) //worn by a captain player, might as well recompensate not wearing the carapace

/obj/item/clothing/suit/storage/blueshield //Look man I don't know, this is the file it was in on Oracle. Don't shoot me. Please.
	name = "blueshield coat"
	desc = "An armored coat often worn by bodyguards. Tough because everyone knows deep down you're a softie."
	icon = 'GainStation13/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'GainStation13/icons/mob/suit.dmi'
	icon_state = "blueshieldcoat"
	item_state = "blueshieldcoat"
	body_parts_covered = CHEST|LEGS|ARMS
	allowed = list(/obj/item/gun/energy, /obj/item/reagent_containers/spray/pepper, /obj/item/ammo_box, /obj/item/ammo_casing,/obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/flashlight/seclite, /obj/item/melee/classic_baton)
	armor = list(melee = 25, bullet = 10, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0)
	cold_protection = CHEST|LEGS|ARMS
	heat_protection = CHEST|LEGS|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/storage/blueshield/grimmy
	name = "Overcoat of the Destitute"
	desc = "Welcome all to the everlasting all-time low. Please put your hands together for the ever-failing one man show: Domino!"
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/crowbar/bronze/glaug
	name = "Milwaukee Pocket Crowbar"
	desc = "Much more expensive. Still serves the same function."

