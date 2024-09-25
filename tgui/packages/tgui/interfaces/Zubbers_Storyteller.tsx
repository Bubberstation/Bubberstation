import { warn } from 'console';
import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
  Table,
} from '../components';
import { Window } from '../layouts';
import { useState } from 'react';

export type Storyteller_Data = {
  storyteller_name: String;
  storyteller_halt: Boolean;
  antag_count: number;
  antag_cap: number;

  pop_data: Record<string, number>;
  tracks_data: Record<string, Record<string, number>>;
};

export const Zubbers_Storyteller = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  return (
    <Window width={800} height={680}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Zubbers_Storyteller_Round_Data />
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>
            <Zubbers_Storyteller_Track_Data />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const Zubbers_Storyteller_Round_Data = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const {
    storyteller_name,
    storyteller_halt,
    pop_data,
    antag_cap,
    antag_count,
  } = data;
  return (
    <Section
      title="Storyteller"
      buttons={
        <>
          <Box inline bold mr={1}>
            {storyteller_name}
          </Box>
          <Button onClick={() => act('set_storyteller')}>
            Set Storyteller
          </Button>
        </>
      }
    >
      <LabeledList>
        <LabeledList.Item label="Storyteller status">
          <Button
            color={storyteller_halt ? 'red' : 'green'}
            tooltip={(storyteller_halt ? 'Unhalt' : 'Halt') + ' storyteller'}
            onClick={() => act('halt_storyteller')}
            width="20%"
            textAlign="center"
          >
            {storyteller_halt ? 'Halted' : 'Running'}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="Active Players">
          {pop_data['active']} {'('}Head: {pop_data['head']}, Sec:{' '}
          {pop_data['sec']}, Eng: {pop_data['eng']}, Med: {pop_data['med']}
          {')'}
        </LabeledList.Item>
        <LabeledList.Item
          label="Antag Cap"
          tooltip="Amount of antags / The antag cap"
        >
          <ProgressBar
            value={antag_count}
            maxValue={antag_cap}
            ranges={{
              good: [-Infinity, antag_cap],
              bad: [antag_cap, Infinity],
            }}
          >
            {antag_count + ' / ' + antag_cap}
          </ProgressBar>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const TRACK_DATA_TRACK_WIDTH = '8%';
const TRACK_DATA_POINT_WIDTH = '22%';
const TRACK_DATA_NEXT_WIDTH = '8%';
const TRACK_DATA_FORCED_WIDTH = '20%';
const TRACK_DATA_ACTIONS_WIDTH = '20%';

export const Zubbers_Storyteller_Track_Data = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const { tracks_data, storyteller_halt } = data;
  return (
    <Section title="Tracks">
      <Table>
        <Table.Row bold>
          <Table.Cell width={TRACK_DATA_TRACK_WIDTH}>Track</Table.Cell>
          <Table.Cell width={TRACK_DATA_POINT_WIDTH}>Points</Table.Cell>
          <Table.Cell width={TRACK_DATA_NEXT_WIDTH}>Next event</Table.Cell>
          <Table.Cell width={TRACK_DATA_FORCED_WIDTH} textAlign="center">
            Next forced event
          </Table.Cell>
          <Table.Cell width={TRACK_DATA_ACTIONS_WIDTH}>Actions</Table.Cell>
        </Table.Row>
        <Stack.Divider></Stack.Divider>
        {Object.entries(tracks_data).map(([track, track_data]) => {
          const max_points = Number(track_data['max']);
          const current_points = Number(track_data['current']);
          const forced = track_data['forced'];
          return (
            <Table.Row>
              <Table.Cell>
                <Button
                  tooltip="Edit points"
                  width="100%"
                  textAlign="center"
                  onClick={() => act('track_action', { action: 'set_pnts' })}
                >
                  {track}
                </Button>
              </Table.Cell>
              <Table.Cell>
                <ProgressBar
                  value={current_points}
                  maxValue={max_points}
                  ranges={{
                    good: [-Infinity, max_points],
                    average: [max_points, Infinity],
                  }}
                >
                  {current_points + ' / ' + max_points}
                  {' (' +
                    Math.floor((current_points * 100) / max_points) +
                    '%) '}
                </ProgressBar>
              </Table.Cell>
              <Table.Cell textAlign="center">
                {storyteller_halt ? 'N/A' : '~' + track_data['next'] + 'min'}
              </Table.Cell>
              <Table.Cell>{forced ? forced : ''}</Table.Cell>
              <Table.Cell>
                <Button
                  onClick={() =>
                    act('track_action', { action: 'force_next', track: track })
                  }
                >
                  Next Event
                </Button>{' '}
                <Button
                  onClick={() => act('open_event_panel', { track: track })}
                >
                  Events Panel
                </Button>
              </Table.Cell>
            </Table.Row>
          );
        })}
      </Table>
    </Section>
  );
};

export const Zubbers_Storyteller_Scheduled_Data = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  return (
    <Section title="Scheduled events">
      <Stack vertical>
        <Stack.Item></Stack.Item>
      </Stack>
    </Section>
  );
};
