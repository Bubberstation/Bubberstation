//Title Capitalization for names please!!!

/datum/loadout_category/suit
	category_name = "Suits"
	category_ui_icon = FA_ICON_TOILET
	type_to_generate = /datum/loadout_item/suit
	tab_order = /datum/loadout_category/head::tab_order + 10

/datum/loadout_item/suit
	abstract_type = /datum/loadout_item/suit

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.suit)
		LAZYADD(outfit.backpack_contents, outfit.suit)
	outfit.suit = item_path

/*
*	WINTER COATS
*/

/datum/loadout_item/suit/winter_coat
	name = "Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat

/datum/loadout_item/suit/winter_coat_greyscale
	name = "Greyscale Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/custom

/datum/loadout_item/suit/aformal
	name = "Assistant's Formal Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat

/datum/loadout_item/suit/runed
	name = "Runed Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/narsie

/datum/loadout_item/suit/brass
	name = "Brass Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/ratvar

/datum/loadout_item/suit/korea
	name = "Eastern Winter Coat"
	item_path = /obj/item/clothing/suit/koreacoat

/datum/loadout_item/suit/czech
	name = "Czech Winter Coat"
	item_path = /obj/item/clothing/suit/modernwintercoatthing

/datum/loadout_item/suit/mantella
	name = "Mothic Mantella"
	item_path = /obj/item/clothing/suit/mothcoat/winter

/*
*	SUITS / SUIT JACKETS
*/

/datum/loadout_item/suit/recolorable
	name = "Recolorable Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/greyscale

/datum/loadout_item/suit/black_suit_jacket
	name = "Black Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/blue_suit_jacket
	name = "Blue Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer

/datum/loadout_item/suit/purple_suit_jacket
	name = "Purple Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/purple

/datum/loadout_item/suit/white_suit_jacket
	name = "White Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/white

/datum/loadout_item/suit/suitblackbetter
	name = "Light Black Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black/better

/datum/loadout_item/suit/suitwhite
	name = "Texan Suit Jacket"
	item_path = /obj/item/clothing/suit/texas

/*
*	SUSPENDERS
*/

/datum/loadout_item/suit/suspenders
	name = "Recolorable Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders

/*
*	DRESSES
*/

/datum/loadout_item/suit/white_dress
	name = "White Dress"
	item_path = /obj/item/clothing/suit/costume/whitedress

/*
*	LABCOATS
*/

/datum/loadout_item/suit/labcoat
	name = "Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat

/datum/loadout_item/suit/labcoat_green
	name = "Green Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/mad

/datum/loadout_item/suit/labcoat_medical
	name = "Medical Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/medical

/datum/loadout_item/suit/labcoat_viro
	name = "Virologist's Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/virologist

/datum/loadout_item/suit/labcoat_regular
	name = "Researcher's Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/regular

/datum/loadout_item/suit/labcoat_pharmacist
	name = "Pharmacist's Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/chemist/skyrat/pharmacist

/*
*	PONCHOS
*/

/datum/loadout_item/suit/poncho
	name = "Poncho"
	item_path = /obj/item/clothing/suit/costume/poncho

/datum/loadout_item/suit/poncho_green
	name = "Green Poncho"
	item_path = /obj/item/clothing/suit/costume/poncho/green

/datum/loadout_item/suit/poncho_red
	name = "Red Poncho"
	item_path = /obj/item/clothing/suit/costume/poncho/red


/*
*	JACKETS
*/

/datum/loadout_item/suit/bomber_jacket
	name = "Bomber Jacket"
	item_path = /obj/item/clothing/suit/jacket/bomber

/datum/loadout_item/suit/military_jacket
	name = "Military Jacket"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/puffer_jacket
	name = "Puffer Jacket"
	item_path = /obj/item/clothing/suit/jacket/puffer

/datum/loadout_item/suit/puffer_vest
	name = "Puffer Vest"
	item_path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/loadout_item/suit/leather_jacket
	name = "Leather Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather

/datum/loadout_item/suit/leather_jacket/biker
	name = "Biker Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather/biker

