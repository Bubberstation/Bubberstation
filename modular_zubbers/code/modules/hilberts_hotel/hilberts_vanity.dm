/area/ruin/space/has_grav/powered/hilbertresearchfacility
	name = "Hilbert Research Facility"

/area/ruin/space/has_grav/powered/hilbertresearchfacility/secretroom
	area_flags = UNIQUE_AREA | NOTELEPORT | HIDDEN_AREA

/obj/item/analyzer/hilbertsanalyzer
	name = "custom rigged analyzer"
	desc = "A hand-held environmental scanner which reports current gas levels. This one seems custom rigged to additionally be able to analyze some sort of bluespace device."
	icon_state = "hilbertsanalyzer"
	worn_icon_state = "analyzer"

/obj/item/analyzer/hilbertsanalyzer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/item/hilbertshotel))
		if(!Adjacent(interacting_with))
			to_chat(user, span_warning("It's to far away to scan!"))
			return ITEM_INTERACT_BLOCKING
		if(SShilbertshotel.room_data.len)
			to_chat(user, "Currently Occupied Rooms:")
			for(var/room_number in SShilbertshotel.room_data)
				to_chat(user, room_number)
		if(SShilbertshotel.conservated_rooms.len)
			to_chat(user, "Vacated Rooms:")
			for(var/room_number in SShilbertshotel.conservated_rooms)
				to_chat(user, room_number)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/effect/landmark/transport/transport_id/hilbert
	specific_transport_id = HILBERT_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/hilbert
	name = HILBERT_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS

/obj/effect/landmark/transport/nav_beacon/tram/platform/hilbert/left
	name = "Port"
	specific_transport_id = HILBERT_LINE_1
	platform_code = HILBERT_PORT
	tgui_icons = list("Reception" = "briefcase", "Botany" = "leaf", "Chemistry" = "flask")

/obj/effect/landmark/transport/nav_beacon/tram/platform/hilbert/middle
	name = "Central"
	specific_transport_id = HILBERT_LINE_1
	platform_code = HILBERT_CENTRAL
	tgui_icons = list("Processing" = "cogs", "Xenobiology" = "paw")

/obj/effect/landmark/transport/nav_beacon/tram/platform/hilbert/right
	name = "Starboard"
	specific_transport_id = HILBERT_LINE_1
	platform_code = HILBERT_STARBOARD
	tgui_icons = list("Ordnance" = "bullseye", "Office" = "user", "Dormitories" = "bed")

/obj/item/keycard/hilbert
	name = "Hilbert's office keycard"
	desc = "A keycard with an engraving on it. The engraving reads: \"Hilbert\"."
	color = "#aa00cc"
	puzzle_id = "hilbert_office"

/obj/machinery/door/puzzle/keycard/hilbert
	name = "secure airlock"
	puzzle_id = "hilbert_office"

/datum/outfit/doctorhilbert
	name = "Doctor Hilbert"
	id = /obj/item/card/id/advanced/silver
	uniform = /obj/item/clothing/under/rank/rnd/research_director/doctor_hilbert
	shoes = /obj/item/clothing/shoes/sneakers/brown
	back = /obj/item/storage/backpack/satchel/leather
	suit = /obj/item/clothing/suit/toggle/labcoat
	id_trim = /datum/id_trim/away/hilbert

/datum/outfit/doctorhilbert/pre_equip(mob/living/carbon/human/hilbert, visualsOnly)
	. = ..()
	if(!visualsOnly)
		hilbert.gender = MALE
		hilbert.update_body()

/obj/item/paper/crumpled/ruins/note_institute
	name = "note to the institute"

