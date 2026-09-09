/mob/living/basic/pet/syndifox/mini
	name = "Syni-Fox"
	desc = "It's a Cybersun MiniVix robotic model wearing a microsized syndicate MODsuit and a cute little cap. Quite pretty. This one looks a bit more mini."
	initial_size = 0.8
	faction = list(FACTION_NEUTRAL)

/mob/living/basic/pet/syndifox/mini/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_access, ACCESS_SYNDICATE)