/datum/loadout_item/suit/leather_jacket/hooded
	name = "Leather Jacket with a Hoodie"
	item_path = /obj/item/clothing/suit/hooded/leather

/datum/loadout_item/suit/jacket_sweater
	name = "Recolorable Sweater Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sweater

/datum/loadout_item/suit/jacket_oversized
	name = "Recolorable Oversized Jacket"
	item_path = /obj/item/clothing/suit/jacket/oversized

/datum/loadout_item/suit/jacket_fancy
	name = "Recolorable Fancy Fur Coat"
	item_path = /obj/item/clothing/suit/jacket/fancy

/datum/loadout_item/suit/tailored_jacket
	name = "Recolorable Tailored Jacket"
	item_path = /obj/item/clothing/suit/tailored_jacket

/datum/loadout_item/suit/tailored_short_jacket
	name = "Recolorable Tailored Short Jacket"
	item_path = /obj/item/clothing/suit/tailored_jacket/short

/datum/loadout_item/suit/ethereal_raincoat
	name = "Ethereal Raincoat"
	item_path = /obj/item/clothing/suit/hooded/ethereal_raincoat

/datum/loadout_item/suit/mothcoat
	name = "Mothic Flightsuit"
	item_path = /obj/item/clothing/suit/mothcoat

// Silver Jacket Mk2 but for all of Command
/datum/loadout_item/suit/lt3_armor/New()
	restricted_roles += list(JOB_HEAD_OF_SECURITY, JOB_BLUESHIELD, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CAPTAIN, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER)
	return ..()

// Fancy crop-top jackets

/datum/loadout_item/suit/crop_jacket
	name = "Colourable Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket

/datum/loadout_item/suit/shortsleeve_crop_jacket
	name = "Colourable Short-Sleeved Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve

/datum/loadout_item/suit/sleeveless_crop_jacket
	name = "Colourable Sleeveless Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless

/datum/loadout_item/suit/sports_jacket
	name = "Colourable Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/long

/datum/loadout_item/suit/shortsleeve_sports_jacket
	name = "Colourable Short-Sleeved Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve/long

/datum/loadout_item/suit/sleeveless_sports_jacket
	name = "Colourable Sleeveless Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless/long


// Lore Jackets

/datum/loadout_item/suit/galfed_jacket
	name = "Galactic Federation Jacket"
	item_path = /obj/item/clothing/suit/jacket/galfed

/datum/loadout_item/suit/frontier_colonist
	name = "Frontier Trenchcoat"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/loadout

/datum/loadout_item/suit/frontier_colonist_short
	name = "Frontier Jacket"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/short/loadout

//Para Bombers
//Unless it has armor, real armor and not just like minor acid/fire I'm just gonna leave it unrestricted because the people want their drip. Me. I'm the people.
/datum/loadout_item/suit/parabomber
	name = "Three Piece Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber

/datum/loadout_item/suit/paraatmosbomber
	name = "Atmos Bomber Jacket"
	item_path = /obj/item/clothing/suit/utility/fire/atmosbomber
	restricted_roles = list(ALL_JOBS_ENGINEERING)

/datum/loadout_item/suit/paraengibomber
	name = "Engineering Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/engi

/datum/loadout_item/suit/paracargobomber
	name = "Cargo Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo

/datum/loadout_item/suit/parathesmithsbomber
	name = "Blacksmith Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo/smith

/datum/loadout_item/suit/paraminingbomber
	name = "Mining Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining
	restricted_roles = list(JOB_SHAFT_MINER)

/datum/loadout_item/suit/parascibomber
	name = "Scientist Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science

/datum/loadout_item/suit/pararobobomber
	name = "Robotics Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/robotics

/datum/loadout_item/suit/paramedbomber
	name = "Medical Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/med

/datum/loadout_item/suit/parachembomber
	name = "Chemical Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/chem

/datum/loadout_item/suit/paracorobomber
	name = "Black Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/coroner

/datum/loadout_item/suit/parabotbomber
	name = "Botanical Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/hydro

/datum/loadout_item/suit/paraimposterbomber
	name = "Suspicious Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/syndicate/fake


