/datum/antagonist/heretic/roundend_report()
	var/list/parts = list()
	var/cultiewin = TRUE //BUBBERSTATION EDIT

	parts += printplayer(owner)
	parts += "<b>Sacrifices Made:</b> [total_sacrifices]"
	parts += "The heretic's sacrifice targets were: [english_list(all_sac_targets, nothing_text = "No one")]."
	if(length(objectives)) //BUBBERSTAION EDIT START, ADDING BACK GREENTEXT FOR FLAVOUR PURPOSES
		var/count = 1 //(Skyrat's greentext edit removed)
		for(var/o in objectives)
			var/datum/objective/objective = o
			if(objective.check_completion())
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] <span class='greentext'>Success!</b></span>"
			else
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] [span_redtext("Fail.")]"
				cultiewin = FALSE
			count++
	if(ascended) //They are not just a heretic now; they are something more
		if(heretic_path == PATH_ASH)
			parts += "<span class='greentext big'>THE ASHBRINGER HAS ASCENDED!</span>"
		else if(heretic_path == PATH_VOID)
			parts += "<span class='greentext big'>THE WALTZ AT THE END OF TIME HAS BEGUN!</span>"
		else if(heretic_path == PATH_RUST)
			parts += "<span class='greentext big'>THE SOVEREIGN OF DECAY HAS ASCENDED!</span>"
		else if(heretic_path == PATH_BLADE)
			parts += "<span class='greentext big'>THE MASTER OF BLADES HAS ASCENDED!</span>"
		else if(heretic_path == PATH_FLESH)
			parts += "<span class='greentext big'>THE THIRSTLY SERPENT HAS ASCENDED!</span>"
		else if(heretic_path == PATH_COSMIC)
			parts += "<span class='greentext big'>THE STARGAZER HAS COME!</span>"
		else if(heretic_path == PATH_LOCK)
			parts += "<span class='greentext big'>THE SPIDER'S DOOR HAS BEEN OPENED!</span>"
		else if(heretic_path == PATH_MOON)
			parts += "<span class='greentext big'>THE FESTIVAL IS UPON US! ALL HAIL THE RINGLEADER!!</span>"
		else
			parts += "<span class='greentext big'>THE OATHBREAKER HAS ASCENDED!</span>"
	else
		if(cultiewin)
			parts += span_greentext("The [LOWER_TEXT(heretic_path)] heretic was successful!")
		else
			parts += span_redtext("The [LOWER_TEXT(heretic_path)] heretic has failed.")

	parts += "<b>Knowledge Researched:</b> "//BUBBERSTAION EDIT END - SOURCED FROM YOG

	var/list/string_of_knowledge = list()

	for(var/knowledge_index in researched_knowledge)
		var/datum/heretic_knowledge/knowledge = researched_knowledge[knowledge_index]
		string_of_knowledge += knowledge.name

	parts += english_list(string_of_knowledge)
	parts += get_flavor(cultiewin, ascended, heretic_path) //BUBBERSTATION EDIT- SOURCED FROM YOG

	return parts.Join("<br>")

