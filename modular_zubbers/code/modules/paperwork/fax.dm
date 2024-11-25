/obj/machinery/fax/Initialize()
	.=..()
	special_networks |= list(
		//Food Delivery
		Moffuchis = list(fax_name = "Moffuchis Pizzeria", fax_id = "Moffuchis", color = "red", emag_needed = FALSE),
		Dogginos = list(fax_name = "Dogginos Delivery", fax_id = "Dogginos Delivery", color = "red", emag_needed = TRUE),
		//Embassies or Factions
		UnHives = list(fax_name = "United Hives", fax_id = "UnHives", color = "orange", emag_needed = FALSE),
		Tizira = list(fax_name = "Tiziran", fax_id = "Tirizian", color = "orange", emag_needed = FALSE),
		Moghes = list(fax_name = "Moghes", fax_id = "Moghes", color = "orange", emag_needed = FALSE),
		Nri = list(fax_name = "NRI", fax_id = "NRI", color = "orange", emag_needed = FALSE),
		Ombrux = list(fax_name = "Ombrux", fax_id = "Ombrux", color = "orange", emag_needed = TRUE),
		Soato = list(fax_name = "Soato", fax_id = "Soato", color = "orange", emag_needed = TRUE),
		TerraGov = list(fax_name = "SBI", fax_id = "SBI", color = "orange", emag_needed = FALSE),
		Irs = list(fax_name = "IRS", fax_id = "IRS", color = "orange", emag_needed = FALSE),
		Clowns = list(fax_name = "Clown Planet", fax_id = "Clowns", color = "pink", emag_needed = FALSE),
		Mimes = list(fax_name = "La Pantomime Troupe", fax_id = "Mimes", color = "white", emag_needed = FALSE),
		WizFed = list(fax_name = "Wizard Fed", fax_id = "WizFed", color = "blue", emag_needed = TRUE),
		Union = list(fax_name = "Union", fax_id = "Union", color = "orange", emag_needed = TRUE),
		//Syndicate companies
		Cybersun = list(fax_name = "Cybersun", fax_id = "Cybersun", color = "red", emag_needed = TRUE),
		Tiger = list(fax_name = "Tiger Coop", fax_id = "Tiger", color = "red", emag_needed = TRUE),
		Gorlex = list(fax_name = "Gorlex", fax_id = "Gorlex", color = "red", emag_needed = TRUE),
		Donk = list(fax_name = "Donk Co.", fax_id = "Donk", color = "red", emag_needed = TRUE),
		Waffle = list(fax_name = "Waffle Co.", fax_id = "Waffle", color = "red", emag_needed = TRUE),
		Mi13 = list(fax_name = "MI13", fax_id = "MI13", color = "red", emag_needed = TRUE),
		Iaa = list(fax_name = "NT Black Ops", fax_id = "InternalAffairs", color = "black", emag_needed = TRUE),
		Blf = list(fax_name = "Bee Liberation", fax_id = "Bee", color = "red", emag_needed = TRUE),
		Arc = list(fax_name = "Animal Rights Consortium", fax_id = "PETA", color = "red", emag_needed = TRUE),
		Coe = list(fax_name = "Champions of Evil", fax_id = "Evil", color = "red", emag_needed = TRUE),
		//Rogue AI cores
		Fan = list(fax_name = "Fanatical Revelation", fax_id = "FreeAI", color = "green", emag_needed = TRUE),
		Synd = list(fax_name = "SyndOS", fax_id = "SyndAI", color = "red", emag_needed = TRUE),
		Logi = list(fax_name = "Logic Core", fax_id = "LogicAI", color = "green", emag_needed = TRUE),
		//Random ships
		Ntss = list(fax_name = "NTSS Elysium", fax_id = "ntss", color = "black", emag_needed = FALSE),
		Moff = list(fax_name = "Mothic Fleet Flagship", fax_id = "Moff", color = "yellow", emag_needed = FALSE),
		Zeta = list(fax_name = "Mothership Zeta", fax_id = "Zeta", color = "pink", emag_needed = TRUE),
	)
	sort_list(special_networks)