/*
*	VARSITY JACKET
*/

/datum/loadout_item/suit/varsity
	name = "Varsity Jacket"
	item_path = /obj/item/clothing/suit/varsity

/*
*	COSTUMES
*/

/datum/loadout_item/suit/owl
	name = "Owl Cloak"
	item_path = /obj/item/clothing/suit/toggle/owlwings

/datum/loadout_item/suit/griffin
	name = "Griffon Cloak"
	item_path = /obj/item/clothing/suit/toggle/owlwings/griffinwings

/datum/loadout_item/suit/syndi
	name = "Black And Red Space Suit Replica"
	item_path = /obj/item/clothing/suit/syndicatefake

/datum/loadout_item/suit/bee
	name = "Bee Outfit"
	item_path = /obj/item/clothing/suit/hooded/bee_costume

/datum/loadout_item/suit/plague_doctor
	name = "Plague Doctor Suit"
	item_path = /obj/item/clothing/suit/bio_suit/plaguedoctorsuit

/datum/loadout_item/suit/snowman
	name = "Snowman Outfit"
	item_path = /obj/item/clothing/suit/costume/snowman

/datum/loadout_item/suit/chicken
	name = "Chicken Suit"
	item_path = /obj/item/clothing/suit/costume/chickensuit

/datum/loadout_item/suit/monkey
	name = "Monkey Suit"
	item_path = /obj/item/clothing/suit/costume/monkeysuit

/datum/loadout_item/suit/cardborg
	name = "Cardborg Suit"
	item_path = /obj/item/clothing/suit/costume/cardborg

/datum/loadout_item/suit/xenos
	name = "Xenos Suit"
	item_path = /obj/item/clothing/suit/costume/xenos

/datum/loadout_item/suit/ian_costume
	name = "Corgi Costume"
	item_path = /obj/item/clothing/suit/hooded/ian_costume

/datum/loadout_item/suit/carp_costume
	name = "Carp Costume"
	item_path = /obj/item/clothing/suit/hooded/carp_costume

/datum/loadout_item/suit/wizard
	name = "Wizard Robe"
	item_path = /obj/item/clothing/suit/wizrobe/fake

/datum/loadout_item/suit/witch
	name = "Witch Robe"
	item_path = /obj/item/clothing/suit/wizrobe/marisa/fake

/datum/loadout_item/suit/leather_apron
	name = "Leather Apron"
	item_path = /obj/item/clothing/suit/leatherapron

/datum/loadout_item/suit/bubber/hench
	name = "Henchmen Coat"
	item_path = /obj/item/clothing/suit/jacket/henchmen_coat

/datum/loadout_item/suit/suit_harness
	name = "Suit Harness"
	item_path = /obj/item/clothing/suit/misc/suit_harness

/datum/loadout_item/suit/samurai_armor
	name = "Samurai Costume"
	item_path = /obj/item/clothing/suit/costume/samurai

/datum/loadout_item/suit/bunny_tailcoat
	name = "Bunny Tailcoat"
	item_path = /obj/item/clothing/suit/jacket/tailcoat

/datum/loadout_item/suit/pirate_coat
	name = "Pirate Coat"
	item_path = /obj/item/clothing/suit/costume/pirate


/*
*	SEASONAL
*/

/datum/loadout_item/suit/winter_coat/christmas
	name = "Christmas Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/christmas

/datum/loadout_item/suit/winter_coat/christmas/green
	name = "Green Christmas Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/christmas/green


/*
*	FLANNELS
*/

/datum/loadout_item/suit/flannel_gags
	name = "Flannel Shirt"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/gags

/datum/loadout_item/suit/flannel_black
	name = "Black Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel

/datum/loadout_item/suit/flannel_red
	name = "Red Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/red

/datum/loadout_item/suit/flannel_aqua
	name = "Aqua Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/aqua

/datum/loadout_item/suit/flannel_brown
	name = "Brown Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/brown

/*
*	HAWAIIAN
*/


/datum/loadout_item/suit/hawaiian_shirt
	name = "Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/costume/hawaiian

