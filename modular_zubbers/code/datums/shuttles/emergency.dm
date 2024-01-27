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
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
