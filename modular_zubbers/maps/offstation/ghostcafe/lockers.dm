/obj/structure/closet/ghostcafe/build
	name = "construction closet"
	desc = "Management condemns using these tools to stab your friends."
	icon_state = "eng"
	icon_door = "eng_tool"

/obj/structure/closet/ghostcafe/build/PopulateContents()
	..()
	for(var/i in 1 to 4)
		new /obj/item/storage/belt/utility/full/powertools/ircd(src)
	for(var/i in 1 to 4)
		new /obj/item/clothing/glasses/welding(src)
	new /obj/item/stack/tile/carpet/black/fifty(src)
	new /obj/item/stack/tile/carpet/blue/fifty(src)
	new /obj/item/stack/tile/carpet/blue/fifty(src)
	new /obj/item/stack/tile/carpet/green/fifty(src)
	new /obj/item/stack/tile/carpet/orange/fifty(src)
	new /obj/item/stack/tile/carpet/purple/fifty(src)
	new /obj/item/stack/tile/carpet/red/fifty(src)
	new /obj/item/stack/tile/carpet/royalblack/fifty(src)
	new /obj/item/stack/tile/carpet/royalblue/fifty(src)
	new /obj/item/stack/sheet/mineral/wood/fifty(src)