/*
*	MISC
*/

/datum/loadout_item/suit/frenchtrench
	name = "Blue Trenchcoat"
	item_path = /obj/item/clothing/suit/frenchtrench

/datum/loadout_item/suit/cossak
	name = "Ukrainian Coat"
	item_path = /obj/item/clothing/suit/cossack

/datum/loadout_item/suit/parka
	name = "Falls Parka"
	item_path = /obj/item/clothing/suit/fallsparka

/datum/loadout_item/suit/gags_wintercoat
	name = "Recolorable Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/colourable

/datum/loadout_item/suit/urban
	name = "Urban Coat"
	item_path = /obj/item/clothing/suit/urban

/datum/loadout_item/suit/maxson
	name = "Fancy Brown Coat"
	item_path = /obj/item/clothing/suit/brownbattlecoat

/datum/loadout_item/suit/bossu
	name = "Fancy Black Coat"
	item_path = /obj/item/clothing/suit/blackfurrich

/datum/loadout_item/suit/dutchjacket
	name = "Western Jacket"
	item_path = /obj/item/clothing/suit/dutchjacketsr

/datum/loadout_item/suit/caretaker
	name = "Caretaker Jacket"
	item_path = /obj/item/clothing/suit/victoriantailcoatbutler

/datum/loadout_item/suit/jacketbomber_alt
	name = "Bomber Jacket w/ Zipper"
	item_path = /obj/item/clothing/suit/toggle/jacket

/datum/loadout_item/suit/colourable_leather_jacket
	name = "Colourable Leather Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather/colourable

/datum/loadout_item/suit/woolcoat
	name = "Leather Overcoat"
	item_path = /obj/item/clothing/suit/woolcoat

/datum/loadout_item/suit/flakjack
	name = "Flak Jacket"
	item_path = /obj/item/clothing/suit/flakjack

/datum/loadout_item/suit/deckard
	name = "Runner Coat"
	item_path = /obj/item/clothing/suit/toggle/deckard
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/bltrench
	name = "Black Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchblack

/datum/loadout_item/suit/brtrench
	name = "Brown Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchbrown

/datum/loadout_item/suit/discojacket
	name = "Disco Ass Blazer"
	item_path = /obj/item/clothing/suit/discoblazer

/datum/loadout_item/suit/kimjacket
	name = "Aerostatic Bomber Jacket"
	item_path = /obj/item/clothing/suit/kimjacket

/datum/loadout_item/suit/cardigan
	name = "Cardigan"
	item_path = /obj/item/clothing/suit/toggle/jacket/cardigan

/datum/loadout_item/suit/blastwave_suit
	name = "Blastwave Trenchcoat"
	item_path = /obj/item/clothing/suit/blastwave


/datum/loadout_item/suit/recolorable_apron
	name = "Recolorable Apron"
	item_path = /obj/item/clothing/suit/apron/chef/colorable_apron

/datum/loadout_item/suit/recolorable_overalls
	name = "Recolorable Overalls"
	item_path = /obj/item/clothing/suit/apron/overalls

/datum/loadout_item/suit/redhood
	name = "Red cloak"
	item_path = /obj/item/clothing/suit/hooded/cloak/david

/datum/loadout_item/suit/wellwornshirt
	name = "Well-worn Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt

/datum/loadout_item/suit/wellworn_graphicshirt
	name = "Well-worn Graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic

/datum/loadout_item/suit/ianshirt
	name = "Well-worn Ian Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian

/datum/loadout_item/suit/wornoutshirt
	name = "Worn-out Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout

/datum/loadout_item/suit/wornout_graphicshirt
	name = "Worn-out graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic

/datum/loadout_item/suit/wornout_ianshirt
	name = "Worn-out Ian Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian

/datum/loadout_item/suit/messyshirt
	name = "Messy Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy

/datum/loadout_item/suit/messy_graphicshirt
	name = "Messy Graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic

/datum/loadout_item/suit/messy_ianshirt
	name = "Messy Ian Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian

