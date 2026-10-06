/datum/n_Interpreter/proc/Eval(datum/ntsl_node/expression/exp, datum/scope/scope)
	if(istype(exp, /datum/ntsl_node/expression/FunctionCall))
		. = RunFunction(exp, scope)
	else if(istype(exp, /datum/ntsl_node/expression/expression_operator))
		. = EvalOperator(exp, scope)
	else if(istype(exp, /datum/ntsl_node/expression/value/literal))
		var/datum/ntsl_node/expression/value/literal/lit = exp
		. = lit.value
	else if(istype(exp, /datum/ntsl_node/expression/value/reference))
		var/datum/ntsl_node/expression/value/reference/ref = exp
		. = ref.value
	else if(istype(exp, /datum/ntsl_node/expression/value/variable))
		var/datum/ntsl_node/expression/value/variable/v = exp
		. = scope.get_var(v.id.id_name, src, v)
	else if(istype(exp, /datum/ntsl_node/expression/value/list_init))
		var/datum/ntsl_node/expression/value/list_init/list_exp = exp
		. = list()
		for(var/key in list_exp.init_list)
			var/key_eval = Eval(key, scope)
			var/val = list_exp.init_list[key]
			if(val)
				set_index(., key_eval, Eval(val, scope), scope, key)
			else
				. += list(key_eval)
	else if(istype(exp, /datum/ntsl_node/expression/member/dot))
		var/datum/ntsl_node/expression/member/dot/D = exp
		var/object = D.temp_object || Eval(D.object, scope)
		D.temp_object = null
		. = get_property(object, D.id.id_name, scope)
	else if(istype(exp, /datum/ntsl_node/expression/member/brackets))
		var/datum/ntsl_node/expression/member/brackets/B = exp
		var/object = B.temp_object || Eval(B.object, scope)
		B.temp_object = null
		var/index = B.temp_index || Eval(B.index, scope)
		. = get_index(object, index, scope)
	else if(istype(exp, /datum/ntsl_node/expression))
		RaiseError(new /datum/runtimeError/UnknownInstruction(exp), scope, exp)
	else
		. = exp

	return Trim(.)

/datum/n_Interpreter/proc/EvalOperator(datum/ntsl_node/expression/expression_operator/exp, datum/scope/scope)
	if(istype(exp, /datum/ntsl_node/expression/expression_operator/binary/Assign))
		var/datum/ntsl_node/expression/expression_operator/binary/Assign/ass = exp
		var/member_obj
		var/member_idx
		if(istype(ass.exp, /datum/ntsl_node/expression/value/variable))
			var/datum/ntsl_node/expression/value/variable/var_exp = ass.exp
			if(!scope.get_scope(var_exp.id.id_name))
				scope.init_var(var_exp.id.id_name, null, src, var_exp)
		else if(istype(ass.exp, /datum/ntsl_node/expression/member))
			var/datum/ntsl_node/expression/member/M = ass.exp
			member_obj = Eval(M.object, scope)
			if(istype(M, /datum/ntsl_node/expression/member/brackets))
				var/datum/ntsl_node/expression/member/brackets/B = M
				member_idx = Eval(B.index, scope)
		var/out_value
		var/in_value
		if(ass.type != /datum/ntsl_node/expression/expression_operator/binary/Assign)
			if(istype(ass.exp, /datum/ntsl_node/expression/member))
				var/datum/ntsl_node/expression/member/M = ass.exp
				M.temp_object = member_obj
				if(istype(M, /datum/ntsl_node/expression/member/brackets))
					var/datum/ntsl_node/expression/member/brackets/B = M
					B.temp_index = member_idx
			in_value = Eval(ass.exp, scope)
			if(islist(in_value))
				out_value = in_value
				switch(ass.type)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseAnd)
						in_value &= Eval(ass.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseOr)
						in_value |= Eval(ass.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseXor)
						in_value ^= Eval(ass.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Add)
						in_value += Eval(ass.exp2, scope)
					if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Subtract)
						in_value -= Eval(ass.exp2, scope)
					else
						out_value = null
		if(!out_value)
			switch(ass.type)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign)
					out_value = Eval(ass.exp2, scope)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseAnd)
					out_value = BitwiseAnd(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseOr)
					out_value = BitwiseOr(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/BitwiseXor)
					out_value = BitwiseXor(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Add)
					out_value = Add(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Subtract)
					out_value = Subtract(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Multiply)
					out_value = Multiply(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Divide)
					out_value = Divide(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Power)
					out_value = Power(in_value, Eval(ass.exp2, scope), scope, ass)
				if(/datum/ntsl_node/expression/expression_operator/binary/Assign/Modulo)
					out_value = Modulo(in_value, Eval(ass.exp2, scope), scope, ass)
				else
					RaiseError(new /datum/runtimeError/UnknownInstruction(ass), scope, ass)
			// write it to the var
			if(istype(ass.exp, /datum/ntsl_node/expression/value/variable))
				var/datum/ntsl_node/expression/value/variable/var_exp = ass.exp
				scope.set_var(var_exp.id.id_name, out_value, src, var_exp)
			else if(istype(ass.exp, /datum/ntsl_node/expression/member/dot))
				var/datum/ntsl_node/expression/member/dot/dot_exp = ass.exp
				set_property(member_obj, dot_exp.id.id_name, out_value, scope)
			else if(istype(ass.exp, /datum/ntsl_node/expression/member/brackets))
				set_index(member_obj, member_idx, out_value, scope)
			else
				RaiseError(new /datum/runtimeError/InvalidAssignment(), scope, ass)
		return out_value
	else if(istype(exp, /datum/ntsl_node/expression/expression_operator/binary))
		var/datum/ntsl_node/expression/expression_operator/binary/bin = exp
		switch(bin.type)
			if(/datum/ntsl_node/expression/expression_operator/binary/Equal)
				return Equal(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/NotEqual)
				return NotEqual(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Greater)
				return Greater(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Less)
				return Less(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/GreaterOrEqual)
				return GreaterOrEqual(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/LessOrEqual)
				return LessOrEqual(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/LogicalAnd)
				return LogicalAnd(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/LogicalOr)
				return LogicalOr(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/LogicalXor)
				return LogicalXor(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/BitwiseAnd)
				return BitwiseAnd(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/BitwiseOr)
				return BitwiseOr(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/BitwiseXor)
				return BitwiseXor(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Add)
				return Add(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Subtract)
				return Subtract(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Multiply)
				return Multiply(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Divide)
				return Divide(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Power)
				return Power(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			if(/datum/ntsl_node/expression/expression_operator/binary/Modulo)
				return Modulo(Eval(bin.exp, scope), Eval(bin.exp2, scope), scope, bin)
			else
				RaiseError(new /datum/runtimeError/UnknownInstruction(bin), scope, bin)
	else
		switch(exp.type)
			if(/datum/ntsl_node/expression/expression_operator/unary/Minus)
				return Minus(Eval(exp.exp, scope), scope, exp)
			if(/datum/ntsl_node/expression/expression_operator/unary/LogicalNot)
				return LogicalNot(Eval(exp.exp, scope), scope, exp)
			if(/datum/ntsl_node/expression/expression_operator/unary/BitwiseNot)
				return BitwiseNot(Eval(exp.exp, scope), scope, exp)
			if(/datum/ntsl_node/expression/expression_operator/unary/group)
				return Eval(exp.exp, scope)
			else
				RaiseError(new /datum/runtimeError/UnknownInstruction(exp), scope, exp)

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
