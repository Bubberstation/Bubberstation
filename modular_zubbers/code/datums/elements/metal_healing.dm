/datum/element/metal_healing

/datum/element/metal_healing/Attach(datum/target)
	. = ..()
	RegisterSignal(target, COMSIG_ATOM_ATTACKBY, PROC_REF(on_metal_attack))

/datum/element/metal_healing/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_ATTACKBY)

/datum/element/metal_healing/proc/on_metal_attack(mob/living/source, obj/item, mob/living/attack)
	SIGNAL_HANDLER

	var/mob/living/attacker = attack
	var/mob/living/holder = source
	var/obj/item/stack/sheet/material = item

	if(DOING_INTERACTION_WITH_TARGET(attacker, holder))
		return COMPONENT_NO_AFTERATTACK
	if(attacker.combat_mode)
		return
	if(!istype(material))
		return
	if(attacker == holder)
		return
	if(holder.health >= holder.maxHealth)
		to_chat(attacker, span_notice("[holder] can no longer integrate [item] into their mass!"))
		return
	if(!do_after(attacker, 1 SECONDS, holder))
		return
	if(material.use(1))
		to_chat(attacker, span_warning("You feed metal to [holder] to heal them!"))
		holder.adjust_brute_loss(-10, forced = TRUE)
		holder.adjust_fire_loss(-10, forced=TRUE)
		return COMPONENT_NO_AFTERATTACK
	return
