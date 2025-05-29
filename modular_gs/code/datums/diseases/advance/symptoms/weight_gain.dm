/datum/symptom/weight_gain // GS13
	name = "Weight Gain"
	desc = "The virus mutates and merges itself with the host's adipocytes, allowing them to perform a form of mitosis and replicate on their own."
	stealth = -3
	resistance = -2
	stage_speed = 3
	transmittable = -2
	level = 8    //better hope someone went mining kiddo
	severity = 5
	base_message_chance = 100
	symptom_delay_min = 15
	symptom_delay_max = 45
	threshold_desc = list(
		"Stage Speed 7" = "Increases the rate of cell replication.",
		"Stage Speed 12" = "Increases the rate of cell replication further"
	)


/datum/symptom/weight_gain/Activate(datum/disease/advance/A) // GS13
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	if(!(M?.client?.prefs?.weight_gain_viruses))
		return FALSE
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(M, "<span class='warning'>[pick("You feel oddly full...", "You feel more plush...", "You feel more huggable...", "You hear an odd gurgle from your stomach")]</span>")
		else
			to_chat(M, "<span class='warning'><i>[pick("You feel your body churn...", "You feel heavier...", "You hear an ominous gurgle from your belly...", "You feel bulkier...")]</i></span>")
			if(A.properties["stage_rate"] >= 12) //get chunkier quicker
				M.adjust_fatness(70, FATTENING_TYPE_VIRUS)
			else if(A.properties["stage_rate"] >= 7)
				M.adjust_fatness(40, FATTENING_TYPE_VIRUS)
			else
				M.adjust_fatness(15, FATTENING_TYPE_VIRUS)
