import '../../styles/interfaces/StorytellerVote.scss';

import type { StringLike } from 'bun';
import { useState } from 'react';
import {
  Box,
  Button,
  Divider,
  Dropdown,
  Input,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
  Table,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { resolveAsset } from '../../assets';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';

// Tooltips for parameters in status and settings
// These explain how parameters affect event planning,
// global objectives, and branching sub-objectives, balancing threats, pacing, and antagonist activity for rounds.
const TOOLTIPS = {
  // Status (Overview)
  mood: 'The current mood of the storyteller. It acts as a modifier for event difficulty and directly influences the interval between events.',
  tension:
    'Current round tension (0-100%). Depending on the target tension the storyteller aims for, higher values may lead to more positive events.',
  targetTension:
    'Target tension (0-100%). The storyteller strives to maintain it by planning events: low values decrease the overall difficulty modifier, high values increase it. Values closer to 100 lead to extreme event difficulty.',
  threatLevel:
    'Threat level (0-100%). Indicates the current threat points available to the storyteller (from 1 to 10,000).',
  effectiveThreat:
    'Effective threat level (accounts for players and progress). Based on round time, antagonist activity, and overall tension.',
  roundProgression:
    'Round progression (0-1). When it reaches 1, nearly all events become available. By default, the upper progression level is reached in two hours.',
  playersAntags:
    'Number of players / antagonists. Current ratio of active players on the station (not in guest roles and not engaged in ERP) to active antagonists.',
  balance:
    'Antagonist balance (0-100%). Below 40% — "boring," storyteller intensifies antagonist branches; above 60% — "chaos," adds neutral events for a breather.',
  difficulty:
    'Event difficulty modifier (×1). Overall modifier that increases the threat points applied to an event.',
  nextThink:
    'Time until the storyteller\'s next "think." At this point, it analyzes the station.',

  // Settings (Settings & Advanced)
  moodSelect:
    'Mood selection to change the global objective style. Each mood affects planning pace: "Fast Chaos" — frequent antagonist branches, "Slow Schemer" — hidden sub-objectives.',
  pace: 'Event pace multiplier (0.5-2.0). 0.5 — slows sub-objective intervals for deep roleplay; 2.0 — accelerates for dynamic rounds, like in RimWorld with "manic miner."',
  reanalyse:
    'Reanalyze station: recalculates players, threats, and balance to adjust the plan.',
  replan:
    'Replan: launches the analyzer and rebuilds the event queue based on the obtained data.',
  difficultySlider:
    'Global difficulty multiplier (0.3-5). Increases the threat points received by the storyteller, as well as the amount of threat points allocated to events.',
  targetTensionSlider:
    'Target tension for auto-balance. The storyteller plans events to achieve it: low — peaceful sub-objectives, high — escalation of antagonist branches.',
  threatGrowthRate:
    'Threat growth rate (0.1-5). Amount of threat points received by the storyteller per thinking cycle.',
  thinkDelay:
    'Think delay (seconds, 1-240). Frequent thinking — for dynamic branch planning; rare — for strategic approach, like in RimWorld with long-term threats.',
  averageEventInterval:
    'Minimum event interval (seconds, 1-60). Short — for quick sub-objectives and high pace; long — for pauses to players in global objective branches.',
  gracePeriod:
    'Grace period (seconds, 120-1200). Time after an event when repeats are not planned — prevents spamming sub-objectives in the chain.',
  repetitionPenalty:
    'Repetition penalty (0.25-1.0). Reduces weight of repeating events in sub-objectives; 1.0 — no penalty, for cyclic global objectives like "infection."',
} as const;

type StorytellerGoal = {
  id: string;
  name?: string;
  desc?: StringLike;
  weight?: number;
  is_antagonist?: BooleanLike;
};

type StorytellerCandidates = {
  name: string;
  id: string;
};

type StorytellerMood = {
  id: string;
  name: string;
  pace: number; // multiplier (e.g. 0.5 fast, 2.0 slow)
  threat?: number;
};

type StorytellerEventLog = {
  desc: string;
  status?: string;
  id?: string;
  fired_at?: string;
};

type StorytellerUpcomingGoal = {
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

type StorytellerData = {
  id: string;
  name: string;
  desc?: string;
  ooc_desc?: string;
  ooc_difficulty?: string;
  mood?: StorytellerMood;
  upcoming_goals?: StorytellerUpcomingGoal[]; // Chain preview
  next_think_time?: number;
  base_think_delay?: number;
  average_event_interval?: number;
  threat_growth_rate: number;
  grace_period: number;
  threat_level?: number; // 0..100
  effective_threat_level?: number;
  round_progression?: number; // 0..1
  target_tension?: number; // 0..100
  current_tension?: number;
  recent_events?: StorytellerEventLog[];
  player_count?: number;
  antag_count?: number;
  player_antag_balance?: number; // 0..100
  event_difficulty_modifier?: number;
  available_moods?: StorytellerMood[];
  available_goals?: StorytellerGoal[];
  candidates?: StorytellerCandidates[];
  can_force_event?: BooleanLike;
  current_world_time?: number;
};

type scrollConfigProp = {
  value: any;
  setValue: (value: string) => void;
  onSet: any;
  max: number;
  min: number;
  step: number;
  delim?: number;
};

const InputScrollApply = (props: scrollConfigProp) => {
  const { value, setValue, onSet, min, max, step, delim = 1 } = props;

  return (
    <Stack>
      <Stack.Item grow>
        {''}
        <input
          type="range"
          min={min}
          max={max}
          step={step}
          defaultValue={value / delim}
          onChange={(e) =>
            setValue(String(Number(e.currentTarget.value) * delim))
          }
          style={{ width: '100%' }}
          width="100%"
        />
      </Stack.Item>
      <Stack.Item>{value / delim}</Stack.Item>
      <Stack.Item>
        <Button icon="check" tooltip="Apply" onClick={onSet} />
      </Stack.Item>
    </Stack>
  );
};

const formatTime = (ticks?: number, current_time?: number) => {
  if (!ticks && ticks !== 0) return '—';
  const relative = current_time ? ticks - current_time : ticks;
  const seconds = Math.floor(Math.abs(relative) / 10);
  const minutes = Math.floor(seconds / 60);
  const remainderSeconds = seconds % 60;
  const sign = relative < 0 ? '-' : '';
  if (minutes === 0) {
    return `${sign}${seconds}s`;
  }
  return `${sign}${minutes}m ${sign}${remainderSeconds.toString().padStart(2, '0')}s`;
};

const ProgressRow = ({
  label,
  value,
  color,
  tooltip,
}: {
  label: string;
  value?: number;
  color?: 'good' | 'average' | 'bad';
  tooltip?: string;
}) => {
  const pct = Math.max(0, Math.min(1, value ?? 0));
  return (
    <LabeledList.Item label={label} tooltip={tooltip}>
      <ProgressBar value={pct} color={color}>
        {Math.round(pct * 100)}%
      </ProgressBar>
    </LabeledList.Item>
  );
};

const UpcomingGoalItem = ({
  goal,
  current_world_time,
  act,
}: {
  goal: StorytellerUpcomingGoal;
  current_world_time?: number;
  act: any;
}) => {
  const [expanded, setExpanded] = useState(false);
  const isAntag = goal.is_antagonist;
  const isStoryteller = goal.storyteller_implementation;
  const fireTimeText =
    goal.fire_time <= (current_world_time ?? 0)
      ? 'Firing'
      : formatTime(goal.fire_time, current_world_time);

  const boxBgColor = isAntag
    ? 'rgba(255, 60, 60, 0.2)'
    : 'rgba(120,120,120,0.15)';
  const headerBgColor = isAntag
    ? 'rgba(255, 50, 50, 0.3)'
    : 'rgba(180,180,180,0.1)';

  return (
    <Box
      mb={1.5}
      p={1}
      style={{
        borderRadius: '2px',
        backgroundColor: boxBgColor,
        boxShadow: '0 2px 6px rgba(0,0,0,0.3)',
      }}
    >
      <Stack align="center">
        <Stack.Item grow>
          <Button
            icon={expanded ? 'chevron-down' : 'chevron-right'}
            onClick={() => setExpanded(!expanded)}
            backgroundColor={headerBgColor}
            color="white"
            textColor="white"
            fluid
            textAlign="left"
            style={{
              borderRadius: '2px',
              fontWeight: 600,
              textTransform: 'none',
              justifyContent: 'flex-start',
              padding: '0.4rem 0.7rem',
            }}
          >
            {goal.name || goal.id}
            {isAntag ? (
              <Box inline ml={1} color="red" opacity={0.9}>
                - antagonist
              </Box>
            ) : (
              ''
            )}
            {isStoryteller && !isAntag ? (
              <Box opacity={0.9} color="blue">
                {'(Storyteller)'}
              </Box>
            ) : (
              ''
            )}
          </Button>
        </Stack.Item>

        <Stack.Item>
          <Box
            px={1}
            py={0.3}
            style={{
              backgroundColor:
                goal.fire_time <= (current_world_time ?? 0)
                  ? 'rgba(0, 120, 255, 0.3)'
                  : 'rgba(255,255,255,0.1)',
              borderRadius: '2px',
              fontWeight: 500,
            }}
          >
            {fireTimeText}
          </Box>
        </Stack.Item>

        {!expanded && (
          <>
            <Stack.Item>
              <Button
                icon="play"
                tooltip="Fire"
                color="good"
                onClick={() => act('trigger_goal', { offset: goal.fire_time })}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="trash"
                tooltip="Remove"
                color="bad"
                onClick={() => act('remove_goal', { offset: goal.fire_time })}
              />
            </Stack.Item>
          </>
        )}
      </Stack>

      {expanded && (
        <Box
          mt={1}
          px={1}
          py={0.5}
          style={{
            backgroundColor: 'rgba(255,255,255,0.05)',
            borderRadius: '2px',
          }}
        >
          <LabeledList>
            <LabeledList.Item label="Status">
              <Box
                color={
                  goal.status === 'active'
                    ? 'good'
                    : goal.status === 'failed'
                      ? 'bad'
                      : 'average'
                }
                fontWeight={600}
              >
                {goal.status}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Weight">
              <Box>{goal.weight ?? '—'}</Box>
            </LabeledList.Item>

            <LabeledList.Item label="Description">
              <Box opacity={0.9}>
                {goal.desc || 'No description available.'}
              </Box>
            </LabeledList.Item>
          </LabeledList>

          <Stack mt={1}>
            <Stack.Item>
              <Button
                icon="play"
                tooltip="Fire"
                color="good"
                onClick={() => act('trigger_goal', { offset: goal.fire_time })}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="trash"
                tooltip="Remove"
                color="bad"
                onClick={() => act('remove_goal', { offset: goal.fire_time })}
              />
            </Stack.Item>
          </Stack>
        </Box>
      )}
    </Box>
  );
};

const GoalSearchDropdown = ({
  available_goals,
  selectedGoal,
  setSelectedGoal,
  onInsert,
}: {
  available_goals: StorytellerGoal[];
  selectedGoal: string;
  setSelectedGoal: (id: string) => void;
  onInsert: () => void;
}) => {
  const [searchTerm, setSearchTerm] = useState('');

  const searchKey = searchTerm;

  const filteredGoals = available_goals.filter((goal) => {
    if (!goal) return false;
    if (!searchTerm) return true;
    const text = String(goal.name ?? goal.id ?? '').toLowerCase();
    return text.includes(searchTerm.toLowerCase());
  });

  const handleGoalSelect = (goal: StorytellerGoal) => {
    setSelectedGoal(String(goal.id));
  };

  return (
    <Stack vertical>
      <Stack.Item>
        <Stack>
          <Stack.Item grow>
            <Input
              placeholder="Search events..."
              value={searchTerm}
              onChange={(str) => setSearchTerm(str)}
              width="100%"
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="check"
              tooltip="Insert Selected"
              disabled={!selectedGoal}
              onClick={onInsert}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow minHeight="120px">
        <Section scrollable fill key={searchKey}>
          {filteredGoals.length ? (
            filteredGoals.map((g) => (
              <Box
                key={g.id}
                mb={0.5}
                backgroundColor={g.is_antagonist ? 'color-red' : 'color-gray'}
                className={g.is_antagonist ? 'antag-goal' : ''}
                onClick={() => handleGoalSelect(g)}
                style={{
                  cursor: 'pointer',
                  opacity: selectedGoal === String(g.id) ? 1 : 0.7,
                }}
              >
                <Box>
                  {g.name ?? String(g.id)}
                  {g.is_antagonist && (
                    <Box inline ml={1}>
                      (antagonist)
                    </Box>
                  )}
                  {selectedGoal === String(g.id) && (
                    <Box inline ml={1}>
                      (selected)
                    </Box>
                  )}
                </Box>
              </Box>
            ))
          ) : (
            <Box opacity={0.6} color="white">
              No events found.
            </Box>
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const Storyteller = (props) => {
  const { data, act } = useBackend<StorytellerData>();
  const {
    name,
    desc,
    mood,
    id,
    ooc_desc,
    ooc_difficulty,
    upcoming_goals = [],
    next_think_time,
    base_think_delay,
    average_event_interval,
    threat_growth_rate,
    grace_period,
    target_tension,
    recent_events = [],
    player_count,
    antag_count,
    player_antag_balance,
    event_difficulty_modifier,
    candidates = [],
    available_moods = [],
    available_goals = [],
    can_force_event,
    current_world_time,
  } = data;

  // Replacement of useLocalState with useState
  const [tab, setTab] = useState<
    'overview' | 'goals' | 'settings' | 'advanced' | 'logs'
  >('overview');
  const [selectedMood, setSelectedMood] = useState(mood?.id || '');
  const [pace, setPace] = useState(String(mood?.pace ?? 1.0));
  const [selectedGoal, setSelectedGoal] = useState('');
  const [selectedCandidate, setSelectedCandidate] = useState('');
  // Advanced parameter local states
  const [difficulty, setDifficulty] = useState(
    String(event_difficulty_modifier ?? 1.0),
  );
  const [targetTension, setTargetTension] = useState(
    String(target_tension ?? 1.0),
  );
  const [threatGrowthRate, setThreatGrowthRate] = useState(
    String(threat_growth_rate ?? 1.0),
  );
  const [thinkDelay, setThinkDelay] = useState(String(base_think_delay ?? 0));
  const [averageEventInterval, setAverageEventInterval] = useState(
    String(average_event_interval ?? 0),
  );
  const [grace, setGrace] = useState(String(grace_period ?? 300));
  const [repetitionPenalty, setRepetitionPenalty] = useState(
    String(grace_period ?? 1),
  );

  const handleInsertGoal = () => {
    if (selectedGoal) {
      act('insert_goal_to_chain', { id: selectedGoal });
    }
  };

  const handleSetAverageEventInterval = () => {
    act('set_average_event_interval', {
      min: Number(averageEventInterval) || 1000,
    });
  };

  const handleSetThreatGrowthRate = () => {
    act('set_threat_growth_rate', { value: Number(threatGrowthRate) || 1 });
  };

  return (
    <Window
      title={`Storyteller — ${name || 'Unknown'}`}
      width={720}
      height={720}
      theme="stortellerVote"
    >
      <Window.Content
        scrollable
        style={{
          backgroundImage: id
            ? `url(${resolveAsset(`${id}_portrait.png`)})`
            : undefined,
          backgroundSize: '480px 480px',
          backgroundPositionX: '50%',
          backgroundPositionY: '100%',
        }}
      >
        <Stack>
          <Stack.Item grow>
            <Dropdown
              selected={selectedCandidate}
              onSelected={setSelectedCandidate}
              options={candidates.map((c) => ({
                value: c.id,
                displayText: c.name,
              }))}
              placeholder="Select storyteller"
              width="100%"
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="check"
              tooltip="Insert"
              disabled={!selectedCandidate}
              onClick={() => act('set_storyteller', { id: selectedCandidate })}
            />
          </Stack.Item>
        </Stack>
        <Tabs>
          <Tabs.Tab
            selected={tab === 'overview'}
            icon="info"
            onClick={() => setTab('overview')}
          >
            Overview
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 'goals'}
            icon="flag-checkered"
            onClick={() => setTab('goals')}
          >
            Chain
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 'settings'}
            icon="cog"
            onClick={() => setTab('settings')}
          >
            Settings
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 'advanced'}
            icon="sliders-h"
            onClick={() => setTab('advanced')}
          >
            Advanced
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 'logs'}
            icon="file-alt"
            onClick={() => setTab('logs')}
          >
            Logs
          </Tabs.Tab>
        </Tabs>
        <Divider />
        {tab === 'overview' && (
          <>
            <Section title="Overview">
              <h1>{name}</h1>
              <LabeledList>
                <LabeledList.Item label="Description">{desc}</LabeledList.Item>
                <LabeledList.Item label="OOC Description">
                  {ooc_desc}
                </LabeledList.Item>
                <LabeledList.Item label="OOC Difficulty">
                  {ooc_difficulty}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section title="Status">
              <LabeledList>
                <LabeledList.Item
                  label="Mood"
                  buttons={
                    <Button
                      icon="edit"
                      tooltip={TOOLTIPS.moodSelect}
                      onClick={() => setTab('settings')}
                    />
                  }
                >
                  {mood ? `${mood.name} (×${mood.pace})` : '—'}
                </LabeledList.Item>
                <ProgressRow
                  label="Tension"
                  value={(data.current_tension ?? 0) / 100}
                  color={
                    data.current_tension || 0 > (data.target_tension ?? 50)
                      ? 'bad'
                      : 'good'
                  }
                  tooltip={TOOLTIPS.tension}
                />
                <ProgressRow
                  label="Target Tension"
                  value={(data.target_tension ?? 0) / 100}
                  tooltip={TOOLTIPS.targetTension}
                />
                <ProgressRow
                  label="Threat Level"
                  value={(data.threat_level ?? 0) / 100}
                  color={
                    data.threat_level || 0 > 70
                      ? 'bad'
                      : data.threat_level || 0 > 30
                        ? 'average'
                        : 'good'
                  }
                  tooltip={TOOLTIPS.threatLevel}
                />
                <ProgressRow
                  label="Effective Threat"
                  value={(data.effective_threat_level ?? 0) / 100}
                  color={
                    data.effective_threat_level || 0 > 70
                      ? 'bad'
                      : data.effective_threat_level || 0 > 30
                        ? 'average'
                        : 'good'
                  }
                  tooltip={TOOLTIPS.effectiveThreat}
                />
                <ProgressRow
                  label="Round Progression"
                  value={data.round_progression ?? 0}
                  tooltip={TOOLTIPS.roundProgression}
                />
                <LabeledList.Item
                  label="Players / Antags"
                  tooltip={TOOLTIPS.playersAntags}
                >
                  {player_count ?? '—'} / {antag_count ?? '—'}
                </LabeledList.Item>
                <ProgressRow
                  label="Balance"
                  value={(player_antag_balance ?? 50) / 100}
                  color={
                    (player_antag_balance || 0) / 100 < 0.4
                      ? 'bad'
                      : (player_antag_balance || 0) / 100 < 0.6
                        ? 'average'
                        : 'good'
                  }
                  tooltip={TOOLTIPS.balance}
                />
                <LabeledList.Item
                  label="Difficulty"
                  tooltip={TOOLTIPS.difficulty}
                >
                  ×{event_difficulty_modifier ?? 1}
                </LabeledList.Item>
                <LabeledList.Item
                  label="Next Think"
                  tooltip={TOOLTIPS.nextThink}
                >
                  {(next_think_time || 0) <= (current_world_time ?? 0) ? (
                    <Box color="good">Thinking</Box>
                  ) : (
                    formatTime(next_think_time, current_world_time)
                  )}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </>
        )}
        {tab === 'goals' && (
          <>
            <Section title="Insert event">
              <GoalSearchDropdown
                available_goals={available_goals}
                selectedGoal={selectedGoal}
                setSelectedGoal={setSelectedGoal}
                onInsert={handleInsertGoal}
              />
            </Section>
            <Section title="Upcoming Chain">
              {upcoming_goals.length ? (
                <Box>
                  {upcoming_goals.map((g, i) => (
                    <UpcomingGoalItem
                      key={i}
                      goal={g}
                      current_world_time={current_world_time}
                      act={act}
                    />
                  ))}
                </Box>
              ) : (
                <Box opacity={0.6}>No chain planned.</Box>
              )}
              <Stack mt={1} wrap>
                <Stack.Item>
                  <Button.Confirm
                    icon="trash"
                    tooltip="Reschedule"
                    color="red"
                    onClick={() => act('reschedule_chain')}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="fire"
                    tooltip="Fire Next"
                    onClick={() => act('force_fire_next')}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="plus"
                    tooltip="Add Goal"
                    onClick={() => act('add_goal')}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="brain"
                    tooltip="Force Think"
                    onClick={() => act('force_think')}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="bolt"
                    tooltip="Force check and spawn antagonist wave"
                    color="red"
                    onClick={() => act('force_check_atnagoinst')}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="bug"
                    tooltip="Toggle debug mode"
                    onClick={() => act('toggle_debug')}
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </>
        )}
        {tab === 'settings' && (
          <>
            <Section title="Mood & Pace">
              <LabeledList>
                <LabeledList.Item label="Mood" tooltip={TOOLTIPS.moodSelect}>
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={selectedMood}
                        onSelected={setSelectedMood}
                        options={available_moods.map((m) => ({
                          value: m.id,
                          displayText: m.name,
                        }))}
                        placeholder="Select mood..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Set"
                        disabled={!selectedMood}
                        onClick={() => act('set_mood', { id: selectedMood })}
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Pace" tooltip={TOOLTIPS.pace}>
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={pace}
                        onSelected={setPace}
                        options={[0.5, 0.75, 1, 1.25, 1.5, 2].map(String)}
                        placeholder="Select pace..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={() =>
                          act('set_pace', { pace: Number(pace) || 1 })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section title="Planning">
              <Stack wrap>
                <Stack.Item>
                  <Button
                    icon="search"
                    tooltip={TOOLTIPS.reanalyse}
                    onClick={() => act('reanalyse')}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="calendar"
                    tooltip={TOOLTIPS.replan}
                    onClick={() => act('replan')}
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </>
        )}
        {tab === 'advanced' && (
          <>
            <Section title="Configuration">
              <LabeledList>
                <Stack>
                  <Stack.Item>
                    <Button
                      icon="download"
                      tooltip="Reload event configuration"
                      onClick={() => act('reload_event_config')}
                    />
                    <Button
                      icon="upload"
                      tooltip="Reload storyteller data"
                      onClick={() => act('reload_storyteller_config')}
                    />
                    <Button
                      icon="cog"
                      tooltip="Reload current storyteller from data"
                      onClick={() => act('reload_current_storyteller')}
                    />
                  </Stack.Item>
                </Stack>
              </LabeledList>
            </Section>
            <Section title="Difficulty & Tension">
              <LabeledList>
                <LabeledList.Item
                  label="Difficulty"
                  tooltip={TOOLTIPS.difficultySlider}
                >
                  <InputScrollApply
                    value={difficulty}
                    setValue={setDifficulty}
                    max={5}
                    min={0.3}
                    step={0.1}
                    onSet={() =>
                      act('set_difficulty', {
                        value: Number(difficulty) || 1,
                      })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item
                  label="Target Tension"
                  tooltip={TOOLTIPS.targetTensionSlider}
                >
                  <InputScrollApply
                    value={targetTension}
                    setValue={setTargetTension}
                    max={100}
                    min={1}
                    step={1}
                    onSet={() =>
                      act('set_target_tension', {
                        value: Number(targetTension) || 1,
                      })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item
                  label="Threat growth rate"
                  tooltip={TOOLTIPS.threatGrowthRate}
                >
                  <InputScrollApply
                    value={threatGrowthRate}
                    setValue={setThreatGrowthRate}
                    max={5}
                    min={0.1}
                    step={0.1}
                    onSet={handleSetThreatGrowthRate}
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section title="Pacing & Intervals">
              <LabeledList>
                <LabeledList.Item
                  label="Think Delay"
                  tooltip={`${TOOLTIPS.thinkDelay} (in ticks / 10 = seconds)`}
                >
                  <InputScrollApply
                    value={thinkDelay}
                    setValue={setThinkDelay}
                    max={240}
                    min={1}
                    step={1}
                    delim={10}
                    onSet={() =>
                      act('set_think_delay', {
                        value: Number(thinkDelay) || 1,
                      })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item
                  label="Event Interval - min"
                  tooltip={TOOLTIPS.averageEventInterval}
                >
                  <Stack>
                    <Stack.Item grow>
                      {''}
                      <input
                        type="range"
                        min={1}
                        max={60}
                        step={1}
                        defaultValue={Number(averageEventInterval) / 1000}
                        onChange={(e) =>
                          setAverageEventInterval(
                            String(Number(e.currentTarget.value) * 1000),
                          )
                        }
                        style={{ width: '100%' }}
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      {Number(averageEventInterval) / 1000}
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={handleSetAverageEventInterval}
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item
                  label="Grace Period"
                  tooltip={TOOLTIPS.gracePeriod}
                >
                  <InputScrollApply
                    value={grace}
                    setValue={setGrace}
                    max={1200}
                    min={120}
                    step={10}
                    delim={10}
                    onSet={() =>
                      act('set_grace_period', {
                        value: Number(grace) || 1,
                      })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item
                  label="Repetition Penalty"
                  tooltip={TOOLTIPS.repetitionPenalty}
                >
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={repetitionPenalty}
                        onSelected={setRepetitionPenalty}
                        options={[0.25, 0.5, 0.75, 1.0].map(String)}
                        placeholder="Select..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={() =>
                          act('set_repetition_penalty', {
                            value: Number(repetitionPenalty) || 0.5,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </>
        )}
        {tab === 'logs' && (
          <Section title="Action Logs">
            {recent_events.length ? (
              <Table>
                <Table.Row header>
                  <Table.Cell>Time</Table.Cell>
                  <Table.Cell>Desc</Table.Cell>
                  <Table.Cell>Status</Table.Cell>
                  <Table.Cell>ID</Table.Cell>
                </Table.Row>
                {recent_events.map((ev, i) => (
                  <Table.Row
                    key={i}
                    className={
                      ev.status === 'success'
                        ? 'color-good'
                        : ev.status === 'failed'
                          ? 'color-bad'
                          : ''
                    }
                  >
                    <Table.Cell>{ev.fired_at || ' '}</Table.Cell>
                    <Table.Cell>{ev.desc}</Table.Cell>
                    <Table.Cell
                      color={
                        ev.status === 'success'
                          ? 'good'
                          : ev.status === 'failed'
                            ? 'bad'
                            : 'average'
                      }
                    >
                      {ev.status || '—'}
                    </Table.Cell>
                    <Table.Cell>{ev.id || '—'}</Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            ) : (
              <Box opacity={0.6}>No logs.</Box>
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
