/*
 * Statement
 * An object representing a single instruction run by an interpreter.
 */
/datum/ntsl_node/statement

/datum/ntsl_node/statement/New(datum/token/token)
	. = ..()
	src.token = token

/*
 * FunctionDefinition
 * Defines a function.
 */
/datum/ntsl_node/statement/FunctionDefinition
	var/func_name
	var/list/parameters = new
	var/datum/ntsl_node/BlockDefinition/FunctionBlock/block

/*
 * VariableAssignment
 * Sets a variable in an accessible scope to the given value if one exists, otherwise initializes a new local variable to the given value.
 *
 * Notes:
 * If a variable with the same name exists in a higher block, the value will be assigned to it. If not,
 * a new variable is created in the current block. To force creation of a new variable, use <VariableDeclaration>.
 *
 * See Also:
 * - <VariableDeclaration>
 */
/datum/ntsl_node/statement/VariableAssignment
	var/datum/ntsl_node/identifier/object
	var/datum/ntsl_node/identifier/var_name
	var/datum/ntsl_node/expression/value

/*
 * VariableDeclaration
 * Intializes a local variable to a null value.
 *
 * See Also:
 * - <VariableAssignment>
 */
/datum/ntsl_node/statement/VariableDeclaration
	var/datum/ntsl_node/identifier/object
	var/datum/ntsl_node/identifier/var_name

/**
 * IfStatement
 */
/datum/ntsl_node/statement/IfStatement
	var/skip = 0
	var/datum/ntsl_node/BlockDefinition/block
	var/datum/ntsl_node/BlockDefinition/else_block //can be null
	var/datum/ntsl_node/expression/cond
	var/datum/ntsl_node/statement/else_if

/datum/ntsl_node/statement/IfStatement/ElseIf


/**
 * WhileLoop
 * Loops while a given condition is TRUE.
 */
/datum/ntsl_node/statement/WhileLoop
	var/datum/ntsl_node/BlockDefinition/block
	var/datum/ntsl_node/expression/cond

/*
 * ForLoop
 * Loops while test is true, initializing a variable, increasing the variable
 */
/datum/ntsl_node/statement/ForLoop
	var/datum/ntsl_node/BlockDefinition/block
	var/datum/ntsl_node/expression/test
	var/datum/ntsl_node/expression/init
	var/datum/ntsl_node/expression/increment

/*
 * BreakStatement
 * Ends a loop.
 */
/datum/ntsl_node/statement/BreakStatement

/*
 * ContinueStatement
 * Skips to the next iteration of a loop.
 */
/datum/ntsl_node/statement/ContinueStatement

/*
 * ReturnStatement
 * Ends the function and returns a value.
 */
/datum/ntsl_node/statement/ReturnStatement
	var/datum/ntsl_node/expression/value
