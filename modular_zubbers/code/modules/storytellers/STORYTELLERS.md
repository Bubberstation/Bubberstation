# Storyteller System

## General Description

The Storyteller System is a dynamic system for managing events and goals on the station, inspired by RimWorld mechanics. It analyzes the station's state, balances game events, and creates an adaptive gameplay experience, automatically adjusting difficulty to the current situation. The system operates as an intelligent director that monitors station conditions, predicts player needs, and orchestrates events to maintain engaging gameplay without manual intervention.

## System Architecture

### Core Components

The storyteller system is built around several interconnected components that work together to create adaptive storytelling:

#### 1. Storyteller Core (`~storyteller.dm`)

The central datum that orchestrates all storyteller operations. It maintains the system's state and coordinates between components:

- **Initialization**: Sets up mood, behavior, planner, analyzer, and balancer components
- **Think Loop**: Runs every 2-4 minutes (scaled by mood), performing analysis, planning, and event execution
- **Threat Management**: Accumulates threat points over time, manages adaptation factor for difficulty scaling
- **Population Scaling**: Adjusts event frequency and intensity based on player count
- **Antagonist Integration**: Handles roundstart antagonist selection and mid-round spawning

Key variables:

- `threat_points`: Accumulates over time to scale event intensity (0-10000)
- `adaptation_factor`: Reduces threat after crew successes (0-1, lower = more adapted)
- `population_factor`: Scales events for crew size (0.3-1.0)
- `current_tension`: Overall station tension level (0-100)

#### 2. Behavior System (`storyteller_behevour.dm`)

Determines how the storyteller selects and categorizes events. The behavior analyzes station state and generates tag filters for event selection:

- **Tokenization**: Analyzes metrics to generate relevant event tags (combat, health, environmental, etc.)
- **Category Determination**: Decides between good/bad/neutral events based on tension and mood
- **Weighted Selection**: Applies various modifiers to event weights (repetition penalty, tag matching, difficulty scaling)

Available behaviors:

- **Default**: Balanced, adaptive selection
- **Random**: Completely random tag selection for unpredictable gameplay
- **Inverted**: Every third bad event becomes good for chaotic storytelling

#### 3. Planner (`storyteller_planner.dm`)

Manages the event timeline and scheduling:

- **Timeline Management**: Maintains a queue of upcoming events with fire times
- **Anti-Clustering**: Prevents events from firing too close together
- **Recalculation**: Periodically rebuilds the plan based on changing station state
- **Major Event Spacing**: Enforces cooldowns between significant events

Key features:

- Maintains at least 3 pending events in timeline
- Scales event intervals based on population and mood
- Handles event replanning when conditions change

#### 4. Balancer (`~storyteller_balancer.dm`)

Calculates the balance between station strength and antagonist threats:

- **Station Strength**: Weighted calculation of crew health, integrity, power, resources, research, and security
- **Antagonist Strength**: Based on activity, effectiveness, and numbers
- **Tension Calculation**: Complex formula considering damage, security, integrity, resources, and activity
- **Balance Ratio**: Antagonist strength vs station strength (higher = antags stronger)

Tension formula includes:

- Security penalties for low officer counts
- Integrity penalties for station damage
- Resource penalties for low supplies
- Activity modifiers from antagonist actions
- Tension bonuses from recent events

#### 5. Analyzer (`~storyteller_analyzer.dm`)

Collects and processes station metrics from various sources:

- **Metric Collection**: Gathers data from crew health, station integrity, power systems, etc.
- **Input Processing**: Converts raw data into normalized values for decision-making
- **Vault Storage**: Maintains the metrics vault for system-wide access

#### 6. Mood System (`storyteller_mood.dm`)

Influences storyteller personality and pacing:

- **Aggression**: Threat multiplier (0.0-2.0, higher = more dangerous events)
- **Pace**: Event frequency multiplier (0.1-3.0, higher = more events)
- **Volatility**: Randomness in decisions (0.0-2.0, higher = more unpredictable)

Available moods:

- **Chill**: Low aggression, slow pace, minimal volatility
- **Classic**: Balanced settings for traditional gameplay
- **Gambit**: High volatility for unpredictable rounds
- **Catastrophe**: High aggression, fast pace for intense rounds

### Metrics System

The metrics system collects data from across the station:

#### Crew Metrics

- **Health**: Average crew health percentage (0-100)
- **Wounds**: Categorizes wound severity (none/some/many/critical)
- **Diseases**: Tracks disease prevalence (none/minor/major/outbreak)
- **Deaths**: Death counts and ratios for tension calculation

#### Station Metrics

- **Integrity**: Overall structural health (0-100)
- **Power**: Grid strength and damage levels
- **Resources**: Minerals and cargo points available
- **Security**: Active officer count and alert status

#### Antagonist Metrics

- **Activity**: Tracks kills, objectives, and disruption
- **Effectiveness**: Success rate of antagonist actions
- **Presence**: Number and types of active antagonists

