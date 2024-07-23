// THIS IS A BUBBER UI FILE

import { useEffect, useState } from 'react';
import { useBackend, useSharedState } from 'tgui/backend';
import { Window } from 'tgui/layouts/Window';
import {
  Box,
  Button,
  Collapsible,
  Dropdown,
  Flex,
  Icon,
  Image,
  Input,
  LabeledList,
  NumberInput,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';
import { BooleanLike } from 'tgui-core/react';

import { FitText } from '../components';

type Prey = {
  name: string;
  ref: string;
  appearance: string;
};

enum DigestMode {
  None = 'None',
  Digest = 'Digest',
}

type Belly = {
  index: number;
  name: string;
  desc: string;
  ref: string;
  contents: Prey[];
  digest_mode: DigestMode;
  burn_damage: number;
  brute_damage: number;
  fancy_sounds: BooleanLike;
  insert_sound: string;
  release_sound: string;
};

type PreyBellyView = Omit<Belly, 'index' | 'ref'> & {
  owner_name: string;
};

type Data = {
  max_bellies: number;
  max_prey: number;
  max_burn_damage: number;
  max_brute_damage: number;
  selected_belly: number;
  bellies: Belly[];
  preferences: { [key: string]: any };
  current_slot: { name: string; owned: BooleanLike };
  inside: PreyBellyView | null;
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
  const { act } = useBackend();
  const [tab, setTab] = useState(0);

  return (
    <Section
      title="Vore"
      fill
      buttons={
        <>
          <Button icon="upload">Import</Button> {/* TODO: make work */}
          <Button icon="download">Export</Button> {/* TODO: make work */}
          <Button
            icon="cloud-download-alt"
            onClick={() => act('belly_backups')}
          >
            Get Backup
          </Button>
        </>
      }
    >
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
      {tab === 1 && <Inside />}
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
                              : belly.digest_mode === DigestMode.Digest
                                ? 'bad'
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
          <BellyUI
            key={selectedBelly}
            selectedBelly={selectedBelly}
            setSelectedBelly={setSelectedBelly}
          />
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

const BellyContents = (props: { contents: Prey[] }) => {
  const { act } = useBackend();
  const { contents } = props;

  return contents.length ? (
    <Flex wrap="wrap" justify="center" align="center">
      {contents.map((prey) => (
        <Flex.Item key={prey.name} basis="33%">
          <Stack vertical align="center" justify="center">
            <Stack.Item>
              <Button
                width="64px"
                height="64px"
                style={{ verticalAlign: 'middle' }}
                onClick={() => act('click_prey', { ref: prey.ref })}
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
  );
};

const BellyUI = (props: {
  selectedBelly: number | null;
  setSelectedBelly: React.Dispatch<React.SetStateAction<number>>;
}) => {
  const { act, data } = useBackend<Data>();
  const { selectedBelly, setSelectedBelly } = props;

  const belly = data.bellies.find((v) => v.index === selectedBelly);

  if (!belly) {
    return (
      <Section mt={0} fill>
        No Belly Selected
      </Section>
    );
  }

  // Little niceity, this makes it so that it whatever tab the user was last
  // looking at opens automatically when they switch back to this belly
  const [selectedTab, setSelectedTab] = useSharedState(
    'bellyTab-' + belly.name,
    1,
  );
  const [editing, setEditing] = useState(false);

  return (
    <Section
      mt={0}
      fill
      title={
        editing ? (
          <Input
            value={belly.name}
            onChange={(e, value) =>
              act('edit_belly', { ref: belly.ref, var: 'name', value })
            }
          />
        ) : (
          belly.name
        )
      }
      buttons={
        <>
          <Button
            color="transparent"
            selected={selectedTab === 0}
            onClick={() => {
              setSelectedTab(0);
              setEditing(false);
            }}
          >
            Contents
          </Button>
          <Button
            color="transparent"
            selected={selectedTab === 1}
            onClick={() => {
              setSelectedTab(1);
              setEditing(false);
            }}
          >
            Settings
          </Button>
        </>
      }
    >
      {selectedTab === 0 && <BellyContents contents={belly.contents} />}
      {selectedTab === 1 && (
        <LabeledList>
          <LabeledList.Item label="Options" verticalAlign="top">
            <Stack align="center" justify="flex-end">
              <Stack.Item>
                <Button
                  disabled={belly.index === data.bellies.length}
                  onClick={() => {
                    act('move_belly', { dir: 'down', ref: belly.ref });
                    setSelectedBelly(belly.index + 1); // this will keep our belly selected
                  }}
                  tooltip="Move belly down in the list"
                >
                  <Icon name="arrow-down" />
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  disabled={belly.index === 1}
                  onClick={() => {
                    act('move_belly', { dir: 'up', ref: belly.ref });
                    setSelectedBelly(belly.index - 1); // this will keep our belly selected
                  }}
                  tooltip="Move belly up in the list"
                >
                  <Icon name="arrow-up" />
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  icon="pencil"
                  selected={editing}
                  onClick={() => setEditing(!editing)}
                >
                  Edit
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button.Confirm
                  color="bad"
                  icon="trash"
                  onClick={() => {
                    act('delete_belly', { ref: belly.ref });
                    setSelectedBelly(-1);
                  }}
                >
                  Delete
                </Button.Confirm>
              </Stack.Item>
            </Stack>
          </LabeledList.Item>
          <LabeledList.Item label="Description" verticalAlign="top">
            {editing ? (
              <TextArea
                value={belly.desc}
                height={5}
                onChange={(e, value) =>
                  act('edit_belly', { ref: belly.ref, var: 'desc', value })
                }
              />
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
          <LabeledList.Item label="Belly Mode" verticalAlign="top">
            {editing ? (
              <Dropdown
                color={
                  belly.digest_mode === DigestMode.Digest ? 'bad' : 'default'
                }
                options={Object.values(DigestMode)}
                selected={belly.digest_mode}
                onSelected={(value) =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'digest_mode',
                    value,
                  })
                }
              />
            ) : (
              <Box
                inline
                color={
                  belly.digest_mode === DigestMode.Digest ? 'bad' : 'default'
                }
              >
                {belly.digest_mode}
              </Box>
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Burn Damage">
            {editing ? (
              <NumberInput
                value={belly.burn_damage}
                minValue={0}
                maxValue={data.max_burn_damage}
                step={0.1}
                format={(val) => toFixed(val, 2)}
                onChange={(value) =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'burn_damage',
                    value,
                  })
                }
              />
            ) : (
              toFixed(belly.burn_damage, 2)
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Brute Damage">
            {editing ? (
              <NumberInput
                value={belly.brute_damage}
                minValue={0}
                maxValue={data.max_brute_damage}
                step={0.1}
                format={(val) => toFixed(val, 2)}
                onChange={(value) =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'brute_damage',
                    value,
                  })
                }
              />
            ) : (
              toFixed(belly.brute_damage, 2)
            )}
          </LabeledList.Item>
          <LabeledList.Divider />
          <LabeledList.Item label="Fancy Sounds">
            {editing ? (
              <Button
                icon="pencil"
                onClick={() =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'fancy_sounds',
                    value: '',
                  })
                }
                selected={belly.fancy_sounds}
              >
                {belly.fancy_sounds ? 'On' : 'Off'}
              </Button>
            ) : belly.fancy_sounds ? (
              'On'
            ) : (
              'Off'
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Insertion Sound">
            {editing ? (
              <Button
                icon="pencil"
                onClick={() =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'insert_sound',
                    value: '',
                  })
                }
              >
                {belly.insert_sound}
              </Button>
            ) : (
              belly.insert_sound
            )}
            <Button
              ml={1}
              onClick={() =>
                act('test_sound', { ref: belly.ref, sound: 'insert_sound' })
              }
            >
              <Icon name="volume-up" />
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Release Sound">
            {editing ? (
              <Button
                icon="pencil"
                onClick={() =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'release_sound',
                    value: '',
                  })
                }
              >
                {belly.release_sound}
              </Button>
            ) : (
              belly.release_sound
            )}
            <Button
              ml={1}
              onClick={() =>
                act('test_sound', { ref: belly.ref, sound: 'release_sound' })
              }
            >
              <Icon name="volume-up" />
            </Button>
          </LabeledList.Item>
        </LabeledList>
      )}
    </Section>
  );
};

const digestModeToPreyMode = {
  [DigestMode.None]: { text: 'being held.', color: 'good' },
  [DigestMode.Digest]: { text: 'being digested.', color: 'bad' },
};

const Inside = (props) => {
  const { data } = useBackend<Data>();
  const { inside } = data;

  if (!inside) {
    return <Section title="Inside!">You are not inside anyone!</Section>;
  }

  const preyMode = digestModeToPreyMode[inside.digest_mode];

  return (
    <Section title="Inside!">
      <Box>
        <Box color="yellow" inline>
          You are currently inside
        </Box>{' '}
        <Box inline color="blue">
          {inside.owner_name || 'someone'}
          &apos;s
        </Box>{' '}
        <Box inline color="red">
          {inside.name}
        </Box>{' '}
        <Box inline color="yellow">
          and you are
        </Box>{' '}
        <Box inline color={preyMode.color}>
          {preyMode.text}
        </Box>
      </Box>
      <Box mb={1} color="label">
        {inside.desc}
      </Box>
      {inside.contents.length ? (
        <Collapsible title="Belly Contents">
          <BellyContents contents={inside.contents} />
        </Collapsible>
      ) : (
        'There is nothing else around you.'
      )}
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
    <Button
      fluid
      icon={value === 2 ? 'star' : value === 1 ? 'star-half-alt' : 'star-o'}
      textAlign="center"
      tooltipPosition="bottom"
      onClick={() => act('set_pref', { key, value: (value + 1) % 3 })}
      selected={value === 2}
      tooltip={
        value === 2
          ? 'You will automatically accept vore of this type'
          : value === 1
            ? 'You will always be prompted whether you are okay with vore of this type'
            : 'You will automatically reject vore of this type'
      }
    >
      {name} - {value === 2 ? 'Always' : value === 1 ? 'Prompt' : 'Never'}
    </Button>
  );
};

const PrefBinary = (props: { key: string; name: string; value: number }) => {
  const { act } = useBackend();
  const { key, name, value } = props;

  return (
    <Button
      fluid
      icon={value ? 'toggle-on' : 'toggle-off'}
      textAlign="center"
      tooltipPosition="bottom"
      onClick={() => act('set_pref', { key, value: !value })}
      tooltip={value ? 'Enabled' : 'Disabled'}
      selected={value}
    >
      {name} - {value ? 'Enabled' : 'Disabled'}
    </Button>
  );
};

const PREF_TYPE_MAP = {
  prey_toggle: { component: PrefTrinary, name: 'Prey Toggle' },
  pred_toggle: { component: PrefTrinary, name: 'Pred Toggle' },
  eating_noises: { component: PrefBinary, name: 'Eating Noises' },
  digestion_noises: { component: PrefBinary, name: 'Digestion Noises' },
  belch_noises: { component: PrefBinary, name: 'Belch Noises' },
};
