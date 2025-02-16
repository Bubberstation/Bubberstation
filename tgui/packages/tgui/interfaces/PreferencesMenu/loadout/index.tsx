import { Fragment, useState } from 'react';
import { Flex } from 'tgui-core/components';

import { useBackend, useLocalState } from '../../../backend';
import {
  Box,
  Button,
  Dimmer,
  Divider,
  Dropdown,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from '../../../components';
import { CharacterPreview } from '../../common/CharacterPreview';
import { removeAllSkiplines } from '../../TextInputModal';
import { PreferencesMenuData, ServerData } from '../data';
import { ServerPreferencesFetcher } from '../ServerPreferencesFetcher';
import {
  LoadoutCategory,
  LoadoutItem,
  LoadoutManagerData,
  typePath,
} from './base';
import { ItemIcon, LoadoutTabDisplay, SearchDisplay } from './ItemDisplay';
import { LoadoutModifyDimmer } from './ModifyPanel';

export const LoadoutPage = () => {
  return (
    <ServerPreferencesFetcher
      render={(serverData) => {
        if (!serverData) {
          return <NoticeBox>Loading...</NoticeBox>;
        }
        const loadoutServerData: ServerData = serverData;
        return (
          <LoadoutPageInner
            loadout_tabs={loadoutServerData.loadout.loadout_tabs}
          />
        );
      }}
    />
  );
};

const LoadoutPageInner = (props: { loadout_tabs: LoadoutCategory[] }) => {
  const { loadout_tabs } = props;
  const [searchLoadout, setSearchLoadout] = useState('');
  const [selectedTabName, setSelectedTab] = useState(loadout_tabs[0].name);
  const [modifyItemDimmer, setModifyItemDimmer] = useState<LoadoutItem | null>(
    null,
  );
  // BUBBER EDIT ADDITION START: Multiple loadout presets
  const [managingPreset, _setManagingPreset] = useLocalState<string | null>(
    'managingPreset',
    null,
  );
  const { act, data } = useBackend<PreferencesMenuData>();
  const [input, setInput] = useState('');
  const setManagingPreset = (value) => {
    _setManagingPreset(value);
    setInput('');
  };
  const onType = (value: string) => {
    if (value === input) {
      return;
    }
    setInput(removeAllSkiplines(value));
  };
  // BUBBER EDIT END

  return (
    <Stack vertical fill>
      <Stack.Item>
        {/* BUBBER EDIT ADDITION START: Multiple loadout presets */}
        {!!managingPreset && (
          <Dimmer style={{ zIndex: '100' }}>
            <Stack
              vertical
              width="400px"
              backgroundColor="#101010"
              style={{
                borderRadius: '2px',
                position: 'relative',
                display: 'inline-block',
                padding: '5px',
              }}
            >
              <Stack.Item height="20px" width="100%">
                <Flex>
                  <Flex.Item fontSize="1.3rem">
                    {managingPreset} Loadout Preset
                  </Flex.Item>
                  {managingPreset === 'Add' && (
                    <Flex.Item ml="6px" mt="4px">
                      (
                      {
                        data.character_preferences.misc.loadout_lists.loadouts
                          .length
                      }{' '}
                      of 12 total)
                    </Flex.Item>
                  )}
                  <Flex.Item ml="auto">
                    <Button
                      icon="times"
                      color="red"
                      onClick={() => {
                        setManagingPreset(null);
                      }}
                    />
                  </Flex.Item>
                </Flex>
              </Stack.Item>
              <Stack.Item width="100%" height="20px">
                <Input
                  placeholder="Maximum of 24 characters long"
                  width="100%"
                  maxLength={24}
                  onChange={(_, value) => onType(value)}
                  onInput={(_, value) => onType(value)}
                  onEnter={(event) => {
                    event.preventDefault();
                    act(`${managingPreset.toLowerCase()}_loadout_preset`, {
                      name: input,
                    });
                    setManagingPreset(null);
                  }}
                  onEscape={() => setManagingPreset(null)}
                />
              </Stack.Item>
              <Stack.Item>
                <Stack justify="center">
                  <Button
                    onClick={() => {
                      act(`${managingPreset.toLowerCase()}_loadout_preset`, {
                        name: input,
                      });
                      setManagingPreset(null);
                    }}
                  >
                    Done
                  </Button>
                </Stack>
              </Stack.Item>
            </Stack>
          </Dimmer>
        )}
        {/* BUBBER EDIT END */}
        {!!modifyItemDimmer && (
          <LoadoutModifyDimmer
            modifyItemDimmer={modifyItemDimmer}
            setModifyItemDimmer={setModifyItemDimmer}
          />
        )}
        <Section
          title="&nbsp;"
          align="center"
          buttons={
            <Input
              width="200px"
              onInput={(_, value) => setSearchLoadout(value)}
              placeholder="Search for an item..."
              value={searchLoadout}
            />
          }
        >
          <Tabs fluid align="center">
            {loadout_tabs.map((curTab) => (
              <Tabs.Tab
                key={curTab.name}
                selected={
                  searchLoadout.length <= 1 && curTab.name === selectedTabName
                }
                onClick={() => {
                  setSelectedTab(curTab.name);
                  setSearchLoadout('');
                }}
              >
                <Box>
                  {curTab.category_icon && (
                    <Icon name={curTab.category_icon} mr={1} />
                  )}
                  {curTab.name}
                </Box>
              </Tabs.Tab>
            ))}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <LoadoutTabs
          loadout_tabs={loadout_tabs}
          currentTab={selectedTabName}
          currentSearch={searchLoadout}
          modifyItemDimmer={modifyItemDimmer}
          setModifyItemDimmer={setModifyItemDimmer}
        />
      </Stack.Item>
    </Stack>
  );
};

const LoadoutTabs = (props: {
  loadout_tabs: LoadoutCategory[];
  currentTab: string;
  currentSearch: string;
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
}) => {
  const {
    loadout_tabs,
    currentTab,
    currentSearch,
    modifyItemDimmer,
    setModifyItemDimmer,
  } = props;
  const activeCategory = loadout_tabs.find((curTab) => {
    return curTab.name === currentTab;
  });
  const searching = currentSearch.length > 1;

  // BUBBER EDIT ADDITION START: Multiple loadout presets
  const { act, data } = useBackend<PreferencesMenuData>();
  const [_, setManagingPreset] = useLocalState<string | null>(
    'managingPreset',
    null,
  );
  // BUBBER EDIT END

  return (
    <Stack fill height="550px">
      <Stack.Item align="center" width="250px" height="100%">
        <Stack vertical fill>
          <Stack.Item
            height="50%" // BUBBER EDIT: Better loadout pref: ORIGINAL: 60%
          >
            <LoadoutPreviewSection />
          </Stack.Item>
          {/* BUBBER EDIT ADDITION START: Multiple loadout presets */}
          <Stack.Item>
            <Section>
              <Stack vertical>
                <Stack.Item>
                  <Dropdown
                    mb="2px"
                    width="100%"
                    options={
                      data.character_preferences.misc.loadout_lists.loadouts
                    }
                    selected={data.character_preferences.misc.loadout_index}
                    onSelected={(value) =>
                      act('set_loadout_preset', { name: value })
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button.Confirm
                    icon="times"
                    color="red"
                    align="center"
                    disabled={
                      data.character_preferences.misc.loadout_index ===
                      'Default'
                    }
                    tooltip={
                      data.character_preferences.misc.loadout_index ===
                      'Default'
                        ? "Can't delete the default loadout entry."
                        : 'Delete the current loadout entry.'
                    }
                    onClick={() => act('remove_loadout_preset')}
                  >
                    Delete
                  </Button.Confirm>
                  <Button onClick={() => setManagingPreset('Add')} icon="plus">
                    Add Loadout
                  </Button>
                  <Button
                    icon="pen"
                    onClick={() => setManagingPreset('Rename')}
                    disabled={
                      data.character_preferences.misc.loadout_index ===
                      'Default'
                    }
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          {/* BUBBER EDIT END */}
          <Stack.Item grow>
            <LoadoutSelectedSection
              all_tabs={loadout_tabs}
              modifyItemDimmer={modifyItemDimmer}
              setModifyItemDimmer={setModifyItemDimmer}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        {searching || activeCategory?.contents ? (
          <Section
            title={searching ? 'Searching...' : 'Catalog'}
            fill
            scrollable
            buttons={
              activeCategory?.category_info ? (
                <Box italic mt={0.5}>
                  {activeCategory.category_info}
                </Box>
              ) : null
            }
          >
            <Stack vertical>
              <Stack.Item>
                {searching ? (
                  <SearchDisplay
                    loadout_tabs={loadout_tabs}
                    currentSearch={currentSearch}
                  />
                ) : (
                  <LoadoutTabDisplay category={activeCategory} />
                )}
              </Stack.Item>
            </Stack>
          </Section>
        ) : (
          <Section fill>
            <Box>No contents for selected tab.</Box>
          </Section>
        )}
      </Stack.Item>
    </Stack>
  );
};

const typepathToLoadoutItem = (
  typepath: typePath,
  all_tabs: LoadoutCategory[],
) => {
  // Maybe a bit inefficient, could be replaced with a hashmap?
  for (const tab of all_tabs) {
    for (const item of tab.contents) {
      if (item.path === typepath) {
        return item;
      }
    }
  }
  return null;
};

const LoadoutSelectedItem = (props: {
  path: typePath;
  all_tabs: LoadoutCategory[];
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
}) => {
  const { all_tabs, path, modifyItemDimmer, setModifyItemDimmer } = props;
  const { act } = useBackend();

  const item = typepathToLoadoutItem(path, all_tabs);
  if (!item) {
    return null;
  }

  return (
    <Stack align={'center'}>
      <Stack.Item>
        <ItemIcon item={item} scale={1} />
      </Stack.Item>
      <Stack.Item width="55%">{item.name}</Stack.Item>
      {item.buttons.length ? (
        <Stack.Item>
          <Button
            color="none"
            width="32px"
            onClick={() => {
              setModifyItemDimmer(item);
            }}
          >
            <Icon size={1.8} name="cogs" color="grey" />
          </Button>
        </Stack.Item>
      ) : (
        <Stack.Item width="32px" /> // empty space
      )}
      <Stack.Item>
        <Button
          color="none"
          width="32px"
          onClick={() => act('select_item', { path: path, deselect: true })}
        >
          <Icon size={2.4} name="times" color="red" />
        </Button>
      </Stack.Item>
    </Stack>
  );
};

const LoadoutSelectedSection = (props: {
  all_tabs: LoadoutCategory[];
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
}) => {
  const { act, data } = useBackend<LoadoutManagerData>();
  const loadout_list = data.character_preferences.misc.loadout_lists.loadout; // BUBBER EDIT: Multiple loadout presets: ORIGINAL: const { loadout_list } = data.character_preferences.misc;
  const { all_tabs, modifyItemDimmer, setModifyItemDimmer } = props;

  return (
    <Section
      title="&nbsp;"
      scrollable
      fill
      buttons={
        <Button.Confirm
          icon="times"
          color="red"
          align="center"
          disabled={!loadout_list || Object.keys(loadout_list).length === 0}
          tooltip="Clears ALL selected items from all categories."
          onClick={() => act('clear_all_items')}
        >
          Clear All
        </Button.Confirm>
      }
    >
      {loadout_list &&
        Object.entries(loadout_list).map(([path, item]) => (
          <Fragment key={path}>
            <LoadoutSelectedItem
              path={path}
              all_tabs={all_tabs}
              modifyItemDimmer={modifyItemDimmer}
              setModifyItemDimmer={setModifyItemDimmer}
            />
            <Divider />
          </Fragment>
        ))}
    </Section>
  );
};

const LoadoutPreviewSection = () => {
  const { act, data } = useBackend<LoadoutManagerData>();

  return (
    <Section
      fill
      // BUBBER EDIT REMOVAL: Better loadout pref
      // title="&nbsp;"
      // buttons={
      //   <Button.Checkbox
      //     align="center"
      //     checked={data.job_clothes}
      //     onClick={() => act('toggle_job_clothes')}
      //   >
      //     Job Clothes
      //   </Button.Checkbox>
      // }
    >
      <Stack vertical fill>
        <Stack.Item grow align="center">
          <CharacterPreview height="100%" id={data.character_preview_view} />
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item align="center">
          <Stack>
            {/* BUBBER EDIT ADDITION START: Better loadout pref */}
            <Stack.Item>
              <Dropdown
                selected={data.preview_selection}
                options={data.preview_options}
                onSelected={(value) =>
                  act('update_preview', {
                    updated_preview: value,
                  })
                }
              />
            </Stack.Item>
            {/* BUBBER EDIT END */}
            <Stack.Item>
              <Button
                icon="chevron-left"
                onClick={() =>
                  act('rotate_dummy', {
                    dir: 'left',
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="chevron-right"
                onClick={() =>
                  act('rotate_dummy', {
                    dir: 'right',
                  })
                }
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