/datum/loadout_item/suit/wornshirt
	name = "Worn Shirt"
	item_path = /obj/item/clothing/suit/wornshirt

/datum/loadout_item/suit/duster
	name = "Colorable Duster"
	item_path = /obj/item/clothing/suit/duster

/datum/loadout_item/suit/peacoat
	name = "Colorable Peacoat"
	item_path = /obj/item/clothing/suit/toggle/peacoat

/datum/loadout_item/suit/trackjacket
	name = "Track Jacket"
	item_path = /obj/item/clothing/suit/toggle/trackjacket

/datum/loadout_item/suit/croptop
	name = "Crop Top Turtleneck"
	item_path = /obj/item/clothing/suit/croptop

/*
*	HOODIES
*/

/datum/loadout_item/suit/hoodie/greyscale
	name = "Greyscale Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie

/datum/loadout_item/suit/hoodie/greyscale_trim
	name = "Greyscale Trimmed Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim

/datum/loadout_item/suit/hoodie/greyscale_trim_alt
	name = "Greyscale Trimmed Hoodie (Alt)"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim/alt

/datum/loadout_item/suit/hoodie/black
	name = "Black Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/black

/datum/loadout_item/suit/hoodie/red
	name = "Red Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/red

/datum/loadout_item/suit/hoodie/blue
	name = "Blue Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/blue

/datum/loadout_item/suit/hoodie/green
	name = "Green Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/green

/datum/loadout_item/suit/hoodie/orange
	name = "Orange Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/orange

/datum/loadout_item/suit/hoodie/yellow
	name = "Yellow Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/yellow

/datum/loadout_item/suit/hoodie/grey
	name = "Grey Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/grey

/datum/loadout_item/suit/hoodie/nt
	name = "NT Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded

/datum/loadout_item/suit/hoodie/smw
	name = "SMW Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/smw

/datum/loadout_item/suit/hoodie/nrti
	name = "NRTI Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/nrti

/datum/loadout_item/suit/hoodie/cti
	name = "CTI Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/cti

/datum/loadout_item/suit/hoodie/mu
	name = "Mojave University Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/mu

//Doppler hoodies.

/datum/loadout_item/suit/hoodie/big_hoodie
	name = "Big Hoodie"
	item_path = /obj/item/clothing/suit/hooded/big_hoodie

/datum/loadout_item/suit/hoodie/twee_hoodie
	name = "Disconcertingly Twee Hoodie"
	item_path = /obj/item/clothing/suit/hooded/twee_hoodie

/*
*	JOB-LOCKED
*/

// WINTER COATS
/datum/loadout_item/suit/coat_med
	name = "Medical Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical

/datum/loadout_item/suit/coat_paramedic
	name = "Paramedic Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic

/datum/loadout_item/suit/coat_robotics
	name = "Robotics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science/robotics

/datum/loadout_item/suit/coat_sci
	name = "Science Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science

/datum/loadout_item/suit/coat_eng
	name = "Engineering Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering

/datum/loadout_item/suit/coat_atmos
	name = "Atmospherics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos

/datum/loadout_item/suit/coat_hydro
	name = "Hydroponics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/hydro

/datum/loadout_item/suit/coat_bar
	name = "Bartender Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/bartender

/datum/loadout_item/suit/coat_cargo
	name = "Cargo Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/cargo

/datum/loadout_item/suit/coat_miner
	name = "Mining Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/miner

// JACKETS
/datum/loadout_item/suit/navybluejacketofficer
	name = "Security Officer's Navy Blue Formal Jacket"
	item_path = /obj/item/clothing/suit/jacket/officer/blue
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/navybluejacketwarden
	name = "Warden's Navy Blue Formal Jacket"
	item_path = /obj/item/clothing/suit/jacket/warden/blue
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/suit/navybluejackethos
	name = "Head of Security's Navy Blue Formal Jacket"
	item_path = /obj/item/clothing/suit/jacket/hos/blue
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/suit/security_jacket
	name = "Security Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY) //Not giving this one to COs because it's actually better than the one they spawn with

