import {
  Box,
  Button,
  Collapsible,
  Dimmer,
  Icon,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
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
  voting: string[];
  LastVoteTime: number;
  VoteCD: number;
};

export const VotePanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user, LastVoteTime, VoteCD } = data;

  /**
   * Adds the voting type to title if there is an ongoing vote.
   */
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
        <Stack fill vertical>
          <Section
            title="Create Vote"
            buttons={
              !!user.isLowerAdmin && (
                <Stack>
                  <Stack.Item>
                    <Button
                      icon="refresh"
                      content="Reset Cooldown"
                      disabled={LastVoteTime + VoteCD <= 0}
                      onClick={() => act('resetCooldown')}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="skull"
                      content="Toggle dead vote"
                      disabled={!user.isUpperAdmin}
                      onClick={() => act('toggleDeadVote')}
                    />
                  </Stack.Item>
                </Stack>
              )
            }
          >
            <VoteOptions />
            {!!user.isLowerAdmin && currentVote && <VotersList />}
          </Section>
          <ChoicesPanel />
          <TimePanel />
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

/**
 * The create vote options menu. Only upper admins can disable voting.
 * @returns A section visible to everyone with vote options.
 */
const VoteOptions = (props) => {
  const { act, data } = useBackend<Data>();
  const { possibleVotes, user, LastVoteTime, VoteCD } = data;

  return (
    <Stack.Item>
      <Collapsible title="Start a Vote">
        <Section>
          {LastVoteTime + VoteCD > 0 && <VoteOptionDimmer />}
          <Stack vertical justify="space-between">
            {possibleVotes.map((option) => (
              <Stack.Item key={option.name}>
                <Stack>
                  {!!user.isLowerAdmin && (
                    <Stack.Item>
                      <Button.Checkbox
                        width={7}
                        color="red"
                        checked={option.config === VoteConfig.Enabled}
                        disabled={
                          !user.isUpperAdmin ||
                          option.config === VoteConfig.None
                        }
                        tooltip={
                          option.config === VoteConfig.None
                            ? 'This vote cannot be disabled.'
                            : null
                        }
                        content={
                          option.config === VoteConfig.Enabled
                            ? 'Enabled'
                            : 'Disabled'
                        }
                        onClick={() =>
                          act('toggleVote', {
                            voteName: option.name,
                          })
                        }
                      />
                    </Stack.Item>
                  )}
                  <Stack.Item>
                    <Button
                      width={12}
                      textAlign={'center'}
                      disabled={!option.canBeInitiated}
                      tooltip={option.message}
                      content={option.name}
                      onClick={() =>
                        act('callVote', {
                          voteName: option.name,
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Collapsible>
    </Stack.Item>
  );
};

/**
 * View Voters by ckey. Admin only.
 * @returns A collapsible list of voters
 */
const VotersList = (props) => {
  const { data } = useBackend<Data>();

  return (
    <Stack.Item>
      <Collapsible
        title={`View Active Voters${
          data.voting.length ? ` (${data.voting.length})` : ''
        }`}
      >
        <Section height={4} fill scrollable>
          {data.voting.map((voter) => {
            return <Box key={voter}>{voter}</Box>;
          })}
        </Section>
      </Collapsible>
    </Stack.Item>
  );
};

/**
 * The choices panel which displays all options in the list.
 * @returns A section visible to all users.
 */
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
                      <Icon
                        align="right"
                        mr={2}
                        color="green"
                        name="vote-yea"
                      />
                    )}
                  {currentVote.displayStatistics ||
                  user.isLowerAdmin /* SKYRAT EDIT*/
                    ? `${choice.votes} Votes`
                    : null}
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

/**
 * Countdown timer at the bottom. Includes a cancel vote option for admins.
 * @returns A section visible to everyone.
 */
const TimePanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user } = data;

  return (
    <Stack.Item mt={1}>
      <Section>
        <Stack justify="space-between">
          <Box fontSize={1.5}>
            Time Remaining:&nbsp;
            {currentVote?.timeRemaining || 0}s
          </Box>
          {!!user.isLowerAdmin && (
            <Stack>
              <Stack.Item>
                <Button
                  color="green"
                  disabled={!user.isLowerAdmin || !currentVote}
                  onClick={() => act('endNow')}
                >
                  End Now
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  color="red"
                  disabled={!user.isLowerAdmin || !currentVote}
                  onClick={() => act('cancel')}
                >
                  Cancel Vote
                </Button>
              </Stack.Item>
            </Stack>
          )}
        </Stack>
      </Section>
    </Stack.Item>
  );
};
