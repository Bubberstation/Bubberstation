import { sortBy } from 'es-toolkit';
import {
  Fragment,
  type Dispatch,
  type SetStateAction,
  useMemo,
  useState,
} from 'react';
import {
  BlockQuote,
  Button,
  Icon,
  ImageButton,
  Modal,
  Section,
  Stack,
  Tabs,
  Tooltip,
} from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';

import { useBackend, useSharedState } from '../../backend';
import { SearchBar } from '../common/SearchBar';
import { searchForSupplies } from './helpers';
import type { CargoData, Supply, SupplyCategory } from './types';

type Props = {
  express?: boolean;
};

export function CargoCatalog(props: Props) {
  const { data } = useBackend<CargoData>();
  const { express } = props;

  const supplies = Object.values(data.supplies);
  const [showContents, setShowContents] = useState('');
  const [searchText, setSearchText] = useSharedState('search_text', '');
  const [activeSupplyName, setActiveSupplyName] = useSharedState(
    'supply',
    supplies[0]?.name,
  );
  // BUBBER EDIT START
  const [activeSubcategory, setActiveSubcategory] = useSharedState(
    'cargo_subcategory',
    '',
  );
  // BUBBER EDIT END

  const basePacks = useMemo(() => {
    let fetched: Supply[] | undefined;

    if (activeSupplyName === 'search_results') {
      fetched = searchForSupplies(supplies, searchText);
    } else {
      fetched = supplies.find(
        (supply) => supply.name === activeSupplyName,
      )?.packs;
    }

    if (!fetched) return [];

    fetched = sortBy(fetched, [(pack: Supply) => pack.name]);

    return fetched;
  }, [activeSupplyName, supplies, searchText]);

  // BUBBER EDIT START
  const subcategoryOrder = useMemo(() => {
    const order: string[] = [];
    for (const pack of basePacks) {
      const sub = pack.subcategory || '';
      if (!order.includes(sub)) {
        order.push(sub);
      }
    }
    if (!order.some((sub) => sub !== '')) {
      return [];
    }
    return [
      ...order.filter((sub) => sub === ''),
      ...order.filter((sub) => sub !== ''),
    ];
  }, [basePacks]);

  const hasSubcategories = subcategoryOrder.length > 0;
  // BUBBER EDIT START
  const subcategoryCounts = useMemo(() => {
    const counts: Record<string, number> = {};
    for (const pack of basePacks) {
      const sub = pack.subcategory || '';
      counts[sub] = (counts[sub] || 0) + 1;
    }
    return counts;
  }, [basePacks]);
  // BUBBER EDIT END

  const resolvedSubcategory =
    hasSubcategories && subcategoryOrder.includes(activeSubcategory)
      ? activeSubcategory
      : (subcategoryOrder[0] ?? '');

  const packs = useMemo(() => {
    if (!hasSubcategories || activeSupplyName === 'search_results') {
      return basePacks;
    }
    return basePacks.filter(
      (pack) => (pack.subcategory || '') === resolvedSubcategory,
    );
  }, [activeSupplyName, basePacks, hasSubcategories, resolvedSubcategory]);
  // BUBBER EDIT END

  return (
    <>
      {showContents && (
        <CatalogPackInfo
          packs={packs}
          name={showContents}
          closeContents={setShowContents}
        />
      )}
      <Stack fill g={0}>
        <Stack.Item grow mr={-0.33}>
          <Section fill>
            <CatalogTabs
              express={express}
              activeSupplyName={activeSupplyName}
              // BUBBER EDIT START - Subcategory accordion props
              activeSubcategory={resolvedSubcategory}
              categories={supplies}
              hasSubcategories={hasSubcategories}
              searchText={searchText}
              subcategoryOrder={subcategoryOrder}
              subcategoryCounts={subcategoryCounts}
              setActiveSupplyName={setActiveSupplyName}
              setActiveSubcategory={setActiveSubcategory}
              // BUBBER EDIT END
              setSearchText={setSearchText}
            />
          </Section>
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item grow={express ? 2 : 3}>
          <Section fill scrollable>
            <CatalogList packs={packs} openContents={setShowContents} />
          </Section>
        </Stack.Item>
      </Stack>
    </>
  );
}

type CatalogTabsProps = {
  // BUBBER EDIT START - Subcategory accordion props
  activeSupplyName: string;
  activeSubcategory: string;
  categories: SupplyCategory[];
  hasSubcategories: boolean;
  searchText: string;
  subcategoryOrder: string[];
  subcategoryCounts: Record<string, number>;
  setActiveSupplyName: (name: string) => void;
  setActiveSubcategory: (subcategory: string) => void;
  // BUBBER EDIT END
  setSearchText: (text: string) => void;
};

