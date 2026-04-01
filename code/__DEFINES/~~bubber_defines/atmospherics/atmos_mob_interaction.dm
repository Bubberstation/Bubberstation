//Air alarms will trigger below this temperature
#define AIRALARM_TLV_TEMP_WARN_MIN (BODYTEMP_COLD_WARNING_1 + 7)
//Air alarms will trigger above this temperature
#define AIRALARM_TLV_TEMP_WARN_MAX (BODYTEMP_HEAT_WARNING_1 - 27)
//Firebots with hot ice witll use their foam below this temperature
#define FIREBOT_HOTICE_TLV_TEMP_WARN_MIN (AIRALARM_TLV_TEMP_WARN_MIN + 11)
//Firebots with hot ice witll use their foam above this temperature
#define FIREBOT_HOTICE_TLV_TEMP_WARN_MAX (AIRALARM_TLV_TEMP_WARN_MAX - 11)
