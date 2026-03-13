import { Section, Stack, Box, Icon, Button, Divider } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type TrainStationControlData = {
  unlocked: boolean;
  requires_password: boolean;
  station_name: string;
  entered_code: string;
};

export const TrainStationControl = (props: any, context: any) => {
  const { act, data } = useBackend<TrainStationControlData>();
  const {
    unlocked,
    requires_password,
    station_name,
    entered_code = '',
  } = data;

  const displayCode = entered_code || '_____';

  return (
    <Window title={station_name + " - Control Terminal"} width={380} height={600}>
      <Window.Content scrollable>
        {unlocked ? (
          <Section title="Access Status" backgroundColor="#1e3a2f">
            <Box textAlign="center" fontSize="20px" color="good" bold mt={3} mb={3}>
              <Icon name="lock-open" mr={1} />
              STATION UNLOCKED
            </Box>
            <Box textAlign="center" color="grey">
              The train may now proceed to the next destination.
            </Box>
          </Section>
        ) : (
          <Section title="Security Lock">
            <Box textAlign="center" mt={2} mb={3}>
              <Icon name="shield-halved" size={3} color={requires_password ? 'yellow' : 'grey'} />
            </Box>

            {!requires_password ? (
              <Stack vertical align="center">
                <Stack.Item mb={2}>
                  <Box fontSize="14px" color="average">
                    This station does not require authorization code
                  </Box>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    content="Unlock Station"
                    color="good"
                    textAlign="center"
                    fontSize="16px"
                    minWidth="200px"
                    onClick={() => act('unlock')}
                  />
                </Stack.Item>
              </Stack>
            ) : (
              <>
                <Box textAlign="center" bold fontSize="16px" mb={2}>
                  Enter Access Code
                </Box>

                <Box
                  backgroundColor="#111"
                  color="#0f0"
                  fontFamily="Consolas, monospace"
                  fontSize="28px"
                  textAlign="center"
                  p={2}
                  mb={3}

                >
                  {displayCode.split('').map((char, i) => (
                    <Box as="span" key={i} mx={1}>
                      {char}
                    </Box>
                  ))}
                </Box>

                <Stack vertical>
                  <Stack.Item>
                    <Stack justify="center" wrap>
                      {['1', '2', '3'].map((digit) => (
                        <Stack.Item key={digit}>
                          <Button
                            content={digit}
                            fontSize="20px"
                            width="60px"
                            height="60px"
                            m={0.5}
                            onClick={() => act('digit', { dig: digit })}
                          />
                        </Stack.Item>
                      ))}
                    </Stack>
                  </Stack.Item>

                  <Stack.Item>
                    <Stack justify="center" wrap>
                      {['4', '5', '6'].map((digit) => (
                        <Stack.Item key={digit}>
                          <Button
                            content={digit}
                            fontSize="20px"
                            width="60px"
                            height="60px"
                            m={0.5}
                            onClick={() => act('digit', { dig: digit })}
                          />
                        </Stack.Item>
                      ))}
                    </Stack>
                  </Stack.Item>

                  <Stack.Item>
                    <Stack justify="center" wrap>
                      {['7', '8', '9'].map((digit) => (
                        <Stack.Item key={digit}>
                          <Button
                            content={digit}
                            fontSize="20px"
                            width="60px"
                            height="60px"
                            m={0.5}
                            onClick={() => act('digit', { dig: digit })}
                          />
                        </Stack.Item>
                      ))}
                    </Stack>
                  </Stack.Item>

                  <Stack.Item>
                    <Stack justify="center" wrap>
                      <Stack.Item>
                        <Button
                          content="C"
                          fontSize="20px"
                          width="60px"
                          height="60px"
                          color="bad"
                          m={0.5}
                          onClick={() => act('clear')}
                        />
                      </Stack.Item>

                      <Stack.Item>
                        <Button
                          content="0"
                          fontSize="20px"
                          width="60px"
                          height="60px"
                          m={0.5}
                          onClick={() => act('digit', { dig: '0' })}
                        />
                      </Stack.Item>

                      <Stack.Item>
                        <Button
                          content="OK"
                          fontSize="20px"
                          width="60px"
                          height="60px"
                          color="good"
                          m={0.5}
                          onClick={() => act('enter')}
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                </Stack>
              </>
            )}
          </Section>
        )}

        <Divider />

        <Box textAlign="center" color="grey" italic mt={2}>
          Station Control Terminal v2.4 • Authorized Personnel Only
        </Box>
      </Window.Content>
    </Window>
  );
};
