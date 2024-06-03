/datum/loadout_item/shoes/lace_heels
	name = "Elegant Heels"
	item_path = /obj/item/clothing/shoes/heels/drag/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/shoes/glow
	name = "glow shoes"
	item_path = /obj/item/clothing/shoes/glow

/datum/loadout_item/shoes/clown/pink //Unlike the rest, these make noise. Job locked.
	name = "Pink Clown Heels"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/clussy
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/clown/jester/amazing
	name = "Pink Clown Heels"
	item_path = /obj/item/clothing/shoes/clown_shoes/bubber/jester
	restricted_roles = list(JOB_CLOWN)


/datum/loadout_item/shoes/rax_armadyne_boots
	restricted_roles = list(JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CORRECTIONS_OFFICER)
//Every other item in this set is role restricted, and it's like they forgot the boots.
//I don't think anyone on Skyrat noticed because this is ckey whitelisted there.

/datum/loadout_item/shoes/latex_heels
	name = "latex heels"
	item_path = /obj/item/clothing/shoes/latex_heels
