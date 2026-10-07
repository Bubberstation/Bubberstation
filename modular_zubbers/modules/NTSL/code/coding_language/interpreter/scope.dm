/*
 * Scope
 * A runtime instance of a block. Used internally by the interpreter.
 */
/datum/scope
	var/datum/scope/parent
	var/datum/scope/variables_parent
	var/datum/ntsl_node/BlockDefinition/block
	var/list/functions
	var/list/variables
	var/status = 0
	var/allowed_status = 0
	var/recursion = 0
	var/datum/ntsl_node/statement/FunctionDefinition/function
	var/datum/ntsl_node/expression/FunctionCall/call_node
	var/return_val

/datum/scope/New(datum/ntsl_node/BlockDefinition/defined_block, datum/scope/parent, datum/scope/variables_parent, allowed_status = 0)
	src.block = defined_block
	src.parent = parent
	src.variables_parent = variables_parent || parent
	if(defined_block)
		src.variables = defined_block.initial_variables.Copy()
		src.functions = defined_block.functions.Copy()
	else
		src.variables = list()
		src.functions = list()
	if(parent)
		src.status = parent.status
		src.recursion = parent.recursion

	if(allowed_status & RESET_STATUS || !parent)
		src.allowed_status = allowed_status & ~RESET_STATUS
	else
		src.allowed_status = allowed_status | parent.allowed_status
	return ..()

/datum/scope/Destroy()
	parent = null
	variables_parent = null
	block = null
	functions = null
	variables = null
	function = null
	call_node = null
	return ..()

/datum/scope/proc/get_scope(name)
	var/datum/scope/current_scope = src
	while(current_scope)
		if(current_scope.variables.Find(name))
			return current_scope
		current_scope = current_scope.variables_parent

/datum/scope/proc/push(datum/ntsl_node/BlockDefinition/defined_block, datum/scope/variables_parent = src, allowed_status = 0) as /datum/scope
	return new /datum/scope(defined_block, src, variables_parent, allowed_status)

/datum/scope/proc/pop(keep_status = (BREAKING | CONTINUING | RETURNING)) // keep_status is which flags you want to copy to the parent.
	parent.status = (parent.status & ~keep_status) | (status & keep_status)
	if(parent.status & RETURNING)
		parent.return_val = return_val
	return parent

/datum/scope/proc/get_var(name, datum/n_Interpreter/interp, datum/ntsl_node/node)
	var/datum/scope/variable_scope = get_scope(name)
	if(variable_scope)
		return variable_scope.variables[name]
	else if(interp)
		interp.RaiseError(new /datum/runtimeError/UndefinedVariable(name), src, node)

/datum/scope/proc/get_function(name)
	var/datum/scope/function_scope = src
	while(function_scope)
		. = function_scope.functions[name]
		if(.)
			return
		function_scope = function_scope.variables_parent

/datum/scope/proc/set_var(name, val, datum/n_Interpreter/interp, datum/ntsl_node/node)
	var/datum/scope/variable_scope = get_scope(name)
	if(variable_scope)
		variable_scope.variables[name] = val
	else
		init_var(name, val, interp, node)
	return val

/datum/scope/proc/init_var(name, val, datum/n_Interpreter/interp, datum/ntsl_node/node)
	if(variables.Find(name) && interp)
		interp.RaiseError(new /datum/runtimeError/DuplicateVariableDeclaration(name), src, node)
	variables[name] = val
