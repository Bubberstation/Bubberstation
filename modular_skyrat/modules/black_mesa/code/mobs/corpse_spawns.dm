// Corpse definitions for Black Mesa NPCs

/obj/effect/mob_spawn/corpse/human/hecu
	name = "HECU Corpse"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/hecu_corpse

/obj/effect/mob_spawn/corpse/human/hecu_ranged
	name = "HECU Ranged Corpse"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/hecu_ranged_corpse

/obj/effect/mob_spawn/corpse/human/hecu_smg
	name = "HECU SMG Corpse"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/hecu_smg_corpse

/obj/effect/mob_spawn/corpse/human/security_guard
	name = "Security Guard Corpse"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/security_guard_corpse

/obj/effect/mob_spawn/corpse/human/security_guard/ranged
	name = "Armed Security Guard Corpse"
	outfit = /datum/outfit/security_guard_ranged_corpse

/obj/effect/mob_spawn/corpse/human/black_ops
	name = "Black Ops Corpse"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/black_ops_corpse

/obj/effect/mob_spawn/corpse/human/black_ops/ranged
	name = "Armed Black Ops Corpse"
	outfit = /datum/outfit/black_ops_ranged_corpse

// Outfits for corpses
/datum/outfit/hecu_corpse
	name = "HECU Grunt"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	suit = /obj/item/clothing/suit/armor/vest/hecu
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/hecu

/datum/outfit/hecu_ranged_corpse
	name = "HECU Ranged"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	suit = /obj/item/clothing/suit/armor/vest/hecu
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/hecu
	l_pocket = /obj/item/ammo_box/magazine/m50

/datum/outfit/hecu_smg_corpse
	name = "HECU SMG"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	suit = /obj/item/clothing/suit/armor/vest/hecu
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/hecu
	l_pocket = /obj/item/ammo_box/magazine/smgm45

/datum/outfit/security_guard_corpse
	name = "Black Mesa Security"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/helmet/blueshirt

/datum/outfit/security_guard_ranged_corpse
	name = "Armed Black Mesa Security"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/helmet/blueshirt
	l_pocket = /obj/item/ammo_box/magazine/c35sol_pistol

/datum/outfit/black_ops_corpse
	name = "Black Ops"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/alt
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas/sechailer
	head = /obj/item/clothing/head/helmet/swat
	back = /obj/item/storage/backpack/security

/datum/outfit/black_ops_ranged_corpse
	name = "Armed Black Ops"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/alt
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas/sechailer
	head = /obj/item/clothing/head/helmet/swat
	back = /obj/item/storage/backpack/security
	l_pocket = /obj/item/ammo_box/magazine/c40sol_rifle
