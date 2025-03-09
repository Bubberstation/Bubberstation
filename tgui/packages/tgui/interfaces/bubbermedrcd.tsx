import { capitalizeAll } from 'common/string';

import { useBackend } from '../backend';
import { Button, LabeledList, Section, Stack } from '../components';
import { Window } from '../layouts';

type Data = {
  reagents: [];
  total_reagents: number;
  max_reagents: number;
  selected_design: string;
  designs: [];
};

type Category = {
  cat_name: string;
  designs: Design[];
};

type Design = {
  title: string;
  icon: string;
};

export const MatterItem = (props) => {
  const { data } = useBackend<Data>();
  const { total_reagents } = data;
  return (
    <LabeledList.Item label="Units Left">
      &nbsp;{total_reagents} Units
    </LabeledList.Item>
  );
};

export const InfoSection = (props) => {
  const { data } = useBackend<Data>();
  const { reagents } = data;

  return (
    <Section>
      <LabeledList>
        <MatterItem />
        {reagents}
      </LabeledList>
    </Section>
  );
};

const DesignSection = (props) => {
  const { act, data } = useBackend<Data>();

  return (
    <Section fill scrollable>
      {data.designs.map((design, i) => (
        <Button
          key={i + 1}
          fluid
          height="31px"
          color="transparent"
          selected={data.designs.title === data.selected_design}
          onClick={() =>
            act('design', {
              index: i + 1,
            })
          }
        >
          <span>{capitalizeAll(design.title)}</span>
        </Button>
      ))}
    </Section>
  );
};

export const bubbermedrcd = (props) => {
  return (
    <Window width={450} height={590}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <InfoSection />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