function CatalogTabs(props: CatalogTabsProps & Props) {
  const { act, data } = useBackend<CargoData>();
  // BUBBER EDIT START - Subcategory accordion state wiring for selected category
  const {
    activeSupplyName,
    activeSubcategory,
    categories,
    hasSubcategories,
    searchText,
    subcategoryOrder,
    subcategoryCounts,
    setActiveSupplyName,
    setActiveSubcategory,
    setSearchText,
    express,
  } = props;
  // BUBBER EDIT ADDITION
  const { self_paid, allow_private_purchases } = data;
  const getSubcategoryLabel = (subcategory: string) => subcategory || 'General';
  // BUBBER EDIT END

  const sorted = sortBy(categories, [(supply) => supply.name]);

  return (
    <Stack fill vertical>
      <Stack.Item>
        <SearchBar
          expensive
          query={searchText}
          onSearch={(value) => {
            if (value === searchText) {
              return;
            }

            if (value.length) {
              // Start showing results
              setActiveSupplyName('search_results');
            } else if (activeSupplyName === 'search_results') {
              // return to normal category
              setActiveSupplyName(sorted[0]?.name);
            }
            setSearchText(value);
          }}
        />
      </Stack.Item>
      <Stack.Item grow p={1} m={-1} mt={1} overflowY="auto">
        <Tabs vertical>
          <Tabs.Tab
            key="search_results"
            selected={activeSupplyName === 'search_results'}
            style={{ display: 'none' }}
          />

          {/* BUBBER EDIT START - Show subcategory accordion under active category */}
          {sorted.map((supply) => (
            <Fragment key={supply.name}>
              <Tabs.Tab
                className="candystripe"
                color={supply.name === activeSupplyName ? 'green' : undefined}
                selected={supply.name === activeSupplyName}
                onClick={() => {
                  setActiveSupplyName(supply.name);
                  setSearchText('');
                }}
              >
                <Stack justify="space-between">
                  <span>{supply.name}</span>
                  <span> {supply.packs.length}</span>
                </Stack>
              </Tabs.Tab>

              {supply.name === activeSupplyName && hasSubcategories && (
                <Stack.Item ml={1} mr={1} mt={0.5} mb={0.5}>
                  <Stack vertical g={0.25}>
                    {subcategoryOrder.map((sub) => (
                      <Button
                        key={sub || '__none'}
                        fluid
                        color={
                          sub === activeSubcategory ? 'green' : 'transparent'
                        }
                        onClick={() => setActiveSubcategory(sub)}
                        textAlign="left"
                      >
                        <Stack justify="space-between">
                          <span>{getSubcategoryLabel(sub)}</span>
                          <span>{subcategoryCounts[sub] || 0}</span>
                        </Stack>
                      </Button>
                    ))}
                  </Stack>
                </Stack.Item>
              )}
            </Fragment>
          ))}
          {/* BUBBER EDIT END */}
        </Tabs>
      </Stack.Item>
      <Stack.Item>
        {/* BUBBER EDIT START */}
        {(!express || !!allow_private_purchases) && (
          <Button
            fluid
            color={self_paid ? 'caution' : 'transparent'}
            icon={self_paid ? 'check-square-o' : 'square-o'}
            onClick={() => act('toggleprivate')}
            tooltip="Use your own funds to purchase items."
            tooltipPosition="top"
          >
            Buy Privately
          </Button>
        )}
        {/* BUBBER EDIT END */}
      </Stack.Item>
    </Stack>
  );
}

type CatalogListProps = {
  packs: SupplyCategory['packs'];
  openContents: Dispatch<SetStateAction<string>>;
};