### Subsystem Integration

- **SSstorytellers**: Manages storyteller lifecycle and voting
- **Event Control**: Integrates with the round event system
- **UI System**: Provides administrative interface for monitoring

## Decision-Making Process

The storyteller's decision-making follows a structured process every think cycle:

### 1. State Analysis

- Collects current metrics from the analyzer
- Creates a balance snapshot with station/antagonist strengths
- Updates tension level and adaptation factor

### 2. Mood Adaptation

- Adjusts mood based on tension vs target tension
- Updates pace, aggression, and volatility multipliers

### 3. Event Planning

- Determines event category (good/bad/neutral) based on tension and mood
- Generates tag filters based on station conditions
- Selects and weights available events
- Plans event timing in the timeline

### 4. Threat Management

- Accumulates threat points over time
- Applies adaptation decay after successes
- Scales threat by population and difficulty

### 5. Antagonist Balance

- Checks if additional antagonists should spawn
- Maintains target balance ratio between players and threats

## Event Selection Logic

Event selection is a multi-stage process designed to create coherent, responsive storytelling:

### Tag-Based Filtering

The behavior system analyzes station state to generate relevant tags:

**Tone Tags**: Epic, Tragic, Humorous - set event atmosphere
**Category Tags**: Escalation/Deescalation, Combat, Social, Environmental
**Impact Tags**: Wide Impact, Targets Individuals, Affects Whole Station
**Requirement Tags**: Requires Security, Engineering, Medical
**Special Tags**: Health, Antagonist, Major, Roundstart

### Category Determination

Based on current tension and mood:

- **High Tension + Low Target**: Prefer GOOD events (recovery/relief)
- **Low Tension + High Target**: Prefer BAD events (challenge/threat)
- **Balanced Tension**: NEUTRAL events (variety)

### Weight Calculation

Each event receives a base weight modified by:

- **Repetition Penalty**: Reduces weight of recently fired events (decays over 20 minutes)
- **Tag Matching Bonus**: Increases weight for events matching desired tags
- **Tension Balancing**: Boosts events that help correct tension imbalance
- **Population Scaling**: Adjusts for crew size (larger crews = more events)
- **Difficulty Scaling**: Applies global difficulty multiplier
- **Timeline Conflicts**: Reduces weight if event already planned

### Selection Process

1. Filter events by availability and requirements
2. Apply all weighting modifiers
3. Pick weighted random event from candidates
4. Verify event can fire immediately
5. Add to planner timeline with calculated fire time

## Threat Points and Adaptation

### Threat Point Mechanics

Threat points represent accumulated narrative pressure that scales event intensity:

- **Accumulation**: +1.0 per think cycle, scaled by mood aggression and population
- **Maximum**: Capped at 10000 points (apocalyptic level)
- **Scaling**: Events use threat points to determine intensity/difficulty

Threat levels:

- **Low** (0-100): Minor events, basic challenges
- **Moderate** (100-500): Standard events, balanced threats
- **High** (500-2000): Major events, significant challenges
- **Extreme** (2000-5000): Crisis events, station-wide threats
- **Apocalyptic** (5000+): Catastrophic events, existential threats

### Adaptation System

Adaptation reduces threat intensity after crew successes:

- **Trigger**: Increases after escalation-tagged events
- **Decay**: -0.05 per think cycle when active
- **Effect**: Reduces effective threat by up to 50%
- **Reset**: Gradual recovery allows threat to return

### Scaling Factors

- **Population**: Low pop (0.3x) reduces threat, high pop (1.0x) increases threat
- **Mood**: Aggression multiplier directly scales threat
- **Difficulty**: Global multiplier for server-wide tuning

## Event Addition Process

### Creating New Events

1. **Define Event Control** (`storyteller_event_control.dm`):

   ```dm
   /datum/round_event_control/my_event
       name = "My Custom Event"
       typepath = /datum/round_event/my_event
       story_category = STORY_GOAL_BAD  // Category for storyteller
       tags = list(STORY_TAG_COMBAT, STORY_TAG_ESCALATION)  // Relevant tags
       story_weight = STORY_GOAL_BASE_WEIGHT  // Base selection weight
       requierd_threat_level = STORY_GOAL_THREAT_BASIC  // Minimum threat to fire
   ```

2. **Implement Event Datum** (`~round_event.dm`):

   ```dm
   /datum/round_event/my_event
       STORYTELLER_EVENT //define meaning - storyteller_implementation = TRUE, Enable storyteller features

       __setup_for_storyteller(threat_points, additional_args)
           // Use threat_points to scale event difficulty
           // Access storyteller inputs via get_inputs()
           // Get storyteller reference via get_executer()
   ```

3. **Configure Tags and Requirements**:
   - Choose appropriate category (GOOD/BAD/NEUTRAL/ANTAGONIST)
   - Add relevant tags for behavior matching
   - Set threat requirements and round progress minimums
   - Define weight for selection probability

