import { useBackend } from 'tgui/backend';
import {
  DmIcon,
  Icon,
  ImageButton,
  NoticeBox,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { createSearch } from 'tgui-core/string';

import type { LoadoutCategory, LoadoutItem, LoadoutManagerData } from './base';

type Props = {
  item: LoadoutItem;
  scale?: number;
};

export function ItemIcon(props: Props) {
  const { item, scale = 3 } = props;
  const icon_to_use = item.icon;
  const icon_state_to_use = item.icon_state;

  if (!icon_to_use || !icon_state_to_use) {
    return (
      <Icon
        name="question"
        size={Math.round(scale * 2.5)}
        color="red"
        style={{
          transform: `translateX(${scale * 2}px) translateY(${scale * 2}px)`,
        }}
      />
    );
  }

  return (
    <DmIcon
      fallback={<Icon name="spinner" spin color="gray" />}
      icon={icon_to_use}
      icon_state={icon_state_to_use}
      style={{
        transform: `scale(${scale}) translateX(${scale * 3}px) translateY(${
          scale * 3
        }px)`,
      }}
    />
  );
}

type DisplayProps = {
  active: boolean;
  item: LoadoutItem;
  scale?: number;
};

export function ItemDisplay(props: DisplayProps) {
  const { act } = useBackend();
  const { active, item, scale = 3 } = props;

  return (
    <div style={{ position: 'relative' }}>
      <ImageButton
        imageSize={scale * 32}
        color={active ? 'green' : 'default'}
        style={{ textTransform: 'capitalize', zIndex: '1' }}
        tooltip={item.name}
        tooltipPosition={'bottom'}
        dmIcon={item.icon}
        dmIconState={item.icon_state}
        onClick={() =>
          act('select_item', {
            path: item.path,
            deselect: active,
          })
        }
      />
      <div
        style={{ position: 'absolute', top: '8px', right: '8px', zIndex: '2' }}
      >
        {item.information.length > 0 && (
          <Stack vertical>
            {item.information.map((info) => (
              <Stack.Item
                key={info.icon}
                fontSize="14px"
                textColor={'darkgray'}
                bold
              >
                <Tooltip position="right" content={info.tooltip}>
                  <Icon name={info.icon} />
                </Tooltip>
              </Stack.Item>
            ))}
<<<<<<< HEAD
            {
              // SKYRAT EDIT START - EXPANDED LOADOUT
              <Flex.Item
                ml={5.7}
                mt={0.35}
                style={{ position: 'absolute', bottom: 5, right: 5 }}
              >
                {ShouldDisplayJobRestriction(item) && ItemJobRestriction(item)}
                {ShouldDisplayPlayerRestriction(item) &&
                  ItemPlayerRestriction(item)}
              </Flex.Item>

              /* SKYRAT EDIT END */
            }
          </Flex.Item>
=======
          </Stack>
>>>>>>> 71a4f3a83ff ([MDB Ignore] Updates visuals for the loadout menu (#90399))
        )}
      </div>
    </div>
  );
}

type ListProps = {
  items: LoadoutItem[];
};

type LoadoutGroup = {
  items: LoadoutItem[];
  title: string;
};

function sortByGroup(items: LoadoutItem[]): LoadoutGroup[] {
  const groups: LoadoutGroup[] = [];

  for (let i = 0; i < items.length; i++) {
    const item: LoadoutItem = items[i];
    let usedGroup: LoadoutGroup | undefined = groups.find(
      (group) => group.title === item.group,
    );
    if (usedGroup === undefined) {
      usedGroup = { items: [], title: item.group };
      groups.push(usedGroup);
    }
    usedGroup.items.push(item);
  }

  return groups;
}

export function ItemListDisplay(props: ListProps) {
  const { data } = useBackend<LoadoutManagerData>();
<<<<<<< HEAD
  const loadout_list =
    data.character_preferences.misc.loadout_lists[
      data.character_preferences.misc.loadout_index
    ]; // BUBBER EDIT: Multiple loadout presets: ORIGINAL: const { loadout_list } = data.character_preferences.misc;
  const itemList = FilterItemList(props.items); // SKYRAT EDIT - EXPANDED LOADOUT
  return (
    <Flex wrap>
      {itemList.map((item /* SKYRAT EDIT : {props.items.map((item) => (*/) => (
        <Flex.Item key={item.name} mr={2} mb={2}>
          <ItemDisplay
            item={item}
            active={loadout_list && loadout_list[item.path] !== undefined}
          />
        </Flex.Item>
=======
  const { loadout_list } = data.character_preferences.misc;
  const itemGroups = sortByGroup(props.items);

  return (
    <Stack vertical>
      {itemGroups.length > 1 && <Stack.Item />}
      {itemGroups.map((group) => (
        <Stack.Item key={group.title}>
          <Stack vertical>
            {itemGroups.length > 1 && (
              <>
                <Stack.Item mt={-1.5} mb={-0.8} ml={1.5}>
                  <h3 color="grey">{group.title}</h3>
                </Stack.Item>
                <Stack.Divider />
              </>
            )}
            <Stack.Item>
              <Stack wrap g={0.5}>
                {group.items.map((item) => (
                  <Stack.Item key={item.name}>
                    <ItemDisplay
                      item={item}
                      active={
                        loadout_list && loadout_list[item.path] !== undefined
                      }
                    />
                  </Stack.Item>
                ))}
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
>>>>>>> 71a4f3a83ff ([MDB Ignore] Updates visuals for the loadout menu (#90399))
      ))}
    </Stack>
  );
}

type TabProps = {
  category: LoadoutCategory | undefined;
};
// SKYRAT EDIT START - EXPANDED LOADOUT
const FilterItemList = (items: LoadoutItem[]) => {
  const { data } = useBackend<LoadoutManagerData>();
  const { is_donator } = data;
  const ckey = data.ckey;

  return items.filter((item: LoadoutItem) => {
    if (item.ckey_whitelist && item.ckey_whitelist.indexOf(ckey) === -1) {
      return false;
    }
    if (item.donator_only && !is_donator) {
      return false;
    }
    return true;
  });
};
const ShouldDisplayPlayerRestriction = (item: LoadoutItem) => {
  if (item.ckey_whitelist || item.restricted_species) {
    return true;
  }

  return false;
};

const ShouldDisplayJobRestriction = (item: LoadoutItem) => {
  if (item.restricted_roles || item.blacklisted_roles) {
    return true;
  }

  return false;
};

const ItemPlayerRestriction = (item: LoadoutItem) => {
  let restrictions: string[] = [];

  if (item.ckey_whitelist) {
    restrictions.push('CKEY Whitelist: ' + item.ckey_whitelist.join(', '));
  }

  if (item.restricted_species) {
    restrictions.push(
      'Species Whitelist: ' + item.restricted_species.join(', '),
    );
  }

  const tooltip = restrictions.join(', ');

  return (
    <Button
      icon="lock"
      height="22px"
      width="22px"
      color="yellow"
      tooltip={tooltip}
      tooltipPosition={'bottom-start'}
      style={{ zIndex: '2' }}
    />
  );
};

const ItemJobRestriction = (item: LoadoutItem) => {
  let restrictions: string[] = [];
  if (item.restricted_roles) {
    restrictions.push('Job Whitelist: ' + item.restricted_roles.join(', '));
  }

  if (item.blacklisted_roles) {
    restrictions.push('Job Blacklist: ' + item.blacklisted_roles.join(', '));
  }
  const tooltip = restrictions.join(', ');
  return (
    <Button
      icon="briefcase"
      height="22px"
      width="22px"
      color="blue"
      tooltip={tooltip}
      tooltipPosition={'bottom-start'}
      style={{ zIndex: '2' }}
    />
  );
};

// SKYRAT EDIT END - EXPANDED LOADOUT
export function LoadoutTabDisplay(props: TabProps) {
  const { category } = props;
  if (!category) {
    return (
      <NoticeBox>
        Erroneous category detected! This is a bug, please report it.
      </NoticeBox>
    );
  }

  return <ItemListDisplay items={category.contents} />;
}

type SearchProps = {
  loadout_tabs: LoadoutCategory[];
  currentSearch: string;
};

export function SearchDisplay(props: SearchProps) {
  const { loadout_tabs, currentSearch } = props;

  const search = createSearch(
    currentSearch,
    (loadout_item: LoadoutItem) => loadout_item.name,
  );

  const validLoadoutItems = loadout_tabs
    .flatMap((tab) => tab.contents)
    .filter(search)
    .sort((a, b) => (a.name > b.name ? 1 : -1));

  if (validLoadoutItems.length === 0) {
    return <NoticeBox>No items found!</NoticeBox>;
  }

  return <ItemListDisplay items={validLoadoutItems} />;
}
