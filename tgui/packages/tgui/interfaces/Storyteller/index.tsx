import {
  Box,
  Button,
  Divider,
  Dropdown,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Table,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend, useLocalState } from '../../backend';
import { Window } from '../../layouts';

// Data contract expected from backend
// Refactored for chain: upcoming_goals list, removed global/sub/progress/weight

type StorytellerGoal = {
  id: string;
  name?: string;
  weight?: number;
  progress?: number; // 0..1 for individual goal
};

type StorytellerMood = {
  id: string;
  name: string;
  pace: number; // multiplier (e.g. 0.5 fast, 2.0 slow)
  threat?: number; // optional UI hint
};

type StorytellerEventLog = {
  time: number; // ticks
  desc: string;
  status?: string;
  id?: string;
};

type StorytellerUpcomingGoal = {
  id: string;
  name?: string;
  fire_time: number;
  category?: number;
  status: string;
  weight?: number;
  progress?: number;
};

type StorytellerData = {
  name: string;
  desc?: string;
  mood?: StorytellerMood;
  upcoming_goals?: StorytellerUpcomingGoal[]; // Chain preview
  next_think_time?: number;
  base_think_delay?: number;
  min_event_interval?: number;
  max_event_interval?: number;
  threat_level?: number; // 0..100
  effective_threat_level?: number;
  round_progression?: number; // 0..1
  target_tension?: number; // 0..100
  recent_events?: StorytellerEventLog[];
  player_count?: number;
  antag_count?: number;
  player_antag_balance?: number; // 0..100
  event_difficulty_modifier?: number;
  available_moods?: StorytellerMood[];
  available_goals?: StorytellerGoal[];
  can_force_event?: BooleanLike;
  current_world_time?: number; // For relative times
};

const formatTime = (ticks?: number, current_time?: number) => {
  if (!ticks && ticks !== 0) return '—';
  const relative = current_time ? ticks - current_time : ticks;
  const seconds = Math.floor(Math.abs(relative) / 10);
  const sign = relative < 0 ? '-' : '';
  return `${sign}${Math.abs(ticks)}t (${sign}${seconds}s)`;
};

const ProgressRow = ({ label, value }: { label: string; value?: number }) => {
  const pct = Math.max(0, Math.min(1, value ?? 0));
  return (
    <LabeledList.Item label={label}>
      <ProgressBar value={pct}>{Math.round(pct * 100)}%</ProgressBar>
    </LabeledList.Item>
  );
};

