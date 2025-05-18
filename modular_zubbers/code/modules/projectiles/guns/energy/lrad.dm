/obj/item/gun/energy/lrad
	name = "LRAD Cannon"
	desc = "Originally made as a desperate last stand by Sierra Outpost 16's heads of staff during a bloodthirsty revolution, this old design upgraded with bluespace technology\
	has become a favourite among SolGov's search and rescue breacher teams. A crowd-control weapon that shoots out sonic blasts - exploding on impact with surfaces, but not people. \
	The sound wave starts off slow but gradually accelerates. The device's desorientating capabilities are powerful enough to still impact those with bowman equipment \
	- only total deafness helps anyone caught by the bone-vibrating blast. "
	icon_state = "lasercannon"
	inhand_icon_state = "laser"
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lrad)
	pin = null
	ammo_x_offset = 3
	fire_delay = 20


/obj/item/ammo_casing/energy/laser/lrad
	projectile_type = /obj/projectile/beam/laser/lrad
	select_name = "accelerator"
	fire_sound = 'sound/items/weapons/lasercannonfire.ogg'

/obj/projectile/beam/laser/lrad
	name = "accelerator laser"
	icon_state = "scatterlaser"
	range = 255
	pass_flags = PASSMOB
	speed = 0.5

/obj/projectile/beam/laser/lrad/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	playsound()
	if(ismob(target))
		return
	else
		balloon_alert_to_viewers("Eat Lead!")
		for(var/mob/living/carbon/unlucky_bastard in get_hearers_in_view(4, target))
			to_chat(unlucky_bastard, "You are the unlucky bastard")
			var/ear_protection = unlucky_bastard.get_ear_protection()
			var/distance = max(0, get_dist(get_turf(target), unlucky_bastard))
			var/bangact_proof = FALSE
			var/list/reflist = list(bangact_proof) // Need to wrap this in a list so we can pass a reference
			SEND_SIGNAL(src, COMSIG_CARBON_SOUNDBANG, reflist)
			bangact_proof = reflist[1]
			var/obj/item/organ/ears/our_ears = unlucky_bastard.get_organ_slot(ORGAN_SLOT_EARS)
			playsound(target, 'sound/items/weapons/flashbang.ogg', 100, TRUE, 8, 0.9)
			unlucky_bastard.set_jitter_if_lower(20 SECONDS)
			if(distance <= 1 && our_ears && !ear_protection)
				if(bangact_proof)
					unlucky_bastard.adjust_confusion_up_to(50 SECONDS, 50 SECONDS)
					unlucky_bastard.Knockdown(2.5 SECONDS)
					unlucky_bastard.say("1")
				else
					unlucky_bastard.adjust_confusion_up_to(80 SECONDS, 60 SECONDS)
					unlucky_bastard.Knockdown(5 SECONDS)
					unlucky_bastard.say("2")
			else if(distance == 2 && unlucky_bastard.ears)
				if(bangact_proof)
					unlucky_bastard.adjust_confusion_up_to(30 SECONDS, 50 SECONDS)
					unlucky_bastard.Knockdown(1 SECONDS)
					unlucky_bastard.say("3")
				else
					unlucky_bastard.adjust_confusion_up_to(40 SECONDS, 60 SECONDS)
					unlucky_bastard.Knockdown(3 SECONDS)
					unlucky_bastard.say("4")


