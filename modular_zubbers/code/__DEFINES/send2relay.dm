#define US_EAST_RELAY "byond://useast.bubberstation.org:3000"
#define US_WEST_RELAY "byond://uswest.bubberstation.org:3000"
#define SYDNEY_RELAY "byond://sydney.bubberstation.org:3000"
#define SINGAPORE_RELAY "byond://singapore.bubberstation.org:3000"
#define EU_RELAY "byond://germany.bubberstation.org:3000"
#define NO_RELAY "byond://direct.bubberstation.org:3000"

/client/verb/go2relay()
	var/list/static/relays = list(
		US_EAST_RELAY = "Connect to Eastern US (Virginia)",
		US_WEST_RELAY = "Connect to Western US (Oregon)",
		SYDNEY_RELAY = "Connect to Australia (Sydney)",
		SINGAPORE_RELAY = "Connect to Singapore (Singapore)",
		EU_RELAY = "Connect to Germany (Frankfurt)",
		NO_RELAY = "No Relay (Direct Connect)",
	)
	var/choice = tgui_input_list(usr, "Which relay do you wish to use?", "Relay Select", relays)
	if(choice)
		usr << link(choice)
		sleep(1 SECONDS)
		winset(usr, null, "command=.quit")
	else
		usr << "You didn't select a relay."
