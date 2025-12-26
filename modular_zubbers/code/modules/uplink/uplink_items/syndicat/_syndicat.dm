//Just the ears alone
/datum/uplink_item/implant/super_kitty_ears
	name = "Super Syndie-Kitty Ears"
	desc = "Developed by several Interdyne Pharmaceutics scientists and Wizard Federation archmages during a record-breaking rager, \
			this set of feline ears combines the finest of bio-engineering and thamaturgy to allow the user to transform to and from a genetically modified cat at will, \
			granting them all the benefits (and downsides) of being a true genetically modified feline, such as ventcrawling. \
			However, this form will be clad in blood-red Syndicate armor, making its origin somewhat obvious."
	purchasable_from = ~(UPLINK_CLOWN_OPS)
	item = /obj/item/organ/ears/cat/super/syndie
	cost = 16
	surplus = 15
	limited_stock = 1
	progression_minimum = 15 MINUTES

/datum/uplink_item/dangerous/syndicat
	name = "Syndie cat grenade"
	desc = "This grenade is filled with 3 trained angry cats in special syndicate modsuits. Upon activation, the Syndicate cats are awoken and unleashed unto unlucky bystanders."
	item = /obj/item/grenade/spawnergrenade/cat/syndicate
	cost = 12
	surplus = 5
	purchasable_from = ~(UPLINK_CLOWN_OPS)
	progression_minimum = 30 MINUTES

/obj/item/grenade/spawnergrenade/cat/syndicate
	name = "Syndicatnade"
	desc = "You can hear aggressive meowing and the sounds of sharpened claws on metal coming from within."
	spawner_type = /mob/living/basic/pet/cat/syndicat
	deliveryamt = 3