export const Storyteller = (props) => {
  const { data, act } = useBackend<StorytellerData>();
  const {
    name,
    desc,
    mood,
    upcoming_goals = [],
    next_think_time,
    base_think_delay,
    min_event_interval,
    max_event_interval,
    recent_events = [],
    player_count,
    antag_count,
    player_antag_balance,
    event_difficulty_modifier,
    available_moods = [],
    available_goals = [],
    can_force_event,
    current_world_time,
  } = data;

  const [tab, setTab] = useLocalState<
    'overview' | 'goals' | 'settings' | 'advanced'
  >('tab', 'overview');
  const [selectedMood, setSelectedMood] = useLocalState(
    'selectedMood',
    mood?.id || '',
  );
  const [pace, setPace] = useLocalState('pace', String(mood?.pace ?? 1.0));
  const [selectedGoal, setSelectedGoal] = useLocalState('selectedGoal', '');

  // Advanced parameter local states
  const [difficulty, setDifficulty] = useLocalState(
    'difficulty',
    String(event_difficulty_modifier ?? 1.0),
  );
  const [targetTension, setTargetTension] = useLocalState(
    'targetTension',
    '50',
  );
  const [thinkDelay, setThinkDelay] = useLocalState(
    'thinkDelay',
    String(base_think_delay ?? 0),
  );
  const [minInterval, setMinInterval] = useLocalState(
    'minInterval',
    String(min_event_interval ?? 0),
  );
  const [maxInterval, setMaxInterval] = useLocalState(
    'maxInterval',
    String(max_event_interval ?? 0),
  );
  const [grace, setGrace] = useLocalState('grace', '3000');
  const [repetitionPenalty, setRepetitionPenalty] = useLocalState(
    'repetitionPenalty',
    '0.5',
  );

  return (
    <Window
      title={`Storyteller — ${name || 'Unknown'}`}
      width={720}
      height={720}
    >
      <Window.Content scrollable>
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
        </Tabs>

        <Divider />

        {tab === 'overview' && (
          <>
            {desc ? <NoticeBox>{desc}</NoticeBox> : null}
            <Button icon="plus" onClick={() => act('toggle_debug')}>
              Toggle Storyteller debug mode
            </Button>
            <Section title="Status">
              <LabeledList>
                <LabeledList.Item label="Mood">
                  {mood ? `${mood.name} (pace ×${mood.pace})` : '—'}
                </LabeledList.Item>
                <LabeledList.Item label="Target tension">
                  {data.target_tension != null ? `${data.target_tension}` : '—'}
                </LabeledList.Item>
                <LabeledList.Item label="Threat Level">
                  {data.threat_level != null ? `${data.threat_level}/100` : '—'}
                </LabeledList.Item>
                <LabeledList.Item label="Effective Threat">
                  {data.effective_threat_level != null
                    ? `${data.effective_threat_level}/100`
                    : '—'}
                </LabeledList.Item>
                <ProgressRow
                  label="Round Progression"
                  value={data.round_progression ?? 1 / 1}
                />
                <LabeledList.Item label="Players / Antags">
                  {player_count ?? '—'} / {antag_count ?? '—'}
                </LabeledList.Item>
                <ProgressRow
                  label="Player / Antag Balance"
                  value={(player_antag_balance ?? 50) / 100}
                />
                <LabeledList.Item label="Event Difficulty">
                  ×{event_difficulty_modifier ?? 1}
                </LabeledList.Item>
                <LabeledList.Item label="Next Think In">
                  {next_think_time != null &&
                  next_think_time <= (current_world_time ?? 0)
                    ? 'thinking'
                    : formatTime(next_think_time, current_world_time)}
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Upcoming Chain">
              {upcoming_goals.length ? (
                <Table>
                  <Table.Row header>
                    <Table.Cell>Fire In</Table.Cell>
                    <Table.Cell>Goal</Table.Cell>
                    <Table.Cell>Status</Table.Cell>
                    <Table.Cell>Progress</Table.Cell>
                    <Table.Cell>Current Weight</Table.Cell>
                  </Table.Row>
                  {upcoming_goals.map((g, i) => (
                    <Table.Row key={i}>
                      <Table.Cell>
                        {g.fire_time <= (current_world_time ?? 0)
                          ? 'firing'
                          : formatTime(g.fire_time, current_world_time)}
                      </Table.Cell>
                      <Table.Cell>{g.name || g.id}</Table.Cell>
                      <Table.Cell>{g.status}</Table.Cell>
                      <Table.Cell>
                        {Math.round((g.progress ?? 0) * 100)}%
                      </Table.Cell>
                      <Table.Cell>{g.weight ?? '—'}</Table.Cell>
                      <Table.Cell>
                        <Button
                          icon="play"
                          onClick={() =>
                            act('trigger_goal', { offset: g.fire_time })
                          }
                        >
                          Fire
                        </Button>
                        <Button
                          icon="bolt"
                          onClick={() =>
                            act('remove_goal', { offset: g.fire_time })
                          }
                        >
                          Remove
                        </Button>
                      </Table.Cell>
                    </Table.Row>
                  ))}
                </Table>
              ) : (
                <Box opacity={0.6}>No chain planned.</Box>
              )}

              <Stack mt={1} wrap>
                <Stack.Item>
                  <Button icon="play" onClick={() => act('force_think')}>
                    Think Now
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="bolt"
                    disabled={!can_force_event}
                    onClick={() => act('trigger_event')}
                  >
                    Trigger Random
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button.Confirm
                    color="red"
                    icon="trash"
                    onClick={() => act('reschedule_chain')}
                  >
                    Reschedule Chain
                  </Button.Confirm>
                </Stack.Item>
                <Stack.Item>
                  <Button icon="fire" onClick={() => act('force_fire_next')}>
                    Fire Next
                  </Button>
                </Stack.Item>
              </Stack>
              <Stack.Item>
                <Button icon="plus" onClick={() => act('add_goal')}>
                  Schedule New Goal
                </Button>
              </Stack.Item>
            </Section>

            <Section title="Recent Events">
              {recent_events.length ? (
                <LabeledList>
                  {recent_events.map((ev, i) => (
                    <LabeledList.Item key={i} label={formatTime(ev.time)}>
                      {ev.desc} ({ev.status || '—'} - ID: {ev.id || '—'})
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              ) : (
                <Box opacity={0.6}>No events recorded.</Box>
              )}
            </Section>
          </>
        )}

        {tab === 'goals' && (
          <>
            <Section title="Insert to Chain">
              <Stack>
                <Stack.Item grow>
                  <Dropdown
                    selected={selectedGoal}
                    onSelected={(v) => setSelectedGoal(String(v))}
                    options={available_goals.map((g) => g.name || g.id)}
                    placeholder="Select a goal..."
                    width="100%"
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="check"
                    disabled={!selectedGoal}
                    onClick={() => {
                      const goal = available_goals.find(
                        (g) => (g.name || g.id) === selectedGoal,
                      );
                      if (goal) {
                        act('insert_goal_to_chain', { id: goal.id });
                      }
                    }}
                  >
                    Insert
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button icon="random" onClick={() => act('reschedule_chain')}>
                    Reschedule
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>

            <Section title="Available Goals">
              {available_goals.length ? (
                <LabeledList>
                  {available_goals.slice(0, 20).map((g) => (
                    <LabeledList.Item key={g.id} label={g.name || g.id}>
                      —
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              ) : (
                <Box opacity={0.6}>No goals available.</Box>
              )}
            </Section>

            <Section title="Chain Controls">
              <Stack mt={1} wrap>
                <Stack.Item>
                  <Button
                    icon="step-forward"
                    onClick={() => act('next_subgoal')}
                  >
                    Advance Chain
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          </>
        )}

        {tab === 'settings' && (
          <>
            <Section title="Mood & Pace">
              <LabeledList>
                <LabeledList.Item label="Mood">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={selectedMood}
                        onSelected={(v) => setSelectedMood(String(v))}
                        options={available_moods.map((m) => ({
                          value: m.id,
                          displayText: m.name,
                        }))}
                        placeholder="Select a mood..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        disabled={!selectedMood}
                        onClick={() => act('set_mood', { id: selectedMood })}
                      >
                        Set Mood
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Pace Multiplier">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={pace}
                        onSelected={(v) => setPace(String(v))}
                        options={[0.5, 0.75, 1, 1.25, 1.5, 2].map((v) =>
                          String(v),
                        )}
                        placeholder="Select pace..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_pace', { pace: Number(pace) || 1 })
                        }
                      >
                        Apply Pace
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Planning">
              <Stack wrap>
                <Stack.Item>
                  <Button icon="refresh" onClick={() => act('reanalyse')}>
                    Reanalyse Station
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button icon="calendar" onClick={() => act('replan')}>
                    Replan Chain
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          </>
        )}

        {tab === 'advanced' && (
          <>
            <Section title="Difficulty & Tension">
              <LabeledList>
                <LabeledList.Item label="Difficulty Multiplier">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={difficulty}
                        onSelected={(v) => setDifficulty(String(v))}
                        options={[0.75, 1, 1.25, 1.5, 2].map((v) => String(v))}
                        placeholder="Select difficulty..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_difficulty', {
                            value: Number(difficulty) || 1,
                          })
                        }
                      >
                        Apply
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Target Tension">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={targetTension}
                        onSelected={(v) => setTargetTension(String(v))}
                        options={[30, 40, 50, 60, 70].map((v) => String(v))}
                        placeholder="Select target tension..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_target_tension', {
                            value: Number(targetTension) || 50,
                          })
                        }
                      >
                        Apply
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Pacing & Intervals">
              <LabeledList>
                <LabeledList.Item label="Think Delay (ticks)">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={thinkDelay}
                        onSelected={(v) => setThinkDelay(String(v))}
                        options={[300, 600, 900, 1200, 1800, 2400].map((v) =>
                          String(v),
                        )}
                        placeholder="Select think delay..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_think_delay', {
                            value: Number(thinkDelay) || 600,
                          })
                        }
                      >
                        Apply
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Event Interval (ticks)">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={minInterval}
                        onSelected={(v) => setMinInterval(String(v))}
                        options={[200, 300, 400, 500, 600].map((v) =>
                          String(v),
                        )}
                        placeholder="Min"
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item grow>
                      <Dropdown
                        selected={maxInterval}
                        onSelected={(v) => setMaxInterval(String(v))}
                        options={[3000, 6000, 9000, 12000].map((v) =>
                          String(v),
                        )}
                        placeholder="Max"
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_event_intervals', {
                            min: Number(minInterval) || 300,
                            max: Number(maxInterval) || 9000,
                          })
                        }
                      >
                        Apply
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Grace Period (ticks)">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={grace}
                        onSelected={(v) => setGrace(String(v))}
                        options={[600, 1200, 1800, 2400, 3000].map((v) =>
                          String(v),
                        )}
                        placeholder="Select grace period..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_grace_period', {
                            value: Number(grace) || 3000,
                          })
                        }
                      >
                        Apply
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Repetition Penalty">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={repetitionPenalty}
                        onSelected={(v) => setRepetitionPenalty(String(v))}
                        options={[0.25, 0.5, 0.75, 1.0].map((v) => String(v))}
                        placeholder="Select penalty..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_repetition_penalty', {
                            value: Number(repetitionPenalty) || 0.5,
                          })
                        }
                      >
                        Apply
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </>
        )}
      </Window.Content>
    </Window>
  );
};