/obj/item/paper/crumpled/ruins/note_institute/Initialize(mapload)
	if(!SShilbertshotel.hhMysteryroom_number)
		SShilbertshotel.hhMysteryroom_number = rand(1, 999999) // Fix, it should keep the same number on subsystem init
	default_raw_text = {"Note to the Institute<br>
	If you're reading this, I hope you're from the Institute. First things first, I should apologise. I won't be coming back to teach in the new semester.<br>
	We've made some powerful enemies. Very powerful. More powerful than any of you can imagine, and so we can't come back.<br>
	So, we've made the decision to vanish. Perhaps more literally than you might think. Do not try to find us- for your own safety.<br>
	I've left some of our effects in the Hotel. Room number <u>[uppertext(num2hex(SShilbertshotel.hhMysteryroom_number, 0))]</u>. To anyone who should know, that should make sense.<br>
	Best of luck with the research. From all of us in the Hilbert Group, it's been a pleasure working with you.<br>
	- David, Phil, Fiona and Jen"}
	return ..()

/obj/item/paper/crumpled/ruins/postdocs_memo
	name = "memo to the postdocs"
	default_raw_text = {"Memo to the Postdocs
	Remember, if you're going in to retrieve the prototype for any reason (not that you should be without my supervision), that the security systems are always live- they have no shutoff.<br>
	Instead, remember: what you can't see can't hurt you.<br>
	Take care of the lab during my vacation. See you all in June.<br>
	- David"}

/obj/item/paper/crumpled/ruins/hotel_note
	name = "hotel note"
	default_raw_text = {"Hotel Note<br>
	Well, you figured out the puzzle. Looks like someone's done their homework on my research.<br>
	I suppose you deserve to know some more about our situation. Our research has attracted some undue attention and so, for our own safety, we've taken to the Bluespace.<br>
	Yes, you did read that correctly. I'm sure the physics and maths would bore you, but in layman's terms, the manifested link to the Bluespace the crystals provide can be exploited. With the correct technology, one can "surf" the Bluespace, as Jen likes to call it.<br>
	What's more, the space-time continuum is in full effect here. By correctly manipulating the bluespace, one can go <i>anywhere</i>: time or space. I'll confess to not having figured that one out myself. Check the closet- consider it a prize for solving the puzzle. Just be careful with its use- you might find yourself dealing with the same pursuers we've picked up.<br>
	They deal in "time crimes", whatever their definition of those are.<br>
	Anyway, I'm beginning to ramble. We must be going now. Make sure any posthumous Nobel prizes are made out to the department.<br>
	- David"}

/obj/item/paper/fluff/ruins/docslabnotes
	name = "lab notebook page"
	default_raw_text = {"Laboratory Notebook<br>
	PROPERTY OF DOCTOR D. HILBERT<br>
	May 10th, 2555<br>
	Finally, my new facility is complete, and not a moment too soon!<br>
	My disagreements with Greenham have become too much to bear, so some time away from the campus will do me well. It's not like my students understand my work, anyway. Teaching never was my passion.<br>
	Anyway, I'm getting off track. It is quite amazing what a few million in grants will buy you. This station is state of the art, perfect for my studies.<br>
	Since the Zhang Incident of 2459, we have been quite aware of the properties of bluespace crystals. Their space-warping properties are well-documented, but poorly understood. However, I theorise that it may be possible to harness them in new ways.<br>
	To this end, I've procured a small team of postdoctorate students from the institute to assist with my research. Some administrative help wouldn't go amiss, either- perhaps I should hire a secretary...<br>
	*Following this is a long series of pages detailing failures, grievances with the institute, and more scientific equations than anyone can reasonably chew through.*<br>
	<h4>Breakthrough<h4>
	January 8th, 2557<br>
	My theories have held up adequately. Today, we had our first successful test of the "Hilbert Pocket", as we've taken to calling it. By exploiting the ability of bluespace crystals to create a localised dilation in space, with precise application of force according to geometric calculus, we have successfully "folded" space into a pocket. We had Phil throw one of his analysers into it from across the room, and what we saw was incredible.<br>
	A pocket of infinite space, within a finite area. Simply revolutionary!<br>
	I've set the postdocs to paper writing while I work out the specifics. The technology is successful, but we have no way to harness it. Unless...<br>
	*Many more pages dedicated to equations, engineering drawings, and ramblings continue. Hilbert clearly loves the sight of his own handwriting.*<br>
	<h4>A New Device<h4>
	September 21st, 2557<br>
	We've submitted the first draft of the paper on Hilbert Pockets to the journals. Now, I suppose, we wait.<br>
	In the meantime, I've taken to assembling the first prototype of the device. By exploiting the pocket's ability to create an infinite region of space within a finite area, I've made... well, I suppose it could be called a "Pocket Dimension". Within, I've created a nifty system that recursively produces subspace rooms, spatially linking them to any of the infinite points on the pocket's surface. Fiona says it's akin to a hotel, and I'm inclined to agree.<br>
	Hilbert's Hotel. I like the sound of that.<br>"}

/obj/machinery/computer/terminal/hilbert
	upperinfo = "EMAIL READOUT - 14/05/2558"
	content = list(
		"<b>New Job</b><br> \
		<i>Sent to: natalya_petroyenko@kosmokomm.net</i><br> \
		Hello sis! Figured I should update you on what's going on with the career change.<br> \
		First day on the new job. It's a pretty boring position, but hey- it's not like I was finding anything in New Vladimir. I'm just glad to have something to pay the bills.<br> \
		Suppose I should say what's involved: I'm essentially playing housekeeper for some scientist and his cohort of student assistants. Far above my pay grade to understand what they do, but they seem excited enough. Talking about \"pockets\", for whatever reason. Maybe they're designing the next innovation in clothes?<br> \
		Anyway, that's pretty much it. I'm living on their station for pretty much the duration, so I'm not sure if I'll be able to make it to Mama's birthday. Sorry about that- I'll do my best to make it up to her (and you) when I get some leave.<br> \
		Hope to see you soon,<br> \
		Little Brother Roman",
		"<b>Visitors</b><br> \
		<i>Sent to: david_hilbert@physics.mit.edu</i><br> \
		Morning Doctor. Sorry to email you when you're on holiday, but you did tell me to update you on anything suspicious.<br> \
		There's been a ship that's been hanging around the facility for a few days. Figured that was odd enough, given how far from anything important we are, but it got stranger when one of them finally came over to talk.<br> \
		I know I'm not a native speaker, but I couldn't make out his accent. Wasn't like anything I've heard before, anyway.<br> \
		He kept asking where you were, and if he could come in to speak to you. Of course, I turned him away- even if you had been around I'd have been hesitant to let him in.<br> \
		As an aside, the postdocs told me to pass on a message. Apparently they've made a breakthrough, which sounds good and all.<br> \
		Regards,<br> \
		Roman<br>",
		"<b>Weird Times</b><br> \
		<i>Sent to: natalya_petroyenko@kosmokomm.net</i><br> \
		Hi sis! How was Christmas? Are Mama and Papa doing well? I'm really sorry I couldn't be there, but I've been working my fingers to the bone at work.<br> \
		I figure I should tell you a bit about how it's been going here. I know, I know, you keep calling me a workaholic, but it's really... strange, I guess?<br> \
		I keep getting little glimpses into the research that's happening. They're messing around with bluespace- you know, the tech that makes FTL engines work? I'm not sure what exactly they're doing with it, but they're talking more and more about pockets every day now.<br> \
		Not only that, but I'm starting to hear strange noises from the labs I'm not allowed into. Nothing super terrifying, you know, we're not talking xenomorphs, but more like industrial sounds. Crashes, bangs, occasional high-pitched whining, you know the sort. Like a broken vacuum cleaner.<br> \
		I know it's not the instruments or I'd have heard it before, so it must be something new they've been working on. Exciting, I suppose, but I'm starting to wonder if I'm in over my head working here. Maybe I should start looking for a new job, somewhere closer to home.<br> \
		Hope to see you at Papa's birthday. I've requested leave for it, and I'm just waiting on the Doc's response.<br> \
		See you soon,<br> \
		Little Brother Roman<br>",
		"<b>End of Leave</b><br> \
		<i>Sent to: david_hilbert@physics.mit.edu</i><br> \
		Morning Doctor. Where is everyone? I got back from leave and the station was empty. Have you all went on holiday without telling me?<br> \
		And what the hell happened to the ordnance lab? I couldn't even open the door to get in, it was fused shut!<br> \
		Look, I don't feel safe staying on the station with it in this state, so I'm calling an engineer and heading home until I hear back from you.<br> \
		Regards,<br> \
		Roman<br>",
		"<b>Looking for a New Job</b><br> \
		<i>Sent to: natalya_petroyenko@kosmokomm.net</i><br> \
		Hi sis. First things first, sorry for missing your engagement party. There's been a... situation at work.<br> \
		In fact, that's most of why I'm writing this. I have absolutely no idea what happened, but the Doctor and the students are gone. Just up and left. The facility's abandoned.<br> \
		But like, it's clear they left in a hurry. Hell, there's still coffee in the cups. I'd question it further, but they were always kinda... odd, I guess? The whole thing gives me chills and I don't think I want to dig any deeper.<br> \
		I dropped his university an email and called in the authorities. All that's left now, I guess, is to find a new job. Would your boss happen to be hiring?<br> \
		See you soon,<br> \
		Little Brother Roman",
	)

/obj/structure/showcase/machinery/tv/broken
	name = "broken tv"
	desc = "Nothing plays."

/obj/structure/showcase/machinery/tv/broken/Initialize(mapload)
	. = ..()
	add_overlay("television_broken")

/obj/machinery/porta_turret/syndicate/teleport
	name = "displacement turret"
	desc = "A ballistic machine gun auto-turret that fires bluespace bullets."
	lethal_projectile = /obj/projectile/magic/teleport
	stun_projectile = /obj/projectile/magic/teleport
	faction = list(FACTION_TURRET)

/obj/projectile/magic/teleport/bluespace
	antimagic_flags = NONE
