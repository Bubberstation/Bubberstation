// THIS IS A BUBBER UI FILE

import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts/Window';
import {
  Box,
  Button,
  Input,
  LabeledList,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';

type Prey = {
  name: string;
  ref: string;
};

type Belly = {
  name: string;
  desc: string;
  ref: string;
  contents: Prey[];
};

type Data = {
  max_bellies: number;
  max_prey: number;
  selected_belly: number;
  bellies: Belly[];
};

export const VorePanel = (props) => {
  return (
    <Window width={640} height={480}>
      <Window.Content>
        <VoreMain />
      </Window.Content>
    </Window>
  );
};

const VoreMain = (props) => {
  const [tab, setTab] = useState(0);

  return (
    <Section title="Vore" fill>
      <Tabs fluid>
        <Tabs.Tab selected={tab === 0} onClick={() => setTab(0)}>
          Bellies
        </Tabs.Tab>
        <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
          Preferences
        </Tabs.Tab>
      </Tabs>
      {tab === 0 && <BelliesList />}
    </Section>
  );
};

const BelliesList = (props) => {
  const { act, data } = useBackend<Data>();

  const [selectedBelly, setSelectedBelly] = useState<string | null>(null);

  const { bellies } = data;

  return (
    <Box height="90%">
      <Stack fill>
        <Stack.Item>
          <Tabs vertical fill>
            {bellies.map((belly) => (
              <Tabs.Tab
                key={belly.name}
                selected={selectedBelly === belly.name}
                onClick={() => setSelectedBelly(belly.name)}
              >
                {belly.name}
              </Tabs.Tab>
            ))}
            <Button color="good" icon="plus">
              Add Belly
            </Button>
          </Tabs>
        </Stack.Item>
        <Stack.Divider ml={0} mr={0} />
        <Stack.Item grow>
          <BellyUI selectedBelly={selectedBelly} />
        </Stack.Item>
      </Stack>
    </Box>
  );
};

const BellyUI = (props: { selectedBelly: string | null }) => {
  const { act, data } = useBackend<Data>();
  const { selectedBelly } = props;

  const belly = data.bellies.find((v) => v.name === selectedBelly);
  if (!belly) {
    return (
      <Section mt={0} fill>
        No Belly Selected
      </Section>
    );
  }

  const [editing, setEditing] = useState(false);

  return (
    <Section
      mt={0}
      fill
      title={editing ? <Input value={belly.name} /> : belly.name}
      buttons={
        <Button
          icon="pencil"
          selected={editing}
          onClick={() => setEditing(!editing)}
        >
          Edit
        </Button>
      }
    >
      <Box>
        <LabeledList>
          <LabeledList.Item label="Description" verticalAlign="top">
            {editing ? (
              <TextArea value={belly.desc} height={5} />
            ) : (
              <Box backgroundColor="#000" height={5} p={1}>
                {belly.desc}
              </Box>
            )}
          </LabeledList.Item>
        </LabeledList>
        <Section title="Contents">
          {belly.contents.length ? (
            <LabeledList>
              {belly.contents.map((prey) => (
                <LabeledList.Item
                  label={prey.name}
                  key={prey.name}
                  buttons={
                    <Button
                      icon="eject"
                      onClick={() => act('eject', { ref: prey.ref })}
                    >
                      Eject
                    </Button>
                  }
                />
              ))}
            </LabeledList>
          ) : (
            'Nothing is inside this belly.'
          )}
        </Section>
      </Box>
    </Section>
  );
};
