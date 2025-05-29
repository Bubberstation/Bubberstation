/mob/living
	var/adminbus_trash = FALSE				// For abusing trash eater for event shenanigans.

/obj/item
	var/trash_eatable = TRUE

/mob/living/proc/eat_trash()
	set name = "Eat Trash"
	set category = "Vore"	//No Abilities?
	set desc = "Consume held garbage."

	if(!vore_selected)
		to_chat(src,"<span class='warning'>You either don't have a belly selected, or don't have a belly!</span>")
		return

	var/obj/item/I = get_active_held_item()
	if(!I)
		to_chat(src, "<span class='notice'>You are not holding anything.</span>")
		return

	if(is_type_in_list(I,item_vore_blacklist) && !adminbus_trash) //If someone has adminbus, they can eat whatever they want.
		to_chat(src, "<span class='warning'>You are not allowed to eat this.</span>")
		return

	if(!I.trash_eatable) //OOC pref. This /IS/ respected, even if adminbus_trash is enabled
		to_chat(src, "<span class='warning'>You can't eat that so casually!</span>")
		return

	/*
	if(istype(I, /obj/item/paicard))
		var/obj/item/paicard/palcard = I
		var/mob/living/silicon/pai/pocketpal = palcard.pai
		if(pocketpal && (!pocketpal.devourable))
			to_chat(src, "<span class='warning'>\The [pocketpal] doesn't allow you to eat it.</span>")
			return
	*/

	if(is_type_in_list(I,edible_trash) | adminbus_trash /*|| is_type_in_list(I,edible_tech) && isSynthetic()*/)
		/*
		if(I.hidden_uplink)
			to_chat(src, "<span class='warning'>You really should not be eating this.</span>")
			message_admins("[key_name(src)] has attempted to ingest an uplink item. ([src ? ADMIN_JMP(src) : "null"])")
			return
		*/
		if(istype(I,/obj/item/pda))
			var/obj/item/pda/P = I
			if(P.owner)
				var/watching = FALSE
				for(var/mob/living/carbon/human/H in view(src))
					if(H.real_name == P.owner && H.client)
						watching = TRUE
						break
				if(!watching)
					return
				else
					visible_message("<span class='warning'>[src] is threatening to make [P] disappear!</span>")
					if(P.id)
						var/confirm = alert(src, "The PDA you're holding contains a vulnerable ID card. Will you risk it?", "Confirmation", "Definitely", "Cancel") //No tgui input?
						if(confirm != "Definitely")
							return
					if(!do_after(src, 100, P))
						return
					visible_message("<span class='warning'>[src] successfully makes [P] disappear!</span>")
			to_chat(src, "<span class='notice'>You can taste the sweet flavor of delicious technology.</span>")
			dropItemToGround(I)
			I.forceMove(vore_selected)
			updateVRPanel()
			return
		/*
		if(istype(I,/obj/item/clothing/shoes))
			var/obj/item/clothing/shoes/S = I
			if(S.holding)
				to_chat(src, "<span class='warning'>There's something inside!</span>")
				return
		*/
		/*
		if(iscapturecrystal(I))
			var/obj/item/capture_crystal/C = I
			if(!C.bound_mob.devourable)
				to_chat(src, "<span class='warning'>That doesn't seem like a good idea. (\The [C.bound_mob]'s prefs don't allow it.)</span>")
				return
		*/
		dropItemToGround(I)
		I.forceMove(vore_selected)
		updateVRPanel()

		log_admin("VORE: [src] used Eat Trash to swallow [I].")

		if(istype(I,/obj/item/flashlight/flare) || istype(I,/obj/item/match) || istype(I,/obj/item/storage/box/matches))
			to_chat(src, "<span class='notice'>You can taste the flavor of spicy cardboard.</span>")
		else if(istype(I,/obj/item/flashlight/glowstick)) //Repath from /obj/item/device/flashlight/glowstick
			to_chat(src, "<span class='notice'>You found out the glowy juice only tastes like regret.</span>")
		else if(istype(I,/obj/item/cigbutt)) //Repath from /obj/item/trash/cigbutt
			to_chat(src, "<span class='notice'>You can taste the flavor of bitter ash. Classy.</span>")
		else if(istype(I,/obj/item/clothing/mask/cigarette)) //Repath from /obj/item/clothing/mask/smokable
			var/obj/item/clothing/mask/cigarette/C = I
			if(C.lit)
				to_chat(src, "<span class='notice'>You can taste the flavor of burning ash. Spicy!</span>")
			else
				to_chat(src, "<span class='notice'>You can taste the flavor of aromatic rolling paper and funny looks.</span>")
		else if(istype(I,/obj/item/paper)) //Repath from /obj/item/weapon/paper
			to_chat(src, "<span class='notice'>You can taste the dry flavor of bureaucracy.</span>")
		else if(istype(I,/obj/item/dice)) //Repath from /obj/item/weapon/dice
			to_chat(src, "<span class='notice'>You can taste the bitter flavor of cheating.</span>")
		else if(istype(I,/obj/item/lipstick)) //Repath from /obj/item/weapon/lipstick
			to_chat(src, "<span class='notice'>You can taste the flavor of couture and style. Toddler at the make-up bag style.</span>")
		else if(istype(I,/obj/item/soap)) //Repath from /obj/item/weapon/soap
			to_chat(src, "<span class='notice'>You can taste the bitter flavor of verbal purification.</span>")
		else if(istype(I,/obj/item/stack/spacecash) || istype(I,/obj/item/storage/wallet)) //Repath from /obj/item/weapon/spacecash and /obj/item/weapon/storage/wallet
			to_chat(src, "<span class='notice'>You can taste the flavor of wealth and reckless waste.</span>")
		else if(istype(I,/obj/item/broken_bottle) || istype(I,/obj/item/shard)) //Repath from /obj/item/weapon/broken_bottle
			to_chat(src, "<span class='notice'>You can taste the flavor of pain. This can't possibly be healthy for your guts.</span>")
		else if(istype(I,/obj/item/light)) //Repath from /obj/item/weapon/light
			var/obj/item/light/L = I
			if(L.status == LIGHT_BROKEN)
				to_chat(src, "<span class='notice'>You can taste the flavor of pain. This can't possibly be healthy for your guts.</span>")
			else
				to_chat(src, "<span class='notice'>You can taste the flavor of really bad ideas.</span>")
		/*
		else if(istype(I,/obj/item/weapon/bikehorn/tinytether)) //Doenst exist
			to_chat(src, "<span class='notice'>You feel a rush of power swallowing such a large, err, tiny structure.</span>")
		*/
		else if(istype(I,/obj/item/mmi/posibrain) || istype(I,/obj/item/aicard)) //Repath from /obj/item/device/mmi/digital/posibrain and //Repath from /obj/item/device/aicard
			to_chat(src, "<span class='notice'>You can taste the sweet flavor of digital friendship. Or maybe it is something else.</span>")
		else if(istype(I,/obj/item/paicard)) //Repath from /obj/item/device/paicard
			to_chat(src, "<span class='notice'>You can taste the sweet flavor of digital friendship.</span>")
			var/obj/item/paicard/ourcard = I
			if(ourcard.pai && ourcard.pai.client && isbelly(ourcard.loc))
				var/obj/belly/B = ourcard.loc
				to_chat(ourcard.pai, "<span class= 'notice'><B>[B.desc]</B></span>")
		else if(istype(I,/obj/item/reagent_containers/food)) //Repath from /obj/item/weapon/reagent_containers/food
			var/obj/item/reagent_containers/food/F = I
			if(!F.reagents.total_volume)
				to_chat(src, "<span class='notice'>You can taste the flavor of garbage and leftovers. Delicious?</span>")
			else
				to_chat(src, "<span class='notice'>You can taste the flavor of gluttonous waste of food.</span>")
		else if (istype(I,/obj/item/clothing/neck/petcollar))
			to_chat(src, "<span class='notice'>You can taste the submissiveness in the wearer of [I]!</span>")
		/*
		else if(iscapturecrystal(I))
			var/obj/item/capture_crystal/C = I
			if(C.bound_mob && (C.bound_mob in C.contents))
				if(isbelly(C.loc))
					//var/obj/belly/B = C.loc //CHOMPedit
					//to_chat(C.bound_mob, "<span class= 'notice'>Outside of your crystal, you can see; <B>[B.desc]</B></span>") //CHOMPedit: moved to modular_chomp capture_crystal.dm
					to_chat(src, "<span class='notice'>You can taste the the power of command.</span>")
		*/
		// CHOMPedit begin
		/*
		else if(istype(I,/obj/item/starcaster_news))
			to_chat(src, "<span class='notice'>You can taste the dry flavor of digital garbage, oh wait its just the news.</span>")
		*/
		else if(istype(I,/obj/item/newspaper))
			to_chat(src, "<span class='notice'>You can taste the dry flavor of garbage, oh wait its just the news.</span>")
		else if (istype(I,/obj/item/stock_parts/cell))
			visible_message("<span class='warning'>[src] sates their electric appetite with a [I]!</span>")
			to_chat(src, "<span class='notice'>You can taste the spicy flavor of electrolytes, yum.</span>")
		/*
		else if (istype(I,/obj/item/walkpod))
			visible_message("<span class='warning'>[src] sates their musical appetite with a [I]!</span>")
			to_chat(src, "<span class='notice'>You can taste the jazzy flavor of music.</span>")
		*/
		/*
		else if (istype(I,/obj/item/mail/junkmail))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You can taste the flavor of the galactic postal service.</span>")
		*/
		/*
		else if (istype(I,/obj/item/weapon/gun/energy/sizegun))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You didn't read the warning label, did you?</span>")
		*/
		/*
		else if (istype(I,/obj/item/device/slow_sizegun))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You taste the flavor of sunday driver bluespace.</span>")
		*/
		else if (istype(I,/obj/item/laser_pointer))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You taste the flavor of a laser.</span>")
		else if (istype(I,/obj/item/canvas))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You taste the flavor of priceless artwork.</span>")
		//CHOMPedit end

		else
			to_chat(src, "<span class='notice'>You can taste the flavor of garbage. Delicious.</span>")
		visible_message("<span class='warning'>[src] demonstrates their voracious capabilities by swallowing [I] whole!</span>")
		return
	to_chat(src, "<span class='notice'>This snack is too powerful to go down that easily.</span>") //CHOMPEdit
	return
