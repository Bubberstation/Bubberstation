//GS13 Port
/mob/living/proc/mob_climax(forced_climax = FALSE, cause = "none")//This is just so I can test this shit without being forced to add actual content to get rid of arousal. Will be a very basic proc for a while.
	set name = "Masturbate"
	set category = "IC"
	if(canbearoused && !restrained() && !stat)
		if(mb_cd_timer <= world.time)
			//start the cooldown even if it fails
			mb_cd_timer = world.time + mb_cd_length
			if(getArousal() >= ((max_arousal / 100) * 33))//33% arousal or greater required
				src.visible_message("<span class='danger'>[src] starts masturbating!</span>", \
								"<span class='userdanger'>You start masturbating.</span>")
				if(do_after(src, 30, target = src))
					src.visible_message("<span class='danger'>[src] relieves [p_them()]self!</span>", \
								"<span class='userdanger'>You have relieved yourself.</span>")
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
					setArousal(min_arousal)
			else
				to_chat(src, "<span class='notice'>You aren't aroused enough for that.</span>")

