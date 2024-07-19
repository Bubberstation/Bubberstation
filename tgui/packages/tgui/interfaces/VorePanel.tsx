// THIS IS A BUBBER UI FILE

import { useEffect, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts/Window';
import {
  Box,
  Button,
  Flex,
  Icon,
  Image,
  Input,
  LabeledList,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';

import { FitText } from '../components';

type Prey = {
  name: string;
  ref: string;
  appearance: string;
};

type Belly = {
  index: number;
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
  preferences: { [key: string]: any };
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
          Inside
        </Tabs.Tab>
        <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
          Preferences
        </Tabs.Tab>
      </Tabs>
      {tab === 0 && <BelliesList />}
      {tab === 2 && <Preferences />}
    </Section>
  );
};

const BelliesList = (props) => {
  const { act, data } = useBackend<Data>();

  const [selectedBelly, setSelectedBelly] = useState<number>(-1);

  const { bellies } = data;

  return (
    <Box height="90%">
      <Stack fill>
        <Stack.Item>
          <Section fill scrollable width={15} p={0} m={0}>
            <Stack vertical ml={1} fill>
              {bellies.map((belly) => (
                <>
                  <Stack.Item key={belly.index}>
                    <Stack>
                      <Stack.Item>
                        <Button.Checkbox
                          checked={belly.index === data.selected_belly}
                          selected={0}
                          onClick={() =>
                            act('select_belly', { ref: belly.ref })
                          }
                          ml={-2}
                          mr={-2}
                        />
                      </Stack.Item>
                      <Stack.Item grow>
                        <Button
                          color={
                            selectedBelly === belly.index
                              ? 'good'
                              : 'transparent'
                          }
                          selected={selectedBelly === belly.index}
                          onClick={() => setSelectedBelly(belly.index)}
                          textAlign="center"
                          fluid
                        >
                          <FitText maxFontSize={12} maxWidth={100}>
                            {belly.name}
                          </FitText>
                        </Button>
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                  <Stack.Divider ml={-2} pt={0.4} mt={0} mb={-1} />
                </>
              ))}
              <Stack.Item>
                <Button
                  color="good"
                  icon="plus"
                  onClick={() => act('create_belly')}
                  fluid
                  disabled={data.bellies.length >= data.max_bellies}
                  textAlign="center"
                  ml={-2}
                >
                  Add Belly{' '}
                  {data.bellies.length >= data.max_bellies &&
                    '(Max: ' + data.max_bellies + ')'}
                </Button>
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
        <Stack.Divider ml={0} mr={0} />
        <Stack.Item grow>
          <BellyUI selectedBelly={selectedBelly} />
        </Stack.Item>
      </Stack>
    </Box>
  );
};

/**
 * Waits until two XMLHttpRequests have loaded at iconSrc before calling cb().
 * @param iconSrc
 * @param cb
 */
function getTwice(iconSrc: string, cb: () => void) {
  const xhr = new XMLHttpRequest();
  // Block effect until we load
  xhr.open('GET', iconSrc + '?preload');
  xhr.send();
  xhr.onload = () => {
    const xhr = new XMLHttpRequest();
    // Block effect until we load
    xhr.open('GET', iconSrc + '?preload2');
    xhr.send();
    xhr.onload = cb;
  };
}

const AppearanceDisplay = (props: { iconSrc: string }) => {
  const { iconSrc } = props;
  const [icon, setIcon] = useState<string>();

  // This forces two XMLHttpRequests to go through
  // before we try and render the icon for real.
  // Basically just makes sure BYOND knows we really want this icon instead of possibly getting back a transparent png.
  useEffect(() => {
    getTwice(iconSrc, () => {
      setIcon(iconSrc);
    });
  }, [iconSrc]);

  if (icon) {
    return (
      <Image fixErrors src={icon} ml={-1} mt={-1} height="64px" width="64px" />
    );
  } else {
    return <Icon name="spinner" size={2.2} spin color="gray" />;
  }
};

const BellyUI = (props: { selectedBelly: number | null }) => {
  const { act, data } = useBackend<Data>();
  const { selectedBelly } = props;

  const belly = data.bellies.find((v) => v.index === selectedBelly);

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
              <Box
                height={5}
                p={1}
                style={{ border: '1px solid #6992c2', borderRadius: '0.16em' }}
              >
                {belly.desc}
              </Box>
            )}
          </LabeledList.Item>
        </LabeledList>
        <Section title="Contents">
          {belly.contents.length ? (
            <Flex wrap="wrap" justify="center" align="center">
              {belly.contents.map((prey) => (
                <Flex.Item key={prey.name} basis="33%">
                  <Stack vertical align="center" justify="center">
                    <Stack.Item>
                      <Button
                        width="64px"
                        height="64px"
                        style={{ verticalAlign: 'middle' }}
                        onClick={() => act('eject', { ref: prey.ref })}
                      >
                        <AppearanceDisplay iconSrc={prey.appearance} />
                      </Button>
                    </Stack.Item>
                    <Stack.Item>{prey.name}</Stack.Item>
                  </Stack>
                </Flex.Item>
              ))}
            </Flex>
          ) : (
            'Nothing is inside this belly.'
          )}
        </Section>
      </Box>
    </Section>
  );
};

const Preferences = (props) => {
  const { data } = useBackend<Data>();
  const { preferences } = data;

  return (
    <Section title="Vore Preferences">
      <Flex wrap>
        {Object.entries(preferences).map(([key, value]) => {
          const data = PREF_TYPE_MAP[key];
          if (data) {
            return (
              <Flex.Item basis="33%" key={key}>
                {data.component({ key, name: data.name, value })}
              </Flex.Item>
            );
          } else {
            return (
              <Flex.Item key={key} basis="33%">
                Unknown pref: {key}
              </Flex.Item>
            );
          }
        })}
      </Flex>
    </Section>
  );
};

const PrefTrinary = (props: { key: string; name: string; value: number }) => {
  const { act } = useBackend();
  const { key, name, value } = props;

  return (
    <Button onClick={() => act('set_pref', { key, value: (value + 1) % 3 })}>
      {name} - {value === 2 ? 'Always' : value === 1 ? 'Prompt' : 'Never'}
    </Button>
  );
};

const PREF_TYPE_MAP = {
  prey_toggle: { component: PrefTrinary, name: 'Prey Toggle' },
  pred_toggle: { component: PrefTrinary, name: 'Pred Toggle' },
};
