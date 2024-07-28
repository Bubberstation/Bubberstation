import { toFixed } from 'common/math';
import { useState } from 'react';
import { useBackend, useSharedState } from 'tgui/backend';
import {
  Box,
  Button,
  Dropdown,
  Flex,
  Icon,
  Input,
  LabeledList,
  NumberInput,
  Section,
  Stack,
  TextArea,
} from 'tgui-core/components';

import { FitText } from '../../components';
import { AppearanceDisplay } from './AppearanceDisplay';
import * as types from './types';

export const BelliesList = (props) => {
  const { act, data } = useBackend<types.Data>();

  const [selectedBelly, setSelectedBelly] = useState<number>(1);

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
                              : belly.digest_mode === types.DigestMode.Digest
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

export const BellyUI = (props: {
  selectedBelly: number | null;
  setSelectedBelly: React.Dispatch<React.SetStateAction<number>>;
}) => {
  const { act, data } = useBackend<types.Data>();
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
    0,
  );
  const [editing, setEditing] = useState(false);

  return (
    <Section
      mt={0}
      fill
      scrollable
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
                    setSelectedBelly(1);
                  }}
                >
                  Delete
                </Button.Confirm>
              </Stack.Item>
            </Stack>
          </LabeledList.Item>
          <LabeledList.Item
            label="Description"
            tooltip="The following text replacements are available: %pred - Your name | %prey - Prey's name | %belly - Belly name | %count - Prey count"
            verticalAlign="top"
          >
            {editing ? (
              <TextArea
                value={belly.desc}
                height={10}
                className={'VorePanel__AdvancedTextArea'}
                onChange={(e, value) =>
                  act('edit_belly', { ref: belly.ref, var: 'desc', value })
                }
              />
            ) : (
              <Box
                height={10}
                p={1}
                style={{
                  border: '1px solid #6992c2',
                  borderRadius: '0.16em',
                  overflow: 'auto',
                  overflowX: 'hidden',
                  overflowY: 'scroll',
                }}
                preserveWhitespace
              >
                {belly.desc}
              </Box>
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Belly Mode" verticalAlign="top">
            {editing ? (
              <Dropdown
                color={
                  belly.digest_mode === types.DigestMode.Digest
                    ? 'bad'
                    : 'default'
                }
                options={Object.values(types.DigestMode)}
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
                  belly.digest_mode === types.DigestMode.Digest
                    ? 'bad'
                    : 'default'
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
          <LabeledList.Item label="Muffle Radio">
            {editing ? (
              <Button
                icon={belly.muffles_radio ? 'toggle-on' : 'toggle-off'}
                selected={belly.muffles_radio}
                onClick={() =>
                  act('edit_belly', { ref: belly.ref, var: 'muffles_radio' })
                }
              >
                {belly.muffles_radio ? 'Yes' : 'No'}
              </Button>
            ) : belly.muffles_radio ? (
              'Yes'
            ) : (
              'No'
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Chance To Escape">
            {editing ? (
              <NumberInput
                value={belly.escape_chance}
                minValue={0}
                maxValue={100}
                step={1}
                format={(v) => v + '%'}
                onChange={(value) =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'escape_chance',
                    value,
                  })
                }
              />
            ) : (
              belly.escape_chance + '%'
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Time To Escape">
            {editing ? (
              <NumberInput
                value={belly.escape_time / 10}
                minValue={data.min_escape_time / 10}
                maxValue={data.max_escape_time / 10}
                step={1}
                format={(v) => v + ' seconds'}
                onChange={(value) =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'escape_time',
                    value: value * 10,
                  })
                }
              />
            ) : (
              belly.escape_time / 10 + ' seconds'
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Can Taste">
            {editing ? (
              <Button
                icon={belly.can_taste ? 'toggle-on' : 'toggle-off'}
                selected={belly.can_taste}
                onClick={() =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'can_taste',
                    value: '',
                  })
                }
              >
                {belly.can_taste ? 'Yes' : 'No'}
              </Button>
            ) : belly.can_taste ? (
              'Yes'
            ) : (
              'No'
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Insertion Verb">
            {editing ? (
              <Input
                value={belly.insert_verb}
                onChange={(e, value) =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'insert_verb',
                    value,
                  })
                }
                maxLength={data.max_verb_length}
              />
            ) : (
              belly.insert_verb
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Release Verb">
            {editing ? (
              <Input
                value={belly.release_verb}
                onChange={(e, value) =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'release_verb',
                    value,
                  })
                }
              />
            ) : (
              belly.release_verb
            )}
          </LabeledList.Item>
          <LabeledList.Divider />
          <LabeledList.Item label="Fancy Sounds">
            {editing ? (
              <Button
                icon={belly.fancy_sounds ? 'toggle-on' : 'toggle-off'}
                selected={belly.fancy_sounds}
                onClick={() =>
                  act('edit_belly', {
                    ref: belly.ref,
                    var: 'fancy_sounds',
                    value: '',
                  })
                }
              >
                {belly.fancy_sounds ? 'Yes' : 'No'}
              </Button>
            ) : belly.fancy_sounds ? (
              'On'
            ) : (
              'Off'
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Fleshy Belly">
            {editing ? (
              <Button
                icon={belly.is_wet ? 'toggle-on' : 'toggle-off'}
                selected={belly.is_wet}
                onClick={() =>
                  act('edit_belly', { ref: belly.ref, var: 'is_wet' })
                }
              >
                {belly.is_wet ? 'Yes' : 'No'}
              </Button>
            ) : belly.is_wet ? (
              'Yes'
            ) : (
              'No'
            )}
          </LabeledList.Item>
          <LabeledList.Item label="Internal Sound Loop">
            {editing ? (
              <Button
                icon={belly.wet_loop ? 'toggle-on' : 'toggle-off'}
                selected={belly.wet_loop}
                onClick={() =>
                  act('edit_belly', { ref: belly.ref, var: 'wet_loop' })
                }
              >
                {belly.wet_loop ? 'Yes' : 'No'}
              </Button>
            ) : belly.wet_loop ? (
              'Yes'
            ) : (
              'No'
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

export const BellyContents = (props: { contents: types.Prey[] }) => {
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
                color={prey.absorbed ? 'purple' : ''}
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
