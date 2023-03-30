/mob
	var/is_tilted

/mob/verb/tilt_left()
	set hidden = TRUE
	if(is_tilted < -45)
		return FALSE
	transform = transform.Turn(-1)
	is_tilted--

/mob/verb/tilt_right()
	set hidden = TRUE
	if(is_tilted > 45)
		return FALSE
	transform = transform.Turn(1)
	is_tilted++
