// All processed hepothermia areas
GLOBAL_LIST_INIT(hypothermia_areas, list())
GLOBAL_LIST_INIT(hear_sources, list())



/// -15degC
#define TM15C 258.15
/// -30degC
#define TM30C 243.15
/// -40degC
#define TM40C 233.15
/// -70degC
#define TM70C 203.15
/// -90degC
#define TM90C 183.15
/// -130degC
#define TM130C 143.15
/// -150degC
#define TM150C 123.15



#define AREA_TRAIT_NOWEATHER_EFFECT "area_no_weather_overlay"
#define AREA_TRAIT_SUNLIGHT "area_sunlight"



#define COMSIG_MOB_HEAT_SOURCE_ACT "mob_heat_source"


#define MAJOR_ANNOUNCEMENT_TEXT(string) ("<span class='major_announcement_text'>" + string + "</span>")
#define CHAT_ALERT_COLORED_SPAN(color, string) ("<div class='chat_alert_" + color + "'>" + string + "</div>")

/proc/speaker_announce(message, prefix = "...From the speakers comes", sound, color = "default", list/mob/players = GLOB.player_list, encode = TRUE)
	if(!message)
		return

	if(encode)
		message = html_encode(message)

	var/announcement_text = MAJOR_ANNOUNCEMENT_TEXT(prefix + " " + message)
	var/final_announcement = CHAT_ALERT_COLORED_SPAN(color, announcement_text)

	var/sound_to_play = sound ? sound : SSstation.announcer.get_rand_alert_sound()
	dispatch_announcement_to_players(final_announcement, players, sound_to_play)

#undef MAJOR_ANNOUNCEMENT_TEXT
#undef CHAT_ALERT_COLORED_SPAN
