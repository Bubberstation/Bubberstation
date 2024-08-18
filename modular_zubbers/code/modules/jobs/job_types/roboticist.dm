/datum/outfit/job/roboticist/New()
	. = ..()

	LAZYINITLIST(backpack_contents)
	backpack_contents[/obj/item/paper/pamphlet/roboticist_reminder] = 1

/obj/item/paper/pamphlet/roboticist_reminder
	name = "pamphlet - 'Reminder of roboticist duties'"
	default_raw_text = "Don't forget that your duties include treating the synthetic lifeforms aboard the station! Heres some tips and tricks to get you started...<hr><br> \n\
	You can buy <b>health analyzers</b> from your vendor, as well as <b>burn wound treatment chems</b>! Generally, you'll be using the coolant bottles.<br> \n\
	Make sure to <b>use the health analyzers in hand</b> to activate <b>wound mode</b> if you're ever confused about a wound! <b>Blunt wounds</b> even show \
	the current treatment step!<br>\n\
	Your <b>departmental order console</b> includes things like synthetic medicine crates!<br>\n\
	<b>Epipens</b> are an effective treatment method for synthetic slash/pierce wounds!<br>\n\
	<b>Nanite Slurry</b> is used to heal minor synthetic <b>brute</b> and <b>burn</b> damage. \
	overdose is at <b>10u</b>. Overdose heals synthetic organ damage in exchange of overheating and brute damage.<br>\n\
	<b>Critical system repair pills</b> inside your medkit are used to purposely inflict an overdose of nanite slurry to heal ~ <b>240 organ damage</b> per pill. (You need to manage their brute and burn!)<br>\n\
	<b>Liquid Solder</b> is used to heal <b>positronic damage</b><br>\n\
	<b>System Cleaner</b> is used to heal synthetic <b>toxin damage</b><br>\n\
	<b>Dinitrogen Plasmide</b> is used to treat synthetic overheating wounds safely."
