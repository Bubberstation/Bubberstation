/datum/n_Interpreter/proc/Eval(datum/ntsl_node/expression/evaluated_expression, datum/scope/scope)
	if(istype(evaluated_expression, /datum/ntsl_node/expression/FunctionCall))
		. = RunFunction(evaluated_expression, scope)
	else if(istype(evaluated_expression, /datum/ntsl_node/expression/expression_operator))
		. = EvalOperator(evaluated_expression, scope)
	else if(istype(evaluated_expression, /datum/ntsl_node/expression/value/literal))
		var/datum/ntsl_node/expression/value/literal/expression_literal = evaluated_expression
		. = expression_literal.value
	else if(istype(evaluated_expression, /datum/ntsl_node/expression/value/reference))
		var/datum/ntsl_node/expression/value/reference/expression_reference = evaluated_expression
		. = expression_reference.value
	else if(istype(evaluated_expression, /datum/ntsl_node/expression/value/variable))
		var/datum/ntsl_node/expression/value/variable/expression_variable = evaluated_expression
		. = scope.get_var(expression_variable.id.id_name, src, expression_variable)
	else if(istype(evaluated_expression, /datum/ntsl_node/expression/value/list_init))
		var/datum/ntsl_node/expression/value/list_init/list_exp = evaluated_expression
		. = list()
		for(var/key in list_exp.init_list)
			var/key_eval = Eval(key, scope)
			var/val = list_exp.init_list[key]
			if(val)
				set_index(., key_eval, Eval(val, scope), scope, key)
			else
				. += list(key_eval)
	else if(istype(evaluated_expression, /datum/ntsl_node/expression/member/dot))
		var/datum/ntsl_node/expression/member/dot/expression_dot = evaluated_expression
		var/object = expression_dot.temp_object || Eval(expression_dot.object, scope)
		expression_dot.temp_object = null
		. = get_property(object, expression_dot.id.id_name, scope)
	else if(istype(evaluated_expression, /datum/ntsl_node/expression/member/brackets))
		var/datum/ntsl_node/expression/member/brackets/expression_brackets = evaluated_expression
		var/object = expression_brackets.temp_object || Eval(expression_brackets.object, scope)
		expression_brackets.temp_object = null
		var/index = expression_brackets.temp_index || Eval(expression_brackets.index, scope)
		. = get_index(object, index, scope)
	else if(istype(evaluated_expression, /datum/ntsl_node/expression))
		RaiseError(new /datum/runtimeError/UnknownInstruction(evaluated_expression), scope, evaluated_expression)
	else
		. = evaluated_expression

	return Trim(.)

