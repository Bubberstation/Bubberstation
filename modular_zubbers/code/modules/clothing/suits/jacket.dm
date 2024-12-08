/obj/item/clothing/suit/jacket/runner //Sprite by kay#7181 (Donater item: Kan3)
	name = "runner jacket"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/jacket/runner/engi //Sprite by kay#7181 (Donater item: Kan3)
	name = "engineer runner jacket"
	icon_state = "runner_engi"
	desc = ""

/obj/item/clothing/suit/jacket/runner/syndicate //Sprite by kay#7181 (Donater item: Kan3)
	name = "syndicate runner jacket"
	icon_state = "runner_syndi"
	desc = ""

/obj/item/clothing/suit/jacket/runner/winter //Sprite by kay#7181 (Donater item: Kan3)
	name = "winter runner jacket"
	icon_state = "runner_winter"
	desc = ""

/obj/item/clothing/suit/jacket/trucker
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	desc = "Contact a coder if you see this."

/obj/item/clothing/suit/jacket/trucker/highvis //Sprites by Scuhf_
	name = "high vis trucker jacket"
	desc = "A trucker's jacket with high visibility orange and yellow stripes for warehouse work."
	icon_state = "highvis"

/obj/item/clothing/suit/jacket/trucker/ronin //ported from Citadel
	name = "ronin jacket"
	desc = "A dark leather jacket with the logo of an old Sol Chromerock band on it."
	icon_state = "ronin"

/obj/item/clothing/suit/jacket/diver //Donor item for patriot210
	name = "black divers coat"
	desc = "A dark leather jacket with the logo of an old Sol Chromerock band on it."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "diver"
	worn_icon_state = "diver"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/jacket/flight //Donor item for ironknight060
	name = "MA-1 flight jacket"
	desc = "Originally developed for the United States Air Force. This jacket has been lovingly passed down from airman to airman before arriving in the 26th Century. Its complete with the reversible orange interior for emergency situations as well. From what you can see on the tag, this Jacket appears to have been made in the year 1985 for the USAF, with a faint name written onto the nametag."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "flight"
	worn_icon_state = "flight"
	icon = 'modular_zubbers/icons/obj/clothing/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

// Henchmen Sprites by Cannibal Hunter of MonkeStation

/obj/item/clothing/suit/jacket/henchmen_coat
	name = "henchmen coat"
	desc = "Alright boss.. I'll handle it."
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "greyscale_coat"
	greyscale_colors = "#201b1a"
	greyscale_config = /datum/greyscale_config/henchmen
	greyscale_config_worn = /datum/greyscale_config/henchmen/worn
	flags_1 = IS_PLAYER_COLORABLE_1
/obj/item/clothing/suit/jacket/henchmen_coat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/suit/jacket/tailcoat //parent type
	name = "tailcoat"
	desc = "A coat usually worn by bunny themed waiters and the like."
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat"
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/tailcoat
	greyscale_config_worn = /datum/greyscale_config/tailcoat_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/tailcoat/bartender
	name = "bartender's tailcoat"
	desc = "A coat usually worn by bunny themed bartenders. It has an interior holster for firearms and some extra padding for minor protection."
	icon_state = "tailcoat_bar"
	greyscale_colors = "#39393f#ffffff"
	greyscale_config = /datum/greyscale_config/tailcoat_bar
	greyscale_config_worn = /datum/greyscale_config/tailcoat_bar_worn
	armor_type = /datum/armor/suit_armor


/obj/item/clothing/suit/jacket/tailcoat/bartender/Initialize(mapload) //so bartenders can use cram their shotgun inside
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate
	name = "suspicious tailcoat"
	desc = "A oddly intimidating coat usually worn by bunny themed assassins. It's reinforced with some extremely flexible lightweight alloy. How much did they pay for this?"
	icon_state = "tailcoat_syndi"
	armor_type = /datum/armor/wintercoat_syndicate
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/syndicate/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/restraints/handcuffs,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
	)

/obj/item/clothing/suit/jacket/tailcoat/syndicate/fake
	armor_type = /datum/armor/none

