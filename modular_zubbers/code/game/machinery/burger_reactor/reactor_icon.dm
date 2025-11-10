/obj/machinery/power/rbmk2/update_icon_state()

	if(stored_rod)
		if(active)
			if(jammed)
				icon_state = "[base_icon_state]_jammed"
			else if(meltdown)
				var/meltdown_icon_number = 1 + (x + y*2) % 5
				icon_state = "[base_icon_state]_meltdown_loop[meltdown_icon_number]"
			else
				icon_state = "[base_icon_state]_closed"
		else
			icon_state = "[base_icon_state]_open"
	else
		icon_state = base_icon_state

	return ..()

/obj/machinery/power/rbmk2/update_overlays()
	. = ..()
	if(panel_open)
		. += "platform_panel"

	if(stored_rod)

		var/datum/gas_mixture/rod_mix = stored_rod.air_contents

		if(venting)
			var/mutable_appearance/heat_overlay = mutable_appearance(icon, "platform_heat")
			heat_overlay.appearance_flags |= RESET_COLOR
			if(vent_reverse_direction)
				heat_overlay.color = heat2colour(buffer_gases.temperature*0.25)
				heat_overlay.alpha = min( (rod_mix.temperature - T0C) * (1/2000) * 255,255)
			else
				heat_overlay.color = heat2colour(rod_mix.temperature*0.5)
				heat_overlay.alpha = min( (rod_mix.temperature - T0C) * (1/2000) * 255,255)
			. += heat_overlay

		if(!active && !jammed && rod_mix.gases[/datum/gas/tritium])
			var/meter_icon_num = CEILING( min(rod_mix.gases[/datum/gas/tritium][MOLES] / 100, 1) * 5, 1)
			if(meter_icon_num > 0)
				var/rod_mix_pressure = rod_mix.return_pressure()
				var/mutable_appearance/meter_overlay = mutable_appearance(icon, "platform_rod_glow_[meter_icon_num]")
				meter_overlay.appearance_flags |= RESET_COLOR
				var/return_pressure_mod = clamp( (rod_mix_pressure - stored_rod.pressure_limit*0.5) / stored_rod.pressure_limit*0.5,0,1)
				meter_overlay.color = rgb(return_pressure_mod*255,255 - return_pressure_mod*255,0)
				. += meter_overlay