4. **Implement Storyteller Hooks**:
   - Override `__start_for_storyteller()` for custom start logic
   - Override `__end_for_storyteller()` for cleanup
   - Use `get_inputs()` to access current station metrics
   - Use `get_executer()` to access storyteller for logging

### Integration Steps

1. Add event file to appropriate goals/ subdirectory
2. Update any relevant metrics if needed
3. Test event availability and weighting
4. Verify tag matching works correctly
5. Test threat point scaling

## Key Mechanics

### Mood System

Mood profiles define storyteller personality:

- **Pace Multiplier**: Affects think delay (0.1x to 3.0x normal)
- **Threat Multiplier**: Scales event danger (0.0x to 2.0x)
- **Variance Multiplier**: Adds randomness to decisions (0.0x to 2.0x)

Mood updates every 5 minutes based on tension vs target tension.

### Population Scaling

Adjusts all mechanics based on active player count:

- **Thresholds**: Low (< threshold_low), Medium, High, Full population
- **Event Frequency**: Low pop = longer intervals, high pop = shorter intervals
- **Threat Scaling**: Low pop = reduced threat, high pop = increased threat
- **Grace Periods**: Low pop = longer cooldowns between events

Population factor smooths changes to prevent jarring shifts.

### Tension Management

Tension (0-100) drives event selection and mood adaptation:

**Calculation Factors**:

- Security coverage (penalty for low officer counts)
- Station integrity (penalty for damage)
- Resource availability (penalty for shortages)
- Antagonist activity (bonus for active threats)
- Recent event history (bonuses from escalation/deescalation)

**Target Tension**: Storyteller aims to keep tension around target level (default 50)

**Adaptation**: Mood shifts to correct tension imbalances over time

### Antagonist Integration

Seamless integration with antagonist systems:

- **Roundstart Selection**: Chooses antagonists 10 minutes after round start
- **Mid-round Spawning**: Spawns additional threats to maintain balance
- **Activity Tracking**: Monitors antagonist effectiveness via component trackers
- **Balance Checks**: Every 30 minutes, evaluates if more antagonists needed
- **Weight Calculation**: Assigns threat weights based on antagonist type and equipment

## Principles of Operation

### Station Analysis

Continuous monitoring of station state through metrics collection and processing.

### Balancing

Dynamic calculation of player vs antagonist forces with tension-based adaptation.

### Planning

Timeline-based event scheduling with anti-clustering and mood-influenced pacing.

### Adaptation

Multi-layered adaptation to player count, round progress, crew performance, and antagonist effectiveness.

## Key Concepts

### Vault (Metrics Storage)

Associative list containing all station metrics, defined in `~storyteller_vault.dm`. Keys include health states, resource levels, antagonist counts, etc.

### Snapshot (State Snapshot)

Instantaneous capture of current balance state, containing normalized strength values, tension level, and balance ratios used for planning decisions.

### Mood

Dynamic personality system affecting pacing, aggression, and decision volatility. Updates based on tension feedback.

### Tension

Overall station stress level (0-100) calculated from damage, security, resources, and antagonist activity. Drives event category selection.

## Thresholds and Constants

Comprehensive threshold system for state classification:

- Health: Normal/Damaged/Low thresholds
- Wounds: Some/Many/Critical wound levels
- Diseases: Minor/Major/Outbreak severity
- Deaths: Moderate/High/Extreme death ratios
- Security: No/Weak/Moderate/Strong coverage
- Integrity: Minor/Major/Critical damage levels
- Power: Full/Low/Blackout/Critical failure states

All constants defined in `code/__DEFINES/~~bubber_defines/storytellers/`.

## Recent Improvements

### Balancing Fixes

1. **Health threshold logic**: Corrected order checking (worst to best)
2. **Force ratio calculation**: Removed incorrect ratio overwriting
3. **Security scaling**: Normalized security contribution values
4. **Antagonist strength**: Removed arbitrary centering, implemented weighted sum
5. **Health tension calculation**: Applied consistent normalization

### Overall Tension Improvement

Fully normalized tension calculation:

- Base tension normalization from event history
- Weighted antagonist effectiveness and activity combination
- Normalized coordination, stealth, and vulnerability factors
- Normalized force ratio and population factor calculations

## Usage

### For Administrators

Storyteller UI provides:

- Current state monitoring (tension, threat, balance)
- Parameter configuration (difficulty, mood, targets)
- Metric inspection and historical data
- Manual event triggering for testing

### For Developers

**Adding Events**:

1. Create event control with appropriate category and tags
2. Implement storyteller-compatible event datum
3. Configure weights, requirements, and threat levels
4. Test integration with existing metrics

**Adding Metrics**:

1. Define vault key in `~storyteller_vault.dm`
2. Create metric collector in `metrics/`
3. Update balancer calculations if needed
4. Verify normalization and integration

**Modifying Behavior**:

1. Extend `storyteller_behevour.dm` for custom logic
2. Override tokenization and selection methods
3. Test tag generation and event weighting
