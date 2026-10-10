/datum/ntsl_execution_stack
	var/list/contents = new

/datum/ntsl_execution_stack/proc/Push(value)
	contents += value

/datum/ntsl_execution_stack/proc/Pop()
	if(!length(contents))
		return null
	. = contents[length(contents)]
	contents.len--
	return .

///returns the item on the top of the stack without removing it
/datum/ntsl_execution_stack/proc/Top()
	if(!length(contents))
		return null
	return contents[length(contents)]

/datum/ntsl_execution_stack/proc/Copy() as /datum/ntsl_execution_stack
	var/datum/ntsl_execution_stack/new_stack = new()
	new_stack.contents = contents.Copy()
	return new_stack

/datum/ntsl_execution_stack/proc/Clear()
	contents.Cut()
