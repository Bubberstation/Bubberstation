import { useState } from 'react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Collapsible,
  Dropdown,
  Flex,
  Input,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Slider,
  Tabs,
  Tooltip,
} from '../components';
import { Window } from '../layouts';

type Data = {
  mob_name: string;
  mob_type: string;
  admin_mob_type: string;
  client_ckey: string;
  client_rank: string;
  ranks: string;
  last_ckey: string;
  playtimes_enabled: boolean;
  playtime: string;
  godmode: boolean;
  is_frozen: boolean;
  is_slept: boolean;
  client_muted: number;
  current_time: string;
  data_related_ip: string;
  data_related_cid: string;
  data_player_join_date: string;
  data_account_join_date: string;
  data_byond_version: string;
  data_old_names: string;

  glob_mute_bits: {
    name: string;
    bitflag: number;
  }[];

  glob_limbs: {
    [key: string]: string;
  };

  transformables: {
    name: string;
    color: string;
    types: {
      name: string;
      key: string;
    }[];
  }[];
};

const PAGES = [
  {
    title: 'General',
    component: () => GeneralActions,
    color: 'green',
    icon: 'tools',
  },
  {
    title: 'Mob',
    component: () => PhysicalActions,
    color: 'yellow',
    icon: 'bolt',
    canAccess: (data) => {
      return !!data.mob_type.includes('/mob/living');
    },
  },
  {
    title: 'Transform',
    component: () => TransformActions,
    color: 'orange',
    icon: 'exchange-alt',
  },
  {
    title: 'Punish',
    component: () => PunishmentActions,
    color: 'red',
    icon: 'gavel',
  },
  {
    title: 'Fun',
    component: () => FunActions,
    color: 'blue',
    icon: 'laugh',
  },
  {
    title: 'Other',
    component: () => OtherActions,
    color: 'blue',
    icon: 'crosshairs',
  },
];

