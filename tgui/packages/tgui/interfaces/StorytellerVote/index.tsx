import {
  Box,
  Divider,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend, useLocalState } from '../../backend';
import { Window } from '../../layouts';

// Backend contract
// static: storytellers: [{ id, name, desc, portrait }], min_difficulty, max_difficulty
// data: personal_selection, personal_difficulty, total_voters, voted_count, time_left, top_tallies: [{ name, count, avg_diff }], is_open

type Candidate = {
  id: string;
  name: string;
  desc?: string;
  portrait?: string;
};

type TopTally = {
  name: string;
  count: number;
  avg_diff: number;
};

export const StorytellerVote = (props) => {
  const { data, act, config } = useBackend<Candidate[]>();
  const storytellers: Candidate[] = (data && (data as any).storytellers) || [];
  const min_difficulty: number =
    (config && (config as any).min_difficulty) || 0.3;
  const max_difficulty: number =
    (config && (config as any).max_difficulty) || 5.0;

  const personal_selection: string | undefined =
    data && (data as any).personal_selection;
  const personal_difficulty: number =
    (data && (data as any).personal_difficulty) || 1.0;
  const total_voters: number = (data && (data as any).total_voters) || 0;
  const voted_count: number = (data && (data as any).voted_count) || 0;
  const time_left: number = (data && (data as any).time_left) || 0;
  const top_tallies: TopTally[] = (data && (data as any).top_tallies) || [];
  const is_open: BooleanLike = !!(data && (data as any).is_open);

  const [selected, setSelected] = useLocalState(
    'selected',
    personal_selection || '',
  );
  const [diff, setDiff] = useLocalState('diff', String(personal_difficulty));

  const select = (id: string) => {
    if (!is_open) return;
    setSelected(id);
    act('select_storyteller', { id });
  };

  const applyDifficulty = (value: string) => {
    if (!is_open) return;
    setDiff(value);
    const v = Math.max(
      min_difficulty,
      Math.min(max_difficulty, Number(value) || 1.0),
    );
    act('set_difficulty', { value: v });
  };

  let current =
    storytellers.find((c) => c.id === selected) ||
    (is_open ? storytellers[0] : null);
  if (!current) current = storytellers[0];

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
      width={760}
      height={560}
    >
      <Window.Content>
        <Stack fill>
          <Stack.Item style={{ flex: '0 0 240px', boxSizing: 'border-box' }}>
            <Section
              title="Candidates"
              scrollable={true}
              style={{
                width: '240px',
                maxWidth: '240px',
                maxHeight: '560px',
                boxSizing: 'border-box',
                overflowX: 'hidden',
                overflowY: 'auto',
              }}
            >
              <Box>
                {storytellers.length ? (
                  storytellers.map((c) => (
                    <Box
                      key={c.id}
                      p={1}
                      mb={1}
                      style={{
                        cursor: is_open ? 'pointer' : 'default',
                        borderRadius: 4,
                        opacity: is_open ? 1 : 0.6,
                        maxWidth: '100%',
                      }}
                      backgroundColor={
                        c.id === selected ? 'rgba(255,255,255,0.08)' : undefined
                      }
                      onClick={() => select(c.id)}
                    >
                      {c.portrait ? (
                        <Box
                          width={96}
                          height={96}
                          style={{
                            backgroundImage: `url(${c.portrait})`,
                            backgroundSize: 'cover',
                            borderRadius: 4,
                          }}
                          align="center"
                          mr={1}
                        />
                      ) : (
                        <Box
                          width={48}
                          height={48}
                          backgroundColor="#222"
                          mr={1}
                        />
                      )}
                    </Box>
                  ))
                ) : (
                  <NoticeBox>
                    Define /datum/storyteller subtypes in code to enable voting.
                    Check server logs for details.
                  </NoticeBox>
                )}
              </Box>
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section title="Your Vote">
              {current ? (
                <>
                  <LabeledList>
                    <LabeledList.Item label="Name">
                      {current.name}
                    </LabeledList.Item>
                    <LabeledList.Item label="Description">
                      {current.desc || '—'}
                    </LabeledList.Item>
                  </LabeledList>
                  <Divider />
                  <LabeledList>
                    <LabeledList.Item label="Difficulty">
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
                            disabled={!is_open}
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
