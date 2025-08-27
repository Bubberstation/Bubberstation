/// The amount of energy needed to increase the burn force by 1 damage during electrocution. The below means that 100 damage will be dealt if you touch a max safe loaded powergrid. As ((4 MEGA JOULES) / HUMAN_MAXHEALTH) == ~30 KILO JOULES
#define JOULES_PER_DAMAGE (30 KILO JOULES)
/// Calculates the amount of burn force when applying this much energy to a mob via electrocution from an energy source.
#define ELECTROCUTE_DAMAGE(energy) (energy >= 1 KILO JOULES ? clamp(round(energy / JOULES_PER_DAMAGE) + rand(-5,5), 10, (HUMAN_MAXHEALTH-10)) : 0)

/// Health buff for having the oversized quirk.
#define OVERSIZED_HEALTH_BUFF 1.4
