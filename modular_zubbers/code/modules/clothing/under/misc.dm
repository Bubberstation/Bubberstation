/obj/item/clothing/under/misc/diver //Donor item for patriot210
	name = "black divers uniform"
	desc = "An old exploration uniform used by a now-defunct mining coalition, even after all this time, it still fits."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon_state = "diver"
	worn_icon_state = "diver"
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	body_parts_covered = CHEST|LEGS|GROIN

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/under/costume/playbunny
	name = "bunny suit"
	desc = "The staple of any bunny themed waiters and the like. It has a little cottonball tail too."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "playbunny"
	greyscale_colors = "#39393f#39393f#ffffff#87502e"
	greyscale_config = /datum/greyscale_config/bunnysuit
	greyscale_config_worn = /datum/greyscale_config/bunnysuit_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/syndicate/syndibunny //heh
	name = "blood-red bunny suit"
	desc = "The staple of any bunny themed syndicate assassins. Are those carbon nanotube stockings?"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "syndibunny"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/under/syndicate/syndibunny/fake
	armor_type = /datum/armor/clothing_under/none

/obj/item/clothing/under/costume/playbunny/magician
	name = "magician's bunny suit"
	desc = "The staple of any bunny themed stage magician."
	icon_state = "playbunny_wiz"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/magician/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny/magician)

/datum/storage/pockets/tiny/magician/New() //this is probably a good idea
	. = ..()
	var/static/list/exception_cache = typecacheof(list(
		/obj/item/gun/magic/wand,
		/obj/item/warp_whistle,
	))
	exception_hold = exception_cache

/obj/item/clothing/under/costume/playbunny/centcom
	name = "centcom bunnysuit"
	desc = "A modified Centcom version of a bunny outfit, using Lunarian technology to condense countless amounts of rabbits into a material that is extremely comfortable and light to wear."
	icon_state = "playbunny_centcom"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/british
	name = "british bunny suit"
	desc = "The staple of any bunny themed monarchists. It has a little cottonball tail too."
	icon_state = "playbunny_brit"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/communist
	name = "really red bunny suit"
	desc = "The staple of any bunny themed communists. It has a little cottonball tail too."
	icon_state = "playbunny_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/under/costume/playbunny/usa
	name = "striped bunny suit"
	desc = "A bunny outfit stitched together from several American flags. It has a little cottonball tail too."
	icon_state = "playbunny_usa"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

//CAPTAIN

/obj/item/clothing/under/rank/captain/bunnysuit
	desc = "The staple of any bunny themed captains. Great for securing the disk."
	name = "captain's bunnysuit"
	icon_state = "bunnysuit_captain"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//CARGO

/obj/item/clothing/under/rank/cargo/quartermaster_bunnysuit
	name = "quartermaster's bunny suit"
	desc = "The staple of any bunny themed quartermasters. Complete with gold buttons and a nametag."
	icon_state = "bunnysuit_qm"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/cargo_bunnysuit
	name = "cargo bunny suit"
	desc = "The staple of any bunny themed cargo technicians. Nigh indistinguishable from the quartermasters bunny suit."
	icon_state = "bunnysuit_cargo"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/miner/bunnysuit
	name = "shaft miner's bunny suit"
	desc = "The staple of any bunny themed shaft miners. The perfect outfit for fighting demons on an ash choked hell planet."
	icon_state = "bunnysuit_miner"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/mailman_bunnysuit
	name = "mailman's bunny suit"
	desc = "The staple of any bunny themed mailmen. A sleek mailman outfit for when you need to deliver mail as quickly and with as little wind resistance possible."
	icon_state = "bunnysuit_mail"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/bitrunner/bunnysuit
	name = "bunrunner suit"
	desc = "The staple of any bunny themed gamer. Has enough space for one extra soda, if you're worthy."
	icon_state = "bunnysuit_bitrunner"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//ENGI

/obj/item/clothing/under/rank/engineering/engineer_bunnysuit
	name = "engineering bunny suit"
	desc = "The staple of any bunny themed engineers. Keeps loose clothing to a minimum in a fashionable manner."
	icon_state = "bunnysuit_engi"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/atmos_tech_bunnysuit
	name = "atmospheric technician's bunny suit"
	desc = "The staple of any bunny themed atmospheric technicians. Perfect for any blue collar worker wanting to keep up with fashion trends."
	icon_state = "bunnysuit_atmos"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/chief_engineer/bunnysuit
	name = "chief engineer's bunny suit"
	desc = "The staple of any bunny themed chief engineers. The airy design helps with keeping cool when  engine fires get too hot to handle."
	icon_state = "bunnysuit_ce"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//MEDICAL

