/// The Vítězství sentry re-declares TURRET_FLAG_SHOOT_ANOMALOUS locally because the
/// TG define is file-local to portable_turret.dm. If TG ever renumbers that bit, our
/// copy would silently point at the wrong flag, so this test fails loudly the moment
/// the value drifts from the one registered in DEFINE_BITFIELD(turret_flags).
/datum/unit_test/vitezstvi_turret_flags/Run()
	var/list/turret_flag_values = GLOB.bitfields["turret_flags"]
	TEST_ASSERT(turret_flag_values, "turret_flags has no registered bitfield in GLOB.bitfields")

	var/expected = turret_flag_values["TURRET_FLAG_SHOOT_ANOMALOUS"]
	TEST_ASSERT_EQUAL(expected, (1<<4), "TG's TURRET_FLAG_SHOOT_ANOMALOUS changed value; update the local copy in vitezstvi_mercs/turret.dm to match.")

	var/obj/machinery/porta_turret/vitezstvi/sentry = allocate(/obj/machinery/porta_turret/vitezstvi)
	TEST_ASSERT_EQUAL(sentry.turret_flags, expected, "The Vítězství sentry's turret_flags no longer equals TG's TURRET_FLAG_SHOOT_ANOMALOUS.")
