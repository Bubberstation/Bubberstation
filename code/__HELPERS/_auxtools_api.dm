/proc/auxtools_stack_trace(msg)
	CRASH(msg)

/proc/auxtools_expr_stub()
	CRASH("auxtools not loaded")

/proc/enable_debugging(mode, port)
	CRASH("auxtools not loaded")

/proc/enable_mem_profile(filename)
	CRASH("auxtools not loaded")

/proc/disable_mem_profile()
	CRASH("auxtools not loaded")