function CatalogList(props: CatalogListProps) {
  const { act, data } = useBackend<CargoData>();
  // BUBBER EDIT START - Subcategories
  const {
    cart = [],
    max_order,
    self_paid,
    app_cost,
    displayed_currency_name,
  } = data;
  // BUBBER EDIT END
  const { packs = [], openContents } = props;

  // BUBBER EDIT START - Subcategories
  const renderPacks = (subpacks: SupplyCategory['packs']) => (
    // BUBBER EDIT END
    <>
      {subpacks.map((pack) => {
        let color = '';
        const digits = Math.floor(Math.log10(pack.cost) + 1);
        if (self_paid) {
          color = 'yellow';
        } else if (digits >= 5 && digits <= 6) {
          color = 'orange';
        } else if (digits > 6) {
          color = 'bad';
        }

        const privateBuy = (self_paid && !pack.goody) || app_cost;
        const tooltipIcon = (content: string, icon: string, color: string) => (
          <Stack.Item>
            <Tooltip content={content}>
              <Icon color={color} name={icon} />
            </Tooltip>
          </Stack.Item>
        );

        let amount = 0;
        if (cart) {
          const entry = cart.find((entry) => entry.object === pack.name);
          if (entry) {
            amount = entry.amount;
          }
        }

        return (
          <ImageButton
            key={pack.id}
            fluid
            dmIcon={pack.first_item_icon}
            dmIconState={pack.first_item_icon_state}
            imageSize={32}
            color={color}
            disabled={amount >= max_order}
            buttonsAlt={
              <Button
                color="transparent"
                icon="info"
                onClick={() => openContents(pack.name)}
              />
            }
            onClick={() =>
              act('add', {
                id: pack.id,
              })
            }
          >
            <Stack fill textAlign="right">
              <Stack.Item grow textAlign="left">
                {pack.name}
              </Stack.Item>
              {(!!pack.small_item || !!pack.access || !!pack.contraband) && (
                <Stack.Item>
                  <Stack reverse>
                    {!!pack.small_item &&
                      tooltipIcon('Small Item', 'compress-alt', 'purple')}
                    {!!pack.access &&
                      tooltipIcon('Restricted', 'lock', 'average')}
                    {!!pack.contraband &&
                      tooltipIcon('Contraband', 'pastafarianism', 'bad')}
                  </Stack>
                </Stack.Item>
              )}
              <Stack.Item align="center" width={5.5} mt={-0.75} mb={-0.75}>
                <Stack vertical color="gold" lineHeight={0.75} fontSize={0.85}>
                  <Stack.Item
                    opacity={privateBuy && 0.75}
                    style={{ textDecoration: privateBuy && 'red line-through' }}
                  >
                    {formatMoney(pack.cost)}
                    {displayed_currency_name}
                  </Stack.Item>
                  {!!privateBuy && (
                    <Stack.Item>
                      {formatMoney(Math.round(pack.cost * 1.1))}
                      {displayed_currency_name}
                    </Stack.Item>
                  )}
                </Stack>
              </Stack.Item>
            </Stack>
          </ImageButton>
        );
      })}
    </>
  );

  return <>{renderPacks(packs)}</>; // BUBBER EDIT - Subcategories
}

type CatalogContentsProps = {
  name: string;
  closeContents: Dispatch<SetStateAction<string>>;
  packs: SupplyCategory['packs'];
};

function CatalogPackInfo(props: CatalogContentsProps) {
  const { name, packs, closeContents } = props;
  const pack = packs.find((pack) => pack.name === name);
  const contains = pack?.contains;

  return (
    <Modal p={1} width="50vw" height="50vh">
      <Stack fill vertical>
        <Stack.Item>
          <Section
            fill
            title={name}
            buttons={
              <Button
                icon="close"
                color="bad"
                onClick={() => closeContents('')}
              />
            }
          >
            <BlockQuote>{pack?.desc || 'No description available.'}</BlockQuote>
          </Section>
        </Stack.Item>
        <Stack.Item m={0} grow>
          <Section fill scrollable>
            {contains && contains.length > 0 ? (
              contains.map((item) => (
                <ImageButton
                  key={item.name}
                  fluid
                  dmIcon={item.icon}
                  dmIconState={item.icon_state}
                  buttonsAlt={
                    !!item.amount && (
                      <Stack.Item backgroundColor="rgba(255, 255, 255, 0.1">
                        x{item.amount}
                      </Stack.Item>
                    )
                  }
                  imageSize={32}
                >
                  <Stack fill>
                    <Stack.Item textAlign="left">{item.name}</Stack.Item>
                  </Stack>
                </ImageButton>
              ))
            ) : (
              <Stack fill vertical align="center" justify="center">
                <Stack.Item>
                  <Icon name="triangle-exclamation" size={6} color="orange" />
                </Stack.Item>
                <Stack.Item mt={2} color="label" textAlign="center">
                  {`We can't find information about even the approximate contents
                  of this order.`}
                </Stack.Item>
              </Stack>
            )}
          </Section>
        </Stack.Item>
      </Stack>
    </Modal>
  );
}
