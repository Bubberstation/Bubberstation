/obj/effect/mob_spawn/ghost_role/human/tarkon
	name = "Port Tarkon Crew Member"
	prompt_name = "a port deck worker"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a member of Tarkon Industries, recently assigned to a recently recovered asset known as Port Tarkon. Your supervisors are the Ensign and Site Director."
	flavour_text = "On the recently reclaimed Port Tarkon, You are tasked to help finish construction and carry on any tasks given by the site director. It may be best to look at your departmental noteboard. (OOC note: This ghost role was not designed with Plasmamen or Vox in mind. While there are some accommodations so that they can survive, it should be noted that they were not the focal point whilst designing Port Tarkon. The closet in the middle of the room above contains the 'accommodations' for those species.)"
	important_text = "You are not to abandon Port Tarkon. Check other sleepers for alternative jobs. Listen to the Site Director and Ensign."
	outfit = /datum/outfit/tarkon
	faction = list(FACTION_TARKON)
	spawner_job_path = /datum/job/tarkon
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE
	computer_area = /area/ruin/space/has_grav/port_tarkon/centerhall
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/tarkon/cargo
	name = "Port Tarkon Supply Crew Member"
	prompt_name = "a port salvage tech"
	outfit = /datum/outfit/tarkon/cargo

/obj/effect/mob_spawn/ghost_role/human/tarkon/sci
	name = "Port Tarkon Research Crew Member"
	prompt_name = "a port researcher"
	outfit = /datum/outfit/tarkon/sci

/obj/effect/mob_spawn/ghost_role/human/tarkon/service
	name = "Port Tarkon Service Crew Member"
	prompt_name = "a port tarkon chef, and janitor"
	outfit = /datum/outfit/tarkon/service

/obj/effect/mob_spawn/ghost_role/human/tarkon/med
	name = "Port Tarkon Medical Crew Member"
	prompt_name = "a port trauma medic"
	outfit = /datum/outfit/tarkon/med

/obj/effect/mob_spawn/ghost_role/human/tarkon/engi
	name = "Port Tarkon Engineering Crew Member"
	prompt_name = "a port maintenance engineer"
	outfit = /datum/outfit/tarkon/engi

/obj/effect/mob_spawn/ghost_role/human/tarkon/sec
	name = "Port Tarkon Security Crew Member"
	prompt_name = "a port security member"
	outfit = /datum/outfit/tarkon/sec

/obj/effect/mob_spawn/ghost_role/human/tarkon/ensign
	name = "Port Tarkon Ensign"
	prompt_name = "an abandoned ensign"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-o"
	you_are_text = "You were tasked by Tarkon Industries to Port Tarkon as a low-level command member. Your superior is the site director."
	flavour_text = "Second in command, you are usually tasked with outward missions with other tarkon members while the site director stays at the port. (OOC note: This ghost role was not designed with Plasmamen or Vox in mind. While there are some accommodations so that they can survive, it should be noted that they were not the focal point whilst designing Port Tarkon. The closet in the middle of the room above contains the 'accommodations' for those species.)"
	important_text = "You are not to abandon Port Tarkon without reason. You are allowed to travel within available Z-levels and to the station, and are allowed to hold exploration parties."
	outfit = /datum/outfit/tarkon/ensign
	spawner_job_path = /datum/job/tarkon

/obj/effect/mob_spawn/ghost_role/human/tarkon/director
	name = "Port Tarkon Site Director"
	prompt_name = "a port site director"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a newly assigned Site Director for Port Tarkon. Your superiors are none except the will of yourself and Tarkon Industries."
	flavour_text = "On the recently reclaimed Port Tarkon, You are tasked with overlooking your crew and keeping the port up and running. (OOC note: This ghost role was not designed with Plasmamen or Vox in mind. While there are some accommodations so that they can survive, it should be noted that they were not the focal point whilst designing Port Tarkon. The closet in the middle of the room above contains the 'accommodations' for those species.)"
	important_text = "You are not to abandon Port Tarkon. Check other sleepers for alternative jobs."
	outfit = /datum/outfit/tarkon/director
	spawner_job_path = /datum/job/tarkon