export const PlayerPanel = () => {
  const { act, data } = useBackend<Data>();
  const [pageIndex, setPageIndex] = useState(0);
  const PageComponent = PAGES[pageIndex].component();

  const {
    mob_name,
    mob_type,
    client_ckey,
    client_rank,
    ranks,
    last_ckey,
    playtimes_enabled,
    playtime,
  } = data;

  return (
    <Window title={`${mob_name} Player Panel`} width={650} height={500}>
      <Window.Content scrollable>
        <Section>
          <Flex>
            <Flex.Item width="80px" color="label" align="center">
              Name:
            </Flex.Item>
            <Flex.Item grow={1}>
              <Input
                width="100%"
                value={mob_name}
                onChange={(e, value) => act('set_name', { name: value })}
              />
            </Flex.Item>
            {!!client_ckey && (
              <Flex.Item>
                <Box inline ml=".75rem" mr=".5rem" color="label">
                  Rank:
                </Box>
                <Flex.Item inline>
                  <Button
                    minWidth="11rem"
                    textAlign="center"
                    onClick={() => act('edit_rank')}
                  >
                    {client_rank}
                  </Button>
                </Flex.Item>
              </Flex.Item>
            )}
          </Flex>
          <Flex mt={1} align="center" wrap="wrap" justify="flex-end">
            <Flex.Item width="80px" color="label">
              Mob Type:
            </Flex.Item>
            <Flex.Item grow={1} align="right">
              {mob_type}
            </Flex.Item>
            <Flex.Item align="right">
              <Button
                minWidth="11rem"
                textAlign="center"
                ml=".5rem"
                icon="window-restore"
                onClick={() => act('access_variables')}
              >
                Access Variables
              </Button>
            </Flex.Item>
            {!!client_ckey && (
              <Flex.Item>
                <Button
                  minWidth="11rem"
                  textAlign="center"
                  ml=".5rem"
                  icon="window-restore"
                  disabled={!playtimes_enabled}
                  onClick={() => act('access_playtimes')}
                >
                  {playtimes_enabled ? playtime : 'Playtimes'}
                </Button>
              </Flex.Item>
            )}
          </Flex>
          {(!!client_ckey || !!last_ckey) && (
            <Flex mt={1} align="center">
              <Flex.Item width="80px" color="label">
                {client_ckey ? 'Client:' : 'Last client:'}
              </Flex.Item>
              <Flex.Item tooltip grow={1}>
                <Tooltip
                  position="bottom"
                  content={ranks || 'No additional ranks'}
                >
                  <Box
                    inline
                    style={{
                      borderBottom: ranks
                        ? '2px dotted rgba(255, 255, 255, 0.8)'
                        : 'none',
                    }}
                  >
                    {client_ckey || last_ckey}
                  </Box>
                </Tooltip>

                {!client_ckey && !!last_ckey && (
                  <Button
                    ml={1}
                    icon="magnifying-glass"
                    tooltip="Get player's current panel"
                    onClick={() => act('open_latest_panel')}
                  />
                )}
              </Flex.Item>

              {!!client_ckey && (
                <Flex.Item align="right">
                  <Button
                    minWidth="11rem"
                    textAlign="center"
                    mx=".5rem"
                    icon="comment-dots"
                    onClick={() => act('private_message')}
                  >
                    Private Message
                  </Button>
                  <Button
                    minWidth="11rem"
                    textAlign="center"
                    icon="phone-alt"
                    onClick={() => act('subtle_message')}
                  >
                    Subtle Message
                  </Button>
                </Flex.Item>
              )}
            </Flex>
          )}
        </Section>
        <Flex grow>
          <Flex.Item>
            <Section fitted>
              <Tabs vertical>
                {PAGES.map((page, i) => {
                  if (page.canAccess && !page.canAccess(data)) {
                    return;
                  }

                  return (
                    <Tabs.Tab
                      key={i}
                      color={page.color}
                      selected={i === pageIndex}
                      icon={page.icon}
                      onClick={() => setPageIndex(i)}
                    >
                      {page.title}
                    </Tabs.Tab>
                  );
                })}
              </Tabs>
            </Section>
          </Flex.Item>
          <Flex.Item grow>
            <PageComponent />
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const GeneralActions = () => {
  const { act, data } = useBackend<Data>();
  const { client_ckey, mob_type, admin_mob_type } = data;
  return (
    <Section>
      <Section title="Damage">
        <Flex>
          <Button
            width="100%"
            icon="heart"
            color="green"
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('heal')}
          >
            Rejuvenate
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="bolt"
            color="orange"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('smite')}
          >
            Smite
          </Button>
        </Flex>
      </Section>

      <Section title="Teleportation">
        <Flex>
          <Button.Confirm
            width="100%"
            icon="reply"
            onClick={() => act('bring')}
          >
            Bring
          </Button.Confirm>
          <Button width="100%" onClick={() => act('orbit')}>
            Orbit
          </Button>
          <Button.Confirm
            width="100%"
            height="100%"
            icon="share"
            onClick={() => act('jump_to')}
          >
            Jump To
          </Button.Confirm>
        </Flex>
      </Section>

      <Section title="Miscellaneous">
        <Flex>
          <Button
            width="100%"
            icon="user-tie"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('select_equipment')}
          >
            Select Equipment
          </Button>
          <Button.Confirm
            icon="trash-alt"
            width="100%"
            height="100%"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('strip')}
          >
            Drop All Items
          </Button.Confirm>
        </Flex>
        <Flex>
          <Button.Confirm
            icon="snowflake"
            width="100%"
            color="orange"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('cryo')}
          >
            Send To Cryo
          </Button.Confirm>
          <Button.Confirm
            width="100%"
            height="100%"
            color="orange"
            icon="undo"
            disabled={!mob_type.includes('/mob/dead/observer')}
            tooltip={
              mob_type !== '/mob/dead/observer'
                ? 'Can only be used on ghosts'
                : ''
            }
            onClick={() => act('lobby')}
          >
            Send To Lobby
          </Button.Confirm>
        </Flex>
      </Section>
      <Section title="Control">
        <Flex>
          <Button.Confirm
            width="100%"
            icon="ghost"
            confirmColor="bad"
            disabled={!client_ckey || !mob_type.includes('/mob/living')}
            onClick={() => act('ghost')}
          >
            Eject Ghost
          </Button.Confirm>
          <Button.Confirm
            width="100%"
            confirmColor="bad"
            disabled={
              mob_type.includes('/mob/dead/observer') ||
              !admin_mob_type.includes('/mob/dead/observer')
            }
            onClick={() => act('take_control')}
          >
            Take Control
          </Button.Confirm>
          <Button.Confirm
            width="100%"
            height="100%" // weird ass bug here, so height set to 100%
            icon="ghost"
            tooltip="Offers control to ghosts"
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('offer_control')}
          >
            Offer Control
          </Button.Confirm>
        </Flex>
      </Section>
    </Section>
  );
};

