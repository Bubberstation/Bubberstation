
/obj/effect/mob_spawn/corpse/human/damaged/h1132
	name = "frozen colonist"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	skin_tone = "caucasian1"
	outfit = /datum/outfit/h1132/base

/obj/effect/mob_spawn/corpse/human/damaged/h1132/chop
	name = "Security chop"
	outfit = /datum/outfit/h1132/sec_chop

/obj/effect/mob_spawn/corpse/human/damaged/h1132/doc
	name = "Doctor"
	outfit = /datum/outfit/h1132/doctor

/obj/effect/mob_spawn/corpse/human/damaged/h1132/sci
	name = "Scientist"
	outfit = /datum/outfit/h1132/scientist

/obj/effect/mob_spawn/corpse/human/damaged/h1132/cannibal
	name = "Cannibal"
	outfit = /datum/outfit/h1132/cannibal

/obj/effect/mob_spawn/corpse/human/damaged/h1132/bezdelnik
	name = "Bezdelnik"
	outfit = /datum/outfit/h1132/bezdelnik


/obj/effect/mob_spawn/corpse/human/h1132
	name = "frozen colonist"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	skin_tone = "caucasian1"
	outfit = /datum/outfit/h1132/base

/obj/effect/mob_spawn/corpse/human/h1132/chop
	name = "Security chop"
	outfit = /datum/outfit/h1132/sec_chop

/obj/effect/mob_spawn/corpse/human/h1132/doc
	name = "Doctor"
	outfit = /datum/outfit/h1132/doctor

/obj/effect/mob_spawn/corpse/human/h1132/sci
	name = "Scientist"
	outfit = /datum/outfit/h1132/scientist

/obj/effect/mob_spawn/corpse/human/h1132/cannibal
	name = "Cannibal"
	outfit = /datum/outfit/h1132/cannibal

/obj/effect/mob_spawn/corpse/human/h1132/bezdelnik
	name = "Bezdelnik"
	outfit = /datum/outfit/h1132/bezdelnik

/obj/effect/mob_spawn/corpse/human/h1132/thelastone
	name = "Lone sniper"
	outfit = /datum/outfit/h1132/sniper

/datum/outfit/h1132
	id = /obj/item/storage/wallet/random/russian
	back = /obj/item/storage/backpack/satchel/leather

/datum/outfit/h1132/base
	uniform = /obj/item/clothing/under/frontier_colonist
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist

/datum/outfit/h1132/sec_chop
	name = "Security (chopped)"
	uniform = /obj/item/clothing/under/colonial
	suit = /obj/item/clothing/suit/armor/vest
	head = /obj/item/clothing/head/helmet/sec
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	mask = /obj/item/clothing/mask/balaclava/threehole
	r_hand = /obj/item/radio

/datum/outfit/h1132/doctor
	name = "Doctor"
	uniform = /obj/item/clothing/under/colonial
	suit = /obj/item/clothing/suit/toggle/labcoat/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	gloves = /obj/item/clothing/gloves/latex
	back = /obj/item/storage/backpack/satchel/leather
	r_pocket = /obj/item/storage/medkit/ancient

/datum/outfit/h1132/scientist
	name = "Scientist"
	uniform = /obj/item/clothing/under/colonial
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/sneakers/white
	back = /obj/item/storage/backpack/satchel/leather

/datum/outfit/h1132/cannibal
	name = "Cannibal"
	uniform = /obj/item/clothing/under/frontier_colonist
	suit = /obj/item/clothing/suit/armor/vest/marine/security
	head = /obj/item/clothing/head/helmet/swat
	mask = /obj/item/clothing/mask/balaclava/threehole
	shoes = /obj/item/clothing/shoes/combat/coldres
	r_hand = /obj/item/radio

/datum/outfit/h1132/bezdelnik
	name = "Bezdelnik"
	uniform = /obj/item/clothing/under/frontier_colonist
	shoes = /obj/item/clothing/shoes/jackboots/colonial
	r_hand = /obj/item/radio

/datum/outfit/h1132/sniper
	name = "Sniper"
	belt = /obj/item/storage/belt/military
	suit = /obj/item/clothing/suit/hooded/wintercoat/eva
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/color/grey/protects_cold
	head = /obj/item/clothing/head/helmet/rus_ushanka

/obj/item/storage/wallet/random/russian
	name = "worn leather wallet"
	icon_state = "wallet"
	worn_icon_state = "wallet"

/obj/item/storage/wallet/random/russian/PopulateContents()
	if(prob(50))
		new /obj/item/clothing/neck/cross(src)
	var/coins = pick(2, 2, 3, 3, 4, 5)
	for(var/i in 1 to coins)
		var/coin_type = pick_weight(list(
			/obj/item/coin/iron   = 70,
			/obj/item/coin/silver = 20,
			/obj/item/coin/gold   = 10
		))
		new coin_type(src)