/obj/item/clothing/suit/wizrobe/magician //Not really a robe but it's MAGIC
	name = "magician's tailcoat"
	desc = "A magnificent, gold-lined tailcoat that seems to radiate power."
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/jacket_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "tailcoat_wiz"
	inhand_icon_state = null
	flags_inv = null

/obj/item/clothing/suit/jacket/tailcoat/centcom
	name = "Centcom tailcoat"
	desc = "An official coat usually worn by bunny themed executives. The inside is lined with comfortable yet tasteful bunny fluff."
	icon_state = "tailcoat_centcom"
	armor_type = /datum/armor/armor_centcom_formal_nt_consultant
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/british
	name = "british flag tailcoat"
	desc = "A tailcoat emblazoned with the Union Jack. Perfect attire for teatime."
	icon_state = "tailcoat_brit"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/communist
	name = "really red tailcoat"
	desc = "A red tailcoat emblazoned with a golden star. The official uniform of the Bunny Waiter Union."
	icon_state = "tailcoat_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/usa
	name = "stars tailcoat"
	desc = "A vintage coat worn by the 5th bunny battalion during the Revolutionary War. Smooth-bore musket not included."
	icon_state = "tailcoat_stars"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/plasmaman
	name = "purple tailcoat"
	desc = "A purple coat that looks to be the same purple used in several plasmaman evirosuits."
	icon_state = "tailcoat_plasma"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//CAPTAIN

/obj/item/clothing/suit/armor/vest/capcarapace/tailcoat_captain
	name = "captain's tailcoat"
	desc = "A nautical coat usually worn by bunny themed captains. It’s reinforced with genetically modified armored blue rabbit fluff."
	icon_state = "captain"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

//CARGO

/obj/item/clothing/suit/jacket/tailcoat/quartermaster
	name = "quartermaster's tailcoat"
	desc = "A fancy brown coat worn by bunny themed quartermasters. The gold accents show everyone who's in charge."
	icon_state = "qm"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/cargo
	name = "cargo tailcoat"
	desc = "A simple brown coat worn by bunny themed cargo technicians. Significantly less stripy than the quartermasters."
	icon_state = "cargo_tech"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/miner
	name = "explorer tailcoat"
	desc = "An adapted explorer suit worn by bunny themed shaft miners. It has attachment points for goliath plates but comparatively little armor."
	icon_state = "explorer"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor_type = /datum/armor/hooded_explorer
	allowed = list(
		/obj/item/flashlight,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		)
	resistance_flags = FIRE_PROOF
	clothing_traits = list(TRAIT_SNOWSTORM_IMMUNE)

/obj/item/clothing/suit/jacket/tailcoat/miner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/suit/jacket/tailcoat/bitrunner
	name = "bitrunner tailcoat"
	desc = "A black and gold coat worn by bunny themed cargo technicians. Open your Space Colas and let's fuckin' game!"
	icon_state = "bitrunner"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//ENGI

/obj/item/clothing/suit/jacket/tailcoat/engineer
	name = "engineering tailcoat"
	desc = "A high visibility tailcoat worn by bunny themed engineers. Great for working in low-light conditions."
	icon_state = "engi"
	greyscale_config = null
	greyscale_config_worn = null

	greyscale_colors = null
	allowed = list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/storage/bag/construction,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime,
	)

/obj/item/clothing/suit/jacket/tailcoat/engineer/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/utility/fire/atmos_tech_tailcoat
	name = "atmospheric technician's tailcoat"
	desc = "A heavy duty fire-tailcoat worn by bunny themed atmospheric technicians. Reinforced with asbestos weave that makes this both stylish and lung-cancer inducing."
	icon_state = "atmos"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 0
	armor_type = /datum/armor/atmos_tech_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/atmos_tech_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

/obj/item/clothing/suit/utility/fire/ce_tailcoat
	name = "chief engineer's tailcoat"
	desc = "A heavy duty green and white coat worn by bunny themed chief engineers. Made of a three layered composite fabric that is both insulating and fireproof, it also has an open face rendering all this useless."
	icon_state = "ce"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	body_parts_covered = CHEST|GROIN|ARMS
	slowdown = 0
	armor_type = /datum/armor/ce_tailcoat
	flags_inv = null
	clothing_flags = null
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	strip_delay = 30
	equip_delay_other = 30

