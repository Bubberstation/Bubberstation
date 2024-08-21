/*
*	BOOZE
*/

/datum/loadout_item/pocket_items/wine //Beer is already available, so why not wine? Stay classy while drinking on the job.
	name = "Wine Bottle"
	item_path = /obj/item/reagent_containers/cup/glass/bottle/wine

/*
*	PERFUME
*/

/datum/loadout_item/pocket_items/fragrance_ash
	name = "Ash Perfume"
	item_path = /obj/item/perfume/ash

/datum/loadout_item/pocket_items/fragrance_bergamot
	name = "Bergamot Perfume"
	item_path = /obj/item/perfume/bergamot

/datum/loadout_item/pocket_items/fragrance_cardamom
	name = "Cardamom Perfume"
	item_path = /obj/item/perfume/cardamom

/datum/loadout_item/pocket_items/fragrance_chocolate
	name = "Chocolate Perfume"
	item_path = /obj/item/perfume/chocolate

/datum/loadout_item/pocket_items/fragrance_cinnamon
	name = "Cinnamon Perfume"
	item_path = /obj/item/perfume/cinnamon

/datum/loadout_item/pocket_items/fragrance_citrus
	name = "Citrus Perfume"
	item_path = /obj/item/perfume/citrus

/datum/loadout_item/pocket_items/fragrance_clove
	name = "Clove Perfume"
	item_path = /obj/item/perfume/clove

/datum/loadout_item/pocket_items/fragrance_grass
	name = "Grass Perfume"
	item_path = /obj/item/perfume/grass

/datum/loadout_item/pocket_items/fragrance_iron
	name = "Iron Perfume"
	item_path = /obj/item/perfume/iron

/datum/loadout_item/pocket_items/fragrance_oil
	name = "Oil Perfume"
	item_path = /obj/item/perfume/oil

/datum/loadout_item/pocket_items/fragrance_peach
	name = "Peach Perfume"
	item_path = /obj/item/perfume/peach

/datum/loadout_item/pocket_items/fragrance_petrichor
	name = "Petrichor Perfume"
	item_path = /obj/item/perfume/petrichor

/*
*	OTHER
*/

/datum/loadout_item/pocket_items/royalzippo //donator item for UltimariFox, available for all
	name = "Royal Zippo"
	item_path = /obj/item/lighter/royal

/datum/loadout_item/pocket_items/pocketwatch //The Hypnowatch, but uncracked, with the ability to tell time. Best of both worlds!
	name = "Pocket Watch"
	item_path = /obj/item/clothing/accessory/pocketwatch


/datum/loadout_item/pocket_items/cigarettesleary
	name = "Mindbreaker Cigs"
	item_path = /obj/item/storage/fancy/cigarettes/cigpack_mindbreaker

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
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/pocket_items/nif_disk_diag
	name = "Diagnostic Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/diag_hud
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/pocket_items/nif_disk_sec
	name = "Security Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/sec_hud
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/pocket_items/nif_disk_permit
	name = "Permit Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/permit_hud
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_CUSTOMS_AGENT, JOB_SHAFT_MINER)

/datum/loadout_item/pocket_items/nif_disk_sci
	name = "Science Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/sci_hud
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/pocket_items/nif_disk_meson
	name = "Meson Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/meson_hud
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

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
