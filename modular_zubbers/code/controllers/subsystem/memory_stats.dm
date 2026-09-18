/// Rough ceiling of what a Dream Daemon process can address before it falls over, in MB. Display only.
#define MEMORY_STATS_BUDGET_MB 3900
/// File the windows background writer drops its RSS samples into, see tools/memory_stats/mem_writer.ps1
#define MEMORY_RSS_FILE "data/memory_rss.txt"
/// MB of RSS growth between two samples that gets an admin's attention
#define MEMORY_STATS_SPIKE_ALERT_MB 250

// DECLARE_LOG_NAMED is #undef'd at the bottom of code/_globalvars/logging.dm, so this is it expanded by hand
GLOBAL_VAR(world_mem_log)
GLOBAL_PROTECT(world_mem_log)

/world/_initialize_log_files(temp_log_override = null)
	..()
	GLOB.world_mem_log = temp_log_override || "[GLOB.log_directory]/memory_stats.log"
	if(!temp_log_override)
		start_log(GLOB.world_mem_log)

/// Periodically logs process memory usage and the sizes of leak-prone lists/queues
/// to data/logs/<round>/memory_stats.log
SUBSYSTEM_DEF(memory_stats)
	name = "Memory Stats"
	wait = 30 SECONDS
	ss_flags = SS_BACKGROUND
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT
	/// RSS (in MB) of the last sample, so users can see the current memory usage in the statpanel
	var/last_rss_mb = 0
	/// RSS in raw bytes of the last sample (float precision, ~256 byte granularity at the 4GB scale)
	var/last_rss_bytes = 0

/datum/controller/subsystem/memory_stats/Initialize()
	can_fire = CONFIG_GET(flag/enable_memory_stats)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/memory_stats/fire(resumed)
	log_memory_stats()

/**
 * Returns the process resident set size in bytes, or null if unavailable right now.
 *
 * On linux this reads /proc/self/status directly, which is free. On windows there is no
 * equivalent, so a hidden background powershell writer (tools/memory_stats/mem_writer.ps1)
 * is started on the first call and keeps MEMORY_RSS_FILE up to date - that avoids a console
 * window flashing on every sample. The first windows call therefore always returns null.
 */
/proc/get_process_rss_bytes()
	if(world.system_type == UNIX)
		var/status = rustg_file_read("/proc/self/status")
		if(status)
			var/static/regex/rss_regex = regex(@"VmRSS:\s+(\d+) kB")
			if(rss_regex.Find(status))
				return text2num(rss_regex.group[1]) * 1024
		return null

	var/static/writer_started = FALSE
	if(!writer_started)
		writer_started = TRUE
		fdel(MEMORY_RSS_FILE) // clear stale data from a previous round
		// shell() only exists in trusted mode, and we would rather log nothing than runtime every sample
		try
			shell("wscript //B //nologo \"tools/memory_stats/mem_writer.vbs\"")
		catch
			log_world("SSmemory_stats: could not start the RSS writer, is the server running in trusted mode?")
		return null

	if(fexists(MEMORY_RSS_FILE))
		var/bytes = text2num(trim(file2text(MEMORY_RSS_FILE) || ""))
		if(bytes)
			return bytes
	return null

/datum/controller/subsystem/memory_stats/proc/log_memory_stats()
	var/list/out = list()

	var/rss_bytes = get_process_rss_bytes()
	if(!isnull(rss_bytes))
		var/rss = round(rss_bytes / (1024 * 1024), 0.1)
		out += "rss_mb=[rss]"
		out += "rss_bytes=[num2text(rss_bytes, 12)]"
		if(last_rss_mb && rss - last_rss_mb > MEMORY_STATS_SPIKE_ALERT_MB)
			message_admins("MEMORY: process RSS jumped [round(rss - last_rss_mb)]MB in [wait / (1 SECONDS)]s (now [rss]MB)")
		last_rss_mb = rss
		last_rss_bytes = rss_bytes

	out += "world_contents=[length(world.contents)]"
	out += "clients=[length(GLOB.clients)]"
	out += "mobs=[length(GLOB.mob_list)]"
	out += "dead_mobs=[length(GLOB.dead_mob_list)]"
	out += "alive_mobs=[length(GLOB.alive_mob_list)]"

	// lighting queues, these only grow if something is producing sources faster than they can be flushed
	out += "light_srcq=[length(SSlighting.sources_queue)]"
	out += "light_cornq=[length(SSlighting.corners_queue)]"
	out += "light_objq=[length(SSlighting.objects_queue)]"

	// garbage: failed hard deletes pin memory; a growing queue means qdel's harddelling too much
	out += "gc_totaldels=[SSgarbage.totaldels]"
	out += "gc_totalgcs=[SSgarbage.totalgcs]"
	for(var/i in 1 to length(SSgarbage.queues))
		out += "gc_queue[i]=[length(SSgarbage.queues[i])]"

	// timers
	out += "timer_buckets=[SStimer.bucket_count]"
	out += "timer_secondq=[length(SStimer.second_queue)]"
	out += "timer_ids=[length(SStimer.timer_id_dict)]"

	// vis overlays cache (grows per unique overlay key, never evicted)
	out += "vis_overlay_cache=[length(SSvis_overlays.vis_overlay_cache)]"

	// every processing-style subsystem: name=processing/currentrun lengths
	for(var/datum/controller/subsystem/checked_subsystem in Master.subsystems)
		if("processing" in checked_subsystem.vars)
			var/list/procs_list = checked_subsystem.vars["processing"]
			if(islist(procs_list) && length(procs_list))
				out += "ss_[ckey(checked_subsystem.name)]_processing=[length(procs_list)]"
		if("currentrun" in checked_subsystem.vars)
			var/list/current_run = checked_subsystem.vars["currentrun"]
			if(islist(current_run) && length(current_run))
				out += "ss_[ckey(checked_subsystem.name)]_currentrun=[length(current_run)]"

	WRITE_LOG(GLOB.world_mem_log, "MEMSTAT: [out.Join(" ")]")

/// Formatted for the statpanel, "sampling..." until the first successful RSS read
/datum/controller/subsystem/memory_stats/proc/get_status_line()
	return last_rss_mb ? "[last_rss_mb] MB/[MEMORY_STATS_BUDGET_MB] MB" : "sampling..."

/mob/get_status_tab_items()
	. = ..()
	if(CONFIG_GET(flag/enable_memory_stats))
		. += "Memory: [SSmemory_stats.get_status_line()]"

ADMIN_VERB(dump_memory_stats, R_DEBUG, "Dump Memory Stats", "Writes a memory stats sample to memory_stats.log right now.", ADMIN_CATEGORY_DEBUG)
	SSmemory_stats.log_memory_stats()
	to_chat(user, span_notice("Memory stats dumped to memory_stats.log (rss: [SSmemory_stats.last_rss_mb]MB / [num2text(SSmemory_stats.last_rss_bytes, 12)] bytes)."))

#undef MEMORY_RSS_FILE
#undef MEMORY_STATS_BUDGET_MB
#undef MEMORY_STATS_SPIKE_ALERT_MB
