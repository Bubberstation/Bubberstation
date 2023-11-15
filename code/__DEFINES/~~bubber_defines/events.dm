/**
 * The events system now operates off of a defined preset of votable pools.
 * High, med, low
 * Players can vote for whatever one they want and then the subsystem will select a random event from the pool of pre-generated events.
 * The random define is for events such as anomalies so they are still run during higher level events.
 */

// Bubberstation Pop Overrides

#define EVENT_LOWPOP_THRESHOLD 15
#define EVENT_MIDPOP_THRESHOLD 30
#define EVENT_HIGHPOP_THRESHOLD 50
