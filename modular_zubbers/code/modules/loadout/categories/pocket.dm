//Title Capitalization for names please!!!

/*
*	BOOZE
*/

/datum/loadout_item/pocket_items/wine //Beer is already available, so why not wine? Stay classy while drinking on the job.
	name = "Wine Bottle"
	item_path = /obj/item/reagent_containers/cup/glass/bottle/wine

/*
*	OTHER
*/

/datum/loadout_item/pocket_items/pocketwatch //The Hypnowatch, but uncracked, with the ability to tell time. Best of both worlds!
	name = "Pocket Watch"
	item_path = /obj/item/clothing/accessory/pocketwatch

/datum/loadout_item/pocket_items/hypno_watch
	name = "Pocket Watch"
	item_path = /obj/item/clothing/accessory/hypno_watch
	ckeywhitelist = list("slippyjoe")

/datum/loadout_item/pocket_items/table_clock
	name = "Table Clock"
	item_path = /obj/item/table_clock

/datum/loadout_item/pocket_items/drawingtablet
	name = "Drawing Tablet"
	item_path = /obj/item/canvas/drawingtablet
	//ckeywhitelist = list("thedragmeme")

/datum/loadout_item/pocket_items/fuzzy_huglicense
	name = "License To Hug"
	item_path = /obj/item/card/fuzzy_license
	//ckeywhitelist = list("fuzlet")

/datum/loadout_item/pocket_items/korpstech_poster
	name = "Korpstech Poster"
	item_path = /obj/item/poster/korpstech
	//ckeywhitelist = list("1ceres")

/datum/loadout_item/pocket_items/tacticalbrush
	name = "Tactical Brush"
	item_path = /obj/item/hairbrush/tactical
	//ckeywhitelist = list("weredoggo")

/datum/loadout_item/pocket_items/marsoc_coin
	name = "MARSOC Challenge Coin"
	item_path = /obj/item/coin/donator/marsoc
	//ckeywhitelist = list("sweetsoulbrother")

/datum/loadout_item/pocket_items/transponder
	name = "Broken Helian Transponder"
	item_path = /obj/item/donator/transponder
//	ckeywhitelist = list("glacii")

/datum/loadout_item/pocket_items/toaster_implant
	name = "Toaster Implant"
	item_path = /obj/item/implanter/toaster
//	ckeywhitelist = list("jasohavents")

/*
*	FLAGS
*/

/datum/loadout_item/pocket_items/gaypride
	name = "Rainbow Flag"
	item_path = /obj/item/sign/flag/pride/gay

/datum/loadout_item/pocket_items/acepride
	name = "Asexual Flag"
	item_path = /obj/item/sign/flag/pride/ace

/datum/loadout_item/pocket_items/bipride
	name = "Bisexual Flag"
	item_path = /obj/item/sign/flag/pride/bi

/datum/loadout_item/pocket_items/lesbianpride
	name = "Lesbian Flag"
	item_path = /obj/item/sign/flag/pride/lesbian

/datum/loadout_item/pocket_items/panpride
	name = "Pansexual Flag"
	item_path = /obj/item/sign/flag/pride/pan

/datum/loadout_item/pocket_items/transpride
	name = "Trans Flag"
	item_path = /obj/item/sign/flag/pride/trans

/datum/loadout_item/pocket_items/flag_galfed //sprites by Crumpaloo
	name = "Folded Galactic Federation Flag"
	item_path = /obj/item/sign/flag/galfed

/*
*	NIF LENSES
*/

/datum/loadout_item/pocket_items/nif_hud_adapter
	name = "Scrying Lens Adapter"
	item_path = /obj/item/nif_hud_adapter

/datum/loadout_item/pocket_items/nif_disk_med
	name = "Medical Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/med_hud
	restricted_roles = list(ALL_JOBS_MEDICAL, JOB_GENETICIST)

/datum/loadout_item/pocket_items/nif_disk_diag
	name = "Diagnostic Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/diag_hud
	restricted_roles = list(ALL_JOBS_SCIENCE)

/datum/loadout_item/pocket_items/nif_disk_sec
	name = "Security Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/sec_hud
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_DEPT_GUARDS, JOB_BLUESHIELD)

/datum/loadout_item/pocket_items/nif_disk_permit
	name = "Permit Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/permit_hud
	restricted_roles = list(ALL_JOBS_CARGO)

/datum/loadout_item/pocket_items/nif_disk_sci
	name = "Science Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/sci_hud
	restricted_roles = list(ALL_JOBS_SCIENCE, JOB_CHEMIST)

/datum/loadout_item/pocket_items/nif_disk_meson
	name = "Meson Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/meson_hud
	restricted_roles = list(ALL_JOBS_CARGO, ALL_JOBS_ENGINEERING)

/*
*	LUNCHBOX
*/

/datum/loadout_item/pocket_items/lunchbox_nanotrasen
	name = "Nanotrasen Lunchbox"
	item_path = /obj/item/storage/lunchbox/nanotrasen

/datum/loadout_item/pocket_items/lunchbox_medical
	name = "Medical Lunchbox"
	item_path = /obj/item/storage/lunchbox/medical

/datum/loadout_item/pocket_items/lunchbox_bunny
	name = "Bunny Lunchbox"
	item_path = /obj/item/storage/lunchbox/bunny

/datum/loadout_item/pocket_items/lunchbox_corgi
	name = "Corgi Lunchbox"
	item_path = /obj/item/storage/lunchbox/corgi

/datum/loadout_item/pocket_items/lunchbox_heart
	name = "Heart Lunchbox"
	item_path = /obj/item/storage/lunchbox/heart

/datum/loadout_item/pocket_items/lunchbox_safetymoth
	name = "Safety Moth Lunchbox"
	item_path = /obj/item/storage/lunchbox/safetymoth

/datum/loadout_item/pocket_items/lunchbox_amongus
	name = "Suspicious Red Lunchbox"
	item_path = /obj/item/storage/lunchbox/amongus

/// Lustwish stuff

/datum/loadout_item/pocket_items/lustwish_theme
	name = "Lustwish MOD Plating"
	item_path = /obj/item/mod/construction/plating/lustwish

/*
*	CIGS
*/
/datum/loadout_item/pocket_items/brightcosmos
	name = "Bright Cosmos cigar"
	item_path = /obj/item/holocigarette/cigar
	ckeywhitelist = list("lyricalpaws")

/datum/loadout_item/pocket_items/cigarettesleary
	name = "Mindbreaker Cigs"
	item_path = /obj/item/storage/fancy/cigarettes/cigpack_mindbreaker

/datum/loadout_item/pocket_items/royalzippo //donator item for UltimariFox, available for all
	name = "Royal Zippo"
	item_path = /obj/item/lighter/royal

/datum/loadout_item/pocket_items/khicigs
	name = "Kitsuhana Singularity Cigarettes"
	item_path = /obj/item/storage/fancy/cigarettes/khi
	//ckeywhitelist = list("ultimarifox")

/datum/loadout_item/pocket_items/masvedishcigar
	name = "Holocigar"
	item_path = /obj/item/holocigarette/masvedishcigar
	// Asked it to be public, and as such has no whitelist.

