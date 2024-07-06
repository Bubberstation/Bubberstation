/datum/controller/subsystem/ticker/PostSetup()
	. = ..()
	if(GLOB.effigy_promo)
		to_chat(world, create_ooc_announcement_div(EFFIGY_WELCOME_MESSAGE))

/datum/controller/subsystem/ticker/handle_hearts()
	. = ..()
	if(GLOB.effigy_promo)
		to_chat(world, create_ooc_announcement_div(EFFIGY_END_MESSAGE))

/client/verb/webmap()
	set name = "View Webmap"
	set category = "OOC"
	set hidden = FALSE
	var/mapurl = null
	switch(SSmapping.config.map_name)
		if("Effigy Sigma Octantis")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/sigmaoctantis/"
		if("Effigy RimPoint")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/rimpoint/"
	if(mapurl)
		src << link(mapurl)
	else
		to_chat(usr, span_boldwarning("No WebMap Found!"), MESSAGE_TYPE_SYSTEM)
	return


/mob/dead/new_player/proc/get_effigy_menu_html()
	var/splash_data
	if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
		splash_data += {"
			<a id="ready" class="menu_button" href='?src=[text_ref(src)];toggle_ready=1'>[ready == PLAYER_READY_TO_PLAY ? "<span class='cta'>Ready</span>" : "Not Ready"]</a>
		"}
	else
		splash_data += {"
			<a class="menu_button" href='?src=[text_ref(src)];late_join=1'><span class='cta'>Join Game</span></a>
		"}

	splash_data += {"
		<a id="be_antag" class="menu_button" href='?src=[text_ref(src)];toggle_antag=1'>[client.prefs.read_preference(/datum/preference/toggle/be_antag) ? "<span class='antag_enabled'>Antag Enabled</span>" : "<span class='antag_disabled'>Antag Disabled</span>"]</a>
		<br/>
		<a class="menu_button" href='?src=[text_ref(src)];observe=1'>Observe</a>
	"}

	if(SSticker.current_state > GAME_STATE_PREGAME)
		splash_data += {"
			<a class="menu_button" href='?src=[text_ref(src)];view_manifest=1'>Crew Manifest</a>
			<a class="menu_button" href='?src=[text_ref(src)];character_directory=1'>Character Directory</a>
		"}

	splash_data += {"
		<a class="menu_button" href='?src=[text_ref(src)];character_setup=1'>Character Setup (<span id="character_slot">[client.prefs.read_preference(/datum/preference/name/real_name)]</span>)</a>
		<a class="menu_button" href='?src=[text_ref(src)];game_options=1'>Game Options</a>
		<br/>
		<a class="menu_button" href='?src=[text_ref(src)];effigy_link=1'>Visit Effigy Site</a>
	"}

	splash_data += "</div>"
	splash_data += {"
	<script language="JavaScript">
		var ready_int = 0;
		var ready_mark = document.getElementById("ready");
		var ready_marks = \[ "Not Ready", "<span class='cta'>Ready</span>" \];
		function toggle_ready(setReady) {
			if(setReady) {
				ready_int = setReady;
				ready_mark.innerHTML = ready_marks\[ready_int\];
			}
			else {
				ready_int++;
				if (ready_int === ready_marks.length)
					ready_int = 0;
				ready_mark.innerHTML = ready_marks\[ready_int\];
			}
		}
		var antag_int = 0;
		var antag_mark = document.getElementById("be_antag");
		var antag_marks = \[ "<span class='antag_disabled'>Antag Disabled</span> ", "<span class='antag_enabled'>Antag Enabled</span>" \];
		function toggle_antag(setAntag) {
			if(setAntag) {
				antag_int = setAntag;
				antag_mark.innerHTML = antag_marks\[antag_int\];
			}
			else {
				antag_int++;
				if (antag_int === antag_marks.length)
					antag_int = 0;
				antag_mark.innerHTML = antag_marks\[antag_int\];
			}
		}

		var character_name_slot = document.getElementById("character_slot");
		function update_current_character(name) {
			character_name_slot.textContent = name;
		}

		function append_terminal_text() {}
		function update_loading_progress() {}
	</script>
	"}

	return splash_data
