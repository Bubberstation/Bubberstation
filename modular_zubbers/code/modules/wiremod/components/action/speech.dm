/obj/item/circuit_component/speech
	/// The language setting
	var/datum/port/input/language_port

	/// Spans to apply to the output message.
	var/datum/port/input/color_input

	//Shell language selected from the list
	var/shell_language

	//List of valid languages of the speech circuit
	var/static/list/circuit_languages

/obj/item/circuit_component/speech/Initialize(mapload)
	. = ..()
	if(!circuit_languages)
		circuit_languages = list()
		for(var/datum/language/language as anything in GLOB.language_datum_instances)
			if(language.secret)
				continue
			circuit_languages[language.name] = language

/obj/item/circuit_component/speech/populate_ports()
	. = ..()
	color_input = add_input_port("Color", PORT_TYPE_STRING, default = "Default")
	language_port = add_input_port("Language", PORT_TYPE_STRING, trigger = null)

/obj/item/circuit_component/speech/input_received(datum/port/input/port)
	if(!parent.shell)
		return

	if(TIMER_COOLDOWN_RUNNING(parent.shell, COOLDOWN_CIRCUIT_SPEECH))
		return

	if(!(color_input.value in GLOB.component_span_color_list))
		color_input.set_value("Default", TRUE)

	if(message.value)
		var/atom/movable/shell = parent.shell
		if (language_port.value in circuit_languages) //if user selected language is an [item] in the list then...
			shell_language = circuit_languages[language_port.value] //selects the [value] for the specified [item]
		else shell_language = /datum/language/common //if it is not in an [item] in the list then it defaults to common
		shell.say(message.value, language = shell_language, forced = "circuit speech | [parent.get_creator()]", message_range = quietmode.value > 0 ? WHISPER_RANGE : MESSAGE_RANGE, spans = list(GLOB.component_span_color_list[color_input.value]))
		TIMER_COOLDOWN_START(shell, COOLDOWN_CIRCUIT_SPEECH, speech_cooldown)

