/obj/item/clothing/wrists/clockwork_watch
	name = "steampunk watch"
	desc = "A stylish steampunk watch made out of thousands of tiny cogwheels."
	gender = MALE
	icon_state = "clockwork_slab"
	body_parts_covered = HAND_LEFT | ARM_LEFT
	attack_verb_simple = list("showed the time to")

/obj/item/clothing/wrists/clockwork_watch/examine(mob/user)
	. = ..()
	. += "<span class='info'>Station Time: [station_time_timestamp("hh:mm:ss", world.time)]"

/obj/item/clothing/wrists/clockwork_watch/attack(mob/target, mob/user)
	. = ..()
	to_chat(target, "<span class='info'>Station Time: [station_time_timestamp("hh:mm:ss", world.time)]")
