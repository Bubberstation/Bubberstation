import { warn } from 'console';
import { useBackend, useSharedState } from '../backend';
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
import { Tooltip } from 'tgui-core/components';

export type Storyteller_Data = {
  storyteller_name: string;
  storyteller_halt: Boolean;
  antag_count: number;
  antag_cap: number;

  pop_data: Record<string, number>;
  tracks_data: Record<string, Storyteller_Track>;
  scheduled_data: Record<string, Record<string, string>>;
  events: Storyteller_Event_Category[];
};

export type Storyteller_Track = {
  name: string;
  current: number;
  max: number;
  next: number;
  forced: Storyteller_Event;
};

export type Storyteller_Event = {
  name: string;
  desc: string;
  tags: string[];
  occurences: number;
  occurences_shared: Boolean;
  min_pop: number;
  start: number;
  can_run: Boolean;
  weight: number;
  weight_raw: number;
};

export type Storyteller_Event_Category = {
  name: string;
  events: Storyteller_Event[];
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
          <Stack.Item>
            <Zubbers_Storyteller_Scheduled_Data />
          </Stack.Item>
          <Stack.Item>
            <Zubbers_Storyteller_Events_List />
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
          const max_points = track_data.max;
          const current_points = track_data.current;
          const forced = track_data.forced ? track_data.forced : 0;
          return (
            <Table.Row>
              <Table.Cell>
                <Button
                  tooltip="Edit points"
                  width="100%"
                  textAlign="center"
                  onClick={() =>
                    act('track_action', { action: 'set_pnts', track: track })
                  }
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
              <Table.Cell>{forced ? forced.name : ''}</Table.Cell>
              <Table.Cell>
                <Button
                  onClick={() =>
                    act('track_action', { action: 'force_next', track: track })
                  }
                >
                  Next Event
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
  const { scheduled_data } = data;
  return (
    <Section title="Scheduled events">
      <Table>
        <Table.Row bold>
          <Table.Cell>Name</Table.Cell>
          <Table.Cell>Track</Table.Cell>
          <Table.Cell>Time</Table.Cell>
          <Table.Cell>Actions</Table.Cell>
        </Table.Row>
        {Object.entries(scheduled_data).map(([event_name, event_data]) => {
          const time = event_data['time'];
          return (
            <Table.Row>
              <Table.Cell>{event_name}</Table.Cell>
              <Table.Cell>{event_data['track']}</Table.Cell>
              <Table.Cell>{time ? time + ' s' : 'Roundstart'}</Table.Cell>
              <Table.Cell>
                <Button
                  onClick={() =>
                    act('event_action', {
                      action: 'cancel',
                      type: event_data['event_type'],
                    })
                  }
                >
                  Cancel
                </Button>
                <Button
                  onClick={() =>
                    act('event_action', {
                      action: 'refund',
                      type: event_data['event_type'],
                    })
                  }
                >
                  Refund
                </Button>
                <Button
                  onClick={() =>
                    act('event_action', {
                      action: 'reschedule',
                      type: event_data['event_type'],
                    })
                  }
                >
                  Reschedule
                </Button>
                <Button
                  onClick={() =>
                    act('event_action', {
                      action: 'fire',
                      type: event_data['event_type'],
                    })
                  }
                >
                  Fire
                </Button>
              </Table.Cell>
            </Table.Row>
          );
        })}
      </Table>
    </Section>
  );
};

export const Zubbers_Storyteller_Events_List = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const { events } = data;

  const eventCategoryTabs = events.map((eventCategory) => {
    return eventCategory.name;
  });
  const [currentEventCategory, setCurrentEventCategory] = useState(
    eventCategoryTabs[0],
  );

  return (
    <Section title="Event Panel">
      <Stack>
        {Object.entries(events).map((id, event_category) => {
          return (
            <Stack.Item>
              <Button></Button>
            </Stack.Item>
          );
        })}
      </Stack>
      <Stack.Divider />
      <Table>
        <Table.Row bold>
          <Table.Cell>Name</Table.Cell>
          <Table.Cell>Tags</Table.Cell>
          <Table.Cell>Occ.</Table.Cell>
          <Table.Cell>M.Pop</Table.Cell>
          <Table.Cell>M.Time</Table.Cell>
          <Table.Cell>Can Run</Table.Cell>
          <Table.Cell>Weight</Table.Cell>
          <Table.Cell>Actions</Table.Cell>
        </Table.Row>
        {/*Object.entries(events).map(([track, this_event]))*/}
      </Table>
    </Section>
  );
};

export const Zubbers_Storyteller_Event = (props: Storyteller_Event) => {
  const {
    name,
    desc,
    tags,
    occurences,
    occurences_shared,
    min_pop,
    start,
    can_run,
    weight,
    weight_raw,
  } = props;
  return (
    <Table.Row>
      <Table.Cell>
        <Tooltip content={desc}>{name}</Tooltip>
      </Table.Cell>
      <Table.Cell></Table.Cell>
      <Table.Cell></Table.Cell>
      <Table.Cell></Table.Cell>
      <Table.Cell></Table.Cell>
      <Table.Cell></Table.Cell>
      <Table.Cell></Table.Cell>
      <Table.Cell></Table.Cell>
    </Table.Row>
  );
};
