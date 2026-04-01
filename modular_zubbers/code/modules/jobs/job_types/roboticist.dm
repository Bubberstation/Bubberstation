/datum/outfit/job/roboticist
	backpack = /obj/item/storage/backpack/science/robo
	satchel = /obj/item/storage/backpack/satchel/science/robo
	duffelbag = /obj/item/storage/backpack/duffelbag/science/robo

	glasses = /obj/item/clothing/glasses/hud/diagnostic
	gloves = /obj/item/clothing/gloves/color/black

	l_hand = /obj/item/storage/medkit/robotic_repair/preemo/stocked

/datum/job/roboticist
	description = "Build cyborgs, mechs, AIs, and maintain them all. Create MODsuits for those that wish. Try to remind medical that you're \
	actually a lot better at treating synthetic crew members than them."

/datum/outfit/job/roboticist/New()
	. = ..()

	LAZYINITLIST(backpack_contents)
	backpack_contents[/obj/item/clothing/head/utility/welding] = 1

/datum/job/roboticist/New()
	. = ..()

	mail_goodies += list(
		/obj/item/healthanalyzer/advanced = 15,
		/obj/item/screwdriver/power/science = 6,
		/obj/item/crowbar/power/science = 6,
		/obj/item/weldingtool/experimental = 2, // a lot rarer since its relatively powerful
		/obj/item/scalpel/advanced = 6,
		/obj/item/retractor/advanced = 6,
		/obj/item/cautery/advanced = 6,
		/obj/item/storage/pill_bottle/liquid_solder = 6,
		/obj/item/storage/pill_bottle/system_cleaner = 6,
		/obj/item/storage/pill_bottle/nanite_slurry = 6,
		/obj/item/reagent_containers/spray/hercuri/chilled = 8,
		/obj/item/reagent_containers/spray/dinitrogen_plasmide = 8,
	)


/datum/outfit/job/roboticist/New()
	. = ..()

	LAZYINITLIST(backpack_contents)
	backpack_contents[/obj/item/paper/pamphlet/roboticist_reminder] = 1

/obj/item/paper/pamphlet/roboticist_reminder
	name = "synthetic care pamphlet"
	default_raw_text = "Your duties include treating the synthetic and protean lifeforms aboard the station! Heres some tips and tricks to get you started...<hr><br> \n\
	You can buy <b>health analyzers</b> from your vendor, as well as <b>burn wound treatment chems</b>! Generally, you'll be using the coolant bottles.<br> \n\
	Make sure to <b>use the health analyzers in hand</b> to activate <b>wound mode</b> if you're ever confused about a wound! <b>Blunt wounds</b> even show \
	the current treatment step!<br>\n\
	Your <b>departmental order console</b> includes things like synthetic medicine and protean organ crates!<br>\n\
	<b>Epipens</b> are an effective treatment method for synthetic slash/pierce wounds!<br>\n\
	<b>Nanite Slurry</b> is used to heal minor synthetic <b>brute</b> and <b>burn</b> damage. \
	overdose is at <b>10u</b>. Overdose heals synthetic organ damage in exchange of overheating and brute damage.<br>\n\
	<b>Critical system repair pills</b> inside your medkit are used to purposely inflict an overdose of nanite slurry to heal ~ <b>240 organ damage</b> per pill. (You need to manage their brute and burn!)<br>\n\
	<b>Liquid Solder</b> is used to heal <b>positronic damage</b><br>\n\
	<b>System Cleaner</b> is used to heal synthetic <b>toxin damage</b><br>\n\
	<b>Dinitrogen Plasmide</b> is used to treat synthetic overheating wounds safely.<br>\n\
	<b>Blank Synthetic Shells</b> can be produced at the exofab for practice if mining has been gathering resources.<br>\n\
	<b>Oil</b> functions as a synthetic creatures blood. It can be obtained from Chemistry, or if you're crafty, scooped off the floor."
