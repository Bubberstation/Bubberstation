/**
 * public
 *
 * Resets position of all UIs to 0, 0.
 *
 * required user mob The mob who opened/is using the UI.
 * optional src_object datum If provided, only close UIs belonging this src_object.
 *
 * return int The number of UIs reset.
 */
/datum/controller/subsystem/tgui/proc/reset_ui_position(mob/user, datum/src_object)
	var/count = 0
	if(length(user?.tgui_open_uis) == 0)
		return count
	for(var/datum/tgui/ui in user.tgui_open_uis)
		if(isnull(src_object) || ui.src_object == src_object)
			ui.reset_ui_position()
			count++
	return count
