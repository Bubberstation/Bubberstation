#define COLOR_PURPLE_LIGHT "#9F79F2"
#define COLOR_PURPLE_DARK "#6141A6"
#define COLOR_ORANGE_LIGHT "#F27F1B"
#define COLOR_ORANGE_DARK "#F24F13"
#define COLOR_GREY_LIGHT "#FFFFFF"
#define COLOR_GREY_DARK "#292929"

#define COLOR_PRIDE_WHITE "#FFFFFF"

#define COLOR_TRANS_BLUE "#5BCEFA"
#define COLOR_TRANS_PINK "#F5A9B8"

#define COLOR_ACE_BLACK "#292929"
#define COLOR_ACE_GREY "#888888"
#define COLOR_ACE_PURPLE "#800080"

#define COLOR_BI_PINK "#D60270"
#define COLOR_BI_PURPLE "#9B4F96"
#define COLOR_BI_BLUE "#0038A8"

#define COLOR_LESBIAN_RED "#D62800"
#define COLOR_LESBIAN_ORANGE "#FF9B56"
#define COLOR_LESBIAN_PINK "#D452A6"
#define COLOR_LESBIAN_MAGENTA "#A40062"

#define COLOR_PAN_MAGENTA "#FF218C"
#define COLOR_PAN_YELLOW "#FFE45E"
#define COLOR_PAN_CYAN "#2CCAFF"

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
	begin_day = 1 // A whole spooktacular month!
	holiday_colors = list()

/datum/holiday/halloween/New()
	. = ..()
	var/palette = rand(1, 15)
	switch(palette)
		if(1, 2)
			holiday_colors += list(
				COLOR_PURPLE_LIGHT,
				COLOR_PURPLE_DARK,
				COLOR_GREY_DARK,
				COLOR_ORANGE_DARK,
				COLOR_ORANGE_LIGHT,
				COLOR_GREY_LIGHT,
			)
		if(3)
			holiday_colors += list(
				COLOR_PURPLE_LIGHT,
				COLOR_ORANGE_LIGHT,
				COLOR_GREY_LIGHT,
			)
		if(4)
			holiday_colors += list(
				COLOR_PURPLE_DARK,
				COLOR_ORANGE_DARK,
				COLOR_GREY_DARK,
			)
		if(5)
			holiday_colors += list(
				pick(COLOR_GREY_LIGHT, COLOR_GREY_DARK),
				pick(COLOR_PURPLE_LIGHT, COLOR_PURPLE_DARK),
				pick(COLOR_ORANGE_LIGHT, COLOR_ORANGE_DARK),
			)
		if(6)
			holiday_colors += list(
				pick(COLOR_GREY_LIGHT, COLOR_GREY_DARK),
				pick(COLOR_PURPLE_LIGHT, COLOR_PURPLE_DARK),
			)
		if(7)
			holiday_colors += list(
				pick(COLOR_GREY_LIGHT, COLOR_GREY_DARK),
				pick(COLOR_ORANGE_LIGHT, COLOR_ORANGE_DARK),
			)
		if(8)
			holiday_colors += list(
				pick(COLOR_PURPLE_LIGHT, COLOR_PURPLE_DARK),
				pick(COLOR_ORANGE_LIGHT, COLOR_ORANGE_DARK),
			)
		if(9)
			holiday_colors += list(COLOR_PURPLE_LIGHT, COLOR_ORANGE_LIGHT)
		if(10)
			holiday_colors += list(COLOR_PURPLE_DARK, COLOR_ORANGE_DARK)
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
			holiday_colors += COLOR_PURPLE_LIGHT
		if(13)
			holiday_colors += COLOR_ORANGE_LIGHT
		if(14)
			holiday_colors += COLOR_PURPLE_DARK
		if(15)
			holiday_colors += COLOR_ORANGE_DARK

/datum/holiday/halloween/celebrate()
	. = ..()
	queue_storyteller_celebration(event = /datum/round_event/spooky, control = /datum/round_event_control/spooky)

