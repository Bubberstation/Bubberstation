/obj/item/ancientartifact
	name = "Admin Debug. Parent Artifact"
	desc = "You shouldn't have this."
	icon = 'GainStation13/code/xenoarch/fossil_and_artifact.dmi'

/obj/item/ancientartifact/Initialize()
	..()

//

/datum/export/artifacts
	cost = 2000 //Big cash
	unit_name = "useless artifact"
	export_types = list(/obj/item/ancientartifact/useless)

/datum/export/artifacts
	cost = 4000 //Big cash
	unit_name = "fossil artifact"
	export_types = list(/obj/item/ancientartifact/faunafossil,/obj/item/ancientartifact/florafossil)

//

/obj/item/ancientartifact/useless
	name = "nonfunctional artifact"
	desc = "This artifact is nonfunctional... perhaps it can be researched or sold."

/obj/item/ancientartifact/useless/Initialize()
	icon_state = pick(list("urn","statuette","instrument","unknown1","unknown2","unknown3"))
	..()

/obj/item/ancientartifact/useless/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/xenoarch/help/research))
		if(!do_after(user,100,target=src))
			to_chat(user,"You must stand still to analyze.")
			return
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 2000))
		to_chat(user,"You successfully researched the artifact. You have gained 2000 research points.")
		qdel(src)

/obj/item/ancientartifact/faunafossil
	name = "fauna fossil"
	desc = "This is a fossil of an animal... seems dead."

/obj/item/ancientartifact/faunafossil/Initialize()
	icon_state = pick(list("bone1","bone2","bone3","bone4","bone5","bone6"))
	..()

/obj/item/ancientartifact/faunafossil/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/xenoarch/help/research))
		if(!do_after(user,100,target=src))
			to_chat(user,"You must stand still to analyze.")
			return
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 4000))
		to_chat(user,"You successfully researched the artifact. You have gained 4000 research points.")
		qdel(src)

/obj/item/ancientartifact/florafossil
	name = "flora fossil"
	desc = "This is a fossil of a plant... seems dead."

/obj/item/ancientartifact/florafossil/Initialize()
	icon_state = pick(list("plant1","plant2","plant3","plant4","plant5","plant6"))
	..()

/obj/item/ancientartifact/florafossil/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/xenoarch/help/research))
		if(!do_after(user,100,target=src))
			to_chat(user,"You must stand still to analyze.")
			return
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 4000))
		to_chat(user,"You successfully researched the artifact. You have gained 4000 research points.")
		qdel(src)
	if(istype(W,/obj/item/xenoarch/help/plant))
		if(!do_after(user,50,target=src))
			to_chat(user,"You need to stand still to extract the seeds.")
			return
		var/seed = pick(list(	/obj/item/seeds/amauri,
								/obj/item/seeds/gelthi,
								/obj/item/seeds/jurlmah,
								/obj/item/seeds/nofruit,
								/obj/item/seeds/shand,
								/obj/item/seeds/surik,
								/obj/item/seeds/telriis,
								/obj/item/seeds/thaadra,
								/obj/item/seeds/vale,
								/obj/item/seeds/vaporsac,
								/obj/item/seeds/lipoplant, //GS13
								/obj/item/seeds/cherry/bomb,
								/obj/item/seeds/gatfruit,
								/obj/item/seeds/kudzu,
								/obj/item/seeds/firelemon,
								/obj/item/seeds/random
								))

		new seed(get_turf(user))
		user.put_in_active_hand(seed)
		qdel(src)