const PhysicalActions = () => {
  const { act, data } = useBackend<Data>();
  const { glob_limbs, godmode, mob_type } = data;
  const [mobScale, setMobScale] = useState(1);
  const limbs = Object.keys(glob_limbs);
  const limb_flags = limbs.map((_, i) => 1 << i);
  const [delimbOption, setDelimbOption] = useState(0);

  return (
    <Section fill>
      <Section
        title="Traits"
        buttons={
          <Button
            icon={godmode ? 'check-square-o' : 'square-o'}
            color={godmode ? 'green' : 'transparent'}
            onClick={() => act('toggle_godmode')}
          >
            God Mode
          </Button>
        }
      >
        <Flex>
          <Button
            width="100%"
            icon="paw"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('species')}
          >
            Species
          </Button>
          <Button
            width="100%"
            icon="bolt"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('quirk')}
          >
            Quirks
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="magic"
            onClick={() => act('spell')}
          >
            Spells
          </Button>
        </Flex>
        <Flex>
          <Button
            width="100%"
            icon="fist-raised"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() => act('martial_art')}
          >
            Martial Arts
          </Button>
          <Button
            width="100%"
            icon="lightbulb"
            onClick={() => act('skill_panel')}
          >
            Skills
          </Button>
          <Button
            width="100%"
            height="100%"
            icon="comment-dots"
            onClick={() => act('languages')}
          >
            Languages
          </Button>
        </Flex>
      </Section>
      <Section
        title="Limbs"
        buttons={
          <Flex>
            {limbs.map((val, index) => (
              <Button.Checkbox
                key={index}
                height="100%"
                checked={delimbOption & limb_flags[index]}
                disabled={!mob_type.includes('/mob/living/carbon/human')}
                onClick={() =>
                  setDelimbOption(
                    delimbOption & limb_flags[index]
                      ? delimbOption & ~limb_flags[index]
                      : delimbOption | limb_flags[index],
                  )
                }
              >
                {val}
              </Button.Checkbox>
            ))}
          </Flex>
        }
      >
        <Flex>
          <Button.Confirm
            width="100%"
            icon="unlink"
            color="red"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() =>
              act('limb', {
                limbs: limb_flags.map(
                  (val, index) =>
                    !!(delimbOption & val) && glob_limbs[limbs[index]],
                ),
                delimb_mode: true,
              })
            }
          >
            Delimb
          </Button.Confirm>
          <Button.Confirm
            width="100%"
            height="100%"
            icon="link"
            color="green"
            disabled={!mob_type.includes('/mob/living/carbon/human')}
            onClick={() =>
              act('limb', {
                limbs: limb_flags.map(
                  (val, index) =>
                    !!(delimbOption & val) && glob_limbs[limbs[index]],
                ),
              })
            }
          >
            Relimb
          </Button.Confirm>
        </Flex>
      </Section>
      <Section
        title="Scale"
        buttons={
          <Button
            icon="sync"
            onClick={() => {
              setMobScale(1);
              act('scale', { new_scale: 1 });
            }}
          >
            Reset
          </Button>
        }
      >
        <Flex mt={1}>
          <Slider
            minValue={0.25}
            maxValue={8}
            value={mobScale}
            stepPixelSize={12}
            step={0.25}
            onChange={(e, value) => {
              setMobScale(value); // Update slider value
              act('scale', { new_scale: value }); // Update mob's value
            }}
            unit="x"
          />
        </Flex>
      </Section>
      <Section title="Speak">
        <Flex mt={1}>
          <Flex.Item width="100px" color="label">
            Force Say:
          </Flex.Item>
          <Flex.Item grow={1}>
            <Input
              width="100%"
              onEnter={(e, value) => act('force_say', { to_say: value })}
            />
          </Flex.Item>
        </Flex>
        <Flex mt={2}>
          <Flex.Item width="100px" color="label">
            Force Emote:
          </Flex.Item>
          <Flex.Item grow={1}>
            <Input
              width="100%"
              onEnter={(e, value) => act('force_emote', { to_emote: value })}
            />
          </Flex.Item>
        </Flex>
      </Section>
    </Section>
  );
};

