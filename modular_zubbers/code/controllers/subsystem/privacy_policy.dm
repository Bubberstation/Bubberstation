SUBSYSTEM_DEF(privacy)
	name = "Privacy Policy"
	flags = SS_NO_FIRE

/datum/controller/subsystem/privacy/Initialize()
	if(!CONFIG_GET(flag/sql_enabled))
		return
	return SS_INIT_SUCCESS

/datum/controller/subsystem/privacy/proc/has_accepted(ckey, policy_key)
	if(!SSdbcore.IsConnected())
		return
	var/datum/db_query/query = SSdbcore.NewQuery("SELECT ckey, policy_key FROM privacy_policy_acceptances WHERE ckey = :ckey AND policy_key = :policy_key)]",
	list(
		"ckey" = ckey,
		"policy_key" = policy_key)
		)
	if(!query.warn_execute())
		qdel(query)
		return
	qdel(query)

/datum/controller/subsystem/privacy/proc/mark_accepted(ckey, policy_key)
	. = has_accepted(ckey, policy_key)
	if(.)
		return

	var/datum/db_query/query = SSdbcore.NewQuery(
		"INSERT IGNORE INTO [format_table_name("privacy_policy_acceptances")] (ckey, policy_key) VALUES (:ckey, :policy_key)",
		list(
			"ckey" = ckey,
			"policy_key" = policy_key
		)
	)

	query.warn_execute()
	qdel(query)
	return .
