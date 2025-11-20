//Title Capitalization for names please!!!

/datum/loadout_item/accessory/armband
	abstract_type = /datum/loadout_item/accessory/armband
	group = "Armbands"

/datum/loadout_item/accessory/armband/med/blue
	name = "Blue-White Armband"
	item_path = /obj/item/clothing/accessory/armband/medblue/nonsec

/datum/loadout_item/accessory/armband/med
	name = "White Armband"
	item_path = /obj/item/clothing/accessory/armband/med/nonsec

/datum/loadout_item/accessory/armband/cargo
	name = "Brown Armband"
	item_path = /obj/item/clothing/accessory/armband/cargo/nonsec

/datum/loadout_item/accessory/armband/engineering
	name = "Orange Armband"
	item_path = /obj/item/clothing/accessory/armband/engine/nonsec

/datum/loadout_item/accessory/armband/blue
	name = "Blue Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy/lopland/nonsec

/datum/loadout_item/accessory/armband/security
	name = "Security Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy/lopland
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/armband/security/deputy
	name = "Security Deputy Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/armband/science
	name = "Purple Armband"
	item_path = /obj/item/clothing/accessory/armband/science/nonsec

//No red armband for obvious reasons.

/*
*	MISC
*/

/datum/loadout_item/accessory/heirloom
	abstract_type = /datum/loadout_item/accessory/heirloom
	group = "Heirlooms and Badges"

/datum/loadout_item/accessory/heirloom/bone_charm
	name = "Heirloom Bone Talisman"
	item_path = /obj/item/clothing/accessory/talisman/armourless

/datum/loadout_item/accessory/heirloom/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/skullcodpiece/armourless

/datum/loadout_item/accessory/heirloom/sinew_kilt
	name = "Heirloom Sinew Skirt"
	item_path = /obj/item/clothing/accessory/skilt/armourless

/datum/loadout_item/accessory/heirloom/holobadge
	name = "Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo

/datum/loadout_item/accessory/heirloom/holobadge/cord
	name = "Holobadge with Lanyard"
	item_path = /obj/item/clothing/accessory/badge/holo/cord

/datum/loadout_item/accessory/heirloom/dogtags
	name = "Dogtags"
	item_path = /obj/item/clothing/accessory/dogtags

/datum/loadout_item/accessory/heirloom/mercbadge
	name = "Jade Badge"
	item_path = /obj/item/clothing/accessory/badge/holo/jade
	//ckeywhitelist = list("konstyantyn")

/*
*
* Accessory Medals
*
*/
/datum/loadout_item/accessory/medal
	abstract_type = /datum/loadout_item/accessory/medal
	group = "Medals"

/datum/loadout_item/accessory/medal/fake_medal
	name = "Fake Medal"
	item_path = /obj/item/clothing/accessory/fake/medal

/datum/loadout_item/accessory/medal/shield
	name = "Medal - Shield"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/shield

/datum/loadout_item/accessory/medal/shield_br
	name = "Medal - Shield (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/shield/bar_ribbon

/datum/loadout_item/accessory/medal/shield_h
	name = "Medal - Shield (Hollow)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/shield/hollow

/datum/loadout_item/accessory/medal/bar
	name = "Medal - Bar"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/bar

/datum/loadout_item/accessory/medal/bar_br
	name = "Medal - Bar (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/bar/bar_ribbon

/datum/loadout_item/accessory/medal/bar_h
	name = "Medal - Bar (Hollow)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/bar/hollow

/datum/loadout_item/accessory/medal/circle
	name = "Medal - Circle"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/circle

/datum/loadout_item/accessory/medal/circle_br
	name = "Medal - Circle (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/circle/bar_ribbon

/datum/loadout_item/accessory/medal/circle_alt
	name = "Medal - Circle (Alt)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal
	//This is actually the default setup for our medals!

/datum/loadout_item/accessory/medal/circle_h
	name = "Medal - Circle (Hollow)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/circle/hollow

/datum/loadout_item/accessory/medal/circle_h_br
	name = "Medal - Circle (Hollow, Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/circle/hollow/bar_ribbon

/datum/loadout_item/accessory/medal/heart
	name = "Medal - Heart"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/heart

/datum/loadout_item/accessory/medal/heart_br
	name = "Medal - Heart (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/heart/bar_ribbon

/datum/loadout_item/accessory/medal/heart_s
	name = "Medal - Heart (Special)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/heart/special

/datum/loadout_item/accessory/medal/heart_s_br
	name = "Medal - Heart (Special, Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/heart/special/bar_ribbon

/datum/loadout_item/accessory/medal/crown
	name = "Medal - Crown"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/crown

/datum/loadout_item/accessory/medal/crown_br
	name = "Medal - Crown (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/crown/bar_ribbon

/datum/loadout_item/accessory/medal/crown_h
	name = "Medal - Crown (Hollow)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/crown/hollow

/datum/loadout_item/accessory/medal/crown_h_br
	name = "Medal - Crown (Hollow, Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/crown/hollow/bar_ribbon

/datum/loadout_item/accessory/medal/rankpin_star
	name = "Rankpin (Star)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/rankpin

/datum/loadout_item/accessory/medal/rankpin_bar
	name = "Rankpin (Bar)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/rankpin/bar

/datum/loadout_item/accessory/medal/rankpin_twobar
	name = "Rankpin (Double Bars)"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/rankpin/two_bar

/datum/loadout_item/accessory/medal/kiara
	name = "Insignia of Steele"
	item_path = /obj/item/clothing/accessory/medal/steele
	//ckeywhitelist = list("inferno707")

/*
* Special Pins
*/

/datum/loadout_item/accessory/medal/cc_pin
	name = "Neckpin - CentCom"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom
	restricted_roles = list(JOB_NT_REP, JOB_CAPTAIN, JOB_BLUESHIELD)

/datum/loadout_item/accessory/medal/nt_pin
	name = "Neckpin - Nanotrasen"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/neckpin

/datum/loadout_item/accessory/medal/pt_pin
	name = "Neckpin - Port Tarkon"
	item_path = /obj/item/clothing/accessory/bubber/acc_medal/neckpin/porttarkon

