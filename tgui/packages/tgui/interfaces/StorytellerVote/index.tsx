import '../../styles/interfaces/StorytellerVote.scss';
import { useEffect, useMemo, useState } from 'react';
import {
  Box,
  Button,
  Divider,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { resolveAsset } from '../../assets';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';

type Candidate = {
  id: string;
  name: string;
  desc?: string;
  ooc_desc?: string;
  ooc_diff?: string;
  portrait_path?: string;
  logo_path?: string;
};

type TopTally = {
  name: string;
  count: number;
  avg_diff: number;
};

type StorytellerVoteData = {
  storytellers: Candidate[];
  personal_selection?: string;
  personal_difficulty: number;
  total_voters: number;
  voted_count: number;
  time_left: number;
  top_tallies: TopTally[];
  is_open: BooleanLike;
  can_vote: BooleanLike;
};

type StorytellerVoteConfig = {
  min_difficulty?: number;
  max_difficulty?: number;
};

type DifficultyLevel = {
  value: number;
  label: string;
  tooltip: string;
  minPlayers: number;
};

const DIFFICULTY_LEVELS: readonly DifficultyLevel[] = [
  {
    value: 0.3,
    label: 'Extended',
    tooltip: 'Peaceful mode - minimal threats, more positive events',
    minPlayers: 0,
  },
  {
    value: 0.7,
    label: 'Adventure',
    tooltip: 'Easy mode - moderate events, balance between good and bad',
    minPlayers: 0,
  },
  {
    value: 1.0,
    label: 'Struggle',
    tooltip: 'Standard mode - balanced events and threats',
    minPlayers: 15,
  },
  {
    value: 2.0,
    label: 'Blood and Ash',
    tooltip: 'Hard mode - frequent threats and event escalation',
    minPlayers: 30,
  },
  {
    value: 5.0,
    label: 'Losing is Fun',
    tooltip: 'Extreme mode - maximum difficulty and constant threats',
    minPlayers: 50,
  },
];

export const StorytellerVote = () => {
  const { data, act, config } = useBackend<StorytellerVoteData>();
  const { min_difficulty = 0.3, max_difficulty = 5.0 } =
    config as StorytellerVoteConfig;

  const {
    storytellers = [],
    personal_selection,
    personal_difficulty = 1.0,
    total_voters = 0,
    voted_count = 0,
    time_left = 0,
    top_tallies = [],
    is_open = false,
    can_vote = false,
  } = data;

  const [selected, setSelected] = useState(personal_selection || '');

  const availableDifficultyLevels = useMemo(
    () =>
      DIFFICULTY_LEVELS.filter(
        (level) => level.minPlayers === 0 || total_voters >= level.minPlayers,
      ),
    [total_voters],
  );

  const [difficultyCheckboxes, setDifficultyCheckboxes] = useState<
    Record<string, boolean>
  >(() => {
    const initial: Record<string, boolean> = {};
    DIFFICULTY_LEVELS.forEach((level) => {
      initial[String(level.value)] = false;
    });
    return initial;
  });

  const findClosestDifficultyLevel = useMemo(() => {
    const available =
      total_voters > 0 ? availableDifficultyLevels : DIFFICULTY_LEVELS;
    return available.reduce((prev, curr) =>
      Math.abs(curr.value - personal_difficulty) <
      Math.abs(prev.value - personal_difficulty)
        ? curr
        : prev,
    );
  }, [personal_difficulty, availableDifficultyLevels, total_voters]);

  useEffect(() => {
    const closestValue = String(findClosestDifficultyLevel.value);
    setDifficultyCheckboxes((prev) => ({
      ...Object.fromEntries(Object.keys(prev).map((key) => [key, false])),
      [closestValue]: true,
    }));
  }, [personal_difficulty, findClosestDifficultyLevel.value]);

  useEffect(() => {
    const selectedValue = Object.keys(difficultyCheckboxes).find(
      (key) => difficultyCheckboxes[key],
    );

    if (selectedValue) {
      const currentLevel = DIFFICULTY_LEVELS.find(
        (l) => String(l.value) === selectedValue,
      );

      if (
        currentLevel &&
        currentLevel.minPlayers > 0 &&
        total_voters < currentLevel.minPlayers
      ) {
        const available = availableDifficultyLevels
          .filter((l) => l.value <= currentLevel.value)
          .sort((a, b) => b.value - a.value)[0];

        if (available) {
          const newValue = String(available.value);
          setDifficultyCheckboxes((prev) => ({
            ...Object.fromEntries(Object.keys(prev).map((key) => [key, false])),
            [newValue]: true,
          }));

          if (is_open && can_vote) {
            act('set_difficulty', { value: available.value });
          }
        }
      }
    }
  }, [
    total_voters,
    availableDifficultyLevels,
    difficultyCheckboxes,
    is_open,
    can_vote,
    act,
  ]);

  const select = (id: string) => {
    if (!is_open) return;
    setSelected(id);
    if (can_vote) {
      act('select_storyteller', { id });
    }
  };

  const handleDifficultyCheckboxChange = (value: number, checked: boolean) => {
    if (!is_open || !can_vote) return;

    if (checked) {
      setDifficultyCheckboxes((prev) => ({
        ...Object.fromEntries(Object.keys(prev).map((key) => [key, false])),
        [String(value)]: true,
      }));

      const clampedValue = Math.max(
        min_difficulty,
        Math.min(max_difficulty, value),
      );
      act('set_difficulty', { value: clampedValue });
    }
    // При снятии галочки ничего не делаем — оставляем текущий выбор
  };

  const current = useMemo(
    () => storytellers.find((c) => c.id === selected) || null,
    [storytellers, selected],
  );

  const selectedDifficultyInfo = useMemo(() => {
    const selectedValue = Object.keys(difficultyCheckboxes).find(
      (key) => difficultyCheckboxes[key],
    );
    return selectedValue
      ? DIFFICULTY_LEVELS.find((l) => String(l.value) === selectedValue) ||
          DIFFICULTY_LEVELS[2]
      : DIFFICULTY_LEVELS[2];
  }, [difficultyCheckboxes]);

  const timeDisplay = useMemo(() => {
    if (time_left <= 0) return 'Ended';
    const seconds = Math.ceil(time_left / 10);
    const minutes = Math.floor(seconds / 60);
    const remaining = seconds % 60;
    return minutes > 0 ? `${minutes}m ${remaining}s` : `${seconds}s`;
  }, [time_left]);

  if (!is_open && top_tallies.length === 0) {
    return (
      <Window title="Storyteller Vote" width={760} height={560}>
        <Window.Content>
          s
          <NoticeBox>Voting has ended. Check round logs for results!</NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window
      title={is_open ? 'Vote for Storyteller' : 'Storyteller Vote Results'}
      width={1000}
      height={700}
      theme="stortellerVote"
    >
      <Window.Content
        style={{
          backgroundImage: current
            ? `url(${resolveAsset(`${current.id}_portrait.png`)})`
            : undefined,
          backgroundSize: '480px 480px',
          backgroundPositionX: '100%',
          backgroundPositionY: '100%',
          position: 'absolute',
        }}
      >
        {!can_vote && (
          <NoticeBox>
            You cannot participate in the vote, but you can still view the
            candidates.
          </NoticeBox>
        )}

        <Stack fill>
          <Stack.Item style={{ flex: '0 0 240px', boxSizing: 'border-box' }}>
            <Section
              title="Candidates"
              scrollable
              style={{
                maxWidth: '240px',
                height: '100%',
                width: '100%',
                boxSizing: 'border-box',
                overflowX: 'hidden',
                overflowY: 'auto',
              }}
            >
              {storytellers.length ? (
                <Stack fill vertical>
                  {storytellers.map((c) => (
                    <Tooltip
                      key={c.id}
                      content={
                        <Box>
                          <Box bold>{c.name}</Box>
                          {c.ooc_desc && <Box>{c.ooc_desc}</Box>}
                          {c.ooc_diff && (
                            <Box color="average">Difficulty: {c.ooc_diff}</Box>
                          )}
                        </Box>
                      }
                    >
                      <Button
                        p={1}
                        mb={1}
                        width="96px"
                        height="96px"
                        style={{
                          cursor: is_open ? 'pointer' : 'default',
                          borderRadius: 4,
                          opacity: is_open ? 1 : 0.6,
                          backgroundImage: c.logo_path
                            ? `url(${resolveAsset(`${c.id}_logo.png`)})`
                            : undefined,
                          backgroundColor:
                            c.id === selected
                              ? 'rgba(255,255,255,0.255)'
                              : 'rgba(255,255,255,0.00)',
                        }}
                        onClick={() => select(c.id)}
                      />
                    </Tooltip>
                  ))}
                </Stack>
              ) : (
                <NoticeBox>No storytellers provided.</NoticeBox>
              )}
            </Section>
          </Stack.Item>

          <Stack.Item grow maxWidth="60%">
            <Section title="Your Vote" scrollable>
              {current ? (
                <>
                  <h1>{current.name}</h1>
                  <LabeledList>
                    <LabeledList.Item label="Description">
                      {current.desc || '—'}
                    </LabeledList.Item>
                    <LabeledList.Item label="OOC Description">
                      {current.ooc_desc || '-'}
                    </LabeledList.Item>
                    <LabeledList.Item label="OOC Difficulty">
                      {current.ooc_diff || '-'}
                    </LabeledList.Item>
                  </LabeledList>

                  <Divider />

                  <LabeledList>
                    <LabeledList.Item
                      label="Difficulty"
                      tooltip="Determines how much storyteller threat points will be multiplied. Higher values mean more difficult events and more threats. Some difficulty levels require a minimum number of players."
                    >
                      <Stack align="center">
                        <Stack.Item grow>
                          <Box mb={1}>
                            <Stack fill vertical>
                              {availableDifficultyLevels.map((level) => (
                                <Stack.Item key={level.value}>
                                  <Tooltip
                                    content={
                                      level.minPlayers > 0
                                        ? `${level.tooltip} (Requires ${level.minPlayers}+ players)`
                                        : level.tooltip
                                    }
                                  >
                                    <Stack fill>
                                      <Button.Checkbox
                                        checked={
                                          difficultyCheckboxes[
                                            String(level.value)
                                          ] || false
                                        }
                                        disabled={!is_open || !can_vote}
                                        onClick={() =>
                                          handleDifficultyCheckboxChange(
                                            level.value,
                                            !difficultyCheckboxes[
                                              String(level.value)
                                            ],
                                          )
                                        }
                                      />
                                      <Box ml={1}>
                                        <Box fontSize="1.1em">
                                          {level.label}
                                        </Box>
                                        {level.minPlayers > 0 && (
                                          <Box fontSize="0.8em" color="average">
                                            ({level.minPlayers}+ players)
                                          </Box>
                                        )}
                                      </Box>
                                    </Stack>
                                  </Tooltip>
                                </Stack.Item>
                              ))}
                            </Stack>
                          </Box>

                          {availableDifficultyLevels.length <
                            DIFFICULTY_LEVELS.length && (
                            <Box mt={0.5} color="average" fontSize="0.9em">
                              Some difficulty levels require more players
                            </Box>
                          )}
                        </Stack.Item>

                        <Stack.Item>
                          <Tooltip
                            content={
                              selectedDifficultyInfo.minPlayers > 0
                                ? `${selectedDifficultyInfo.tooltip} (Requires ${selectedDifficultyInfo.minPlayers}+ players)`
                                : selectedDifficultyInfo.tooltip
                            }
                          >
                            <Box ml={1} color="label" bold>
                              ×{selectedDifficultyInfo.value.toFixed(1)}
                            </Box>
                          </Tooltip>
                        </Stack.Item>
                      </Stack>
                    </LabeledList.Item>
                  </LabeledList>
                </>
              ) : (
                <NoticeBox>Select a storyteller on the left.</NoticeBox>
              )}
            </Section>

            <Section title="Vote Progress">
              <LabeledList>
                <LabeledList.Item label="Voters">
                  <ProgressBar
                    value={voted_count}
                    maxValue={total_voters || 1}
                    minValue={0}
                    ranges={{
                      good: [0.7, Infinity],
                      average: [0.3, 0.7],
                      bad: [-Infinity, 0.3],
                    }}
                  >
                    {voted_count}/{total_voters}
                  </ProgressBar>
                </LabeledList.Item>

                <LabeledList.Item label="Time Left">
                  {timeDisplay}
                </LabeledList.Item>
              </LabeledList>

              {top_tallies.length > 0 && (
                <>
                  <Divider />
                  <LabeledList>
                    <LabeledList.Item label="Top Choices">
                      {top_tallies.map((t, i) => (
                        <Box key={i} mb={0.5}>
                          <ProgressBar
                            value={t.count}
                            maxValue={total_voters || 1}
                            color="good"
                          >
                            <b>{t.name}</b>: {t.count} votes (avg diff:{' '}
                            {t.avg_diff.toFixed(1)})
                          </ProgressBar>
                        </Box>
                      ))}
                    </LabeledList.Item>
                  </LabeledList>
                </>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