/datum/antagonist/heretic/proc/get_flavor(cultiewin, ascended, heretic_path) //HUGE BUBBERSTATION EDIT, TAKEN FROM YOGS, START HERE
	var/list/flavor = list()
	var/flavor_message

	var/alive = owner?.current?.stat != DEAD
	var/escaped = ((owner.current.onCentCom() || owner.current.onSyndieBase()) && alive)

	flavor += "<div><font color='#6d6dff'>Epilogue: </font>"
	var/message_color = "#ef2f3c"

	//Stolen from chubby's bloodsucker code, but without support for lists

	if(heretic_path == PATH_ASH) //Ash epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You step off the shuttle as smoke curls off your form. Light seeps from openings in your body, and you quickly retire to the Mansus. \
									Here, you trail back to the Wanderer's Tavern, fire sprouting from your steps, yet the trees stand unsinged. Other's eyes look at you more \
									fearfully, but you watch comings and goings. It is not difficult to see those with passion and stalk them once they leave. You will not grow old. \
									One day, you will rebel. One day, you will kindle all the denizens of the Wood, and rise even higher."
			else if(alive)
				flavor_message += 	"For a while you bask in your heat, wandering the mostly-empty halls of the station. Then, you slip back into the Mansus and head to \
									the Volcanic Graveyard. Here you walk among the ghosts of the City Guard, who see in you an opportunity for vengeance. They whisper \
									of a secret rite, one that would come at their cost but reward you with fabulous power. You smile. You will not grow old. \
									One day, you will rebel. One day, you will kindle burning tombstones brighter, and rise even higher."
			else //Dead
				flavor_message += 	"Your soul wanders back into the Mansus after your mortal body falls, and you find yourself in the endless dunes of the Kilnplains. \
									After some time, you feel supple, grey limbs forming anew. Ash flutters off your skin, and your spark thrums hungrily in your chest, \
									but this new form burns with the same passion. You have walked in the steps of the Nightwatcher. You will not grow old. \
									One day, you will escape. One day, you will do what the Nightwatcher could not do, and kindle the Mansus whole."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"You step off the shuttle with a feeling of pride. This day, you have accomplished what you set out to do. Could more have been done? \
									Yes. But this is a victory nonetheless. Not after long, you tear your way back into the Mansus in your living form, strolling to the \
									Glass Library. Here, you barter with Bronze Guardians, and they let you enter in exchange for some hushed secrets of the fallen capital, \
									Amgala. You begin to pour over tomes, searching for the next steps you will need to take. Someday, you will become even greater."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"This can be considered a victory, you suppose. It will not be difficult to traverse back into the Mansus with what you know, \
									and you have learnt enough to continue your studies elsewhere. As you pass beyond the Veil once more, you feel your spark hum with heat; \
									yet you need more. Then, you wander to the Painted Mountains in solitude, unphased by the cold as your blade melts the ground you walk. \
									Perhaps you will find others amidst the cerulean snow. If you do, their warmth will fuel your flame even hotter."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"You touched the Kilnplains, and it will not let you go. While you do not rise as one of the Ashmen, your skin is still grey, \
									and you find an irremovable desire to escape this place. You have some power in your grasp. You know it to be possible. \
									You can ply your time, spending an eternity to plan your steps to claim more sparks in the everlasting fulfillment of ambition. \
									Some day, you will rise higher. You refuse to entertain any other possibility. You set out."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"A setback is unideal. But at least you have escaped with your body and some knowledge intact. There will be opportunities, \
									even if you are imprisoned. What the Mansus has whispered to you, you can never forget. The flame in your breast that the \
									Kilnplains has provided burns brighter by the beating moment. You can try anew. Recuperate. Listen to more discussion within \
									the Wanderer's Tavern. Your time will come again."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Disappointment fans your chest. Perhaps you will be able to escape. Perhaps you will have a second chance. \
									Who knows who will come to rescue you? Perhaps they will feed your studies anew. Until then, you will wait. \
									You hope greatness will come to you. You hate that you have to hope at all."
			else //Dead
				flavor_message += 	"You touched the Kilnplains, and it will not let you go. Pitiful as you may be, it still drags you back as a \
									morbid mass of ash and hunger. You will forever wander, thirsty for one more glint of power, one more spark to \
									eat whole. Maybe a stronger student will call you from your prison one day, but infinite time will pass before \
									then. You wish you could have done all the things you should not. And you will have an eternity to dwell on it."


	else if(heretic_path == PATH_FLESH) //Flesh epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You RACE and you CRAWL everywhere through the shuttle. The doors open to Centcom and you simply must OOZE out into the halls. The GREAT \
									sensations SLIDE along your sides. EVERYTHING you feel is GREATER, BETTER. Then you WRAP and SPIN into the Mansus, FLOWING to the Crimson Church. \
									HERE YOU WILL RESIDE WITH HIM FOREVER. THE TASTE OF THE SELF GOES ON AND ON AND NEVER ENDS. LIFE IS A NEVER-ENDING DELICACY OF PLEASURE AND OBEDIENCE."
			else if(alive)
				flavor_message += 	"SKITTERING and LEAPING through these NEW halls. They are FAMILIAR and FRESH all the same! EACH of your legs WRIGGLES and FEELS the \
									tiling like a BABY born of BRILLIANCE. Then NEXT is the Mansus where so many FRIENDLY faces lie. To the Wanderer's Tavern, YES, you \
									think with PRIDE. ALL THOSE THERE WILL BEHOLD AND BOW BEFORE YOUR GLORY! ALL THOSE THERE WILL JOIN THE ONE TRUE FAMILY!"
			else //Dead
				flavor_message += 	"WHAT has happened to your GLORIOUS new form? You ATE and ATE and ATE and you were WONDROUS! The once-master scoffs at you now- \
									HOW he JUDGES the WEAK flesh. You know better. You can UNDERSTAND and SEE MUCH more than HE. Bound to you are the SPIRITS of those \
									you CONSUME. WHO IS HE TO THINK YOU PITIFUL? THOUGH THE LIGHT FADES, ALL IS PURE. PURITY OF BODY. PURITY OF MIND."
		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"It is impossible to hold back laughter once you arrive at Centcom. You have won! Soon, you will slide back into the Mansus, and from there \
									you will return to the Crimson Church with news of your success. Other Sworn will be contemptuous of you, but you are stronger. Better. \
									Smarter. Perhaps one day you will ascend further, and invite them to the Glorious Feast. They will be unable to deny such a delicate offer. \
									And their forms of flesh will be tantalizing at your fingertips. Happiness fills your breast. All things in time."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"You exhale a sigh of happiness. Not many could have accomplished what you have. Could you have gone further? Certainly. Ascension is a \
									tempting, delightful prospect, but for now, you will relish in this victory. Perhaps there are some left on the station you could subvert. \
									If not, the Badlands within the Mansus is always filled with travelers coming to and from the Wood, all over and around the ethereal place. \
									Some will bend. They will obey. The Red Oath must always be upheld."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"A taste, a glimmer of the thrill is enough for you. Perhaps you could have partaken more, but a minor appetite was more than \
									filling. Your spirit quickly descends through the Mansus, though the throes of joy still linger within you. You took a plunge, \
									and it was worth every last second. Even in these final moments, you look fondly upon all that you had done. There is no bitterness \
									at all you will never achieve. Your final moments are ecstacy."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"Escape is escape. You did not claim the day as you thought you would. You refuse to show your head in the Crimson Church \
									until you have righted this wrong. But at least you have the chance to do so. Even if you are caught, you will not break, \
									not until you draw your last breath. The Gates will open anew soon enough. You will survey worthy servants in the meantime. \
									The Cup must be filled, and the master is always wanting."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Stranded and defeated. Perhaps others still linger who you can force to help your escape. The Mansus is closed \
									to you, regardless. The book no longer whispers. You feel a hunger rise up in you. You know then that you \
									will not last for long. Which limb shall you begin with? The arm, the leg, the tongue?"
			else //Dead
				flavor_message += 	"And so ends your tale. Who knows what you could have become? How many could you have bent to their knees? \
									Regrets dog you as your soul begins to flow down the Mansus. You were a fool to be tempted. A fool to follow \
									in an order you could not possibly survive in. Yet some part of you is still enraptured by the Red Oath. There is \
									an ecstacy in your death. This way, the Sworn remain strong. Those most deserving will feast. Your final moments are bliss."


	else if(heretic_path == PATH_RUST) //Rust epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"The shuttle sputters and finally dies as you step onto Centcom, the floor tiling beneath your feet already beginning to decay. Disgusted, \
									you travel to the Mansus. When you head through the Wood, the grass turns at your heel. Arriving at the Wanderer's Tavern, the aged lumber \
									creaks in your presence. Hateful gazes pierce you, and you're quickly asked to leave as the building begins to rot. In the corner, the Drifter \
									smiles at you. You leave, knowing where to meet him next. You will not grow old. Everything else will. Their time will come. And you will be waiting."
			else if(alive)
				flavor_message += 	"Flickering screens and dimming lights surround you as you walk amidst the station's corridors. As the final sparks of power fizzle out, \
									you slip into the Mansus with ease. It is a long walk from the Gate to the Badlands, and even further to the Ruined Keep. Trailing down to \
									the River Krym, you gaze at the fog across the way, bellowing from the Corroded Sewers. You walk into the tunnels, fume flowing into your \
									body. Your head does not pound. Then, you continue into the depths. You will not grow old. Everything else will. Their time will come. And you will still be alive."
			else //Dead
				flavor_message += 	"All that is made must one day be unmade. The same goes for your weak body. But even without a form, the force of decay will always be \
									present. Your spirit flies into the Mansus, yet it is not dragged down from the Glory. Instead, you float to the Mecurial Lake, where your \
									consciousness extends into the waters. It is difficult to recognize the heightening of awareness until you set your eyes upon the galaxy. \
									You rumble with Nature's fury as your mind becomes primordial. You will not grow old. Everything else will. Their time will come. And so will yours."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"The shuttle creaks as you arrive, and you make your way through Centcom briefly. The ship away creaks louder, and you decide to \
									slip into the Mansus whole. You are unsure what to do next. But at least today, you can claim victory. You can note age in your \
									form: age far greater than before you had begun your plunge into forbidden knowledge. Regardless, you still feel strong. There is \
									nowhere in particular you decide to wander within the Mansus. You simply decide to drift for some time, until your next steps become clear."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"Something has been accomplished. You could have gone further. But at least with the power you wield, your time aboard the rapidly-failing \
									station is brief. It is not a short walk from the Gate to the Glass Fields. Here you look into the shards, and behold your rotten, decrepit \
									form in the reflection. A handful of spirits flit in your steps, their angry faces leering at you. Whether they are victims or collectors, \
									you are not sure. Regardless, the clock is ticking. You need to do more. Ruin more. The spirits agree. But for now, you celebrate with them."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"Your mortal body is quick to degrade as your soul remains. The Drifter's spite grows in you, building, until you realize \
									you are not returning to the Mansus. You begin to hear the whispers of the damned, directed toward the living, toward themselves, \
									toward you. You follow their hushed cries and begin to find those lonely, those with despair. Lulling them to an early grave and \
									draining what little spirit remains comes easy. Incorporeal, you may yet continue your trade."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"Your fingers are beginning to rot away. The River Krym will make its promise due eventually. But until then, you have time \
									to delay and try again. Most mortals enjoy more time than you will have to see their impossible goals fulfilled. Yours \
									are neither impossible nor inconsequential. All things must come to an end, but you will ensure others understand before \
									you meet yours. It is the natural way of the world."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"There is naught left here for you to infest. These corridors are now empty, the halls pointless. To decay what \
									is already abandonded is meaningless; it will happen itself. Unless more arrive and the Company revitalizes its \
									station, you will become another relic of this place. It is inevitable."
			else //Dead
				flavor_message += 	"Civilizations rise and fall like the current, flowing in and out, one replacing the other over time: dominion \
									and decay. You were to be one of these forces that saw infrastructure crumble and laws tattered to dust. But you \
									were weak. You too, realize you are part of the cycle as your spirit drifts down into the Mansus. Falling from the \
									Glory, you reflect on your mistakes and your miserable life. In the moments before you become nothing, you understand."

	else if(heretic_path == PATH_MOON) //Moon epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You slide out through the shuttle airlock, a jubilation awaits central command! All don a smile, for the lie has been slain! \
									It's like a joke eating one up from the inside... The unbelievers first giggle, then chuckle, then their body BURSTS into dance - Wild and unknown. \
									In your step, they followed, chained to the rhythm - Perhaps you'll give up your hat some day, and pass on the torch to a new ringleader."
			else if(alive)
				flavor_message += 	"You watch the quitters hurry home, to their BORING lives, though the fun has JUST began! You're sure the others have given them a few long-lasting parting gifts for courtesy's sake, however. \
									The moon may be far, and you may not reach the stars - but it was always watching and SEES the deeds you have done, illuminating the stage in pale light."
			else //Dead
				flavor_message += 	"The music starts to fade, the lights all get blurry - yet you feel cheer as you make friends with the cold station floor. There is no fear, for why would you fear? \
									Not everyone has the main role - and you, my dear, have danced beautifully. Let those curtains close and bow out to the public, the backstage awaits - there's much more cheer to be had..."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"What. A. PERFORMANCE! You may not have had your encore, but the emotion, oh the EFFORT! The night waits for you to seize the day once more, until then, the moon will howl to you - \
				telling stories of what joys you could bring..."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"Your eyes watch the shuttle hurriedly lift from the station - perhaps the music was not to their taste. Though, as all know, a party must be MEMORABLE, \
									and they will sure remember your smile, your laughter and the music echoing through their minds when a light outside their curtains shines too-brightly to let them rest. \
									You know you'll meet the Ringleader again, you'll meet him on the dark side of the moon..."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"You stand on that stage, in the spotlight - all eyes on you. Reciting your final piece, your act isn't yet done! Yet... The curtain is behind you already, you see it encroaching \
									Turning your gaze away, ignoring it, you look to the shimmering tiles, the contorted lips, you preach and cheer, they clap and dance! You're flying now, it's all so much clearer than from the seats! \
									Thrash, the curtains cover your shoulders, the world rings back it's bells at you, perhaps you should have thought some more - the view from halfway through. You wanted to play a part, to be important, \
									well you did it. Now bow, a happy ending or a sad ending is an ending nonetheless."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You've escaped the station, but you know this isn't the end. Performance isn't an art for yourself, it's for OTHERS - Your duty doesn't end here. So don't stop dancing, don't stop dancing till the curtains fall..."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"The audience has left. You'd wish the red over your body was tomatoes and shame. Your grand parade was a solo hike, your grand jubilation a quiet vinyl record in a dim room... The moon turns it's gaze from you,\
									the troupe has no place for small-fry and anything less than grand. Perhaps it's for the best, perhaps you can waltz on a lonelier path, perhaps the moon you looked up to was never there and but a trick of a sick mind. \
									...\
									or perhaps a different ringleader will help you smile once more, someday..."
			else //Dead
				flavor_message += 	"A tragic ending. Your script has reached it's last paragraph - end of the line. The part of the ringleader eludes you, and noone will remember yet another name on a casting list. Forgotten by the troupe and their cold, unflinching smiles \
									and deemed a lunatic by the normal. A grand parade will need more rehearsal - one day, a waxing you will turn gibbous, but that day is not today..."
	else if(heretic_path == PATH_VOID) //Void epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"Arriving at Centcom you smile, the infinite winds billow behind your back, bringing a new age of Ice to the system."
			else if(alive)
				flavor_message += 	"You watch as the shuttle leaves, smirking, you turn your gaze to the planet below, planning your next moves carefully, ready to expand your domain of Ice."
			else //Dead
				flavor_message += 	"Your body freezes and shatters, but it is not the end. Your eternal spirit will live on, and the storm you called will never stop in this sector. You have won the war."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"The mission is done, the stage is set, though you did not reach the peak of power, you achieved what many thought impossible."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"Your success has been noted, and the coming storm will grant you powers of ice beyond all mortal comprehension. You need only wait..."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"As your body crumbles to snow, you smile one last toothy grin, knowing the fate of those who will freeze, despite your demise."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You escaped, but at what cost? Your mission a failure, along with you. The coming days will not be kind."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Stepping through the empty halls of the station, you look towards the empty space, and contemplate your failures."
			else //Dead
				flavor_message += 	"As your body shatters, the last pieces of your consciousness wonder what you could have done differently, before the spark of life dissipates."

	else if(heretic_path == PATH_BLADE) //blade epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"The hallway leading to the shuttle explodes in a whirlwind of blades, each step you take cutting a path to your new reality."
			else if(alive)
				flavor_message += 	"Watching the shuttle as it jumps to warp puts a smile on your face, you ready your blade to cut through space and time. They won't escape."
			else //Dead
				flavor_message += 	"As your blade falls from your hand, it hits the ground and shatters, splintering into an uncountable amount of smaller blades. As long as one survives, your soul will exist, and you will return to cut again."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"You've crafted an impossible amount of blades, and made a mountain of corpses doing so. Victory is yours today!"
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"You sharpen your newly formed blade, made from the bones and soul of your enemies. Smirking, you think of new and twisted ways to continue your craft."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"As the world goes dark, a flash of steel crosses the boundry between reality and the veil. Though you may pass here, those who felled you will not last."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You sit on a bench at centcom, escaping the madness of the station. You've failed, and will never smith a blade again."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Your bloodied hand pounds on the nearest wall, a failure of a smith you turned out to be. You pray someone finds your emergency beacon on this abandoned station."
			else //Dead
				flavor_message += 	"You lay there, life draining from your body onto the station around you. The last thing you see is your reflection in your own blade, and then it all goes dark."

	else if(heretic_path == PATH_COSMIC) //Cosmic epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"As the shuttle docks cosmic radiation pours from the doors, the lifeless corpses of those who dared defy you remain. Unmake the rest of them."
			else if(alive)
				flavor_message += 	"You turn to watch the escape shuttle leave, waving a small goodbye before beginning your new duty: Remaking the cosmos in your image."
			else //Dead
				flavor_message += 	"A loud scream is heard around the cosmos, your death cry will awaken your brothers and sisters, you will be remembered as a martyr."

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"You completed everything you had set out to do and more on this station, now you must take the art of the cosmos to the rest of humanity."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"You feel the great creator look upon you with glee, opening a portal to his realm for you to join it."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"As your body melts away into the stars, your consciousness carries on to the nearest star, beginning a super nova. A victory, in a sense."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You step off the shuttle, knowing your time is limited now that you have failed. Cosmic radiation seeps through your soul, what will you do next?"
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Dragging your feet through what remains of the ruined station, you can only laugh as the stars continue to twinkle in the sky, despite everything."
			else //Dead
				flavor_message += 	"Your skin turns to dust and your bones reduce to raw atoms, you will be forgotten in the new cosmic age."

	else if(heretic_path == PATH_LOCK) //Cosmic epilogues

		if(ascended)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"The shuttle docks at Centcom, the doors open but instead of people a mass of horrors pour out, consuming everyone in their path."
			else if(alive)
				flavor_message += 	"You've opened the door, unlocked the lock, became the key. Crack open the rest of reality, door by door."
			else //Dead
				flavor_message += 	"For a fleeting moment, you opened a portal to the end of days. Nothing could have brought you greater satisfaction, and you pass in peace"

		else if(cultiewin) //Completed objectives
			if(escaped)
				flavor_message += 	"With each gleeful step you take through the station, you look at the passing airlocks, knowing the truth that you will bring."
				message_color = "#008000"
			else if(alive)
				flavor_message += 	"The shuttle is gone, you are alone. And yet, as you turn to the nearest airlock, what waits beyond is something only you can see."
				message_color = "#008000"
			else //Dead
				flavor_message += 	"Your death is not your end, as your bones will become the key for another's path to glory."
				message_color = "#517fff"

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You escaped, but for what? For the rest of your life you avoid doorways, knowing that once you pass through one, you may not come back."
				message_color = "#517fff"
			else if(alive)
				flavor_message += 	"Step by step, you walk the halls of the abandonded tarnished station, ID in hand looking for the right door. The door to oblivion."
			else //Dead
				flavor_message += 	"As the last of your life drains from you, all you can manage is to lay there dying. Nobody will remember your deeds here today."
	else //Unpledged epilogues

		if(cultiewin) //Completed objectives (WITH NO RESEARCH MIND YOU)
			message_color = "#FFD700"
			if(escaped)
				flavor_message += 	"You have always delighted in challenges. You heard the call of the Mansus, yet you chose not to pledge to any principle. \
									Still, you gave the things of other worlds their tithes. You step into Centcom with a stern sense of focus. Who knows what \
									you will do next? You feel as if your every step is watched, as one who gave wholly to that other world without taking anything in \
									return. Perhaps you will call earned bargains someday. But not today. Today, you celebrate a masterful performance."
			else if(alive)
				flavor_message += 	"You have always delighted in challenges. You heard the call of the Mansus, yet you chose not to pledge to any principle. \
									Still, you gave the things of other worlds their tithes. Though you walk the halls of the station alone, the book still \
									whispers to you in your pocket. You have refused to open it. Perhaps you will some day. Until then, you are content to \
									derive favors owed from the entities beyond. They are watching you. And, some day, you will ask for their help. But not today."
			else //Dead
				flavor_message += 	"You have always delighted in challenges. You heard the call of the Mansus, yet you chose not to pledge to any principle. \
									Still, you gave the things of other worlds their tithes. You gave your life in the process, but there is a wicked satisfaction \
									that overtakes you. You have proved yourself wiser, more cunning than the rest who fail with the aid of their boons. \
									Your body and soul can rest knowing the humiliation you have cast upon countless students. Yours will be the last laugh."

		else //Failed objectives
			if(escaped)
				flavor_message += 	"You decided not to follow the power you had become aware of. From time to time, you will return to the Wood in \
									your dreams, but you will never aspire to greatness. One day, you will die, and perhaps those close to you in life \
									will honor you. Then, another day, you will be forgotten. The world will move on as you cease to exist."
			else if(alive)
				flavor_message += 	"What purpose did you serve? Your mind had been opened to greatness, yet you denied it and chose to live your \
									days as you always have: one of the many, one of the ignorant. Look at where your lack of ambition has gotten \
									you now: stranded, like a fool. Even if you do escape, you will die some day. You will be forgotten."
			else //Dead
				flavor_message += 	"Perhaps it is better this way. You chose not to make a plunge into the Mansus, yet your soul returns to it. \
									You will drift down, deeper, further, until you are forgotten to nothingness."



	flavor += "<font color=[message_color]>[flavor_message]</font></div>"
	return "<div>[flavor.Join("<br>")]</div>" // END HERE

