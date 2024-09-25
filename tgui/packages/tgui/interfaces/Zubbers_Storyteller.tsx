import { warn } from 'console';
import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from '../components';
import { Window } from '../layouts';

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
    <Window width={500} height={500}>
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
            onClick={() => act('halt_storyteller')}
          >
            {storyteller_halt ? 'Halted' : 'Running'}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="Players">
          Active: {pop_data['active']}, Head: {pop_data['head']}, Sec:{' '}
          {pop_data['sec']}, Eng: {pop_data['eng']}, Med: {pop_data['med']}
        </LabeledList.Item>
        <LabeledList.Item label="Antag Cap">
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

export const Zubbers_Storyteller_Track_Data = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const { tracks_data } = data;
  return (
    <Section title="Tracks">
      <LabeledList>
        {Object.entries(tracks_data).map(([track, track_data]) => {
          const max_points = Number(track_data['max']);
          const current_points = Number(track_data['current']);
          return (
            <LabeledList.Item label={track}>
              <Stack>
                <Stack.Item width="33%">
                  <ProgressBar
                    value={current_points}
                    maxValue={max_points}
                    ranges={{
                      good: [-Infinity, max_points],
                      average: [max_points, Infinity],
                    }}
                  >
                    {track_data['current']}
                    {' / '}
                    {track_data['max']}
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <LabeledList.Item label="Next event">
                    {track_data['next']} min
                  </LabeledList.Item>
                </Stack.Item>
              </Stack>
            </LabeledList.Item>
          );
        })}
      </LabeledList>
    </Section>
  );
};
