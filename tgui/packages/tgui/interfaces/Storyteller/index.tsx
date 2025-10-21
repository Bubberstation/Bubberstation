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
  threat?: number;
};

type StorytellerEventLog = {
  time: number;
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
  current_tension?: number;
  recent_events?: StorytellerEventLog[];
  player_count?: number;
  antag_count?: number;
  player_antag_balance?: number; // 0..100
  event_difficulty_modifier?: number;
  available_moods?: StorytellerMood[];
  available_goals?: StorytellerGoal[];
  can_force_event?: BooleanLike;
  current_world_time?: number;
};

const formatTime = (ticks?: number, current_time?: number) => {
  if (!ticks && ticks !== 0) return '—';
  const relative = current_time ? ticks - current_time : ticks;
  const seconds = Math.floor(Math.abs(relative) / 10);
  const sign = relative < 0 ? '-' : '';
  return `${sign}${Math.abs(ticks)}t (${sign}${seconds}s)`;
};

const ProgressRow = ({
  label,
  value,
  color,
}: {
  label: string;
  value?: number;
  color?: 'good' | 'average' | 'bad';
}) => {
  const pct = Math.max(0, Math.min(1, value ?? 0));
  return (
    <LabeledList.Item label={label}>
      <ProgressBar value={pct} color={color}>
        {Math.round(pct * 100)}%
      </ProgressBar>
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
    'overview' | 'goals' | 'settings' | 'advanced' | 'logs'
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
            {desc && <NoticeBox info>{desc}</NoticeBox>}
            <Button
              icon="bug"
              tooltip="Toggle debug mode"
              onClick={() => act('toggle_debug')}
            />
            <Section title="Status">
              <LabeledList>
                <LabeledList.Item
                  label="Mood"
                  buttons={
                    <Button
                      icon="edit"
                      tooltip="Change mood"
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
                />
                <ProgressRow
                  label="Target Tension"
                  value={(data.target_tension ?? 0) / 100}
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
                />
                <ProgressRow
                  label="Round Progression"
                  value={data.round_progression ?? 0}
                />
                <LabeledList.Item label="Players / Antags">
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
                />
                <LabeledList.Item label="Difficulty">
                  ×{event_difficulty_modifier ?? 1}
                </LabeledList.Item>
                <LabeledList.Item label="Next Think">
                  {(next_think_time || 0) <= (current_world_time ?? 0) ? (
                    <Box color="good">Thinking</Box>
                  ) : (
                    formatTime(next_think_time, current_world_time)
                  )}
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
                    <Table.Cell>Weight</Table.Cell>
                    <Table.Cell>Actions</Table.Cell>
                  </Table.Row>
                  {upcoming_goals.map((g, i) => (
                    <Table.Row
                      key={i}
                      className={g.status === 'firing' ? 'color-good' : ''}
                    >
                      <Table.Cell
                        color={
                          g.fire_time <= (current_world_time ?? 0)
                            ? 'blue'
                            : null
                        }
                      >
                        {g.fire_time <= (current_world_time ?? 0)
                          ? 'Firing'
                          : formatTime(g.fire_time, current_world_time)}
                      </Table.Cell>
                      <Table.Cell>{g.name || g.id}</Table.Cell>
                      <Table.Cell
                        color={
                          g.status === 'active'
                            ? 'good'
                            : g.status === 'failed'
                              ? 'bad'
                              : 'average'
                        }
                      >
                        {g.status}
                      </Table.Cell>
                      <Table.Cell>
                        <ProgressBar
                          value={g.progress ?? 0}
                          color={
                            g.progress || 1 > 0.7
                              ? 'good'
                              : g.progress || 1 > 0.3
                                ? 'average'
                                : 'bad'
                          }
                        >
                          {Math.round((g.progress ?? 0) * 100)}%
                        </ProgressBar>
                      </Table.Cell>
                      <Table.Cell>{g.weight ?? '—'}</Table.Cell>
                      <Table.Cell>
                        <Button
                          icon="play"
                          tooltip="Fire"
                          onClick={() =>
                            act('trigger_goal', { offset: g.fire_time })
                          }
                        />
                        <Button
                          icon="trash"
                          tooltip="Remove"
                          color="bad"
                          onClick={() =>
                            act('remove_goal', { offset: g.fire_time })
                          }
                        />
                      </Table.Cell>
                    </Table.Row>
                  ))}
                </Table>
              ) : (
                <Box opacity={0.6}>No chain planned.</Box>
              )}
              <Stack mt={1} wrap>
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
                    tooltip="Random Event"
                    disabled={!can_force_event}
                    onClick={() => act('trigger_event')}
                  />
                </Stack.Item>
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
              </Stack>
            </Section>
            <Section title="Recent Events">
              {recent_events.length ? (
                <Table>
                  <Table.Row header>
                    <Table.Cell>Time</Table.Cell>
                    <Table.Cell>Desc</Table.Cell>
                    <Table.Cell>Status</Table.Cell>
                    <Table.Cell>ID</Table.Cell>
                  </Table.Row>
                  {recent_events.map((ev, i) => (
                    <Table.Row key={i}>
                      <Table.Cell>{formatTime(ev.time)}</Table.Cell>
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
                <Box opacity={0.6}>No events.</Box>
              )}
            </Section>
          </>
        )}
        {tab === 'goals' && (
          <>
            <Section title="Insert Goal">
              <Stack>
                <Stack.Item grow>
                  <Dropdown
                    selected={selectedGoal}
                    onSelected={setSelectedGoal}
                    options={available_goals.map((g) => ({
                      value: g.id,
                      displayText: g.name || g.id,
                    }))}
                    placeholder="Select goal..."
                    width="100%"
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="check"
                    tooltip="Insert"
                    disabled={!selectedGoal}
                    onClick={() =>
                      act('insert_goal_to_chain', { id: selectedGoal })
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="sync"
                    tooltip="Reschedule"
                    onClick={() => act('reschedule_chain')}
                  />
                </Stack.Item>
              </Stack>
            </Section>
            <Section title="Available Goals">
              {available_goals.length ? (
                <Table>
                  <Table.Row header>
                    <Table.Cell>Name</Table.Cell>
                    <Table.Cell>Weight</Table.Cell>
                    <Table.Cell>Progress</Table.Cell>
                  </Table.Row>
                  {available_goals.slice(0, 20).map((g) => (
                    <Table.Row key={g.id}>
                      <Table.Cell>{g.name || g.id}</Table.Cell>
                      <Table.Cell>{g.weight ?? '—'}</Table.Cell>
                      <Table.Cell>
                        {g.progress ? `${Math.round(g.progress * 100)}%` : '—'}
                      </Table.Cell>
                    </Table.Row>
                  ))}
                </Table>
              ) : (
                <Box opacity={0.6}>None available.</Box>
              )}
            </Section>
            <Section title="Controls">
              <Stack wrap>
                <Stack.Item>
                  <Button
                    icon="step-forward"
                    tooltip="Advance"
                    onClick={() => act('next_subgoal')}
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
                <LabeledList.Item label="Mood">
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
                <LabeledList.Item label="Pace">
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
                    tooltip="Reanalyse"
                    onClick={() => act('reanalyse')}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="calendar"
                    tooltip="Replan"
                    onClick={() => act('replan')}
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </>
        )}
        {tab === 'advanced' && (
          <>
            <Section title="Difficulty & Tension">
              <LabeledList>
                <LabeledList.Item label="Difficulty">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={difficulty}
                        onSelected={setDifficulty}
                        options={[0.75, 1, 1.25, 1.5, 2].map(String)}
                        placeholder="Select..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={() =>
                          act('set_difficulty', {
                            value: Number(difficulty) || 1,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Target Tension">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={targetTension}
                        onSelected={setTargetTension}
                        options={[30, 40, 50, 60, 70].map(String)}
                        placeholder="Select..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={() =>
                          act('set_target_tension', {
                            value: Number(targetTension) || 50,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section title="Pacing & Intervals">
              <LabeledList>
                <LabeledList.Item label="Think Delay">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={thinkDelay}
                        onSelected={setThinkDelay}
                        options={[300, 600, 900, 1200, 1800, 2400].map(String)}
                        placeholder="Select..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={() =>
                          act('set_think_delay', {
                            value: Number(thinkDelay) || 600,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Event Interval">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={minInterval}
                        onSelected={setMinInterval}
                        options={[200, 300, 400, 500, 600].map(String)}
                        placeholder="Min"
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item grow>
                      <Dropdown
                        selected={maxInterval}
                        onSelected={setMaxInterval}
                        options={[3000, 6000, 9000, 12000].map(String)}
                        placeholder="Max"
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={() =>
                          act('set_event_intervals', {
                            min: Number(minInterval) || 300,
                            max: Number(maxInterval) || 9000,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Grace Period">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={grace}
                        onSelected={setGrace}
                        options={[600, 1200, 1800, 2400, 3000].map(String)}
                        placeholder="Select..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        tooltip="Apply"
                        onClick={() =>
                          act('set_grace_period', {
                            value: Number(grace) || 3000,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Repetition Penalty">
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
                    <Table.Cell>
                      {formatTime(ev.time, current_world_time)}
                    </Table.Cell>
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