const TransformActions = () => {
  const { act, data } = useBackend<Data>();
  const { transformables, mob_type } = data;
  return (
    <Section>
      <Button
        width="100%"
        py=".5rem"
        textAlign="center"
        onClick={() => act('transform', { newType: '/mob/living' })}
      >
        Custom
      </Button>

      {transformables.map((transformables_category) => {
        return (
          <Section title={transformables_category.name} key={0}>
            <Flex wrap="wrap" justify="space-between">
              {transformables_category.types.map((transformables_type) => {
                return (
                  <Flex.Item key={0} width="calc(33.3% - .125rem)" mb=".25rem">
                    <Button.Confirm
                      width="100%"
                      height="100%"
                      color={transformables_category.color}
                      disabled={mob_type === transformables_type.key}
                      onClick={() =>
                        act('transform', {
                          newType: transformables_type.key,
                          newTypeName: transformables_type.name,
                        })
                      }
                    >
                      {transformables_type.name}
                    </Button.Confirm>
                  </Flex.Item>
                );
              })}
            </Flex>
          </Section>
        );
      })}
    </Section>
  );
};

const PunishmentActions = () => {
  const { act, data } = useBackend<Data>();
  const {
    client_ckey,
    mob_type,
    is_frozen,
    is_slept,
    glob_mute_bits,
    client_muted,
    data_related_cid,
    data_related_ip,
    data_byond_version,
    data_player_join_date,
    data_account_join_date,
    data_old_names,
    current_time,
  } = data;
  return (
    <Section>
      <Flex>
        <Button
          width="50%"
          py=".5rem"
          icon="clipboard-list"
          color="orange"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('notes')}
        >
          Notes
        </Button>
        <Button
          width="50%"
          height="100%"
          py=".5rem"
          icon="clipboard-list"
          color="orange"
          textAlign="center"
          onClick={() => act('logs')}
        >
          Logs
        </Button>
      </Flex>
      <Section title="Contain">
        <Flex>
          <Button
            width="100%"
            color={is_frozen ? 'orange' : ''}
            icon={is_frozen ? 'check-square-o' : 'square-o'}
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('freeze')}
          >
            Freeze
          </Button>
          <Button
            width="100%"
            color={is_slept ? 'orange' : ''}
            icon={is_slept ? 'check-square-o' : 'square-o'}
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('sleep')}
          >
            Sleep
          </Button>
          <Button.Confirm
            width="100%"
            height="100%"
            icon="share"
            color="bad"
            disabled={!mob_type.includes('/mob/living')}
            onClick={() => act('prison')}
          >
            Admin Prison
          </Button.Confirm>
        </Flex>
      </Section>

      <Section title="Banishment">
        <Flex>
          <Button.Confirm
            width="100%"
            icon="ban"
            color="red"
            disabled={!client_ckey}
            onClick={() => act('kick')}
          >
            Kick
          </Button.Confirm>
          <Button
            width="100%"
            icon="gavel"
            color="red"
            disabled={!client_ckey}
            onClick={() => act('ban')}
          >
            Ban
          </Button>
          <Button.Confirm
            width="100%"
            height="100%"
            icon="gavel"
            color="red"
            disabled={!client_ckey}
            onClick={() => act('sticky_ban')}
          >
            Sticky Ban
          </Button.Confirm>
        </Flex>
      </Section>

      <Section
        title="Mute"
        buttons={
          <>
            <Button
              icon="lock-open"
              color="green"
              disabled={!client_ckey}
              onClick={() => act('unmute_all')}
            >
              Unmute All
            </Button>
            <Button
              icon="lock"
              color="red"
              disabled={!client_ckey}
              onClick={() => act('mute_all')}
            >
              Mute All
            </Button>
          </>
        }
      >
        <Flex>
          {glob_mute_bits.map((bit, i) => {
            const isMuted = client_muted && client_muted & bit.bitflag;
            return (
              <Button
                key={i}
                width="100%"
                height="100%"
                icon={isMuted ? 'check-square-o' : 'square-o'}
                color={isMuted ? 'bad' : ''}
                disabled={!client_ckey}
                onClick={() =>
                  act('mute', {
                    mute_flag: !isMuted
                      ? client_muted | bit.bitflag
                      : client_muted & ~bit.bitflag,
                  })
                }
              >
                {bit.name}
              </Button>
            );
          })}
        </Flex>
      </Section>
      <Section
        title="Investigate"
        buttons={
          <Flex>
            <Flex.Item align="center" mr=".5rem" color="label">
              Related accounts by:
            </Flex.Item>
            <Button
              minWidth="5rem"
              color="orange"
              textAlign="center"
              mr=".5rem"
              disabled={!data_related_cid}
              onClick={() => act('related_accounts', { related_thing: 'CID' })}
            >
              CID
            </Button>
            <Button
              minWidth="5rem"
              height="100%"
              color="orange"
              textAlign="center"
              disabled={!data_related_ip}
              onClick={() => act('related_accounts', { related_thing: 'IP' })}
            >
              IP
            </Button>
          </Flex>
        }
      >
        <Collapsible
          width="100%"
          color="orange"
          title="Details"
          disabled={!client_ckey}
        >
          <LabeledList>
            <LabeledList.Item label="NOW" color="label">
              {current_time}
            </LabeledList.Item>
            <LabeledList.Item label="Account made">
              {data_account_join_date}
            </LabeledList.Item>
            <LabeledList.Item label="First joined server">
              {data_player_join_date}
            </LabeledList.Item>
            <LabeledList.Item label="Byond version">
              {data_byond_version}
            </LabeledList.Item>
            <LabeledList.Item label="Old names">
              {data_old_names}
            </LabeledList.Item>
          </LabeledList>
        </Collapsible>
      </Section>
    </Section>
  );
};

