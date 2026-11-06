/datum/antagonist/ert/vitezstvi
	name = "Vítězství Arms Contractor"
	role = "Contractor"
	outfit = /datum/outfit/vitezstvi_merc
	// the bunk spawner already equips and names them, and re-equipping would undo it
	equip_ert = FALSE
	random_names = FALSE

/datum/antagonist/ert/vitezstvi/forge_objectives()
	var/static/list/orders = list(
		"Protect the VARS-7 'Provodnik' and keep it operational.",
		"Locate surviving station personnel and get as many of them aboard as possible.",
		"Do not leave Boris behind. He is senior staff.",
	)
	for(var/order in orders)
		var/datum/objective/contract = new()
		contract.owner = owner
		contract.explanation_text = order
		// vague standing orders, so they pass unless an admin says otherwise
		contract.completed = TRUE
		objectives += contract

/datum/antagonist/ert/vitezstvi/greet()
	var/list/orders = list()
	orders += span_boldbig("VÍTĚZSTVÍ ARMS EMERGENCY EXTRACTION ORDERS")
	var/count = 1
	for(var/datum/objective/contract in objectives)
		orders += span_notice("<b>Objective #[count]</b>: [contract.explanation_text]")
		count++
	orders += span_warning("RULES OF ENGAGEMENT: Station personnel are clients and comrades. Use lethal force only against clear threats to the evacuation, the crew, or the shuttle.")
	to_chat(owner.current, jointext(orders, "\n"))
