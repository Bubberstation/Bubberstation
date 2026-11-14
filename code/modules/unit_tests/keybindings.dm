//BUBBER TEST FILE

/// Validates that the keybinding sanitizer keeps valid entries, drops unknown
/// ones, and repairs null/garbage values (these are what corrupt a player's
/// saved key_bindings after a "Reset to Defaults" on a keybinding with no
/// default keys, then crash TGUI's keybinding page with
/// "Cannot read properties of null (reading 'filter')").
/datum/unit_test/preferences_sanitize_keybindings

/datum/unit_test/preferences_sanitize_keybindings/Run()
	var/list/known_bindings = list()
	for (var/name in GLOB.keybindings_by_name)
		known_bindings += name

	if(!length(known_bindings))
		TEST_FAIL("GLOB.keybindings_by_name is empty; cannot test sanitize_keybindings")
		return

	var/first_binding = known_bindings[1]
	var/second_binding = known_bindings[2]

	var/list/input = list(
		first_binding = list("W"),
		second_binding = null, // what a reset-to-defaults on a keyless binding writes
		"not_a_real_keybinding" = list("X"),
	)

	var/list/result = sanitize_keybindings(input)

	TEST_ASSERT(istype(result, /list), "sanitize_keybindings did not return a list")
	TEST_ASSERT(!(second_binding in result), "unknown keybinding was not removed")
	TEST_ASSERT(istype(result[first_binding], /list) && result[first_binding][1] == "W", "valid binding was corrupted")
	TEST_ASSERT(istype(result[second_binding], /list) && !length(result[second_binding]), "null binding was not repaired to an empty list")
	// A json round-trip of the sanitized value must not contain nulls
	var/round_trip = json_decode(json_encode(result))
	for (var/bound_key in round_trip)
		TEST_ASSERT(istype(round_trip[bound_key], /list), "[bound_key] is not a list after a json round-trip")
