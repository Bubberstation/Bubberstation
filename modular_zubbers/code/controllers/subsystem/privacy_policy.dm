SUBSYSTEM_DEF(privacy)
	name = "Privacy Policy"
	flags = SS_NO_FIRE

	VAR_PRIVATE/list/completed_by_ckey = list()

/datum/controller/subsystem/privacy/Initialize()
	load_initial_acceptances()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/privacy/proc/load_initial_acceptances()
	set waitfor = FALSE

	if(!SSdbcore.IsConnected())
		return

	var/datum/db_query/query = SSdbcore.NewQuery("SELECT ckey, policy_key FROM [format_table_name("privacy_policy_acceptances")]")

	if(!query.Execute())
		qdel(query)
		return

	while(query.NextRow())
		var/ckey = query.item[1]
		var/policy_key = query.item[2]

		completed_by_ckey[ckey] ||= list()
		completed_by_ckey[ckey] += policy_key

	qdel(query)

/datum/controller/subsystem/privacy/proc/has_accepted(ckey, policy_key)
	return completed_by_ckey[ckey] && (policy_key in completed_by_ckey[ckey])

/datum/controller/subsystem/privacy/proc/mark_accepted(ckey, policy_key)
	if(has_accepted(ckey, policy_key))
		return

	completed_by_ckey[ckey] ||= list()
	completed_by_ckey[ckey] += policy_key

	var/datum/db_query/query = SSdbcore.NewQuery(
		"INSERT IGNORE INTO [format_table_name("privacy_policy_acceptances")] (ckey, policy_key) VALUES (:ckey, :policy_key)",
		list(
			"ckey" = ckey,
			"policy_key" = policy_key
		)
	)

	query.Execute()
	qdel(query)