/obj/item/clothing/under/rank/medical/doctor_bunnysuit
	desc = "The staple of any bunny themed doctors. The open design is great for both comfort and surgery."
	name = "medical bunnysuit"
	icon_state = "bunnysuit_doctor"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/paramedic_bunnysuit
	desc = "The staple of any bunny themed paramedics. Comes with spare pockets for medical supplies fastened to the leggings."
	name = "paramedic's bunnysuit"
	icon_state = "bunnysuit_paramedic"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/chemist/bunnysuit
	desc = "The staple of any bunny themed chemists. The stockings are both airy and acid resistant."
	name = "chemist's bunnysuit"
	icon_state = "bunnysuit_chem"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/pathologist_bunnysuit
	desc = "The staple of any bunny themed pathologists. The stockings, while cute, do nothing to combat pathogens."
	name = "pathologist's bunnysuit"
	icon_state = "bunnysuit_viro"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/coroner_bunnysuit
	desc = "The staple of any bunny themed coroners. A rejected mime costume."
	name = "coroner's bunnysuit"
	icon_state = "bunnysuit_coroner"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/cmo_bunnysuit
	desc = "The staple of any bunny themed chief medical officers. The more vibrant blue accents denote a higher status."
	name = "chief medical officer's bunnysuit"
	icon_state = "bunnysuit_cmo"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//SCIENCE

/obj/item/clothing/under/rank/rnd/scientist/bunnysuit
	desc = "The staple of any bunny themed scientists. Smart bunnies, Hef."
	name = "scientist's bunnysuit"
	icon_state = "bunnysuit_sci"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/scientist/roboticist_bunnysuit
	desc = "The staple of any bunny themed roboticists. The open design and thin leggings help to keep cool when piloting mechs."
	name = "roboticist's bunnysuit"
	icon_state = "bunnysuit_roboticist"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/geneticist/bunnysuit
	desc = "The staple of any bunny themed geneticists. Doesn’t go great with an abominable green muscled physique, but then again, what does?"
	name = "geneticist's bunnysuit"
	icon_state = "bunnysuit_genetics"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/bunnysuit
	desc = "The staple of any bunny themed head researchers. Advanced technology allows this suit to stimulate spontaneous bunny tail growth when worn, though it's nigh-indistinguishable from the standard cottonball and disappears as soon as the suit is removed."
	name = "research director's bunnysuit"
	icon_state = "bunnysuit_rd"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	alt_covers_chest = TRUE

//SECURITY

/obj/item/clothing/under/rank/security/security_bunnysuit
	desc = "The staple of any bunny themed security officers. The red coloring helps to hide any blood that may stain this."
	name = "security bunnysuit"
	icon_state = "bunnysuit_sec"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/security_assistant_bunnysuit
	desc = "The staple of any bunny themed security assistants. Can't lost respect you don't have!"
	name = "security assistant's bunnysuit"
	icon_state = "bunnysuit_sec_assistant"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE



/obj/item/clothing/under/rank/security/warden_bunnysuit
	desc = "The staple of any bunny themed wardens. The more formal security bunny suit for a less combat focused job."
	name = "warden's bunnysuit"
	icon_state = "bunnysuit_warden"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/brig_phys_bunnysuit
	desc = "The staple of any bunny themed brig physicians. The rejected alternative to an already discontinued alternate uniform, now sold at a premium!"
	name = "brig physician's bunnysuit"
	icon_state = "bunnysuit_brig_phys"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/detective_bunnysuit
	desc = "The staple of any bunny themed detectives. Capable of storing precious candy corns."
	name = "detective's bunnysuit"
	icon_state = "bunnysuit_det"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/detective_bunnysuit/noir
	desc = "The staple of any noir bunny themed detectives. Capable of storing precious candy corns."
	name = "noir detective's bunnysuit"
	icon_state = "bunnysuit_det_noir"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/prisoner_bunnysuit
	desc = "The staple of any bunny themed prisoners. Great for hiding shanks and other small contrabands."
	name = "prisoner's bunnysuit"
	icon_state = "bunnysuit_prisoner"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/head_of_security/bunnysuit
	desc = "The staple of any bunny themed security commanders. Includes kevlar weave stockings and a gilded tail."
	name = "Head of Security's bunnysuit"
	icon_state = "bunnysuit_hos"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//SERVICE

