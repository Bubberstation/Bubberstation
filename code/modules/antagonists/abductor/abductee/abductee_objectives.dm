/datum/objective/abductee
	completed = 1
	explanation_text = "THEY took you... you can't remember...? The pale faces.. the hands... THEY control us now. You must protect yourself."

/datum/objective/abductee/fearful
	explanation_text = "They're in league with THEM. You know their plans now. You must tell the others: "

/datum/objective/abductee/fearful/New()
	var/target = pick(list("Security", "Medical", "Command"))

	var/transgression = pick(list(
		"putting drugs in the water supply",
		"putting nanomachine trackers into our bodies",
		"using the cameras to track our emotions",
		"putting drugs in the food"))

	explanation_text += "[target] is [transgression] to keep us compliant and sheepish. They know that you know it. Hide! Run! Don't let them catch you!"


/datum/objective/abductee/violent
	explanation_text = "You are filled with an otherworldly rage simmering within. Threatening to boil over at the slightest provocation: "

/datum/objective/abductee/violent/New()
	// we use suit sensors because we really want to make sure that this person can be found by our little crackhead here
	var/target
	if(length(GLOB.suit_sensors_list))
		target = "[pick(GLOB.suit_sensors_list)]"
	else
		target = "the first person I see"

	var/list/exit_spots = list()
	var/possible_area_count = 3
	var/sanity = 0
	while(exit_spots.len < possible_area_count && sanity < 100)
		var/area/area_target = pick(GLOB.areas - exit_spots)
		if(area_target == /area/station/commons/dorms) //If you win a jackpot on getting the one area you shouldn't grief, then congrats, you get the chance to steal copper wire from the SM room
			area_target = /area/station/engineering/supermatter
		if(area_target && is_station_level(area_target.z) && (area_target.area_flags & VALID_TERRITORY))
			exit_spots += area_target
		sanity++
// Nar'sie summoning location code
	var/list/your_poison = list(
		"I am [target], THEY have changed my face and tried to replace me by sending a clone! I must kill them first and resume my life as my original identity.",
		"No, no, no, this isn't right! I never left the ship - this must be a simulation! I must find a way to break out of here... An exit, it must be somewhere, hidden! Under the floors, the walls, I have to take it all apart and find the hidden simulation exit, it could be in one of these: [english_list(exit_spots)]")

	explanation_text += pick(your_poison)


/datum/objective/abductee/paranoid
	explanation_text = "THEY are everywhere, hear everything. They're out to get you, anyone could be one of their agents!"

/datum/objective/abductee/paranoid/New()
	var/holeinthewall = pick(list("engineering", "tool storage", "the chapel"))

	var/list/your_poison = list(
		"I must hole myself up in [holeinthewall] and turn it into a veritable fortress. NONE may enter. It will be my safe space.",
		"They are sending cancer radio mindcontrol waves through the telecoms equipment. All of us are at risk. I must save the station by disabling every piece of radio equipment I can find.",
		"This station is lost. We are all lost. It won't be long now, until THEY come to take us all away. They are our lords... The things I must do to serve them are cruel and vicious, but if I don't do this... Everything I know will end. I must give them a sacrifice.")

	explanation_text += pick(your_poison)

