/datum/job
	/// The job's outfit that will be assigned for Vox
	var/vox_outfit = null
	/// The job's outfit that will be assigned for Akula
	var/akula_outfit = null
	/// The list of alternative job titles people can pick from, null by default.
	var/list/alt_titles = null
	/// Whether the ID of the job can be tagged as an intern at all
	var/can_be_intern = TRUE
	/// Whether the job uses its own EXP to define the internship status
	var/internship_use_self_exp_type = FALSE
	/// How much does this job raise the storytellers antag cap by?
	var/sec_antag_cap = 0
