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
    <NtosWindow width={500} height={670}>
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
      <Section title={authIDName}>
        <Stack wrap="wrap">
          <Stack.Item width="100%" mt={1} ml={0}>
            authCard: {authCard || '-----'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            authIDName: {authIDName || '-----'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            authIDRank: {authIDRank || '-----'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            hasTrim: {hasTrim ? 'Yes' : 'No'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            trimAssignment: {trimAssignment || '-----'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            stationAlertLevel: {stationAlertLevel || '-----'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            trimClockedOut: {trimClockedOut ? 'Off Duty' : 'Active Duty'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            selfServeBlock: {selfServeBlock ? 'TRUE' : 'FALSE'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            authCardHOPLocked: {authCardHOPLocked ? 'TRUE' : 'FALSE'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            authCardTimeLocked: {authCardTimeLocked ? 'TRUE' : 'FALSE'}
          </Stack.Item>

          <Stack.Item align="center" mt={1} ml={0}>
            Assignment:
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
            <Stack.Item grow={1}>
              <NoticeBox>
                Changing job trim information is currently blocked, please visit
                the HoP window for trim changes.
              </NoticeBox>
            </Stack.Item>
          ) : (
            ''
          )}
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
        </Stack>
      </Section>
    </Section>
  );
};
