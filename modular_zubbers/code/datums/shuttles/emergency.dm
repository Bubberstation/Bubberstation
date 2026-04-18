/datum/map_template/shuttle/emergency/meteor
	prefix = "_maps/shuttles/zubbers/"
	suffix = "cube"
	name = "THE CUBE"
	description = "A massive 16x16 solid chunk of metal with a bunch of engines strapped to it. The thing flies like shit so expect it to crash into departures. All worth it for THE CUBE."
	admin_notes = "This shuttle will crush escape, killing anyone there. Also a huge bitch to get in and requires people to actually break through several metal walls."
	credit_cost = CARGO_CRATE_VALUE * 30
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	occupancy_limit = "4^3"
	emag_only = TRUE

/datum/map_template/shuttle/emergency/burgerstation
	prefix = "_maps/shuttles/zubbers/"
	suffix = "moonstation"
	name = "Moon Station Emergency Shuttle"
	description = "A shuttle that is just as malformed as the station it's designed for. The Millennium Patty emergency shuttle will probably leave you wanting less. Comes with a decent medbay and a luxury section."
	admin_notes = "Comes with a first class paywalled section, as well as its own in-flight entertainment and catering staff! Bardrone, Barmaid, and Clown are GODMODE, will be automatically sentienced by the fun balloon at 60 seconds before arrival."
	credit_cost = CARGO_CRATE_VALUE * 25
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/imfedupwiththisworld
	prefix = "_maps/shuttles/zubbers/"
	suffix = "imfedupwiththisworld"
	name = "How's your sex life?"
	description = "You can love someone deep inside your heart, and there is nothing wrong with it. If a lot of people love each other, the world would be a better place to live."
	admin_notes = "Cramped, made out of wood, and very susceptible to breaches given the single wooden airlock. What could possibly go wrong?"
	occupancy_limit = "5"
	emag_only = TRUE
	credit_cost = 4988
	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)

/datum/map_template/shuttle/emergency/lance/New()
	. = ..()
	if(SSmapping.current_map.map_name == "Moon Station")
		who_can_purchase = null

/datum/map_template/shuttle/emergency/vortex
	prefix = "_maps/shuttles/zubbers/"
	suffix = "vortex"
	name = "Vortex-Class Luxury Evacuation Shuttle"
	description = "A mildly luxurious evac shuttle that gives fulfills every crew's desire, from free coffee, to free cigarettes, as well as advanced tools distributed to each department's rooms, such as advanced tools, advanced meds, as well as department protolathes, even Command's own E.V.A. storage, holding a spare unique MODsuit for each Head of Staff, not to mention the atmospherics, and shocked grille built-in support, as well as two Authentication devices for mobile Code-Red's! Fly home with elegancy."
	admin_notes = "A shuttle that has it's own protolathes, as well as severely upgraded tools, and gear. A very luxurious evacuation shuttle, with no drawbacks. Two Authentication Devices, spare Head of Staff MOD's, gives NTC a Corporate MOD, gives Blueshield a Asset Protection MOD, atmospherics, shocked grilles, Gives everyone what they need while leaving a burning heap of a station, or just getting off from a nice calm shift."
	credit_cost = CARGO_CRATE_VALUE * 625
	occupancy_limit = "65"

/datum/map_template/shuttle/emergency/gorilla2
	prefix = "_maps/shuttles/zubbers/"
	suffix = "gorilla2"
	name = "Gorilla Cargo Freighter Mark 2"
	description = "Due to (un)popular demand that may (or may not) exist, along with a small fee, this freighter has been recommissioned to be your escape shuttle. A rustic, barely excuseable shuttle transporting important cargo. Not for crew who are about to go ape. Note: Please do not provoke the cargo."
	admin_notes = "Trashy shuttle covered in rust. Random maints loot spawns in the cargo bay. The gorillas have the 'hostile' faction and are shut in the back half of the bay, but given enough time with a crew member in sight, they'll break down the plasma windows."
	credit_cost = CARGO_CRATE_VALUE * 5
	occupancy_limit = "25 + 15"
	emag_only = TRUE

/datum/map_template/shuttle/emergency/foxferry
	prefix = "_maps/shuttles/zubbers/"
	suffix = "foxferry"
	name = "Jumbo Fox-Class Evacuation Ferry"
	description = "A super-sized version of the much, much, smaller Fox-class ferry pod, this comfortable and unarmed Syndicate transport features ample seating and some syndicate supplies, along with brand merchandise and logo placement. Contains a small atmospherics system within the engine room and electrified grilles. The Syndicate is not responsible for any injuries or incidents that may occur after purchasing this shuttle."
	admin_notes = "Reasonably sized, round, and somewhat expensive shuttle. Has a small amount of traitor and syndicate branded items in the public area and a few contraband items locked away in lockers and crates. Beware the energy axe."
	credit_cost = CARGO_CRATE_VALUE * 250
	occupancy_limit = "50"
	emag_only = TRUE

/datum/map_template/shuttle/emergency/pod_cluster
	prefix = "_maps/shuttles/zubbers/"
	suffix = "pod_cluster"
	name = "A Cluster of Escape Pods"
	description = "We couldn't get a proper shuttle for you, so instead we took a bunch of the escape pods that everyone seems to like and strapped them together with lattice. It ain't pretty, but hey, at least it was cheap."
	admin_notes = "No air between pods. Command pod is slightly longer to fit the console. Funny idea courtesy of a friend."
	credit_cost = CARGO_CRATE_VALUE * 1.5
	occupancy_limit = "36"

/datum/map_template/shuttle/emergency/stockade
	prefix = "_maps/shuttles/zubbers/"
	suffix = "stockade"
	name = "Breacher-Class Stockade Shuttle"
	description = "This older Nanotrasen Breacher-class Stockade Shuttle makes up for it's lack of shields and advanced technologies with absolute heft and durability. Sporting an incredibly up-armored hull, laser defence turrets and an asteroid plow, there's not much that's going to get through this beast of a ship."
	admin_notes = "Big and chonky, where every door is a secure door. Features turrets used on the Raven shuttle. Not terribly special otherwise."
	credit_cost = CARGO_CRATE_VALUE * 125
	occupancy_limit = "80"
