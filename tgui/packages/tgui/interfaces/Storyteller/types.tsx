import type { StringLike } from 'bun';
import type { BooleanLike } from 'tgui-core/react';

export type StorytellerGoal = {
  id: string;
  name?: string;
  desc?: StringLike;
  weight?: number;
  is_antagonist?: BooleanLike;
};

export type DifficultyLevel = {
  value: number;
  label: string;
  tooltip: string;
  minPlayers: number;
};

export type StorytellerCandidates = {
  name: string;
  id: string;
};

export type StorytellerMood = {
  id: string;
  name: string;
  pace: number;
  threat?: number;
};

export type StorytellerEventLog = {
  desc: string;
  status?: string;
  id?: string;
  fired_at?: string;
};

export type StorytellerUpcomingGoal = {
  id: string;
  name?: string;
  desc?: string;
  storyteller_implementation?: BooleanLike;
  fire_time: number;
  category?: number;
  status: string;
  weight?: number;
  progress?: number;
  is_antagonist?: BooleanLike;
};

export type StorytellerData = {
  id: string;
  name: string;
  desc?: string;
  ooc_desc?: string;
  ooc_difficulty?: string;
  mood?: StorytellerMood;
  upcoming_goals?: StorytellerUpcomingGoal[];
  next_think_time?: number;
  base_think_delay?: number;
  average_event_interval?: number;
  threat_growth_rate: number;
  grace_period: number;
  threat_level?: number;
  effective_threat_level?: number;
  round_progression?: number;
  target_tension?: number;
  current_tension?: number;
  recent_events?: StorytellerEventLog[];
  player_count?: number;
  antag_count?: number;
  player_antag_balance?: number;
  event_difficulty_modifier?: number;
  available_moods?: StorytellerMood[];
  available_goals?: StorytellerGoal[];
  candidates?: StorytellerCandidates[];
  can_force_event?: BooleanLike;
  current_world_time?: number;
};

export type scrollConfigProp = {
  value: string;
  setValue: (value: string) => void;
  onSet: () => void;
  max: number;
  min: number;
  step: number;
  delim?: number;
};

export const DIFFICULTY_LEVELS: readonly DifficultyLevel[] = [
  {
    value: 0.3,
    label: 'Extended',
    tooltip: 'Peaceful mode - minimal threats, more positive events',
    minPlayers: 0,
  },
  {
    value: 0.7,
    label: 'Adventure story',
    tooltip: 'Easy mode - moderate events, balance between good and bad',
    minPlayers: 0,
  },
  {
    value: 1.0,
    label: 'Strive to survive',
    tooltip: 'Standard mode - balanced events and threats',
    minPlayers: 15,
  },
  {
    value: 2.0,
    label: 'Blood and dust',
    tooltip:
      'Hard mode - frequent threats and event escalation \n\n Recommended for: \n Experienced players who want to struggle to survive',
    minPlayers: 30,
  },
  {
    value: 5.0,
    label: 'Losing is Fun',
    tooltip:
      'Extreme mode - maximum difficulty and constant threats. \n\n Recommended for: \n \
        Experienced players who want to face a brutal, unfair challenge where even \
        great skill may not prevent death \n Lovers of tragedy \n Digital masochists',
    minPlayers: 50,
  },
];

// Tooltips for parameters in status and settings
export const TOOLTIPS = {
  // Status (Overview)
  mood: 'The current mood of the storyteller. It acts as a modifier for event difficulty and directly influences the interval between events. Each mood has its own pace and aggression.',
  tension:
    'Current round tension (0-100%). Shows the overall level of stress and threats on the station. Higher values may lead to more positive events for balance.',
  targetTension:
    'Target tension (0-100%). The storyteller strives to maintain it by planning events: low values decrease the overall difficulty modifier, high values increase it. Values closer to 100 lead to extreme event difficulty.',
  threatLevel:
    'Threat level (0-100%). Shows the current threat points available to the storyteller (from 1 to 10,000). Used for scaling event intensity.',
  effectiveThreat:
    'Effective threat level (accounts for players and progress). Based on round time, antagonist activity, and overall tension. Determines the actual difficulty of events.',
  roundProgression:
    'Round progression (0-1). When it reaches 1, nearly all events become available. By default, the maximum progression level is reached in two hours.',
  playersAntags:
    'Number of players / antagonists. Current ratio of active players on the station (not in guest roles and not engaged in ERP) to active antagonists.',
  balance:
    'Antagonist balance (0-100%). Below 40% — "boring," storyteller intensifies antagonist branches; above 60% — "chaos," adds neutral events for a breather.',
  difficulty:
    'Event difficulty modifier (×1). Overall modifier that increases the threat points applied to an event. Affects the intensity of all events.',
  nextThink:
    'Time until the storyteller\'s next "think." At this point, it analyzes the station and plans events.',

  // Settings (Settings & Advanced)
  moodSelect:
    'Mood selection to change the global objective style. Each mood affects planning pace: "Fast Chaos" — frequent antagonist branches, "Slow Schemer" — hidden sub-objectives.',
  pace: 'Event pace multiplier (0.5-2.0). 0.5 — slows sub-objective intervals for deep roleplay; 2.0 — accelerates for dynamic rounds, like in RimWorld with "manic miner."',
  reanalyse:
    'Reanalyze station: recalculates players, threats, and balance to adjust the plan. Use when there are significant changes on the station.',
  replan:
    'Replan: launches the analyzer and rebuilds the event queue based on the obtained data. Use for a complete plan revision.',
  difficultySlider:
    'Global difficulty multiplier (0.3-5.0). Increases the threat points received by the storyteller, as well as the amount of threat points allocated to events. High values make the round significantly harder.',
  targetTensionSlider:
    'Target tension for auto-balance. The storyteller plans events to achieve it: low — peaceful sub-objectives, high — escalation of antagonist branches.',
  threatGrowthRate:
    'Threat growth rate (0.1-5.0). Amount of threat points received by the storyteller per thinking cycle. High values lead to rapid threat accumulation.',
  thinkDelay:
    'Think delay (seconds, 1-240). Frequent thinking — for dynamic branch planning; rare — for strategic approach, like in RimWorld with long-term threats.',
  averageEventInterval:
    'Minimum event interval (seconds, 1-60). Short — for quick sub-objectives and high pace; long — for pauses to players in global objective branches.',
  gracePeriod:
    'Grace period (seconds, 120-1200). Time after an event when repeats are not planned — prevents spamming sub-objectives in the chain.',
  repetitionPenalty:
    'Repetition penalty (0.25-1.0). Reduces weight of repeating events in sub-objectives; 1.0 — no penalty, for cyclic global objectives like "infection."',
} as const;
