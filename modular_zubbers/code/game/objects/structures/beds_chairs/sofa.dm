/// Looking through pillows on sofas when rightclicked
/obj/structure/chair/sofa/attack_hand_secondary(mob/user, list/modifiers)
	if(!ishuman(user) || !user.ckey)
		return ..()
	balloon_alert(user, "Searching under pillows...")
	to_chat(user, span_alert("You start scouring through the sofa's pillows...."))
	if(do_after(user, 10 SECONDS, src))
		if(prob(40))
			balloon_alert(user, "Found something")
			if(prob(0.02)) // 0.02 About 1 in 125000, astronomically low
				// Run through all nuclear disks and steal the first one
				for(var/obj/item/disk/nuclear/N in SSpoints_of_interest.real_nuclear_disks)
					do_teleport(N, src, channel = TELEPORT_CHANNEL_QUANTUM, forced = TRUE)
					return
			else
				// New epic way of making money. Totally
				new /obj/item/coin/iron(loc)
		else
			balloon_alert(user, "Nothing")
