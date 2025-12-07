//Title Capitalization for names please!!!

/datum/loadout_category/mask
	category_name = "Masks"
	category_ui_icon = FA_ICON_MASK
	type_to_generate = /datum/loadout_item/mask
	tab_order = /datum/loadout_category/head::tab_order + 12

/datum/loadout_item/mask
	abstract_type = /datum/loadout_item/mask

/datum/loadout_item/mask/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.mask)
		LAZYADD(outfit.backpack_contents, outfit.mask)
	outfit.mask = item_path

/*
*	BANDANAS
*/

/datum/loadout_item/mask/bandana
	group = "Bandanas & Face Coverings"
	abstract_type = /datum/loadout_item/mask/bandana

/datum/loadout_item/mask/bandana/black
	name = "Bandana (Black)"
	item_path = /obj/item/clothing/mask/bandana/black

/datum/loadout_item/mask/bandana/blue
	name = "Bandana (Blue)"
	item_path = /obj/item/clothing/mask/bandana/blue

/datum/loadout_item/mask/bandana/gold
	name = "Bandana (Gold)"
	item_path = /obj/item/clothing/mask/bandana/gold

/datum/loadout_item/mask/bandana/green
	name = "Bandana (Green)"
	item_path = /obj/item/clothing/mask/bandana/green

/datum/loadout_item/mask/bandana/red
	name = "Bandana (Red)"
	item_path = /obj/item/clothing/mask/bandana/red

/datum/loadout_item/mask/bandana/driscoll //Technically just looks like one but it's nicer here smiley face.
	name = "Bandana (Driscoll)"
	item_path = /obj/item/clothing/mask/gas/driscoll

/datum/loadout_item/mask/bandana/skull
	name = "Bandana (Skull)"
	item_path = /obj/item/clothing/mask/bandana/skull

/datum/loadout_item/mask/bandana/stripe
	name = "Bandana (Striped)"
	item_path = /obj/item/clothing/mask/bandana/striped

/datum/loadout_item/mask/bandana/facescarf
	name = "Facescarf"
	item_path = /obj/item/clothing/mask/facescarf

/datum/loadout_item/mask/bandana/sechailer_half_mask
	name = "Tacticool Half-Mask"
	item_path = /obj/item/clothing/mask/gas/half_mask

/datum/loadout_item/mask/bandana/neckgaiter
	name = "Neck Gaiter"
	item_path = /obj/item/clothing/mask/primitive_catgirl_greyscale_gaiter


/*
*	BALACLAVAS
*/

/datum/loadout_item/mask/balaclava
	group = "Balaclavas"
	abstract_type = /datum/loadout_item/mask/balaclava

/datum/loadout_item/mask/balaclava/adj
	name = "Adjustable Balaclava"
	item_path = /obj/item/clothing/mask/balaclavaadjust

/datum/loadout_item/mask/balaclava/black
	name = "Balaclava"
	item_path = /obj/item/clothing/mask/balaclava

/datum/loadout_item/mask/balaclava/three
	name = "Three-Hole Balaclava (Black)"
	item_path = /obj/item/clothing/mask/balaclava/threehole

/datum/loadout_item/mask/balaclava/green
	name = "Three-Hole Balaclava (Green)"
	item_path = /obj/item/clothing/mask/balaclava/threehole/green

/*
*	GAS MASKS
*/

/datum/loadout_item/mask/gas
	group = "Gas Masks"
	abstract_type = /datum/loadout_item/mask/gas

/datum/loadout_item/mask/gas/tider
	name = "Gas Mask"
	item_path = /obj/item/clothing/mask/gas

/datum/loadout_item/mask/gas/alt
	name = "Black Gas Mask"
	item_path = /obj/item/clothing/mask/gas/alt

/datum/loadout_item/mask/gas/glass
	name = "Glass Gas Mask"
	item_path = /obj/item/clothing/mask/gas/glass

/datum/loadout_item/mask/gas/respirator
	name = "Half Mask Respirator"
	item_path = /obj/item/clothing/mask/gas/respirator

/datum/loadout_item/mask/gas/german
	name = "Black Gas Mask"
	item_path = /obj/item/clothing/mask/gas/german

/datum/loadout_item/mask/gas/soviet
	name = "Soviet Gas Mask"
	item_path = /obj/item/clothing/mask/gas/soviet

/datum/loadout_item/mask/gas/nri_police
	name = "Colonial Gas Mask"
	item_path = /obj/item/clothing/mask/gas/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/mask/gas/frontier_colonist
	name = "Frontier Gas Mask"
	item_path = /obj/item/clothing/mask/gas/atmos/frontier_colonist/loadout

/datum/loadout_item/mask/gas/nightlight_mask/alldono
	name = "Commercial FIR-36 Rebreather"
	item_path = /obj/item/clothing/mask/gas/nightlight/alldono

/datum/loadout_item/mask/gas/nightlight_mask
	name = "'Royez' Half-Face Rebreather"
	item_path = /obj/item/clothing/mask/gas/nightlight
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/mask/gas/fir22
	name = "'Kimball' Rebreather"
	item_path = /obj/item/clothing/mask/gas/nightlight/fir22
