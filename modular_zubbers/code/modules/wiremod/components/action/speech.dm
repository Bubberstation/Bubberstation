/obj/item/circuit_component/speech
	/// Whether the whisper flag is on or not
	var/datum/port/input/whisper

/obj/item/circuit_component/speech/populate_ports()
	. = ..()
	whisper = add_input_port("Whisper", PORT_TYPE_NUMBER, default = 0) //Add new whisper port to component (and default to off)

/obj/item/circuit_component/speech/input_received(datum/port/input/port)
	if(!parent.shell)
		return

	if(TIMER_COOLDOWN_RUNNING(parent.shell, COOLDOWN_CIRCUIT_SPEECH))
		return

	if(message.value)
		var/atom/movable/shell = parent.shell
		shell.say(message.value, forced = "circuit speech | [parent.get_creator()]", message_range = whisper.value ? WHISPER_RANGE : MESSAGE_RANGE)
		TIMER_COOLDOWN_START(shell, COOLDOWN_CIRCUIT_SPEECH, speech_cooldown)
