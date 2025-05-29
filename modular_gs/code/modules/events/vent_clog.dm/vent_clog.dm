

/datum/round_event_control/vent_clog/fattening
	name = "Clogged Vents: Fattening"
	typepath = /datum/round_event/vent_clog/fattening
	max_occurrences = 0
	min_players = 5
	description = "Spits out lipoifier foam through the scrubber system."

/datum/round_event/vent_clog/fattening
	reagentsAmount = 50

/datum/round_event/vent_clog/fattening/announce()
	priority_announce("The scrubbers network is experiencing an unexpected surge of lipo-related chemicals. Some ejection of contents may occur.", "Atmospherics alert")

/datum/round_event/vent_clog/fattening/start()
	for(var/obj/machinery/atmospherics/components/unary/vent in vents)
		if(vent && vent.loc && !vent.welded)
			var/datum/reagents/R = new/datum/reagents(1000)
			R.my_atom = vent
			R.add_reagent(/datum/reagent/consumable/lipoifier, reagentsAmount)

			var/datum/effect_system/foam_spread/foam = new
			foam.set_up(200, get_turf(vent), R)
			foam.start()
		CHECK_TICK