/datum/n_Interpreter/proc/EvalOperator(datum/ntsl_node/expression/expression_operator/operator_expression, datum/scope/scope)
	if(istype(operator_expression, /datum/ntsl_node/expression/expression_operator/binary/Assign))
		var/datum/ntsl_node/expression/expression_operator/binary/Assign/assignment_expression = operator_expression
		var/member_obj
		var/member_idx
		if(istype(assignment_expression.exp, /datum/ntsl_node/expression/value/variable))
			var/datum/ntsl_node/expression/value/variable/var_exp = assignment_expression.exp
			if(!scope.get_scope(var_exp.id.id_name))
				scope.init_var(var_exp.id.id_name, null, src, var_exp)
		else if(istype(assignment_expression.exp, /datum/ntsl_node/expression/member))
			var/datum/ntsl_node/expression/member/expression_member = assignment_expression.exp
			member_obj = Eval(expression_member.object, scope)
			if(istype(expression_member, /datum/ntsl_node/expression/member/brackets))
				var/datum/ntsl_node/expression/member/brackets/expression_brackets = expression_member
				member_idx = Eval(expression_brackets.index, scope)
		var/out_value
		var/in_value
		if(assignment_expression.type != /datum/ntsl_node/expression/expression_operator/binary/Assign)
			if(istype(assignment_expression.exp, /datum/ntsl_node/expression/member))
				var/datum/ntsl_node/expression/member/expression_member = assignment_expression.exp
				expression_member.temp_object = member_obj
				if(istype(expression_member, /datum/ntsl_node/expression/member/brackets))
					var/datum/ntsl_node/expression/member/brackets/expression_brackets = expression_member
					expression_brackets.temp_index = member_idx
			in_value = Eval(assignment_expression.exp, scope)
			if(islist(in_value))
				out_value = in_value
				switch(assignment_expression.type)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseAnd)
						in_value &= Eval(assignment_expression.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseOr)
						in_value |= Eval(assignment_expression.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseXor)
						in_value ^= Eval(assignment_expression.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Add)
						in_value += Eval(assignment_expression.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Subtract)
						in_value -= Eval(assignment_expression.exp2, scope)
					else
						out_value = null
		if(!out_value)
			switch(assignment_expression.type)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign)
					out_value = Eval(assignment_expression.exp2, scope)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseAnd)
					out_value = BitwiseAnd(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseOr)
					out_value = BitwiseOr(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseXor)
					out_value = BitwiseXor(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Add)
					out_value = Add(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Subtract)
					out_value = Subtract(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Multiply)
					out_value = Multiply(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Divide)
					out_value = Divide(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Power)
					out_value = Power(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Modulo)
					out_value = Modulo(in_value, Eval(assignment_expression.exp2, scope), scope, assignment_expression)
				else
					RaiseError(new /datum/runtimeError/UnknownInstruction(assignment_expression), scope, assignment_expression)
			// write it to the var
			if(istype(assignment_expression.exp, /datum/ntsl_node/expression/value/variable))
				var/datum/ntsl_node/expression/value/variable/var_exp = assignment_expression.exp
				scope.set_var(var_exp.id.id_name, out_value, src, var_exp)
			else if(istype(assignment_expression.exp, /datum/ntsl_node/expression/member/dot))
				var/datum/ntsl_node/expression/member/dot/dot_exp = assignment_expression.exp
				set_property(member_obj, dot_exp.id.id_name, out_value, scope)
			else if(istype(assignment_expression.exp, /datum/ntsl_node/expression/member/brackets))
				set_index(member_obj, member_idx, out_value, scope)
			else
				RaiseError(new /datum/runtimeError/InvalidAssignment(), scope, assignment_expression)
		return out_value
	else if(istype(operator_expression, /datum/ntsl_node/expression/expression_operator/binary))
		var/datum/ntsl_node/expression/expression_operator/binary/binary_expression = operator_expression
		switch(binary_expression.type)
			if(/datum/ntsl_node/expression/expression_operator/binary/Equal)
				return Equal(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/NotEqual)
				return NotEqual(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Greater)
				return Greater(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Less)
				return Less(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/GreaterOrEqual)
				return GreaterOrEqual(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/LessOrEqual)
				return LessOrEqual(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/LogicalAnd)
				return LogicalAnd(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/LogicalOr)
				return LogicalOr(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/LogicalXor)
				return LogicalXor(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/BitwiseAnd)
				return BitwiseAnd(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/BitwiseOr)
				return BitwiseOr(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/BitwiseXor)
				return BitwiseXor(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Add)
				return Add(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Subtract)
				return Subtract(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Multiply)
				return Multiply(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Divide)
				return Divide(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Power)
				return Power(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			if(/datum/ntsl_node/expression/expression_operator/binary/Modulo)
				return Modulo(Eval(binary_expression.exp, scope), Eval(binary_expression.exp2, scope), scope, binary_expression)
			else
				RaiseError(new /datum/runtimeError/UnknownInstruction(binary_expression), scope, binary_expression)
	else
		switch(operator_expression.type)
			if(/datum/ntsl_node/expression/expression_operator/unary/Minus)
				return Minus(Eval(operator_expression.exp, scope), scope, operator_expression)
			if(/datum/ntsl_node/expression/expression_operator/unary/LogicalNot)
				return LogicalNot(Eval(operator_expression.exp, scope), scope, operator_expression)
			if(/datum/ntsl_node/expression/expression_operator/unary/BitwiseNot)
				return BitwiseNot(Eval(operator_expression.exp, scope), scope, operator_expression)
			if(/datum/ntsl_node/expression/expression_operator/unary/group)
				return Eval(operator_expression.exp, scope)
			else
				RaiseError(new /datum/runtimeError/UnknownInstruction(operator_expression), scope, operator_expression)

/datum/n_Interpreter/proc/Equal(a, b)
	return a == b

/datum/n_Interpreter/proc/NotEqual(a, b)
	return a != b //LogicalNot(Equal(a, b))

/datum/n_Interpreter/proc/Greater(a, b)
	return a > b

/datum/n_Interpreter/proc/Less(a, b)
	return a < b

/datum/n_Interpreter/proc/GreaterOrEqual(a, b)
	return a >= b

/datum/n_Interpreter/proc/LessOrEqual(a, b)
	return a <= b

/datum/n_Interpreter/proc/LogicalAnd(a, b)
	return a && b

/datum/n_Interpreter/proc/LogicalOr(a, b)
	return a || b

/datum/n_Interpreter/proc/LogicalXor(a, b)
	return (a || b) && !(a && b)

/datum/n_Interpreter/proc/BitwiseAnd(a, b)
	return a & b

/datum/n_Interpreter/proc/BitwiseOr(a, b)
	return a | b

/datum/n_Interpreter/proc/BitwiseXor(a, b)
	return a^b

/datum/n_Interpreter/proc/Add(a, b, scope, node)
	if(istext(a) && !istext(b))
		b = "[b]"
	else if(istext(b) && !istext(a) && !islist(a))
		a = "[a]"
	if(isnull(a) || isnull(b))
		RaiseError(new /datum/runtimeError/TypeMismatch("+", a, b), scope, node)
		return null
	return a+b

/datum/n_Interpreter/proc/Subtract(a, b, scope, node)
	if(isnull(a) || isnull(b))
		RaiseError(new /datum/runtimeError/TypeMismatch("-", a, b), scope, node)
		return null
	return a-b

/datum/n_Interpreter/proc/Divide(a, b, scope, node)
	if(isnull(a) || isnull(b))
		RaiseError(new /datum/runtimeError/TypeMismatch("/", a, b), scope, node)
		return null
	if(b)
		return a/b
	// If $b is 0 or Null or whatever, then the above if statement fails,
	// and we got a divison by zero.
	RaiseError(new /datum/runtimeError/DivisionByZero(), scope, node)
	//ReleaseSingularity()
	return null

/datum/n_Interpreter/proc/Multiply(a, b, scope, node)
	if(isnull(a) || isnull(b))
		RaiseError(new /datum/runtimeError/TypeMismatch("*", a, b), scope, node)
		return null
	return a*b

/datum/n_Interpreter/proc/Modulo(a, b, scope, node)
	if(isnull(a) || isnull(b))
		RaiseError(new /datum/runtimeError/TypeMismatch("%", a, b), scope, node)
		return null
	return a%b

/datum/n_Interpreter/proc/Power(a, b, scope, node)
	if(isnull(a) || isnull(b))
		RaiseError(new /datum/runtimeError/TypeMismatch("**", a, b), scope, node)
		return null
	return a**b

/datum/n_Interpreter/proc/Minus(a)
	return -a

/datum/n_Interpreter/proc/LogicalNot(a)
	return !a

/datum/n_Interpreter/proc/BitwiseNot(a)
	return ~a
