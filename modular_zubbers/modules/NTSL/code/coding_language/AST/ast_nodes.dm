/**
 * An abstract syntax tree (AST) is a representation of source code in a computer-friendly format. It is composed of nodes,
 * each of which represents a certain part of the source code. For example, an <IfStatement> node represents an if statement in the
 * script's source code. Because it is a representation of the source code in memory, it is independent of any specific scripting language.
 * This allows a script in any language for which a parser exists to be run by the interpreter.
 *
 * The AST is produced by an <n_Parser> object. It consists of a <GlobalBlock> with an arbitrary amount of statements. These statements are
 * run in order by an <n_Interpreter> object. A statement may in turn run another block (such as an if statement might if its condition is
 * met).
 *
 * Articles:
 * - <http://en.wikipedia.org/wiki/Abstract_syntax_tree>
 */

/**
 * Node
 */
/datum/ntsl_node
	///Returns line number information
	var/datum/token/token

/datum/ntsl_node/proc/ToString()
	return "[type]"

/*
 * identifier
 */
/datum/ntsl_node/identifier
	var/id_name

/datum/ntsl_node/identifier/New(id, token)
	. = ..()
	src.id_name = id
	src.token = token

/datum/ntsl_node/identifier/ToString()
	return id_name

/*
 * expression
 */
/datum/ntsl_node/expression
/*
 * operator
 * See <Binary Operators> and <Unary Operators> for subtypes.
 */
/datum/ntsl_node/expression/expression_operator
	var/datum/ntsl_node/expression/exp
	var/tmp/name
	var/tmp/precedence

/datum/ntsl_node/expression/expression_operator/New(token, exp)
	. = ..()
	if(!name)
		name = "[type]"
	src.token = token
	src.exp = exp

/datum/ntsl_node/expression/expression_operator/ToString()
	return "operator: [name]"

/datum/ntsl_node/expression/member
	var/datum/ntsl_node/expression/object
	var/tmp/temp_object // so you can pre-eval it, used for function calls and assignments

/datum/ntsl_node/expression/member/New(token)
	src.token = token
	return ..()

/datum/ntsl_node/expression/member/dot
	var/datum/ntsl_node/identifier/id

/datum/ntsl_node/expression/member/brackets
	var/datum/ntsl_node/expression/index
	var/tmp/temp_index


/*
 * FunctionCall
 */
/datum/ntsl_node/expression/FunctionCall
	//Function calls can also be expressions or statements.
	var/datum/ntsl_node/expression/function
	var/list/parameters = list()

/datum/ntsl_node/expression/FunctionCall/New(token)
	. = ..()
	src.token = token

/*
 * literal
 */
/datum/ntsl_node/expression/value/literal
	var/value

/datum/ntsl_node/expression/value/literal/New(value)
	. = ..()
	src.value = value

/datum/ntsl_node/expression/value/literal/ToString()
	return value

/*
 * Variable
 */
/datum/ntsl_node/expression/value/variable
	///Either a node/identifier or another node/expression/value/variable which points to the object
	var/datum/ntsl_node/object
	var/datum/ntsl_node/identifier/id

/datum/ntsl_node/expression/value/variable/New(datum/ntsl_node/identifier/ident, datum/token/token)
	. = ..()
	src.token = token
	src.id = ident
	if(istext(id))
		src.id = new(id)

/datum/ntsl_node/expression/value/variable/ToString()
	return id.ToString()

/datum/ntsl_node/expression/value/list_init
	var/list/init_list

/datum/ntsl_node/expression/value/list_init/New(datum/token/token)
	. = ..()
	src.token = token

/**
 * Reference
 */
/datum/ntsl_node/expression/value/reference
	var/datum/value

/datum/ntsl_node/expression/value/reference/New(value, datum/token/token)
	. = ..()
	src.token = token
	src.value = value

/datum/ntsl_node/expression/value/reference/ToString()
	return "ref: [value] ([value.type])"