/datum/loadout_item/suit/brit
	name = "High Vis Armored Vest"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/brit
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/british_jacket
	name = "Peacekeeper Officer Coat"
	item_path = /obj/item/clothing/suit/british_officer
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/offdep_jacket
	name = "Off-Department Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/assistant

/datum/loadout_item/suit/engi_jacket
	name = "Engineering Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/engi

/datum/loadout_item/suit/sci_jacket
	name = "Science Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sci

/datum/loadout_item/suit/med_jacket_light
	name = "Medical Jacket (Light)"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/medical
	restricted_roles = list (JOB_MEDICAL_DOCTOR, JOB_SECURITY_MEDIC, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/med_jacket_dark
	name = "Medical Jacket (Dark)"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/medical/dark
	restricted_roles = list (JOB_MEDICAL_DOCTOR, JOB_SECURITY_MEDIC, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/med_jacket_orderly
	name = "Medical Jacket (Orderly/SecMed)"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec/medical
	restricted_roles = list (JOB_ORDERLY, JOB_SECURITY_MEDIC, JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/labcoat/doctor_tailcoat
	name = "Brig Physician's tailcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/doctor_tailcoat
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/supply_jacket
	name = "Supply Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/supply

/datum/loadout_item/suit/cargo_gorka_jacket
	name = "Cargo Gorka Jacket"
	item_path = /obj/item/clothing/suit/toggle/cargo_tech

/datum/loadout_item/suit/qm_jacket
	name = "Quartermaster's Overcoat"
	item_path = /obj/item/clothing/suit/jacket/quartermaster
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/suit/hooded/wintercoat/security
	name = "Security Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/hooded/wintercoat/security/redsec
	name = "Security Red Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/toggle/jacket/sec/old
	name = "Security Red Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec/old
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/secjacket
	name = "High-Vis Security Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/secjacket/blue
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/secjacket/bomber
	name = "Security Bomber Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/officer/tan
	name = "Tan Security Blazer"
	item_path = /obj/item/clothing/suit/jacket/officer/tan
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/secjacket
	name = "Security Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/secjacket
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/peacekeeper/armadyne
	name = "Armadyne Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/peacekeeper/armadyne/armor
	name = "Armadyne Armor Vest"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/nri_police
	name = "Imperial Police Vest"
	item_path = /obj/item/clothing/suit/armor/vest/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/suit/jacket/fedsec
	name = "Modern Security Federation Jacket"
	item_path = /obj/item/clothing/suit/fedcoat/modern/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/corrections_officer
	name = "Correction's Officer's Blazer"
	item_path = /obj/item/clothing/suit/toggle/jacket/corrections_officer
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/suit/jacket/security_medic
	name = "Security Medic Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/jacket/security_medic
	name = "Security Medic's Blue Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue
	restricted_roles = list(JOB_SECURITY_MEDIC)

// LABCOATS
/datum/loadout_item/suit/labcoat_highvis
	name = "High-Vis Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/highvis

/*
*	FAMILIES
*/

/datum/loadout_item/suit/tmc
	name = "TMC Coat"
	item_path = /obj/item/clothing/suit/costume/tmc

/datum/loadout_item/suit/pg
	name = "PG Coat"
	item_path = /obj/item/clothing/suit/costume/pg

/datum/loadout_item/suit/deckers
	name = "Deckers Hoodie"
	item_path = /obj/item/clothing/suit/costume/deckers

/datum/loadout_item/suit/soviet
	name = "Soviet Coat"
	item_path = /obj/item/clothing/suit/costume/soviet

/datum/loadout_item/suit/yuri
	name = "Yuri Coat"
	item_path = /obj/item/clothing/suit/costume/yuri

/*
*	DONATOR
*/

/datum/loadout_item/suit/donator
	donator_only = TRUE

/datum/loadout_item/suit/donator/furredjacket
	name = "Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/public

/datum/loadout_item/suit/donator/whitefurredjacket
	name = "White Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/white

/datum/loadout_item/suit/donator/creamfurredjacket
	name = "Cream Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/cream

/datum/loadout_item/suit/donator/modern_winter
	name = "Modern Winter Coat"
	item_path = /obj/item/clothing/suit/modern_winter

/datum/loadout_item/suit/donator/blondie
	name = "Cowboy Vest"
	item_path = /obj/item/clothing/suit/cowboyvest

/datum/loadout_item/suit/donator/digicoat/nanotrasen
	name = "nanotrasen digicoat"
	item_path = /obj/item/clothing/suit/toggle/digicoat/nanotrasen

/datum/loadout_item/suit/donator/digicoat/interdyne
	name = "Interdyne Digicoat"
	item_path = /obj/item/clothing/suit/toggle/digicoat/interdyne

/datum/loadout_item/suit/digicoat_glitched //Public donator reward for Razurath.
	name = "Glitched Digicoat"
	item_path = /obj/item/clothing/suit/toggle/digicoat/glitched

/datum/loadout_item/suit/warm_coat
	name = "Colourable Warm Coat"
	item_path = /obj/item/clothing/suit/warm_coat

/datum/loadout_item/suit/warm_sweater
	name = "Colourable Warm Sweater"
	item_path = /obj/item/clothing/suit/warm_sweater

/datum/loadout_item/suit/heart_sweater
	name = "Colourable Heart Sweater"
	item_path = /obj/item/clothing/suit/heart_sweater

/datum/loadout_item/suit/runner_engi
	name = "Engineer Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/engi
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/runner_syndi
	name = "Syndicate Runner Jacket"
	item_path = /obj/item/clothing/suit/jacket/runner/syndicate
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/collared_vest
	name = "GLP-C 'Úlfur' Vest"
	item_path = /obj/item/clothing/suit/armor/vest/collared_vest
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_CENTRAL)
	donator_only = TRUE //Dono item for offwrldr

/datum/loadout_item/suit/highvisjacket //sprites by Keila
	name = "High Vis Trucker Jacket"
	item_path = /obj/item/clothing/suit/jacket/trucker/highvis
	donator_only = TRUE //Donator item for arandomhyena

/datum/loadout_item/suit/roninjacket //sprites by Keila
	name = "Ronin Jacket"
	item_path = /obj/item/clothing/suit/jacket/trucker/ronin
	donator_only = TRUE //Donator item for arandomhyena

/datum/loadout_item/suit/flight //Donor item for ironknight060
	name = "MA-1 flight jacket"
	item_path = /obj/item/clothing/suit/jacket/flight

/datum/loadout_item/suit/furcoat
	name = "Leather coat with fur"
	item_path = /obj/item/clothing/suit/furcoat
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/ryddid
	name = "The Ryddid"
	item_path = /obj/item/clothing/suit/jacket/ryddid
	//ckeywhitelist = list("grunnyyy")

/datum/loadout_item/suit/rax_peacekeeper_jacket
	name = "Peacekeeper Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/warden/rax
	//ckeywhitelist = list("raxraus")
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC,)

/datum/loadout_item/suit/jacket/cherno
	name = "Blue-Silvered Coat"
	item_path = /obj/item/clothing/suit/jacket/cherno
	//ckeywhitelist = list("cherno00")

/datum/loadout_item/suit/caligram_parka_tan
	name = "Blacktide Tan Coat"
	item_path = /obj/item/clothing/suit/jacket/caligram_parka_tan
	can_be_reskinned = TRUE
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/suit/caligram_parka_vest_tan
	name = "Blacktide Armored Coat"
	item_path = /obj/item/clothing/suit/armor/vest/caligram_parka_vest_tan
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC,)
	can_be_reskinned = TRUE