/obj/item/clothing/under/rank/civilian/hop_bunnysuit
	name = "head of personnel's bunny suit"
	desc = "The staple of any bunny themed bureaucrats. It has a spare “pocket” for holding extra pens and paper."
	icon_state = "bunnysuit_hop"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/janitor/bunnysuit
	name = "janitor's bunny suit"
	desc = "The staple of any bunny themed janitors. The stockings are made of cotton to allow for easy laundering."
	icon_state = "bunnysuit_janitor"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/bartender_bunnysuit
	name = "bartender's bunnysuit"
	desc = "The staple of any bunny themed bartenders. Looks even more stylish than the standard bunny suit."
	icon_state = "bunnysuit_bar"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	custom_price = PAYCHECK_CREW

/obj/item/clothing/under/rank/civilian/cook_bunnysuit
	name = "cook's bunny suit"
	desc = "The staple of any bunny themed chefs. Shame there aren't any fishnets."
	icon_state = "bunnysuit_chef"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/hydroponics/bunnysuit
	name = "botanist's bunny suit"
	desc = "The staple of any bunny themed botanists. The stockings are made of faux-denim to mimic the look of overalls."
	icon_state = "bunnysuit_botany"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/clown/clown_bunnysuit
	name = "clown's bunny suit"
	desc = "The staple of any bunny themed clowns. Now this is just ridiculous."
	icon_state = "bunnysuit_clown"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/mime_bunnysuit
	name = "mime's bunny suit"
	desc = "The staple of any bunny themed mimes. Includes black and white stockings in order to comply with mime federation outfit regulations."
	icon_state = "bunnysuit_mime"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/civilian/chaplain_bunnysuit
	name = "chaplain's bunny suit"
	desc = "The staple of any bunny themed chaplains. The wool for the stockings came from a sacrificial lamb, making them extra holy."
	icon_state = "bunnysuit_chaplain"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/curator_bunnysuit_red
	name = "curator's red bunny suit"
	desc = "The staple of any bunny themed librarians. A professional yet comfortable suit perfect for the aspiring bunny academic."
	icon_state = "bunnysuit_curator_red"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/curator_bunnysuit_green
	name = "curator's green bunny suit"
	desc = "The staple of any bunny themed librarians. A professional yet comfortable suit perfect for the aspiring bunny academic."
	icon_state = "bunnysuit_curator_green"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/curator_bunnysuit_teal
	name = "curator's teal bunny suit"
	desc = "The staple of any bunny themed librarians. A professional yet comfortable suit perfect for the aspiring bunny academic."
	icon_state = "bunnysuit_curator_teal"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_black
	name = "lawyer's black bunny suit"
	desc = "A black linen coat worn by bunny themed lawyers. May or may not contain souls of the damned in suit pockets."
	icon_state = "bunnysuit_law_black"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_blue
	name = "lawyer's blue bunny suit"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "bunnysuit_law_blue"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_red
	name = "lawyer's red bunny suit"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "bunnysuit_law_red"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_good
	name = "good lawyer's bunny suit"
	desc = "The staple of any bunny themed lawyers. EXTREMELY professional."
	icon_state = "bunnysuit_law_good"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/psychologist_bunnysuit
	name = "psychologist's bunny suit"
	desc = "The staple of any bunny themed psychologists. Perhaps not the best choice for making your patients feel at home."
	icon_state = "bunnysuit_psychologist"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/under/costume/loincloth
	name = "loincloth"
	desc = "A simple leather covering. It's better than wearing nothing at least."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "loincloth"
	body_parts_covered = GROIN
	can_adjust = FALSE
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/loincloth/sensor
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/costume/loincloth/cloth
	desc = "A simple cloth covering. It's better than wearing nothing at least."
	icon_state = "loincloth_cloth"

/obj/item/clothing/under/costume/loincloth/cloth/sensor
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/costume/lizardgas
	name = "lizard gas uniform"
	desc = "A purple shirt with a nametag, and some ill-fitting jeans. The bare minimum required by company standards."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "lizardgas"
	body_parts_covered = CHEST|GROIN|LEGS
	has_sensor = NO_SENSORS //you're not NT employed, so they don't care about you

/obj/item/clothing/under/costume/allamerican
	name = "all-american diner employee uniform"
	desc = "A salmon colored short-sleeved dress shirt with a white nametag, bearing the name of the employee. Along with some snazzy dark grey slacks, a formal attire for a classy joint."
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "allamerican"
	body_parts_covered = CHEST|GROIN|LEGS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE

/obj/item/clothing/under/costume/allamerican/manager
	name = "all-american diner manager uniform"
	desc = "A salmon colored long-sleeved dress shirt with a white nametag, bearing the name of the employee. Along with some snazzy dark grey slacks held up by a belt with a gold buckle, a formal attire for a classy joint."
	icon_state = "allamerican_manager"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
