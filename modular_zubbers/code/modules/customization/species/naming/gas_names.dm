/proc/generate_gas_name()
	var/random_name
	random_name += (pick("Alpha","Beta","Gamma","Delta","Dzetta","Pi","Phi","Epsilon","Tau","Omega") + " [rand(1, 199)]")
	return random_name