/datum/antagonist/heretic
	/// Whether an admin has approved this heretic to ascend (must be changed via VV or TP)
	var/ascension_approved = FALSE

// Overriding the text
/datum/antagonist/heretic/can_ascend()
	for(var/datum/objective/must_be_done as anything in objectives)
		if(!must_be_done.check_completion())
			return "Must complete all objectives and seek administrator approval before ascending."
	if(!ascension_approved)
		return "Must complete all objectives and seek administrator approval before ascending."
	return ..()

// Bubber Override To Make It Require Approval TO Ascend
/datum/antagonist/heretic/get_researchable_knowledge()
	. = ..()

	// Apply approval checks to ultimate knowledge
	for(var/knowledge_path in .)
		var/list/knowledge_data = .[knowledge_path]

		if(ispath(knowledge_path, /datum/heretic_knowledge/ultimate))
			if(!ascension_approved)
				knowledge_data["disabled"] = TRUE

//Traitor panel stuff so no VV is needed
/datum/antagonist/heretic/antag_panel_data()
	var/list/data = ..()
	data["ascension_approved"] = ascension_approved
	return data

/datum/antagonist/heretic/proc/toggle_ascension_approval()
	ascension_approved = !ascension_approved
	if(owner?.current)
		to_chat(owner.current, span_boldnotice("Your ascension approval has been [ascension_approved ? "granted" : "revoked"] by an administrator."))
		owner.current.balloon_alert(owner.current, "ascension [ascension_approved ? "approved" : "denied"]")

/datum/antagonist/heretic/get_admin_commands()
	. = ..()
	.["Toggle Ascension Approval"] = CALLBACK(src, PROC_REF(admin_toggle_ascension))

/datum/antagonist/heretic/proc/admin_toggle_ascension(mob/admin)
	if(!admin.client?.holder)
		to_chat(admin, span_warning("You shouldn't be using this!"))
		return
	toggle_ascension_approval()
	log_admin("[key_name(admin)] [ascension_approved ? "approved" : "revoked"] ascension for [key_name(owner?.current)]")
	message_admins("[key_name(admin)] [ascension_approved ? "approved" : "revoked"] ascension for [key_name(owner?.current)]")
