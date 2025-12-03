import '../../styles/interfaces/StorytellerVote.scss';
import { useState } from 'react';
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

export const StorytellerVote = (props) => {
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
  const [diff, setDiff] = useState(String(personal_difficulty));

  const select = (id: string) => {
    if (!is_open) return;
    setSelected(id);

    if (!can_vote) return;
    act('select_storyteller', { id });
  };

  const applyDifficulty = (value: string) => {
    if (!is_open || !can_vote) return;
    setDiff(value);
    const v = Math.max(
      min_difficulty,
      Math.min(max_difficulty, Number(value) || 1.0),
    );
    act('set_difficulty', { value: v });
  };

  const current = storytellers.find((c) => c.id === selected) || null;

  if (!is_open && top_tallies.length === 0) {
    return (
      <Window title="Storyteller Vote" width={760} height={560}>
        <Window.Content>
          <NoticeBox>Voting has ended. Check round logs for results!</NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window
      title={is_open ? 'Vote for Storyteller' : 'Storyteller Vote Results'}
      width={800}
      height={620}
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
        {!can_vote ? (
          <NoticeBox>
            You cannot participate in the vote, but you can still view the
            candidates.
          </NoticeBox>
        ) : (
          ' '
        )}
        <Stack fill>
          <Stack.Item style={{ flex: '0 0 240px', boxSizing: 'border-box' }}>
            <Section
              title="Candidates"
              scrollable={true}
              style={{
                maxWidth: '240px',
                height: '100%',
                width: '100%',
                boxSizing: 'border-box',
                overflowX: 'hidden',
                overflowY: 'auto',
              }}
            >
              <Box>
                {storytellers.length ? (
                  <Stack fill vertical>
                    {storytellers.map((c) => (
                      <Tooltip content={c.name} key={c.id}>
                        <Button
                          p={1}
                          mb={1}
                          width="96px"
                          height="96px"
                          style={{
                            cursor: is_open ? 'pointer' : 'default',
                            borderRadius: 4,
                            opacity: is_open ? 1 : 0.6,
                            maxWidth: '96px',
                            maxHeight: '96px',
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
              </Box>
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
                    <LabeledList.Item label="Difficulty">
                      {current.ooc_diff || '-'}
                    </LabeledList.Item>
                  </LabeledList>
                  <Divider />
                  <LabeledList>
                    <LabeledList.Item
                      label="Difficulty Multiplier"
                      tooltip="How much storyteller threat points will be multiplied."
                    >
                      <Stack align="center">
                        <Stack.Item grow>
                          <input
                            type="range"
                            min={min_difficulty}
                            max={max_difficulty}
                            step={0.1}
                            value={diff}
                            onChange={(e) =>
                              applyDifficulty(e.currentTarget.value)
                            }
                            disabled={!is_open || !can_vote}
                            style={{ width: '100%' }}
                          />
                        </Stack.Item>
                        <Stack.Item>
                          <Box ml={1}>{Number(diff).toFixed(1)}</Box>
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
                  {time_left > 0 ? `${Math.ceil(time_left / 10)}s` : 'Ended'}
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
