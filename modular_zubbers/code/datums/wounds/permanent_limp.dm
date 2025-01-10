/datum/wound/perm_limp
	name = "Permanent Limp"
	desc = "Whether from an improperly set bone, genetic disorder, or otherwise, this limb has developed a permanent limp."
	treat_text = "Little short of full limb replacement will fix this."

	limp_slowdown = 3
	limp_chance = 50
	wound_flags = 0
	can_scar = FALSE

	var/limb_to_apply_to

/datum/wound/perm_limp/right
	limb_to_apply_to = "Right"

/datum/wound/perm_limp/right/moderate
	limp_slowdown = 6
	limp_chance = 60

/datum/wound/perm_limp/right/major
	limp_slowdown = 7
	limp_chance = 70

/datum/wound/perm_limp/left
	limb_to_apply_to = "Left"

/datum/wound/perm_limp/left/moderate
	limp_slowdown = 6
	limp_chance = 60

/datum/wound/perm_limp/left/major
	limp_slowdown = 7
	limp_chance = 70

/datum/wound_pregen_data/perm_limp
	abstract = TRUE

	wound_path_to_generate = /datum/wound/perm_limp
	required_limb_biostate = BIO_BONE | BIO_METAL
	require_any_biostate = TRUE

	required_wounding_types = list(WOUND_ALL)

	wound_series = WOUND_SERIES_PERM_LIMP_BASIC
	can_be_randomly_generated = FALSE

/datum/wound_pregen_data/perm_limp/right
	abstract = FALSE
	wound_path_to_generate = /datum/wound/perm_limp/right

/datum/wound_pregen_data/perm_limp/right/moderate
	wound_path_to_generate = /datum/wound/perm_limp/right/moderate

/datum/wound_pregen_data/perm_limp/right/major
	wound_path_to_generate = /datum/wound/perm_limp/right/major

/datum/wound_pregen_data/perm_limp/left
	abstract = FALSE
	wound_path_to_generate = /datum/wound/perm_limp/left

/datum/wound_pregen_data/perm_limp/left/moderate
	wound_path_to_generate = /datum/wound/perm_limp/left/moderate

/datum/wound_pregen_data/perm_limp/left/major
	wound_path_to_generate = /datum/wound/perm_limp/left/major
