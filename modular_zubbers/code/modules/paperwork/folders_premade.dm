/obj/item/folder/coderbus
	icon_state = "folder_syndie" //honestly

/obj/item/folder/coderbus/Initialize(mapload)
	. = ..()
	for(var/i in 1 to rand(3,8))
		new /obj/item/paper/fluff/merge_my_fucking_pr(src)
	update_appearance()