/datum/loadout_item/suit/brasspriest
	name = "Brasspriest Coat"
	item_path = /obj/item/clothing/suit/jacket/brasspriest
//	ckeywhitelist = list("ChillyLobster")

/datum/loadout_item/suit/hydrogenrobes
	name = "Metallic-Hydrogen robes"
	item_path = /obj/item/clothing/suit/jacket/hydrogenrobes
//	ckeywhitelist = list("ChillyLobster")

/datum/loadout_item/suit/darkarmor
	name = "Dark Armor"
	item_path = /obj/item/clothing/suit/armor/vest/darkcarapace
	//ckeywhitelist = list("inferno707")

/datum/loadout_item/suit/scraparmour
	name = "Scrap Armor"
	item_path = /obj/item/clothing/suit/scraparmour
	//ckeywhitelist = list("hackertdog")

/datum/loadout_item/suit/mikujacket
	name = "starlight singer jacket"
	item_path = /obj/item/clothing/suit/mikujacket
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/suit/delta_coat
	name = "Grey Winter Hoodie"
	item_path = /obj/item/clothing/suit/jacket/delta
	//ckeywhitelist = list("deltatri")

/datum/loadout_item/suit/hubertcc
	name = "CC Ensign's armoured vest"
	item_path = /obj/item/clothing/suit/armor/vest/nanotrasen_consultant/hubert
	//ckeywhitelist = list("hackertdog")
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/suit/occult_coat
	name = "Occult Collector's Coat"
	item_path = /obj/item/clothing/suit/hooded/occult
	//ckeywhitelist = list("gamerguy14948")

