/*
	Bubberstation body markings
	Body marking code is in modular_skyrat/[...]/new_player/body_markings.dm
*/

/datum/body_marking/bubber
	icon = 'modular_zubbers/icons/customization/body_markings/markings.dmi'
	default_color = "#000000"
	recommended_species = null

/datum/body_marking/bubber/facedisc
	name = "Face Disc"
	icon_state = "facedisc"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/facemask
	name = "Facemask"
	icon_state = "facemask"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/verticalstripe
	name = "Vertical Stripe"
	icon_state = "verticalstripe"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/lips
	name = "Lips"
	icon_state = "lips"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/fangs
	name = "Fangs"
	icon_state = "fangs"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/deer //Sprites by AP Will on Sojourn :)
	name = "Deer Snout (Marking)"
	icon_state = "deer"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/anime_inner
	name = "Anime Eyes (Inner)"
	icon_state = "eyesinner"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/anime_outer
	name = "Anime Eyes (Outer)"
	icon_state = "eyesouter"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/clowncross
	name = "Clown Cross"
	icon_state = "clowncross"
	affected_bodyparts = HEAD
	gendered = FALSE

/datum/body_marking/bubber/clownlips
	name = "Clown Lips"
	icon_state = "clownlips"
	affected_bodyparts = HEAD
	gendered = FALSE

/datum/body_marking/bubber/cyclopssclera
	name = "Cyclops Sclera"
	icon_state = "cyclopssclera"
	affected_bodyparts = HEAD
	gendered = FALSE

/datum/body_marking/bubber/longsock
	name = "Longsock"
	icon_state = "longsock"
	affected_bodyparts = LEG_LEFT | LEG_RIGHT

/datum/body_marking/bubber/sock //NO FEET FIX
	name = "Sock"
	icon_state = "sock"
	affected_bodyparts = LEG_LEFT | LEG_RIGHT

/datum/body_marking/bubber/sleeve
	name = "Sleeve"
	icon_state = "sleeve"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT

/datum/body_marking/bubber/glove
	name = "Glove"
	icon_state = "glove"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT

/datum/body_marking/bubber/shoulder
	name = "Shoulder"
	icon_state = "shoulder"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT

/datum/body_marking/bubber/elbow
	name = "Elbow"
	icon_state = "elbow"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT

/datum/body_marking/bubber/hip
	name = "Hip"
	icon_state = "hip"
	affected_bodyparts = LEG_LEFT | LEG_RIGHT

/datum/body_marking/bubber/chestplate
	name = "Chestplate"
	icon_state = "chestplate"
	affected_bodyparts = CHEST
	gendered = FALSE

/datum/body_marking/bubber/monster2_mouth
	name = "Monster Mouth (White)"
	icon_state = "monster2"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/monster3_mouth
	name = "Monster Mouth (White, eyes-compatible)"
	icon_state = "monster3"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/weight2
	name = "Body Weight (Greyscale)"
	icon_state = "weight2"
	default_color = DEFAULT_PRIMARY
	affected_bodyparts = CHEST

/datum/body_marking/bubber/bellybutton //a literal pixel addition
	icon_state = "bellybutton"
	name = "Belly Button"
	default_color = DEFAULT_PRIMARY
	affected_bodyparts = CHEST
	gendered = FALSE

/datum/body_marking/bubber/bellymonster
	icon_state = "bellymonster"
	name = "Belly Monster"
	default_color = "#CCCCCC"
	affected_bodyparts = CHEST
	gendered = FALSE

/datum/body_marking/bubber/bellymonster_alt
	icon_state = "bellymonster_alt"
	name = "Belly Monster (Alt)"
	default_color = "#CCCCCC"
	affected_bodyparts = CHEST
	gendered = FALSE

/* /datum/body_marking/bubber/talons //still no digitigrade feet fix
	icon_state = "talon"
	affected_bodyparts = LEG_LEFT | LEG_RIGHT
*/

/datum/body_marking/bubber/cleavage
	icon_state = "cleavage"
	name = "Cleavage"
	default_color = "#ffffff"
	affected_bodyparts = CHEST
	gendered = FALSE

/datum/body_marking/bubber/thirdeye //we love 1 pixel
	icon_state = "thirdeye"
	name = "Third Eye"
	default_color = "#FFFFFF"
	affected_bodyparts = HEAD
	gendered = FALSE

/datum/body_marking/bubber/splotches //Sprites by Avimour
	name = "Splotches"
	icon_state = "splotches"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/bubber/splotcheswap
	name = "Splotches Swapped"
	icon_state = "splotcheswap"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/chitin //End of sprites by Avimour
	name = "Chitin"
	icon_state = "chitin"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/bubber/dome //Sprites by thgvr
	icon_state = "dome"
	name = "Dome"
	default_color = "#FFFFFF"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/topscars_1
	icon_state = "topscars_1"
	name = "Top Scar Variant 1"
	affected_bodyparts = CHEST
	default_color = "#FFFFFF"
	gendered = FALSE

/datum/body_marking/bubber/topscars_2
	icon_state = "topscars_2"
	name = "Top Scar Variant 2"
	affected_bodyparts = CHEST
	default_color = "#FFFFFF"
	gendered = FALSE

/datum/body_marking/bubber/talleyes
	icon_state = "talleyes"
	name = "Tall Eyes"
	default_color = "#FFFFFF"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/wideeyes
	icon_state = "wideeyes"
	name = "Wide Eyes"
	default_color = "#FFFFFF"
	affected_bodyparts = HEAD

/datum/body_marking/bubber/angledeyes
	icon_state = "angledeyes"
	name = "Angled Eyes"
	default_color = "#FFFFFF"
	affected_bodyparts = HEAD
