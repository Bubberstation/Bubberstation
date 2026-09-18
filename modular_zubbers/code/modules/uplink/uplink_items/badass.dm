/datum/uplink_item/badass/plushie
	name = "Syndicate Support Plushie"
	desc = "For agents in the field requiring urgent emotional support."
	item = /obj/item/toy/plush/nukeplushie
	cost = 1
	uplink_item_flags = NONE

/datum/uplink_item/badass/medalbox
	name = "Syndicate Medal Box"
	desc = "For Nuclear Leaders wanting to reward their Crew. Or helping collaborators. Access not included."
	item = /obj/item/storage/lockbox/medal/bubber/synd
	cost = 1
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/flag
	name = "Syndicate Flag"
	desc = "For those agents too lazy to get some cloth. They hung out the flag of war."
	item = /obj/item/sign/flag/syndicate
	cost = 1
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/badass/henchmen_traitor_outfits
	name = "Henchmen Bundle"
	desc = "A set of five armored henchmen outfits! Each set comes with a cap, coat, uniform, gloves, shoes, and a switchblade!"
	item = /obj/item/storage/backpack/duffelbag/henchmen_traitor_outfits
	cost = 4

/datum/uplink_item/badass/foam_sword_traitor
	name = "Lead-cored Foam Force Claymore"
	desc = "Looks just like the toy! Filled with lead! Deflect blows (sometimes)! Not usable as a bludgeon."
	item = /obj/item/foam_baton/sword/traitor
	cost = 2
	surplus = 50
	cant_discount = TRUE
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