/datum/armor/ce_tailcoat
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 50
	fire = 100
	acid = 50

//MEDICAL

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat
	name = "medical tailcoat"
	desc = "A sterile white and blue coat worn by bunny themed doctors. Great for keeping the blood off."
	icon_state = "doctor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/paramedic
	name = "paramedic's tailcoat"
	desc = "A heavy duty coat worn by bunny themed paramedics. Marked with high visibility lines for emergency operations in the dark."
	icon_state = "paramedic"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/chemist
	name = "chemist's tailcoat"
	desc = "A sterile white and orange coat worn by bunny themed chemists. The open chest isn't the greatest when working with dangerous substances."
	icon_state = "chem"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/pathologist
	name = "pathologist's tailcoat"
	desc = "A sterile white and green coat worn by bunny themed pathologists. The more stylish and ineffective alternative to a biosuit."
	icon_state = "virologist"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/coroner
	name = "coroner's tailcoat"
	desc = "A sterile black and white coat worn by bunny themed coroners. Adorned with a skull on the back."
	icon_state = "coroner"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/cmo
	name = "chief medical officer's tailcoat"
	desc = "A sterile blue coat worn by bunny themed chief medical officers. The blue helps both the wearer and bloodstains stand out from other, lower ranked, and cleaner doctors."
	icon_state = "cmo"

//SCIENCE

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science
	name = "scientist's tailcoat"
	desc = "A smart white coat worn by bunny themed scientists. Decent protection against slimes."
	icon_state = "science"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/robotics
	name = "roboticist's tailcoat"
	desc = "A smart white coat with red pauldrons worn by bunny themed roboticists. Looks surprisingly good with oil stains on it."
	icon_state = "roboticist"


/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/science/genetics
	name = "geneticist's tailcoat"
	desc = "A smart white and blue coat worn by bunny themed geneticists. Nearly looks like a real doctor's lab coat."
	icon_state = "genetics"

/obj/item/clothing/suit/jacket/research_director/tailcoat
	name = "research director's tailcoat"
	desc = "A smart purple coat worn by bunny themed head researchers. Created from captured abductor technology, what looks like a coat is actually an advanced hologram emitted from the pauldrons. Feels exactly like the real thing, too."
	icon_state = "rd"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|ARMS|GROIN

//SECURITY

/obj/item/clothing/suit/armor/security_tailcoat
	name = "security tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security officers. Uses the same lightweight armor as the MK 1 vest, though obviously has lighter protection in the chest area."
	icon_state = "sec"
	inhand_icon_state = "armor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/suit/armor/security_tailcoat/assistant
	name = "security assistant's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security assistants. The duller color scheme denotes a lower rank on the chain of bunny command."
	icon_state = "sec_assistant"

/obj/item/clothing/suit/armor/security_tailcoat/warden
	name = "warden's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed wardens. Stylishly holds hidden flak plates."
	icon_state = "warden"

/obj/item/clothing/suit/toggle/labcoat/doctor_tailcoat/sec
	name = "brig physician's tailcoat"
	desc = "A mostly sterile red and grey coat worn by bunny themed brig physicians. It lacks the padding of the \"standard\" security tailcoat."
	icon_state = "brig_phys"

/obj/item/clothing/suit/jacket/det_suit/tailcoat
	name = "detective's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed detectives. Perfect for a hard boiled no-nonsense type of gal."
	icon_state = "detective"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'

/obj/item/clothing/suit/jacket/det_suit/tailcoat/noir
	name = "noir detective's tailcoat"
	desc = "A reinforced tailcoat worn by noir bunny themed detectives. Perfect for a hard boiled no-nonsense type of gal."
	icon_state = "detective_noir"

/obj/item/clothing/suit/armor/hos_tailcoat
	name = "head of security's tailcoat"
	desc = "A reinforced tailcoat worn by bunny themed security commanders. Enhanced with a special alloy for some extra protection and style."
	icon_state = "hos"
	inhand_icon_state = "armor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	armor_type = /datum/armor/armor_hos
	strip_delay = 80
//SERVICE