//	ckeywhitelist = list("farsightednightlight", "raxraus", "1ceres", "marcoalbaredaa", "itzshift_yt", "drifter7371", "AvianAviator", "Katty Kat", "Investigator77", "Dalao Azure", "Socialistion", "ChillyLobster", "Sylvara", "AmZee", "Tf4", "rb303", "Kay_Nite", "whataboutism", "taac", "Halkyon", "Lupo_di_rosa", "Merek2", "lowpowermia", "RyeanBread", "Jesterz7", "Saund_Minah", "Ruediger4")

/datum/loadout_item/mask/gas/octusvox
	name = "Sinister Visor"
	item_path = /obj/item/clothing/mask/breath/vox/octus
	//ckeywhitelist = list("octus")

/datum/loadout_item/mask/gas/larpswat
	name = "Foam Force SWAT Mask"
	item_path = /obj/item/clothing/mask/gas/larpswat
	//ckeywhitelist = list("erdinyobarboza")

/*
*	MASQUERADE MASKS
*/

/datum/loadout_item/mask/masquerade
	group = "Masquerade Masks"
	abstract_type = /datum/loadout_item/mask/masquerade

/datum/loadout_item/mask/masquerade/masqmask
	name = "Masquerade Mask"
	item_path = /obj/item/clothing/mask/masquerade

/datum/loadout_item/mask/masquerade/two_colors
	name = "Masquerade Mask (Split)"
	item_path = /obj/item/clothing/mask/masquerade/two_colors

/datum/loadout_item/mask/masquerade/feathered
	name = "Masquerade Mask (Feathered)"
	item_path = /obj/item/clothing/mask/masquerade/feathered

/datum/loadout_item/mask/masquerade/two_colors/feathered
	name = "Masquerade Mask (Feathered, Split)"
	item_path = /obj/item/clothing/mask/masquerade/two_colors/feathered

/datum/loadout_item/mask/masquerade/rebellion
	name = "Rebellion Mask"
	item_path = /obj/item/clothing/mask/rebellion

/datum/loadout_item/mask/masquerade/hheart //sans undertale
	name = "The Hollow Heart"
	item_path = /obj/item/clothing/mask/hheart
	//ckeywhitelist = list("inferno707")

/*
*	MISC
*/

/datum/loadout_item/mask/utility
	group = "Utility Masks"
	abstract_type = /datum/loadout_item/mask/utility

/datum/loadout_item/mask/utility/surgical
	name = "Sterile Mask (Recolorable)"
	item_path = /obj/item/clothing/mask/surgical/greyscale

/datum/loadout_item/mask/utility/pipe
	name = "Pipe"
	item_path = /obj/item/cigarette/pipe

/datum/loadout_item/mask/utility/pipe/corn
	name = "Pipe (Corn Cob)"
	item_path = /obj/item/cigarette/pipe/cobpipe

/datum/loadout_item/mask/utility/lollipop
	name = "Lollipop"
	item_path = /obj/item/food/lollipop

/datum/loadout_item/mask/utility/whistle
	name = "Police Whistle"
	item_path = /obj/item/clothing/mask/whistle
	restricted_roles = list(ALL_JOBS_SEC)

/*
*	COSTUMES
*/

/datum/loadout_item/mask/costume
	group = "Costumes and Silly Masks"
	abstract_type = /datum/loadout_item/mask/costume

/datum/loadout_item/mask/costume/fake_mustache
	name = "Fake Moustache"
	item_path = /obj/item/clothing/mask/fakemoustache

/datum/loadout_item/mask/costume/plague_doctor
	name = "Plague Doctor Mask"
	item_path = /obj/item/clothing/mask/gas/plaguedoctor

/datum/loadout_item/mask/costume/kitsune
	name = "Kitsune Mask"
	item_path = /obj/item/clothing/mask/kitsune

/datum/loadout_item/mask/costume/monkey
	name = "Monkey Mask"
	item_path = /obj/item/clothing/mask/gas/monkeymask

/datum/loadout_item/mask/costume/owl
	name = "Owl Mask"
	item_path = /obj/item/clothing/mask/gas/owl_mask

/datum/loadout_item/mask/costume/joy
	name = "Joy Mask"
	item_path = /obj/item/clothing/mask/joy

/datum/loadout_item/mask/costume/paper
	name = "Paper Mask"
	item_path = /obj/item/clothing/mask/paper

/datum/loadout_item/mask/costume/britches_mask
	name = "Britches' mask"
	item_path = /obj/item/clothing/mask/gas/britches
	//ckeywhitelist = list("bloodrite")
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/mask/costume/clown/recolour
	name = "Recolorable Clown Mask"
	item_path = /obj/item/clothing/mask/gas/clown_colourable
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/mask/costume/luchador_mask
	name = "Mask of El Red Templar"
	item_path = /obj/item/clothing/mask/luchador/enzo
	//ckeywhitelist = list("enzoman")

/datum/loadout_item/mask/costume/wolf_mask
	name = "Wolf mask"
	item_path = /obj/item/clothing/mask/animal/wolf
	//ckeywhitelist = list("theooz")
