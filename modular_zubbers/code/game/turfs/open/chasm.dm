/turf/open/chasm/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(isliving(mover))
		var/mob/living/mover_as_livng = mover
		if(mover_as_livng.stat != DEAD) //Only the living can stop themselves.
			if(mover.loc == src) //If you fall on a chasm, you're dicked.
				return TRUE
			return can_cross_safely(mover) //Else, well you stop yourself.
	return TRUE //Everything else can pass.