const FunActions = () => {
  const { act } = useBackend<Data>();

  const colours = {
    White: '#a4bad6',
    Dark: '#42474D',
    Red: '#c51e1e',
    'Red Bright': '#FF0000',
    Velvet: '#660015',
    Green: '#059223',
    Blue: '#6685f5',
    Purple: '#800080',
    'Purple Dark': '#5000A0',
    Narsie: '#973e3b',
    Ratvar: '#BE8700',
  };

  const [lockExplode, setLockExplode] = useState(true);
  const [empMode, setEmpMode] = useState(false);
  const [expPower, setExpPower] = useState(8);
  const [narrateSize, setNarrateSize] = useState(1);
  const [narrateMessage, setNarrateMessage] = useState('');
  const [narrateColour, setNarrateColour] = useState(Object.keys(colours)[0]);
  const [narrateFont, setNarrateFont] = useState('Verdana');
  const [narrateBold, setNarrateBold] = useState(false);
  const [narrateItalic, setNarrateItalic] = useState(false);
  const [narrateGlobal, setNarrateGlobal] = useState(false);
  const [narrateRange, setNarrateRange] = useState(7);

  const narrateStyles = {
    color: colours[narrateColour],
    'font-size': narrateSize + 'rem',
    'font-weight': narrateBold ? 'bold' : '',
    'font-family': narrateFont,
    'font-style': narrateItalic ? 'italic' : '',
  };

  return (
    <Section fill>
      <NoticeBox info textAlign="center">
        These features are centred on YOUR viewport
      </NoticeBox>

      <Section
        title="Explosion"
        buttons={
          <>
            <Button.Checkbox
              checked={empMode}
              color="transparent"
              onClick={() => setEmpMode(!empMode)}
            >
              EMP Mode
            </Button.Checkbox>
            <Button
              icon={lockExplode ? 'lock' : 'lock-open'}
              onClick={() => setLockExplode(!lockExplode)}
              color={lockExplode ? 'green' : 'bad'}
            >
              {lockExplode ? 'Locked' : 'Unlocked'}
            </Button>
          </>
        }
      >
        <Flex align="right" grow={1} mt={1}>
          <Flex.Item>
            <Button
              width="100%"
              height="100%"
              color="red"
              disabled={lockExplode}
              onClick={() =>
                act('explode', { power: expPower, emp_mode: empMode })
              }
            >
              <Box height="100%" pt={2} pb={2} textAlign="center">
                Detonate
              </Box>
            </Button>
          </Flex.Item>
          <Flex.Item ml={1} grow={1}>
            <Slider
              unit="Range"
              value={expPower}
              stepPixelSize={15}
              onDrag={(e, value) => setExpPower(value)}
              ranges={{
                green: [0, 8],
                orange: [8, 15],
                red: [15, 30],
              }}
              minValue={1}
              maxValue={30}
              height="100%"
            />
          </Flex.Item>
        </Flex>
      </Section>
      <Section
        title="Narrate"
        buttons={
          <Button
            icon={narrateGlobal ? 'check-square-o' : 'square-o'}
            color={narrateGlobal ? 'red' : 'transparent'}
            onClick={() => setNarrateGlobal(!narrateGlobal)}
          >
            Global Narrate
          </Button>
        }
      >
        <Flex width="100%">
          <Flex width="100%" wrap>
            <Flex.Item width="52%">
              <LabeledList>
                <LabeledList.Item label="Colour">
                  <Dropdown
                    width="calc(100% - 1rem)"
                    options={Object.keys(colours)}
                    selected={narrateColour}
                    onSelected={(value) => setNarrateColour(value)}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Font">
                  <Dropdown
                    width="calc(100% - 1rem)"
                    selected={narrateFont}
                    options={[
                      'Verdana',
                      'Consolas',
                      'Trebuchet MS',
                      'Comic Sans MS',
                      'Times New Roman',
                    ]}
                    onSelected={(value) => setNarrateFont(value)}
                  />
                </LabeledList.Item>
              </LabeledList>
            </Flex.Item>
            <Flex.Item width="20%">
              <LabeledList>
                <LabeledList.Item label="Bold">
                  <Button.Checkbox
                    checked={narrateBold}
                    height="100%"
                    color="transparent"
                    onClick={() => setNarrateBold(!narrateBold)}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Italic">
                  <Button.Checkbox
                    checked={narrateItalic}
                    height="100%"
                    color="transparent"
                    onClick={() => setNarrateItalic(!narrateItalic)}
                  />
                </LabeledList.Item>
              </LabeledList>
            </Flex.Item>
            <Flex.Item width="28%">
              <LabeledList>
                <LabeledList.Item label="Size">
                  <NumberInput
                    width="100%"
                    value={narrateSize}
                    minValue={1}
                    maxValue={6}
                    unit="rem"
                    // align="center"
                    step={1}
                    stepPixelSize={25}
                    onDrag={(value) => setNarrateSize(value)}
                  />
                </LabeledList.Item>
                {!narrateGlobal && (
                  <LabeledList.Item label="Range">
                    <NumberInput
                      width="100%"
                      value={narrateRange}
                      minValue={1}
                      maxValue={14}
                      unit="Tiles"
                      step={1}
                      // align="center"
                      stepPixelSize={25}
                      onDrag={(value) => setNarrateRange(value)}
                    />
                  </LabeledList.Item>
                )}
              </LabeledList>
            </Flex.Item>
          </Flex>
        </Flex>

        <Flex mt="1rem">
          <Flex.Item width="100%" mr="1rem">
            <Input
              width="100%"
              my=".5rem"
              onInput={(e, value) => setNarrateMessage(value)}
            />
          </Flex.Item>

          <Button
            color="green"
            p=".5rem"
            textAlign="center"
            disabled={!narrateMessage}
            onClick={() =>
              act('narrate', {
                message: narrateMessage,
                classes: narrateStyles,
                range: narrateRange,
                mode_global: narrateGlobal,
              })
            }
          >
            Broadcast
          </Button>
        </Flex>

        <Box
          style={narrateStyles}
          mt="1rem"
          pl=".5rem"
          width="37rem"
          maxWidth="37rem"
        >
          {narrateMessage}
        </Box>
      </Section>
    </Section>
  );
};

const OtherActions = () => {
  const { act, data } = useBackend<Data>();
  const { mob_type, client_ckey } = data;

  return (
    <Section fill>
      <Section title="Miscellaneous Features">
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('traitor_panel')}
        >
          Traitor Panel
        </Button>
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('job_exemption_panel')}
        >
          Job Exemption Panel
        </Button>
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('commend')}
        >
          Commend Behavior
        </Button>
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={!client_ckey}
          onClick={() => act('play_sound_to')}
        >
          Play Sound To
        </Button>
        <Button
          width="100%"
          p=".5rem"
          mb=".5rem"
          textAlign="center"
          disabled={
            !client_ckey || !mob_type.includes('/mob/living/carbon/human')
          }
          onClick={() => act('apply_client_quirks')}
        >
          Apply Client Quirks
        </Button>
      </Section>
    </Section>
  );
};
