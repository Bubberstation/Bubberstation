#define PURPLE_LIGHT "#9F79F2"
#define PURPLE_DARK "#6141A6"
#define ORANGE_LIGHT "#F27F1B"
#define ORANGE_DARK "#F24F13"
#define GREY_LIGHT "#FFFFFF"
#define GREY_DARK "#292929"

/datum/holiday/proc/queue_storyteller_celebration(datum/round_event/event, datum/round_event_control/control)
	if(isnull(event) || isnull(control))
		stack_trace("Invalid holiday event passed to storyteller")
		return

	if(locate(event) in SSevents.running)
		return

	var/datum/round_event_control/holiday_event = locate(control) in SSevents.control
	if(isnull(holiday_event))
		return

	holiday_event.run_event(admin_forced = TRUE)

/datum/holiday/valentines/celebrate()
	. = ..()
	queue_storyteller_celebration(event = /datum/round_event/valentines, control = /datum/round_event_control/valentines)

/datum/holiday/easter/celebrate()
	. = ..()
	queue_storyteller_celebration(event = /datum/round_event/easter, control = /datum/round_event_control/easter)

/datum/holiday/halloween
	name = HALLOWEEN
	begin_day = 17
	holiday_colors = list()

/datum/holiday/halloween/New()
	. = ..()
	var/palette = rand(1, 15)
	switch(palette)
		if(1, 2)
			holiday_colors += list(
				PURPLE_LIGHT,
				PURPLE_DARK,
				GREY_DARK,
				ORANGE_DARK,
				ORANGE_LIGHT,
				GREY_LIGHT,
			)
		if(3)
			holiday_colors += list(
				PURPLE_LIGHT,
				ORANGE_LIGHT,
				GREY_LIGHT,
			)
		if(4)
			holiday_colors += list(
				PURPLE_DARK,
				ORANGE_DARK,
				GREY_DARK,
			)
		if(5)
			holiday_colors += list(
				pick(GREY_LIGHT, GREY_DARK),
				pick(PURPLE_LIGHT, PURPLE_DARK),
				pick(ORANGE_LIGHT, ORANGE_DARK),
			)
		if(6)
			holiday_colors += list(
				pick(GREY_LIGHT, GREY_DARK),
				pick(PURPLE_LIGHT, PURPLE_DARK),
			)
		if(7)
			holiday_colors += list(
				pick(GREY_LIGHT, GREY_DARK),
				pick(ORANGE_LIGHT, ORANGE_DARK),
			)
		if(8)
			holiday_colors += list(
				pick(PURPLE_LIGHT, PURPLE_DARK),
				pick(ORANGE_LIGHT, ORANGE_DARK),
			)
		if(9)
			holiday_colors += list(PURPLE_LIGHT, ORANGE_LIGHT)
		if(10)
			holiday_colors += list(PURPLE_DARK, ORANGE_DARK)
		if(11)
			holiday_colors = list(
				COLOR_PRIDE_PURPLE,
				COLOR_PRIDE_BLUE,
				COLOR_PRIDE_GREEN,
				COLOR_PRIDE_YELLOW,
				COLOR_PRIDE_ORANGE,
				COLOR_PRIDE_RED,
			)
		if(12)
			holiday_colors += PURPLE_LIGHT
		if(13)
			holiday_colors += ORANGE_LIGHT
		if(14)
			holiday_colors += PURPLE_DARK
		if(15)
			holiday_colors += ORANGE_DARK

/datum/holiday/halloween/celebrate()
	. = ..()
	queue_storyteller_celebration(event = /datum/round_event/spooky, control = /datum/round_event_control/spooky)

/datum/holiday/xmas
	name = CHRISTMAS
	begin_day = 18
	mail_holiday = FALSE
	holiday_colors = list()

/datum/holiday/xmas/New()
	. = ..()
	var/palette = rand(1, 11)
	switch(palette)
		if(1, 2, 3, 4)
			holiday_colors += list(
				COLOR_CHRISTMAS_GREEN,
				COLOR_CHRISTMAS_RED,
			)
		if(5, 6)
			holiday_colors += list(
				COLOR_CHRISTMAS_GREEN,
				COLOR_CHRISTMAS_RED,
				GREY_LIGHT,
			)
		if(7, 8)
			holiday_colors += list(
				COLOR_CHRISTMAS_GREEN,
				GREY_LIGHT,
			)
		if(9, 10)
			holiday_colors += list(
				COLOR_CHRISTMAS_RED,
				GREY_LIGHT,
			)
		if(11)
			holiday_colors += list(
				COLOR_PRIDE_PURPLE,
				COLOR_PRIDE_BLUE,
				COLOR_PRIDE_GREEN,
				COLOR_PRIDE_YELLOW,
				COLOR_PRIDE_ORANGE,
				COLOR_PRIDE_RED,
			)

#undef PURPLE_LIGHT
#undef PURPLE_DARK
#undef ORANGE_LIGHT
#undef ORANGE_DARK
#undef GREY_LIGHT
#undef GREY_DARK
