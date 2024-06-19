import { capitalizeFirst } from 'common/string';

import { useBackend } from '../backend';
import { Button, Input, NoticeBox, Section, Stack } from '../components';
import { NtosWindow } from '../layouts';
import { NTOSData } from '../layouts/NtosWindow';

type Data = {
  authCard: string;
  authIDName: string;
  authIDRank: string;
  hasTrim: boolean;
  trimAssignment: string;
  stationAlertLevel: string;
  trimClockedOut: boolean;
  authCardHOPLocked: boolean;
  authCardTimeLocked: boolean;
  selfServeBlock: boolean;
} & NTOSData;

export const NtosSelfServe = (props) => {
  const { act, data } = useBackend<Data>();

  return (
    <NtosWindow width={400} height={500}>
      <NtosWindow.Content scrollable>
        <Stack>
          <Stack.Item width="100%">
            <SelfServePage />
          </Stack.Item>
        </Stack>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const SelfServePage = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    authCard,
    authIDName,
    authIDRank,
    authCardHOPLocked,
    authCardTimeLocked,
    stationAlertLevel,
    trimClockedOut,
    hasTrim,
    trimAssignment,
    selfServeBlock,
  } = data;

  return (
    <Section title="Enterprise Resource Planning">
      <Section title={'Welcome ' + authIDName + '!'}>
        <Stack wrap="wrap">
          <Stack.Item width="100%" mt={1} ml={0}>
            Current Assignment: {trimAssignment || '-----'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            Current Status: {trimClockedOut ? 'Off-Duty' : 'Active Duty'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            Station Alert Level: {capitalizeFirst(stationAlertLevel) || '-----'}
          </Stack.Item>
          <Stack.Item align="center" mt={1} ml={0}>
            Job Title:
          </Stack.Item>

          <Stack.Item grow={1}>
            <Input
              fluid
              mt={1}
              disabled={trimClockedOut || selfServeBlock}
              value={authIDRank}
              onChange={(e, value) =>
                act('PRG_assign', {
                  assignment: value,
                })
              }
            />
          </Stack.Item>
          {selfServeBlock ? (
            <Stack.Item width="100%" mt={1} ml={0}>
              <NoticeBox>
                Changing job title and trim information is currently blocked,
                please visit the HoP window for trim changes.
              </NoticeBox>
            </Stack.Item>
          ) : (
            ''
          )}
        </Stack>
      </Section>
      <Section title="Employee Self Serve">
        <Stack wrap="wrap">
          <Stack.Item width="100%" mt={1} ml={0}>
            {authCardHOPLocked ? (
              <NoticeBox>
                This card is locked from changing duty status, please visit the
                HoP window to clock in/out.
              </NoticeBox>
            ) : (
              <Button
                width="100%"
                disabled={authCardTimeLocked}
                onClick={() => act('PRG_change_status')}
              >
                <center>
                  {trimClockedOut
                    ? 'Return to Job Assignment'
                    : 'Clock Out from Job Assignment'}
                </center>
              </Button>
            )}
          </Stack.Item>
          {!trimClockedOut ? (
            <Stack.Item width="100%" mt={1} ml={0}>
              <NoticeBox info>
                While off-duty any restricted items will be transferred to a
                crew equipment lockbox, to be returned upon clocking in.
              </NoticeBox>
            </Stack.Item>
          ) : (
            ''
          )}
        </Stack>
      </Section>
    </Section>
  );
};
