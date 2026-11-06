/datum/atom_hud/data/human/permit
	hud_icons = list(PERMIT_HUD)

// the permit sprite hugs the tile corner, so height offsets push it off the tile
/mob/living/carbon/human/adjust_hud_position(image/holder, animate_time = null)
	if(holder != hud_list?[PERMIT_HUD])
		return ..()
	holder.pixel_w = 0
	holder.pixel_z = 0
