/obj/item/circuit_component/color
	display_name = "Color"
	desc = "A component that has a drop-down of pickable colors to change the color in chat."
	category = "String"

	/// Colors to pick from to change to, list defined in spans.dm (modular_zubber)
	var/datum/port/input/option/color_options
	/// Whether the color is on or not
	var/datum/port/input/on
	/// The result of the text operation
	var/datum/port/output/output

	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL

/obj/item/circuit_component/color/populate_options()
	var/static/component_options = GLOB.component_span_color_list
	color_options = add_option_port("Color Options", component_options)

/obj/item/circuit_component/color/populate_ports()
	on = add_input_port("On", PORT_TYPE_NUMBER)
	output = add_output_port("Output", PORT_TYPE_STRING)

/obj/item/circuit_component/color/input_received(datum/port/input/port)
	if(!on.value)
		return

	if(isnull(color_options.value))
		return

	output.set_output(color_options.value)
