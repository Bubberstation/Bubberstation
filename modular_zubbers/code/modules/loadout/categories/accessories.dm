//Title Capitalization for names please!!!

/datum/loadout_item/accessory/fake_medal
	name = "Fake Medal"
	item_path = /obj/item/clothing/accessory/fake/medal

/datum/loadout_item/accessory/holobadge
	name = "Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo

/datum/loadout_item/accessory/holobadge_cord
	name = "Holobadge with Lanyard"
	item_path = /obj/item/clothing/accessory/badge/holo/cord

/datum/loadout_item/accessory/dogtags
	name = "Dogtags"
	item_path = /obj/item/clothing/accessory/dogtags

/*
*
* Accessory Medals
*
*/
/datum/loadout_item/accessory/medal
	abstract_type = /datum/loadout_item/accessory/medal
	group = "Medals"

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

