/datum/loadout_item/shoes/lace_heels
	name = "Elegant Heels"
	item_path = /obj/item/clothing/shoes/heels/drag/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/shoes/glow
	name = "glow shoes"
	item_path = /obj/item/clothing/shoes/glow

/datum/loadout_item/shoes/bubber/clown/pink/squeak //Unlike the rest, these make noise. Job locked.
	name = "Pink Clown Heels"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/clussy
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/bubber/clown/pink/mute //Less silly = Unrestricted
	name = "Squeakless Pink Clown Heels"
	item_path = /obj/item/clothing/shoes/latex_heels/bubber/clussy/mute

/datum/loadout_item/shoes/bubber/clown/jester/amazing
	name = "Striped Jester Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/jester
	restricted_roles = list(JOB_CLOWN)


/datum/loadout_item/shoes/rax_armadyne_boots
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CORRECTIONS_OFFICER)
//Every other item in this set is role restricted, and it's like they forgot the boots.
//I don't think anyone on Skyrat noticed because this is ckey whitelisted there.

/datum/loadout_item/shoes/latex_heels
	name = "latex heels"
	item_path = /obj/item/clothing/shoes/latex_heels

/datum/loadout_item/shoes/diver //Donor item for patriot210
	name = "Black Divers Boots"
	item_path = /obj/item/clothing/shoes/boots/diver
	ckeywhitelist = list("sexmaster", "leafydasurvivor")
