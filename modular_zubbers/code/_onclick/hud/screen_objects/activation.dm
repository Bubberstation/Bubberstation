/atom/movable/screen/text/activation_text
	screen_loc = "BOTTOM,LEFT"
	maptext = ""
	alpha = 180
	plane = SPLASHSCREEN_PLANE
	layer = SCREENTIP_LAYER
	var/vetted = FALSE

/atom/movable/screen/text/activation_text/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	update_view()
	INVOKE_ASYNC(src, PROC_REF(update_status))

/atom/movable/screen/text/activation_text/proc/update_view()
	if(!hud?.mymob?.canon_client?.view_size)
		return
	maptext_width = view_to_pixels(hud.mymob.canon_client.view_size.getView())[1]

/atom/movable/screen/text/activation_text/proc/update_status()
	if(!CONFIG_GET(flag/check_vetted))
		return
	if(vetted || !SSplayer_ranks.initialized || !hud?.mymob?.canon_client)
		return
	if(!SSplayer_ranks.is_vetted(hud.mymob.canon_client, admin_bypass = FALSE))
		maptext = MAPTEXT_SELAWIK("<span style='text-align: right; color: #7A7E88'>Activate Bubberstation</span>")
		maptext += MAPTEXT_SELAWIK("<span style='text-align: right; color: #7A7E88; font-size: 10pt'>Go to the Discord to get vetted.</span>")
	else
		maptext = ""
		vetted = TRUE