/datum/holiday/xmas
	name = CHRISTMAS
	begin_day = 18
	no_mail_holiday = FALSE
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
				COLOR_GREY_LIGHT,
			)
		if(7, 8)
			holiday_colors += list(
				COLOR_CHRISTMAS_GREEN,
				COLOR_GREY_LIGHT,
			)
		if(9, 10)
			holiday_colors += list(
				COLOR_CHRISTMAS_RED,
				COLOR_GREY_LIGHT,
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

/datum/holiday/pride_week
	begin_day = 1
	holiday_colors = list()

/datum/holiday/pride_week/New()
	. = ..()
	var/palette = rand(1, 7)
	switch(palette)
		if(1)
			holiday_colors += list(
				COLOR_PRIDE_PURPLE,
				COLOR_PRIDE_BLUE,
				COLOR_PRIDE_GREEN,
				COLOR_PRIDE_YELLOW,
				COLOR_PRIDE_ORANGE,
				COLOR_PRIDE_RED,
			)
		if(2)
			holiday_colors += list(
				COLOR_TRANS_BLUE,
				COLOR_TRANS_PINK,
				COLOR_PRIDE_WHITE,
			)
		if(3)
			holiday_colors += list(
				COLOR_ACE_BLACK,
				COLOR_ACE_GREY,
				COLOR_PRIDE_WHITE,
				COLOR_ACE_PURPLE,
			)
		if(4)
			holiday_colors += list(
				COLOR_PAN_MAGENTA,
				COLOR_PAN_YELLOW,
				COLOR_PAN_CYAN,
			)
		if(5)
			holiday_colors += list(
				COLOR_BI_PINK,
				COLOR_BI_PURPLE,
				COLOR_BI_BLUE,
			)
		if(6)
			holiday_colors += list(
				COLOR_LESBIAN_RED,
				COLOR_LESBIAN_ORANGE,
				COLOR_LESBIAN_PINK,
				COLOR_LESBIAN_MAGENTA,
			)
		if(7)
			holiday_colors += list(
				COLOR_LESBIAN_RED,
				COLOR_LESBIAN_ORANGE,
				COLOR_LESBIAN_PINK,
				COLOR_LESBIAN_MAGENTA,
				COLOR_PRIDE_PURPLE,
				COLOR_PRIDE_BLUE,
				COLOR_PRIDE_GREEN,
				COLOR_PRIDE_YELLOW,
				COLOR_PRIDE_ORANGE,
				COLOR_PRIDE_RED,
				COLOR_TRANS_BLUE,
				COLOR_TRANS_PINK,
				COLOR_PRIDE_WHITE,
				COLOR_PAN_MAGENTA,
				COLOR_PAN_YELLOW,
				COLOR_PAN_CYAN,
				COLOR_ACE_BLACK,
				COLOR_ACE_GREY,
				COLOR_PRIDE_WHITE,
				COLOR_ACE_PURPLE,
				COLOR_BI_PINK,
				COLOR_BI_PURPLE,
				COLOR_BI_BLUE,
			)

#undef COLOR_PURPLE_LIGHT
#undef COLOR_PURPLE_DARK
#undef COLOR_ORANGE_LIGHT
#undef COLOR_ORANGE_DARK
#undef COLOR_GREY_LIGHT
#undef COLOR_GREY_DARK

#undef COLOR_PRIDE_WHITE

#undef COLOR_TRANS_BLUE
#undef COLOR_TRANS_PINK

#undef COLOR_ACE_BLACK
#undef COLOR_ACE_GREY
#undef COLOR_ACE_PURPLE

#undef COLOR_BI_PINK
#undef COLOR_BI_PURPLE
#undef COLOR_BI_BLUE

#undef COLOR_LESBIAN_RED
#undef COLOR_LESBIAN_ORANGE
#undef COLOR_LESBIAN_PINK
#undef COLOR_LESBIAN_MAGENTA

#undef COLOR_PAN_MAGENTA
#undef COLOR_PAN_YELLOW
#undef COLOR_PAN_CYAN
