/// Looking through pillows on sofas when rightclicked
/obj/structure/chair/sofa/attack_hand_secondary(mob/user, list/modifiers)
	if(!ishuman(user) || !user.ckey)
		return ..()
	balloon_alert(user, "searching under pillows...")
	to_chat(user, span_alert("You start scouring through the sofa's pillows...."))
	if(do_after(user, 10 SECONDS, src))
		if(prob(10))
			balloon_alert(user, "found something")
			if(prob(1))
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(5, 1, loc)
				new /obj/item/disk/nuclear/fake(loc)
			else
				// New epic way of making money. Totally
				new /obj/item/coin/iron(loc)
		else
			balloon_alert(user, "nothing")
