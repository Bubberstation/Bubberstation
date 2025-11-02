# Storyteller System

## General Description

The Storyteller System is a dynamic system for managing events and goals on the station, inspired by RimWorld mechanics. It analyzes the station's state, balances game events, and creates an adaptive gameplay experience, automatically adjusting difficulty to the current situation.

## System Architecture

### Main Components

#### 1. Core (System Core)

- **storyteller.dm** - Main storyteller datum, manages the entire lifecycle
- **storyteller_balancer.dm** - Balancing system, analyzes the ratio of player and antagonist forces
- **storyteller_analyzer.dm** - Station analyzer, collects metrics about the station's state
- **storyteller_inputs.dm** - Storage for input data for analysis and planning
- **storyteller_planner.dm** - Goal and event planner, builds timelines
- **storyteller_mood.dm** - Mood system, influences event pace and aggression
- **storyteller_log.dm** - Action logging system for the storyteller

#### 2. Metrics

Metrics collect data on various aspects of the station:

- **health.dm** - Crew and antagonist health analysis (health, wounds, diseases, deaths)
- **station_integrity.dm** - Station integrity (hull damage, infrastructure, fires)
- **power_grid_check.dm** - Power grid status (APC, SMES, power output)
- **station_strength.dm** - Station strength (crew readiness, security, resources)
- **resources.dm** - Station resources (minerals, other materials)
- **research.dm** - Research progress
- **utility.dm** - Utility metrics

**Antagonist Metrics:**

- **metric.dm** - Main antagonist activity metric
- **effectivity.dm** - Antagonist effectiveness (damage, kills, objectives)
- **\_tracker.dm** - Tracker for individual antagonist activity

#### 3. Goals (Goals and Events)

#### 4. Subsystem

- **SSstorytellers.dm** - Storytellers subsystem, manages the active storyteller
- **storyteller_ui.dm** - User interface for administrators
- **storyteller_vote.dm** - Storyteller voting system

#### 5. Thinking (Decision Logic)

- **storyteller_think.dm** - Decision-making logic, event and goal selection

#### 6. Overrides

- **atom_storyvalue.dm** - Values for atoms (object importance)
- **jobs.dm** - Values for jobs

## Principles of Operation

### 1. Station Analysis

The system continuously analyzes:

- Crew and antagonist health
- Station and infrastructure integrity
- Resources and power supply
- Antagonist activity
- Research progress
- Force ratios

### 2. Balancing

The balancer calculates:

- **Station Strength** - Station strength (crew readiness, security, resources)
- **Antagonist Strength** - Antagonist strength (activity, effectiveness, numbers)
- **Overall Tension** - Overall tension (0-100), influences event selection
- **Ratio** - Antagonist-to-station force ratio

### 3. Planning

The planner:

- Selects goals based on current state
- Builds event timelines
- Accounts for storyteller mood
- Avoids repeating recent events

### 4. Adaptation

The system adapts to:

- Number of players
- Round progress
- Crew successes/failures
- Antagonist effectiveness

## Key Concepts

### Vault (Metrics Storage)

Vault is an associative list storing all station metrics. Keys are defined in `~storyteller_vault.dm`.

### Snapshot (State Snapshot)

Snapshot is an instantaneous capture of the current balance, used by the planner for decisions.

### Mood

Storyteller mood determines:

- **Pace** - Event pace
- **Aggression** - Aggression level
- **Volatility** - Volatility (unpredictability)

### Tension

Overall tension (0-100) is calculated based on:

- Base tension from goal history
- Antagonist contributions (effectiveness and activity)
- Station integrity
- Crew health
- Qualitative factors (coordination, stealth, vulnerability)

## Thresholds and Constants

The system uses numerous thresholds for state classification:

- Health thresholds (HEALTH_NORMAL_THRESHOLD, HEALTH_DAMAGED_THRESHOLD, HEALTH_LOW_THRESHOLD)
- Wound thresholds (WOUNDING_SOME_THRESHOLD, WOUNDING_MANY_THRESHOLD, WOUNDING_CRITICAL_THRESHOLD)
- Disease thresholds (DISEASES_MINOR_THRESHOLD, DISEASES_MAJOR_THRESHOLD, DISEASES_OUTBREAK_THRESHOLD)
- Death ratio thresholds (DEAD_RATIO_MODERATE_THRESHOLD, DEAD_RATIO_HIGH_THRESHOLD, DEAD_RATIO_EXTREME_THRESHOLD)

All constants are defined in `code/__DEFINES/~~bubber_defines/storytellers/`.

## Recent Improvements

### Balancing Fixes

1. **Fixed health threshold logic** - Thresholds now checked in correct order (worst to best)
2. **Improved force ratio calculation** - Removed incorrect ratio overwriting
3. **Fixed security scaling** - Normalized security_contribution value
4. **Improved antagonist strength calculation** - Removed arbitrary centering, uses weighted sum
5. **Fixed health tension calculation** - Consistent normalization application

### Overall Tension Improvement

The overall tension calculation function now uses fully normalized values instead of raw ones:

- Normalization of base tension from history
- Weighted combination of antagonist effectiveness and activity
- Normalized coordination, stealth, and vulnerability values
- Normalized force ratio calculation
- Normalized population factor

## Usage

### For Administrators

Use the storyteller UI (`storyteller_ui.dm`) to:

- View current state
- Configure storyteller parameters
- Monitor metrics

### For Developers

When adding new events:

1. Create a new goal in the appropriate category
2. Specify event tags and categories
3. Configure trigger conditions
4. Define metric impacts

When adding new metrics:

1. Add key to `~storyteller_vault.dm`
2. Create metric in `metrics/`
3. Update balancer if necessary

## Future Improvements

- Additional metrics for more precise analysis
- Expanded goal system
- Improved adaptation to different playstyles
- Finer threshold and weight tuning
