/datum/outfit/job/roboticist/New()
	. = ..()

	LAZYINITLIST(backpack_contents)
	backpack_contents[/obj/item/paper/pamphlet/roboticist_reminder] = 1

/obj/item/paper/pamphlet/roboticist_reminder
	name = "pamphlet - 'Reminder of roboticist duties'"
	default_raw_text = "Don't forget that your duties include treating the synthetic lifeforms aboard the station! Heres some tips and tricks to get you started... \n\
	You can buy <b>health analyzers</b> from your vendor, as well as <b>burn wound treatment chems</b>! Generally, you'll be using the coolant bottles. \n\
	Make sure to <b>use the health analyzers in hand</b> to activate <b>wound mode</b> if you're ever confused about a wound! <b>Blunt wounds</b> even show \
	the current treatment step!\n\
	Your <b>departmental order console</b> includes things like synthetic medicine crates!\n\
	<b>Epipens</b> are an effective treatment method for synthetic slash/pierce wounds!"