/obj/item/clothing/suit/armor/hop_tailcoat
	name = "head of personnel's tailcoat"
	desc = "A strict looking coat usually worn by bunny themed bureaucrats. The pauldrons are sure to make people finally take you seriously."
	icon_state = "hop"
	inhand_icon_state = "armor"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/clothing/suit/jacket/tailcoat/janitor
	name = "janitor's tailcoat"
	desc = "A clean looking coat usually worn by bunny themed janitors. The purple sleeves are a late 24th century style."
	icon_state = "janitor"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/cook
	name = "cook's tailcoat"
	desc = "A professional white coat worn by bunny themed chefs. The red accents pair nicely with the monkey blood that often stains this."
	icon_state = "chef"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/kitchen,
		/obj/item/knife/kitchen,
		/obj/item/storage/bag/tray,
	)

/obj/item/clothing/suit/jacket/tailcoat/botanist
	name = "botanist's tailcoat"
	desc = "A green leather coat worn by bunny themed botanists. Great for keeping the sun off your back."
	icon_state = "botany"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/cultivator,
		/obj/item/geneshears,
		/obj/item/graft,
		/obj/item/hatchet,
		/obj/item/plant_analyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/secateurs,
		/obj/item/seeds,
		/obj/item/storage/bag/plants,
	)

/obj/item/clothing/suit/jacket/tailcoat/clown
	name = "clown's tailcoat"
	desc = "An orange polkadot coat worn by bunny themed clowns. Shows everyone who the real ringmaster is."
	icon_state = "clown"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/mime
	name = "mime's tailcoat"
	desc = "A stripy sleeved black coat worn by bunny themed mimes. The red accents mimic the suspenders seen in more standard mime outfits."
	icon_state = "mime"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/chaplain
	name = "chaplain's tailcoat"
	desc = "A gilded black coat worn by bunny themed chaplains. Traditional vestments of the lagomorphic cults of Cairead."
	icon_state = "chaplain"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	allowed = list(
		/obj/item/nullrod,
		/obj/item/reagent_containers/cup/glass/bottle/holywater,
		/obj/item/storage/fancy/candle_box,
		/obj/item/flashlight/flare/candle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman
	)

/obj/item/clothing/suit/jacket/tailcoat/curator_red
	name = "curator's red tailcoat"
	desc = "A red linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon_state = "curator_red"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/curator_green
	name = "curator's green tailcoat"
	desc = "A green linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon_state = "curator_green"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/curator_teal
	name = "curator's teal tailcoat"
	desc = "A teal linen coat worn by bunny themed librarians. Keeps the dust off your shoulders during long shifts in the archives."
	icon_state = "curator_teal"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_black
	name = "lawyer's black tailcoat"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "lawyer_black"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_blue
	name = "lawyer's blue tailcoat"
	desc = "A blue linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "lawyer_blue"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_red
	name = "lawyer's red tailcoat"
	desc = "A red linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "lawyer_red"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/lawyer_good
	name = "good lawyer's tailcoat"
	desc = "A beige linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "lawyer_good"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/psychologist
	name = "psychologist's tailcoat"
	desc = "A black linen coat worn by bunny themed psychologists. A casual open coat for making you seem approachable, maybe too casual."
	icon_state = "psychologist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

// Medical Jackets
/obj/item/clothing/suit/toggle/labcoat/skyrat/medical
	name = "medical department jacket"
	desc = "This stylish jacket is perfect for those impromptu fashion shows on the scene of an emergency. Now, you can be the brightest beacon of style while administering medical treatment! Because, after all, why save lives if you can't look fabulous while doing it?"
	icon = 'modular_zubbers/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/labcoat.dmi'
	icon_state = "labcoat_med_light"
	body_parts_covered = CHEST|ARMS|GROIN
	cold_protection = CHEST|ARMS|GROIN
	toggle_noun = "zipper"

/obj/item/clothing/suit/toggle/labcoat/skyrat/medical/dark
	name = "medical expedition jacket"
	icon_state = "labcoat_med_dark"

/obj/item/clothing/suit/toggle/jacket/sec/medical
	name = "medical praetorian jacket"
	desc = "This stylish jacket is perfect for those impromptu fashion shows on the scene of an emergency. Now, you can be the brightest beacon of style while administering medical treatment! Because, after all, why save lives if you can't look fabulous while doing it?"
