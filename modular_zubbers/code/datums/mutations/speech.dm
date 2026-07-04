/datum/mutation/uwu
	name = "Uwuification"
	desc = "A mutation that causes the afflicted to speak in an overly cutesy manner."
	locked = TRUE
	instability = NEGATIVE_STABILITY_MINI
	quality = MINOR_NEGATIVE
	text_gain_indication = span_notice("You feel like nya-ing...")
	text_lose_indication = span_notice("The need to nya passes.")
	var/static/list/language_mutilation = list(
		"r" = "w",
		"l" = "w",
		"na" = "nya",
		"ne" = "nye",
		"ni" = "nyi",
		"no" = "nyo",
		"nu" = "nyu"
	)

/datum/mutation/uwu/New(datum/mutation/copymut)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = language_mutilation)
