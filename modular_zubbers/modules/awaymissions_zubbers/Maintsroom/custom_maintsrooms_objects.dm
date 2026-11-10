/obj/item/paper/fluff/awaymissions/maintsroom/readfucker
	name = "Read Me"
	desc = "It is rumored that the literacy rates among the frontier stations are as low as 50%"
	default_raw_text =  "<li>To whom it may concern, this is lieutenant Pristine here, serving with the nanotrasen expeditionary squad.</li> \
	<li>If you are reading this note, this means youve ended up here in this hell, these hallways, that means you fucking screwed up.</li> \
	<li>These hallways are cruel and unforgiving- yet, kind and gentle when you are at youre worst, so here are some tips to help you get through things. Because ive been here for a long time.</li> \
	<li>First things first, the red lights, if you see red lights at a door- fucking think twice before opening it, like the meaning most associated with the color RED it means BAD, but risk equals reward so take it at your own risk.</li> \
	<li>Second thing is situational awareness, most things here- are not as they seem, if you see corpses near a door theres probably a fucking demon behind it or some fuckoff anomaly-</li> \
	<li>This tends to scale with the number of corpses (fucking obviously), something we found out in my squad is that the remains, have no DNA but the corpses do, its like if the remains are a</li> \
	<li>warning from this place itself rather than former corpses of the living meanwhile the corpses are- just that.</li> \
	<li>Third things last- take things slow, this place tends to be forgiving if you are slow, you wont die, if you see a red light and want to take it on, plan out a course</li> \
	<li>to run to in case you need space to shoot them down while theyre chasing you- make sure to take note of where dead ends are and where the doors are too, i reccomend</li> \
	<li>bolting the doors open as that way you wont lose precious time running from -it- from having to stop and re-open doors. Also, dont listen to the Void, I learnt that quickly. It likes to pretend to be your loved ones.</li>"

/obj/item/clothing/accessory/armband/gift_of_the_void
	name = "incrementum"
	color = "#000000"
	desc = "A completely normal armband, but its black, you feel safe putting it on"

/obj/item/clothing/accessory/armband/gift_of_the_void/accessory_equipped(obj/item/clothing/under/clothes, mob/living/user)
	user.add_mood_event("locked in", /datum/mood_event/locked_in)

/obj/item/clothing/accessory/armband/gift_of_the_void/accessory_dropped(obj/item/clothing/under/clothes, mob/living/user)
	user.clear_mood_event("locked in")

/datum/mood_event/locked_in
	description = "My mind feels secure. It was worth it."
	mood_change = 31

/obj/effect/baseturf_helper/beach/black
	name = "beach sand baseturf editor"
	baseturf = /turf/open/floor/black
