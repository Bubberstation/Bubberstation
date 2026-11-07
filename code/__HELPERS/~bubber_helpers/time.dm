/proc/gameTimestamp(format = "hh:mm:ss", wtime=null, legend = FALSE)
	if(!wtime)
		wtime = world.time - SSticker.round_start_time
	var/hour = round(wtime / 36000)
	var/minute = round(((wtime) - (hour * 36000)) / 600)
	var/second = round(((wtime) - (hour * 36000) - (minute * 600)) / 10)

	if(hour < 10)
		hour = "0[hour]"
	if(minute < 10)
		minute = "0[minute]"
	if(second < 10)
		second = "0[second]"

	if(legend)
		return "[hour]h:[minute]m:[second]s"
	else
		return "[hour]:[minute]:[second]"
