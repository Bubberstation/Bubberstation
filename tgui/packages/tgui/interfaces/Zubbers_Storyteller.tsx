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
  pop: number;

  antag_count: number;
  antag_cap: number;
};

export const Zubbers_Storyteller = (props) => {
  const { act, data } = useBackend<Storyteller_Data>();
  const { storyteller_name, storyteller_halt, pop, antag_cap, antag_count } =
    data;
  return (
    <Window width={500} height={500}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
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
                  Active: {pop}
                </LabeledList.Item>
                <LabeledList.Item label="Antag Cap">
                  <ProgressBar
                    value={antag_count}
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
          </Stack.Item>
          <Stack.Divider />
        </Stack>
      </Window.Content>
    </Window>
  );
};
