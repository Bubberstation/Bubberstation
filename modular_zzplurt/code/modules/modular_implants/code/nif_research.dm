// Add NIFs to alien surgery node
/datum/techweb_node/alien_surgery/New()
	design_ids += list(
		"nifsoft_hypno_brainwash",
	)
	return ..()

// Design for brainwash NIFSoft
/datum/design/nifsoft_hud/nifsoft_hypno_brainwash
	name = "Mesmer Eye NIFSoft"
	desc = "A NIFSoft datadisk containing the experimental Mesmer Eye NIFsoft."
	id = "nifsoft_hypno_brainwash"
	build_path = /obj/item/disk/nifsoft_uploader/dorms/hypnosis/brainwashing
	//departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

// Design for storage concealment NIFSoft
/datum/design/nifsoft_hud/nifsoft_storage_concealment
	name = "Storage Concealment NIFSoft"
	desc = "A NIFSoft datadisk containing the Storage Concealment NIFsoft."
	id = "nifsoft_storage_concealment"
	build_path = /obj/item/disk/nifsoft_uploader/nif_hide_backpack_disk

// Design for rapid disrobe NIFSoft
/datum/design/nifsoft_hud/nifsoft_rapid_disrobe
	name = "Emergency Clothing Disruption NIFSoft"
	desc = "A NIFSoft datadisk containing the Emergency Clothing Disruption NIFsoft."
	id = "nifsoft_rapid_disrobe"
	build_path = /obj/item/disk/nifsoft_uploader/dorms/nif_disrobe_disk

// Design for genital fluid NIFSoft
/datum/design/nifsoft_hud/nifsoft_gfluid
	name = "Genital Fluid Inducer NIFSoft"
	desc = "A NIFSoft datadisk containing the Genital Fluid Inducer NIFsoft."
	id = "nifsoft_gfluid"
	build_path = /obj/item/disk/nifsoft_uploader/dorms/nif_gfluid_disk
