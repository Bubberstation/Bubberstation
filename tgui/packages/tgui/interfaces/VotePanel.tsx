import {
  BlockQuote,
  Box,
  Button,
  Dimmer,
  Icon,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

enum VoteConfig {
  None = -1,
  Disabled = 0,
  Enabled = 1,
}

type Vote = {
  name: string;
  canBeInitiated: BooleanLike;
  config: VoteConfig;
  message: string;
};

type Option = {
  name: string;
  votes: number;
};

type ActiveVote = {
  vote: Vote;
  question: string | null;
  timeRemaining: number;
  displayStatistics: boolean;
  choices: Option[];
  countMethod: number;
};

type UserData = {
  ckey: string;
  isGhost: BooleanLike;
  isLowerAdmin: BooleanLike;
  isUpperAdmin: BooleanLike;
  singleSelection: string | null;
  multiSelection: string[] | null;
  countMethod: VoteSystem;
};

enum VoteSystem {
  VOTE_SINGLE = 1,
  VOTE_MULTI = 2,
  VOTE_RANKED = 3, // BUBBER EDIT ADDITION - Ranked Choice Voting
}

type Data = {
  currentVote: ActiveVote;
  possibleVotes: Vote[];
  user: UserData;
  LastVoteTime: number;
  VoteCD: number;
  deadVoteEnabled: BooleanLike;
};

export const VotePanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user, LastVoteTime, VoteCD } = data;

  let windowTitle = 'Vote';
  if (currentVote) {
    windowTitle +=
      ': ' +
      (currentVote.question || currentVote.vote.name).replace(/^\w/, (c) =>
        c.toUpperCase(),
      );
  }

  return (
    <Window title={windowTitle} width={400} height={500}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section
              title="New Vote"
              buttons={
                !!user.isLowerAdmin && (
                  <Stack>
                    <Stack.Item>
                      <Button
                        icon="refresh"
                        disabled={LastVoteTime + VoteCD <= 0}
                        onClick={() => act('resetCooldown')}
                      >
                        Reset cooldown
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <Button.Checkbox
                        disabled={!user.isUpperAdmin}
                        onClick={() => act('toggleDeadVote')}
                        checked={!data.deadVoteEnabled}
                        color="primary"
                      >
                        Dead votes
                      </Button.Checkbox>
                    </Stack.Item>
                  </Stack>
                )
              }
            >
              <VoteOptions />
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section fill scrollable title="Active Vote">
              <ChoicesPanel />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section>
              <TimePanel />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const VoteOptionDimmer = (props) => {
  const { data } = useBackend<Data>();
  const { LastVoteTime, VoteCD } = data;

  return (
    <Dimmer>
      <Box textAlign="center">
        <Box fontSize={2} bold>
          Vote Cooldown
        </Box>
        <Box fontSize={1.5}>{Math.floor((VoteCD + LastVoteTime) / 10)}s</Box>
      </Box>
    </Dimmer>
  );
};

const VoteOptions = (props) => {
  const { act, data } = useBackend<Data>();
  const { possibleVotes, user, LastVoteTime, VoteCD } = data;

  return (
    <Stack.Item>
      {LastVoteTime + VoteCD > 0 && <VoteOptionDimmer />}
      <Stack vertical justify="space-between">
        {possibleVotes.map((option) => (
          <Stack.Item key={option.name}>
            <Stack>
              {!!user.isLowerAdmin && (
                <Stack.Item>
                  <Button.Checkbox
                    color="primary"
                    checked={
                      option.config === VoteConfig.Enabled ||
                      option.config === VoteConfig.None
                    }
                    disabled={
                      !user.isUpperAdmin || option.config === VoteConfig.None
                    }
                    tooltip={
                      option.config === VoteConfig.None
                        ? 'This vote cannot be disabled.'
                        : null
                    }
                    onClick={() =>
                      act('toggleVote', {
                        voteName: option.name,
                      })
                    }
                  >
                    Active
                  </Button.Checkbox>
                </Stack.Item>
              )}
              <Stack.Item>
                <Button
                  disabled={!option.canBeInitiated}
                  onClick={() =>
                    act('callVote', {
                      voteName: option.name,
                    })
                  }
                  icon="play"
                />
              </Stack.Item>
              <Stack.Item>
                <Tooltip content={option.message}>
                  <BlockQuote style={{ lineHeight: '1.7em' }}>
                    {option.name} Vote
                  </BlockQuote>
                </Tooltip>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        ))}
      </Stack>
    </Stack.Item>
  );
};

const ChoicesPanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user } = data;

  return (
    <Stack.Item grow>
      <Section fill scrollable title="Active Vote">
        {currentVote && currentVote.countMethod === VoteSystem.VOTE_SINGLE ? (
          <NoticeBox success>Select one option</NoticeBox>
        ) : null}
        {currentVote &&
        currentVote.choices.length !== 0 &&
        currentVote.countMethod === VoteSystem.VOTE_SINGLE ? (
          <LabeledList>
            {currentVote.choices.map((choice) => (
              <Box key={choice.name}>
                <LabeledList.Item
                  label={choice.name.replace(/^\w/, (c) => c.toUpperCase())}
                  textAlign="right"
                  buttons={
                    <Button
                      tooltip={
                        user.isGhost && 'Ghost voting was disabled by an admin.'
                      }
                      disabled={
                        user.singleSelection === choice.name || user.isGhost
                      }
                      onClick={() => {
                        act('voteSingle', { voteOption: choice.name });
                      }}
                    >
                      Vote
                    </Button>
                  }
                >
                  {user.singleSelection &&
                    choice.name === user.singleSelection && (
                    <Icon align="right" mr={2} color="green" name="vote-yea" />
                  )}
                  {currentVote.displayStatistics || user.isLowerAdmin /* SKYRAT EDIT*/ ? `${choice.votes} Votes` : null}
                </LabeledList.Item>
                <LabeledList.Divider />
              </Box>
            ))}
          </LabeledList>
        ) : null}
        {currentVote && currentVote.countMethod === VoteSystem.VOTE_MULTI ? (
          <NoticeBox success>Select any number of options</NoticeBox>
        ) : null}
        {currentVote &&
        currentVote.choices.length !== 0 &&
        currentVote.countMethod === VoteSystem.VOTE_MULTI ? (
          <LabeledList>
            {currentVote.choices.map((choice) => (
              <Box key={choice.name}>
                <LabeledList.Item
                  label={choice.name.replace(/^\w/, (c) => c.toUpperCase())}
                  textAlign="right"
                  buttons={
                    <Button
                      tooltip={
                        user.isGhost && 'Ghost voting was disabled by an admin.'
                      }
                      disabled={user.isGhost}
                      onClick={() => {
                        act('voteMulti', { voteOption: choice.name });
                      }}
                    >
                      Vote
                    </Button>
                  }
                >
                  {user.multiSelection &&
                  // BUBBER EDIT CHANGE - Original: [user.ckey.concat(choice.name)]
                  user.multiSelection[`${user.ckey}_${choice.name}`] === 1 ? (
                    <Icon align="right" mr={2} color="blue" name="vote-yea" />
                  ) : null}
                  {
                    user.isLowerAdmin
                      ? `${choice.votes} Votes`
                      : '' /* SKYRAT EDIT*/
                  }
                </LabeledList.Item>
                <LabeledList.Divider />
              </Box>
            ))}
          </LabeledList>
        ) : null}
        {/* BUBBER EDIT ADDITION - Ranked Choice Voting */}
        {currentVote && currentVote.countMethod === VoteSystem.VOTE_RANKED ? (
          <NoticeBox success>
            Click options to rank them in order of preference. Click again to
            remove.
          </NoticeBox>
        ) : null}
        {currentVote &&
        currentVote.choices.length !== 0 &&
        currentVote.countMethod === VoteSystem.VOTE_RANKED ? (
          <LabeledList>
            {currentVote.choices
              .map((choice) => {
                // Get all current ranks for this user
                const userRanks: Record<string, number> = {};
                let maxRank = 0;
                currentVote.choices.forEach((c) => {
                  const rankKey = `${user.ckey}_${c.name}`;
                  const rank = user.multiSelection?.[rankKey] || 0;
                  if (rank > 0) {
                    userRanks[c.name] = rank;
                    maxRank = Math.max(maxRank, rank);
                  }
                });

                // Get this choice's current rank
                const rankKey = `${user.ckey}_${choice.name}`;
                const currentRank = user.multiSelection?.[rankKey] || 0;

                return {
                  choice,
                  currentRank,
                  userRanks,
                  maxRank,
                };
              })
              // Sort by rank (unranked at bottom)
              .sort((a, b) => {
                if (a.currentRank === 0 && b.currentRank === 0) {
                  // If both unranked, sort alphabetically
                  return a.choice.name.localeCompare(b.choice.name);
                }
                if (a.currentRank === 0) return 1; // a is unranked, move to bottom
                if (b.currentRank === 0) return -1; // b is unranked, move to bottom
                return a.currentRank - b.currentRank; // sort by rank
              })
              .map(({ choice, currentRank, userRanks, maxRank }) => {
                // Function to get button text
                const getButtonText = () => {
                  if (currentRank === 0) {
                    return 'Vote';
                  }
                  return `Choice #${currentRank}`;
                };

                // Function to handle vote click
                const handleVoteClick = () => {
                  if (currentRank > 0) {
                    // Remove this rank and shift others up
                    const newRanks: Record<string, number> = {};
                    Object.entries(userRanks).forEach(
                      ([name, rank]: [string, number]) => {
                        if (name === choice.name) {
                          return; // Skip this one as we're removing it
                        }
                        if (rank > currentRank) {
                          newRanks[name] = rank - 1; // Shift up
                        } else {
                          newRanks[name] = rank; // Keep same
                        }
                      },
                    );
                    // Send all rank updates
                    Object.entries(newRanks).forEach(
                      ([name, newRank]: [string, number]) => {
                        act('voteRanked', {
                          voteOption: name,
                          voteRank: newRank,
                        });
                      },
                    );
                    // Remove this rank
                    act('voteRanked', {
                      voteOption: choice.name,
                      voteRank: 0,
                    });
                  } else {
                    // Add as next rank
                    act('voteRanked', {
                      voteOption: choice.name,
                      voteRank: maxRank + 1,
                    });
                  }
                };

                return (
                  <Box key={choice.name}>
                    <LabeledList.Item
                      label={choice.name.replace(/^\w/, (c) => c.toUpperCase())}
                      textAlign="right"
                      buttons={
                        <Button
                          tooltip={
                            user.isGhost &&
                            'Ghost voting was disabled by an admin.'
                          }
                          selected={currentRank > 0}
                          disabled={user.isGhost}
                          onClick={handleVoteClick}
                        >
                          {getButtonText()}
                        </Button>
                      }
                    >
                      {currentVote.displayStatistics || user.isLowerAdmin
                        ? `${choice.votes} Votes`
                        : null}
                    </LabeledList.Item>
                    <LabeledList.Divider />
                  </Box>
                );
              })}
          </LabeledList>
        ) : null}
        {/* BUBBER EDIT ADDITION END */}
        {currentVote ? null : <NoticeBox>No vote active!</NoticeBox>}
      </Section>
    </Stack.Item>
  );
};

const TimePanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user } = data;

  return (
    <Stack.Item>
      <Stack justify="space-between">
        <Box fontSize={1.5}>
          {currentVote
            ? `Time remaining: ${currentVote.timeRemaining}s`
            : 'No current vote'}
        </Box>
        {!!user.isLowerAdmin && (
          <Stack>
            <Stack.Item>
              <Button
                color="green"
                disabled={!user.isLowerAdmin || !currentVote}
                onClick={() => act('endNow')}
                style={{ lineHeight: '1.8em' }}
              >
                End Now
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                color="red"
                disabled={!user.isLowerAdmin || !currentVote}
                onClick={() => act('cancel')}
                style={{ lineHeight: '1.8em' }}
              >
                Cancel
              </Button>
            </Stack.Item>
          </Stack>
        )}
      </Stack>
    </Stack.Item>
  );
};
