import { Button, NoticeBox, Section, Stack } from 'tgui-core/components';
import { capitalizeFirst } from 'tgui-core/string';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import type { NTOSData } from '../layouts/NtosWindow';

type Data = {
  authCard: string;
  authCardTimeRemaining: string;
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
    <NtosWindow width={400} height={522}>
      <NtosWindow.Content>
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
    authCardTimeRemaining,
    authIDName,
    authIDRank,
    authCardHOPLocked,
    authCardTimeLocked,
    stationAlertLevel,
    trimClockedOut,
    trimAssignment,
  } = data;

  return (
    <Section title="Enterprise Resource Planning">
      <Section title={`Welcome ${authIDName}`}>
        <Stack wrap="wrap">
          <Stack.Item width="100%" mt={1} ml={0}>
            Current Assignment: {trimAssignment || '-----'}
          </Stack.Item>
          <Stack.Item align="center" mt={1} ml={0}>
            Job Title: {authIDRank || '-----'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            Current Status: {trimClockedOut ? 'Off-Duty' : 'Active Duty'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            Station Alert Level: {capitalizeFirst(stationAlertLevel) || '-----'}
          </Stack.Item>
        </Stack>
      </Section>

      <Section title="Punch Clock">
        <Stack wrap="wrap">
          <Stack.Item width="100%" mt={1} ml={0}>
            <Stack>
              <Stack.Item>
                <Button
                  width="342px"
                  disabled={
                    authCardHOPLocked || authCardTimeLocked || !authIDName
                  }
                  onClick={() => act('PRG_change_status')}
                >
                  <center>
                    {trimClockedOut
                      ? 'Return to Job Assignment'
                      : 'Punch Out from Job Assignment'}
                  </center>
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  right="0px"
                  width="100%"
                  icon="eject"
                  onClick={() => act('PRG_eject_id')}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Section>
      <Section title="Assignment Information">
        <Stack wrap="wrap">
          {!trimClockedOut ? (
            <Stack.Item width="100%" mt={0} ml={0}>
              <NoticeBox info>
                Before punching out, please return any job gear that is
                important or limited to your workplace.
              </NoticeBox>
              <NoticeBox info>
                While off-duty, any restricted items will be transferred to a
                crew equipment lockbox, to be returned upon punching in.
              </NoticeBox>
            </Stack.Item>
          ) : (
            ''
          )}
          {authCardHOPLocked ? (
            <Stack.Item width="100%" mt={0} ml={0}>
              <NoticeBox danger>
                Assignment Locked!
                <br />
                <br />
                Security and Command members must visit an appropriate Command
                member to punch in!
              </NoticeBox>
            </Stack.Item>
          ) : authCardTimeLocked ? (
            <Stack.Item width="100%" mt={0} ml={0}>
              <NoticeBox>
                It is too early to return to your assignment!
                <br />
                Time remaining: {authCardTimeRemaining}
                <br />
                <br />
                Please visit the HoP window or your departmental Command member
                for an override.
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
