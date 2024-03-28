/**
 * # NTNet Transmitter List Literal Component
 *
 * Create a list literal and send a data package through NTNet
 *
 * This file is based off of ntnet_send.dm and list_literal.dm
 * Any changes made to those files should be copied over with discretion
 */
/obj/item/circuit_component/ntnet_send_literal
	display_name = "NTNet Transmitter List Literal"
	desc = "Creates a list literal data package and sends it through NTNet. If Encryption Key is set then transmitted data will be only picked up by receivers with the same Encryption Key."
	category = "NTNet"
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL

	/// The list type
	var/datum/port/input/option/list_options

	/// The inputs used to create the list
	var/list/datum/port/input/entry_ports = list()
	/// Encryption key
	var/datum/port/input/enc_key

	ui_buttons = list(
		"plus" = "add",
		"minus" = "remove"
	)

	var/max_list_count = 100

/obj/item/circuit_component/ntnet_send_literal/populate_options()
	list_options = add_option_port("List Type", GLOB.wiremod_basic_types)

/obj/item/circuit_component/ntnet_send_literal/pre_input_received(datum/port/input/port)
	if(port == list_options)
		var/new_datatype = list_options.value
		for(var/datum/port/input/port_to_set as anything in entry_ports)
			port_to_set.set_datatype(new_datatype)

/obj/item/circuit_component/ntnet_send_literal/populate_ports()
	AddComponent(/datum/component/circuit_component_add_port, \
		port_list = entry_ports, \
		add_action = "add", \
		remove_action = "remove", \
		port_type = PORT_TYPE_ANY, \
		prefix = "Index", \
		minimum_amount = 1, \
		maximum_amount = 20 \
	)
	enc_key = add_input_port("Encryption Key", PORT_TYPE_STRING)

/obj/item/circuit_component/ntnet_send_literal/input_received(datum/port/input/port)
	if(!find_functional_ntnet_relay())
		return

	var/new_datatype = list_options.value
	var/list/new_literal = list()
	var/datum/circuit_datatype/handler = GLOB.circuit_datatypes[new_datatype]
	var/obj/item/integrated_circuit/parentbackup = parent

	/// Create the virtual list using data from our ports
	for(var/datum/port/input/entry_port as anything in entry_ports)
		var/value = entry_port.value
		// To prevent people from infinitely making lists to crash the server
		if(islist(value) && get_list_count(value, max_list_count) >= max_list_count)
			visible_message("[src] begins to overheat!")
			return
		var/value_to_add = handler.convert_value(PORT_TYPE_LIST(new_datatype), value)
		if(isdatum(value_to_add))
			value_to_add = WEAKREF(value_to_add)
		new_literal += list(value_to_add)

	/// ntnet_recieve.dm requires the "port" argument to have a weak ref, but a
	/// weak ref is only created when I use a *real* port/output variable made
	/// using add_output_port() (couldn't figure out why... sorry!). To get
	/// around this, and to not tax the UI system with creating and deleting an
	/// object per trigger, I set the parent reference to null and then call
	/// add_output_port(), which then skips the UI stuff when initializing.
	///
	/// "Great! Soooo what's the downside?" the voice of hindsight asks with contempt.
	///
	/// This mess, and assuming nothing in the future ruins this stack of cards...
	/// My sincerest apologies to anyone who ends up maintaining this mess.
	/// You have my permission to outright delete this if it becomes an issue.
	parent = null
	var/datum/port/output/list_output = add_output_port("Value", PORT_TYPE_LIST(PORT_TYPE_ANY), order = 1.1)
	list_output.set_datatype(PORT_TYPE_LIST(new_datatype))
	list_output.set_output(new_literal)
	parent = parentbackup

	/// Package, ship, mail off into the void with furious anger of 1000 suns
	var/datum/port/input/data_package = list_output
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CIRCUIT_NTNET_DATA_SENT, list("data" = data_package.value, "enc_key" = enc_key.value, "port" = WEAKREF(data_package)))

	/// Clean up our mess, because we're civilized
	parent = null
	remove_output_port(list_output)
	parent = parentbackup
