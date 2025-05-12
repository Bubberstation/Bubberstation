//Lockers specific to persistence

/obj/structure/closet/secure_closet/interdynefob/sa_locker/persistence
	name = "\proper land crawler admiral's locker"

/obj/structure/closet/secure_closet/interdynefob/sa_locker/persistence/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/station_admiral(src)
	new /obj/item/radio/headset/syndicateciv/command(src)

/obj/structure/closet/secure_closet/persistence/maa_locker
	icon_door = "warden"
	icon_state = "warden"
	name = "master at arms' locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/persistence/maa_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/security/full(src)
	new /obj/item/watertank/pepperspray(src)
	new /obj/item/storage/bag/garment/master_arms(src)
	new /obj/item/radio/headset/syndicateciv/staff(src)


