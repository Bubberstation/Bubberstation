/datum/action/innate/absorb_control
	name = "Take Back Control"
	desc = "Take control of your body back."

	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "soulcatcher_exit"

/datum/action/innate/absorb_control/Trigger(trigger_flags)
	var/datum/component/absorb_control/AC = target
	AC.revert()

/datum/action/innate/absorb_control/prey
	name = "Yield Control"
	desc = "Yield control to the body's rightful owner and go back to being absorbed."

/datum/component/absorb_control
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/reverted = FALSE
	var/mob/living/controller
	var/mob/living/pred_backseat/pred_backseat

	var/datum/action/innate/absorb_control/prey/absorb_control_prey
	var/datum/action/innate/absorb_control/absorb_control_pred

/datum/component/absorb_control/Initialize(mob/living/new_controller)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	if(!istype(new_controller))
		return COMPONENT_INCOMPATIBLE
	absorb_control_prey = new(src)
	absorb_control_pred = new(src)

	controller = new_controller
	// Not to the controller, that body is now uninhabitated!
	absorb_control_prey.Grant(parent)
	pred_backseat = new(parent, src)
	absorb_control_pred.Grant(pred_backseat)

	RegisterSignal(controller, COMSIG_QDELETING, PROC_REF(revert))
	RegisterSignal(controller, COMSIG_MOVABLE_MOVED, PROC_REF(revert))

	put_pred_in_backseat()

/datum/component/absorb_control/Destroy()
	revert()
	QDEL_NULL(pred_backseat)
	QDEL_NULL(absorb_control_prey)
	QDEL_NULL(absorb_control_pred)
	UnregisterSignal(controller, COMSIG_QDELETING)
	UnregisterSignal(controller, COMSIG_MOVABLE_MOVED)
	controller = null
	. = ..()

// Blindly swaps between pred and prey
/datum/component/absorb_control/proc/unsafe_swap()
	PRIVATE_PROC(TRUE)

	var/mob/living/puppet = parent
	to_chat(puppet, span_userdanger("You feel your control being taken away..."))

	var/mob/living/puppetmaster
	var/mob/living/backseat
	if(pred_backseat.ckey)
		puppetmaster = pred_backseat
		backseat = controller
	else
		puppetmaster = controller
		backseat = pred_backseat
		backseat.name = "[puppet.real_name] (Backseat)"

	to_chat(puppetmaster, span_userdanger("You take control of [puppet]!"))

	// Swap puppet to backseat
	var/puppet_id = puppet.computer_id
	var/puppet_ip = puppet.lastKnownIP
	puppet.computer_id = null
	puppet.lastKnownIP = null

	backseat.ckey = puppet.ckey
	if(puppet.mind)
		backseat.mind = puppet.mind
	if(!backseat.computer_id)
		backseat.computer_id = puppet_id
	if(!backseat.lastKnownIP)
		backseat.lastKnownIP = puppet_ip

	// Swap puppetmaster to puppet
	var/master_id = puppetmaster.computer_id
	var/master_ip = puppetmaster.lastKnownIP
	puppetmaster.computer_id = null
	puppetmaster.lastKnownIP = null

	puppet.ckey = puppetmaster.ckey
	puppet.mind = puppetmaster.mind
	if(!puppet.computer_id)
		puppet.computer_id = master_id
	if(!puppet.lastKnownIP)
		puppet.lastKnownIP = master_ip

/datum/component/absorb_control/proc/put_pred_in_backseat()
	if(!pred_backseat.ckey)
		unsafe_swap()

/datum/component/absorb_control/proc/revert()
	if(reverted)
		return
	reverted = TRUE

	if(pred_backseat.ckey)
		unsafe_swap()

	if(!QDELING(src))
		qdel(src)

/mob/living/pred_backseat
	name = "pred backseat"
	var/mob/living/body
	var/datum/component/absorb_control/absorb_control

/mob/living/pred_backseat/Initialize(mapload, datum/component/absorb_control/new_absorb_control)
	. = ..()
	ADD_TRAIT(src, TRAIT_SOFTSPOKEN, TRAIT_SOURCE_VORE)
	if(isliving(loc))
		body = loc
		absorb_control = new_absorb_control

/mob/living/pred_backseat/Life(seconds_per_tick, times_fired)
	if(QDELETED(body))
		qdel(src)

	if(body.stat == DEAD)
		absorb_control.revert()

	if(!body.client)
		absorb_control.revert()

	. = ..()
