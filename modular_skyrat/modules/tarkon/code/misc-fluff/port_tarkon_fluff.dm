// Engine based key doors
/obj/machinery/door/puzzle/keycard/rnd
	name = "R&D Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has purple markings on it."
	puzzle_id = "tarkon1"

/obj/machinery/door/puzzle/keycard/engi
	name = "Engineering Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has orange markings on it."
	puzzle_id = "tarkon2"

/obj/machinery/door/puzzle/keycard/med
	name = "Medical Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has blue markings on it."
	puzzle_id = "tarkon3"

/obj/machinery/door/puzzle/keycard/vault
	name = "Vault Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has black markings on it."
	puzzle_id = "tarkon4"

// End Engine based key doors

// Engine based Door Keys

/obj/item/keycard/tarkon_rnd
	name = "Research keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#a03aaf"
	puzzle_id = "tarkon1"

/obj/item/keycard/tarkon_engi
	name = "Engineering keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#f05812"
	puzzle_id = "tarkon2"

/obj/item/keycard/tarkon_med
	name = "Medical keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#33d4ff"
	puzzle_id = "tarkon3"

/obj/item/keycard/tarkon_vault
	name = "Vault keycard"
	desc = "Tarkon industries secure storage lock key."
	color = "#303030"
	puzzle_id = "tarkon4"

// End Engine based door keys

/mob/living/basic/alien/drone/tarkon
	basic_mob_flags = DEL_ON_DEATH

// JOB SPECIFIC VAULT KEYS

/obj/item/keycard/tarkon_job_med
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Medical Secure Storage'"
	color = "#33d4ff"
	puzzle_id = "tarkon_vaultmed"

/obj/item/keycard/tarkon_job_sec
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Security Secure Storage'"
	color = "#C70039"
	puzzle_id = "tarkon_vaultsec"

/obj/item/keycard/tarkon_job_engi
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Engineering Secure Storage'"
	color =  "#FFC300"
	puzzle_id = "tarkon_vaultengi"

/obj/item/keycard/tarkon_job_rnd
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Research Secure Storage'"
	color = "#a207b9"
	puzzle_id = "tarkon_vaultrnd"

/obj/item/keycard/tarkon_job_supply
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Supply Secure Storage'"
	color = "#9e5d06"
	puzzle_id = "tarkon_vaultsupply"

/obj/item/keycard/tarkon_job_command
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Command Secure Storage'"
	color = "#1b50d5"
	puzzle_id = "tarkon_vaultcommand"

/obj/item/keycard/tarkon_job_ensign
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Ensign Secure Storage'"
	color = "#1b50d5"
	puzzle_id = "tarkon_vaultensign"

/obj/item/keycard/tarkon_job_service
	name = "Personal keycard"
	desc = "Tarkon industries secure storage lock key. This one has a label reading 'Service Secure Storage'"
	color = "#1cac40"
	puzzle_id = "tarkon_vaultservice"

// End job specific vault keys

// JOB SPECIFIC VAULT DOORS
/obj/machinery/door/puzzle/keycard/personal_med
	name = "Personal Medical Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has blue markings on it."
	puzzle_id = "tarkon_vaultmed"

/obj/machinery/door/puzzle/keycard/personal_sec
	name = "Personal Security Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has red markings on it."
	puzzle_id = "tarkon_vaultsec"

/obj/machinery/door/puzzle/keycard/personal_engi
	name = "Personal Engineering Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has orange markings on it."
	puzzle_id = "tarkon_vaultengi"

/obj/machinery/door/puzzle/keycard/personal_rnd
	name = "Personal Science Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has purple markings on it."
	puzzle_id = "tarkon_vaultrnd"

/obj/machinery/door/puzzle/keycard/personal_supply
	name = "Personal Supply Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has brown markings on it."
	puzzle_id = "tarkon_vaultsupply"

/obj/machinery/door/puzzle/keycard/personal_command
	name = "Personal Command Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has blue and gold markings on it."
	puzzle_id = "tarkon_vaultcommand"

/obj/machinery/door/puzzle/keycard/personal_ensign
	name = "Personal Ensign Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has blue and red markings on it."
	puzzle_id = "tarkon_vaultensign"

/obj/machinery/door/puzzle/keycard/personal_service
	name = "Personal Service Secure Airlock"
	desc = "Tarkon industries secure storage lock. This one has dark green markings on it."
	puzzle_id = "tarkon_vaultservice"

// End job specific vault doors
