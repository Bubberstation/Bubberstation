
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

/datum/loadout_item/pocket_items/nif_disk_med
	name = "Medical Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/med_hud
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

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
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD, JOB_VIROLOGIST)

/datum/loadout_item/pocket_items/nif_disk_meson
	name = "Meson Scrying Lens Disk"
	item_path = /obj/item/disk/nifsoft_uploader/meson_hud
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/pocket_items/nif_hud_adapter
	name = "Scrying Lens Adapter"
	item_path = /obj/item/nif_hud_adapter