/datum/loadout_item/suit/gorlex_harness
	name = "Engine Technician Harness"
	item_path = /obj/item/clothing/suit/jacket/gorlex_harness
	//ckeywhitelist = list("1ceres")

/datum/loadout_item/suit/tenrai_coat
	name = "Tenrai Coat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/tenrai
	//ckeywhitelist = list("cimika")

/datum/loadout_item/suit/rainbowcoat
	name = "Rainbow Coat"
	item_path = /obj/item/clothing/suit/toggle/rainbowcoat
	//ckeywhitelist = list("dudewithatude")

/datum/loadout_item/suit/recruiter_jacket
	name = "Recruiter's Jacket"
	item_path = /obj/item/clothing/suit/toggle/recruiter_jacket
	//ckeywhitelist = list("m97screwsyourparents")

/datum/loadout_item/suit/techpriest
	name = "Techpriest Robes"
	item_path = /obj/item/clothing/suit/hooded/techpriest
	//ckeywhitelist = list("imthinkingarbys")

/datum/loadout_item/suit/elofy
	name = "Solar Admiral Coat"
	item_path = /obj/item/clothing/suit/armor/hos/elofy
//	ckeywhitelist = list("october23")
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	can_be_reskinned = TRUE

/datum/loadout_item/suit/shortcoat
	name = "Short Purple Coat"
	item_path = /obj/item/clothing/suit/short_coat
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/blackraincoat
	name = "Black Open-Faced Raincoat"
	item_path = /obj/item/clothing/suit/hooded/sigmarcoat
	//ckeywhitelist = list("sigmaralkahest")

/datum/loadout_item/suit/razurathcoat
	name = "Golden Nanotrasen Officer Coat"
	item_path = /obj/item/clothing/suit/razurathcoat
	//ckeywhitelist = list("razurath")

/datum/loadout_item/suit/digicoat_glitched
	name = "Glitched Digicoat"
	item_path = /obj/item/clothing/suit/toggle/digicoat/glitched
	//ckeywhitelist = list("razurath")

/datum/loadout_item/suit/lt3_armor
	name = "Silver Jacket Mk II"
	item_path = /obj/item/clothing/suit/armor/skyy
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_NT_REP)

/datum/loadout_item/suit/lt3_jacket
	name = "Silver Jacket"
	item_path = /obj/item/clothing/suit/jacket/skyy

/datum/loadout_item/suit/colorblockhoodie
	name = "Color-Block Hoodie"
	item_path = /obj/item/clothing/suit/hooded/colorblockhoodie
//	ckeywhitelist = list("lolpopomg101")

/datum/loadout_item/suit/nobility_dresscoat
	name = "Nobility Dresscoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator
//	ckeywhitelist = list("nikotheguydude")

/datum/loadout_item/suit/blutigen_kimono
	name = "Blutigen Kimono"
	item_path = /obj/item/clothing/suit/blutigen_kimono
	//ckeywhitelist = list("random516")

