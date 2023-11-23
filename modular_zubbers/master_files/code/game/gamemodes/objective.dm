/datum/objective/mutiny/check_completion()
	. = ..()
	if(.)
		return
	if(!IS_HEAD_REVOLUTIONARY(target.current) && !(target.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND))
		return TRUE
