// THIS IS A SKYRAT UI FILE
import {
  Box,
  Button,
  Flex,
  Icon,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tabs,
  Tooltip,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { MaterialAccessBar } from './Fabrication/MaterialAccessBar';

export const AmmoWorkbench = (props) => {
  const [tab, setTab] = useSharedState('tab', 1);
  const { data, act } = useBackend();
  const { materials = [], SHEET_MATERIAL_AMOUNT, hacked, silo_connected } =
    data;

  return (
    <Window
      width={620}
      height={640}
      theme="ammoworkbench"
      title="Ammunitions Workbench"
    >
      <Window.Content>
        <Stack vertical fill>
          {/* Armadyne identity header (this is an Armadyne bench, not Nanotrasen). */}
          <Stack.Item>
            <Box className="AmmoWorkbench__header">
              <Box as="span" className="AmmoWorkbench__header-icon">
                ⌖
              </Box>
              <Box as="span" className="AmmoWorkbench__header-title">
                ARMADYNE AMMUNITIONS WORKBENCH
              </Box>
              <Tooltip
                content={
                  silo_connected
                    ? 'Linked to the ore silo.'
                    : 'Not linked to an ore silo; using local storage. Link with a multitool.'
                }
              >
                <Box
                  as="span"
                  className="AmmoWorkbench__header-silo"
                  color={silo_connected ? 'good' : 'bad'}
                >
                  <Icon name="wifi" mr={0.5} />
                  {silo_connected ? 'LINKED' : 'LOCAL'}
                </Box>
              </Tooltip>
              <Box
                as="span"
                className="AmmoWorkbench__header-status"
                color={hacked ? 'bad' : 'good'}
              >
                {hacked ? 'SAFETY PROTOCOLS: DISENGAGED' : 'SAFETY PROTOCOLS: ENGAGED'}
              </Box>
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Tabs fluid>
              <Tabs.Tab
                icon="gun"
                selected={tab === 1}
                onClick={() => setTab(1)}
              >
                Ammunitions
              </Tabs.Tab>
              <Tabs.Tab
                icon="compact-disc"
                selected={tab === 3}
                onClick={() => setTab(3)}
              >
                Datadisks
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          <Stack.Item grow style={{ overflowY: 'auto' }}>
            {tab === 1 && <AmmunitionsTab />}
            {tab === 3 && <DatadiskTab />}
          </Stack.Item>
          {/* status strip + standard fabricator material dock */}
          <Stack.Item>
            <Section>
              <Flex
                className="AmmoWorkbench__statusline"
                align="center"
                mb={1}
              >
                <Flex.Item color="label" style={{ letterSpacing: '1px' }}>
                  STOCK
                </Flex.Item>
                <Flex.Item grow />
                <Flex.Item color="label">
                  reclaim {data.recyclePercent}% · {Math.round(data.efficiency * 100)}% cost
                </Flex.Item>
              </Flex>
              <MaterialAccessBar
                availableMaterials={materials}
                SHEET_MATERIAL_AMOUNT={SHEET_MATERIAL_AMOUNT}
                onEjectRequested={(material, amount) =>
                  act('remove_mat', { ref: material.ref, amount })
                }
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const AmmunitionsTab = (props) => {
  const { act, data } = useBackend();
  const {
    mag_loaded,
    system_busy,
    hacked,
    error,
    error_type,
    mag_name,
    turboBoost,
    current_rounds,
    max_rounds,
    efficiency,
    time,
    recyclePercent,
    partTier,
    bar_state,
    recycle_preview,
    available_rounds = [],
  } = data;

  const isFull = mag_loaded && current_rounds >= max_rounds;
  let barState = 'IDLE';
  if (system_busy) {
    barState = bar_state || 'FABRICATING';
  } else if (isFull) {
    barState = 'FULL';
  }

  return (
    <>
      {/* fixed-height notice slot so layout doesn't shift */}
      <Box height="2.5rem" mb={0.5}>
        {!!error && (
          <NoticeBox textAlign="center" color={error_type}>
            {error}
          </NoticeBox>
        )}
      </Box>

      <Section title="Machine Settings">
        <Flex align="center" justify="space-between">
          <Flex.Item>
            <Flex align="center">
              <Flex.Item mr={2}>
                <Tooltip content="Component quality. Higher-tier parts mean lower material cost, faster fabrication, and better recycling yield.">
                  <Box>
                    <SignalBars level={partTier} />
                  </Box>
                </Tooltip>
              </Flex.Item>
              <Flex.Item color="label" mr={1}>
                Cost
              </Flex.Item>
              <Flex.Item bold mr={3}>
                {Math.round(efficiency * 100)}%
              </Flex.Item>
              <Flex.Item color="label" mr={1}>
                Time per round
              </Flex.Item>
              <Flex.Item bold>{time}s</Flex.Item>
            </Flex>
          </Flex.Item>
          <Flex.Item>
            <Button.Checkbox
              checked={turboBoost}
              onClick={() => act('turboBoost')}
            >
              Turbo Boost
            </Button.Checkbox>
          </Flex.Item>
        </Flex>
      </Section>

      <Section
        title="Loaded Container"
        buttons={
          <>
            <Button
              icon="recycle"
              tooltip={
                `Empties the container and reclaims ${recyclePercent}% of its rounds' base materials` +
                (recycle_preview ? ` (${recycle_preview})` : '') +
                '.'
              }
              tooltipPosition="bottom-end"
              disabled={!mag_loaded || !current_rounds || system_busy}
              onClick={() => act('RecycleMag')}
            >
              Recycle
            </Button>
            <Button
              icon="eject"
              tooltip="Ejects the current container."
              tooltipPosition="bottom-end"
              disabled={!mag_loaded || system_busy}
              onClick={() => act('EjectMag')}
            >
              Eject
            </Button>
          </>
        }
      >
        {/* fixed height so layout holds when no mag loaded */}
        <Box height="3.5rem">
          {!mag_loaded ? (
            <Flex height="100%" align="center" justify="center">
              <Flex.Item color="label" italic>
                <Icon name="inbox" mr={1} />
                No container inserted. Insert one to begin.
              </Flex.Item>
            </Flex>
          ) : (
            <>
              <Flex align="center" mb={0.5}>
                <Flex.Item grow color="label">
                  {mag_name}
                </Flex.Item>
                <Flex.Item bold mr={2} style={{ letterSpacing: '1px' }}>
                  {'// '}
                  {barState}
                </Flex.Item>
                <Flex.Item bold>
                  {current_rounds} / {max_rounds}
                </Flex.Item>
              </Flex>
              <SegmentBar
                current={current_rounds}
                max={max_rounds}
                active={system_busy}
              />
              {/* inline cancel while busy */}
              {!!system_busy && (
                <Button
                  fluid
                  mt={0.5}
                  icon="xmark"
                  color="bad"
                  textAlign="center"
                  onClick={() => act('CancelFabrication')}
                >
                  Cancel Operation
                </Button>
              )}
            </>
          )}
        </Box>
      </Section>

      <Section title="Available Ammunition Types">
        {!mag_loaded && (
          <Box color="label" italic>
            Insert a container to list compatible rounds.
          </Box>
        )}
        {!!mag_loaded && !available_rounds.length && (
          <Box color="label" italic>
            No printable rounds for this container.
          </Box>
        )}
        {!!mag_loaded &&
          available_rounds.map((available_round) => (
            <Box key={available_round.typepath} mb={0.5}>
              <Tooltip
                content={available_round.mats_list}
                position="bottom-start"
              >
                <Button
                  fluid
                  textAlign="left"
                  disabled={system_busy}
                  onClick={() =>
                    act('FillMagazine', {
                      selected_type: available_round.typepath,
                    })
                  }
                >
                  <Box
                    inline
                    mr={1}
                    style={{
                      width: '0.6rem',
                      height: '0.6rem',
                      borderRadius: '50%',
                      verticalAlign: 'middle',
                      backgroundColor: available_round.tip_color || '#888780',
                      boxShadow: `0 0 3px ${available_round.tip_color || '#888780'}`,
                    }}
                  />
                  {available_round.name}
                </Button>
              </Tooltip>
            </Box>
          ))}
      </Section>

      {!!hacked && (
        <NoticeBox textAlign="center" color="bad">
          !WARNING! - ARMADYNE SAFETY PROTOCOLS ARE NOT ENGAGED! MISUSE IS NOT
          COVERED UNDER WARRANTY. SOME MUNITION TYPES MAY CONSTITUTE A WAR CRIME
          IN YOUR AREA. PLEASE CONTACT AN ARMADYNE ADMINISTRATOR IMMEDIATELY.
        </NoticeBox>
      )}
    </>
  );
};

export const DatadiskTab = (props) => {
  const { act, data } = useBackend();
  const {
    loaded_datadisks = [],
    datadisk_loaded,
    datadisk_name,
    datadisk_desc,
    disk_error,
    disk_error_type,
  } = data;
  return (
    <>
      <Box height="2.5rem" mb={0.5}>
        {!!disk_error && (
          <NoticeBox textAlign="center" color={disk_error_type}>
            {disk_error}
          </NoticeBox>
        )}
      </Box>
      <Section
        title="Datadisk"
        buttons={
          <>
            <Button
              icon="save"
              disabled={!datadisk_loaded}
              onClick={() => act('ReadDisk')}
            >
              Load Disk
            </Button>
            <Button
              icon="eject"
              disabled={!datadisk_loaded}
              onClick={() => act('EjectDisk')}
            >
              Eject
            </Button>
          </>
        }
      >
        <Box minHeight="3rem">
          {datadisk_loaded ? (
            <Box>
              <Box bold mb={0.5}>
                {datadisk_name}
              </Box>
              <Box color="label">{datadisk_desc}</Box>
            </Box>
          ) : (
            <Flex height="3rem" align="center" justify="center">
              <Flex.Item color="label" italic>
                No datadisk inserted.
              </Flex.Item>
            </Flex>
          )}
        </Box>
      </Section>
      <Section title="Installed Recipe Data" mt={1}>
        {!loaded_datadisks.length && (
          <Box color="label" italic>
            No recipe data installed.
          </Box>
        )}
        <Table>
          {loaded_datadisks.map((loaded_datadisk) => (
            <Table.Row key={loaded_datadisk.loaded_disk_name} mb={0.5}>
              <Table.Cell bold>{loaded_datadisk.loaded_disk_name}</Table.Cell>
              <Table.Cell color="label">
                {loaded_datadisk.loaded_disk_desc}
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      </Section>
    </>
  );
};

// Four-bar signal-strength gauge (one bar per part tier), lit to `level`.
const SignalBars = (props) => {
  const level = props.level || 0;
  const heights = [4, 7, 10, 13];
  return (
    <Box inline style={{ whiteSpace: 'nowrap', lineHeight: 0 }}>
      {heights.map((h, i) => (
        <Box
          key={i}
          inline
          style={{
            width: '4px',
            height: `${h}px`,
            marginRight: i < 3 ? '2px' : 0,
            verticalAlign: 'bottom',
            borderRadius: '1px',
            backgroundColor:
              i < level ? '#7bbd2a' : 'rgba(255, 255, 255, 0.15)',
          }}
        />
      ))}
    </Box>
  );
};

// Capacity gauge: continuous fill with per-round dividers (up to SEGMENT_CAP).
const SEGMENT_CAP = 40;

const SegmentBar = (props) => {
  const { current, max, active } = props;
  const litColor = '#7bbd2a';
  const frac = max > 0 ? current / max : 0;
  const bg = 'rgba(255, 255, 255, 0.06)';

  // single animated fill + gap-colored dividers = synced segmented look
  const showSegments = max > 1 && max <= SEGMENT_CAP;
  const dividers = [];
  if (showSegments) {
    for (let i = 1; i < max; i++) {
      dividers.push(
        <Box
          key={i}
          style={{
            position: 'absolute',
            top: 0,
            bottom: 0,
            left: `calc(${(i / max) * 100}% - 1px)`,
            width: '2px',
            backgroundColor: '#0b1109',
          }}
        />,
      );
    }
  }

  return (
    <Box
      style={{
        position: 'relative',
        height: '1.25rem',
        borderRadius: '2px',
        border: '1px solid rgba(255,255,255,0.15)',
        overflow: 'hidden',
        backgroundColor: bg,
      }}
    >
      <Box
        className={active ? 'AmmoWorkbench__barberpole' : undefined}
        style={{
          position: 'absolute',
          top: 0,
          bottom: 0,
          left: 0,
          width: `${frac * 100}%`,
          backgroundColor: active ? undefined : litColor,
        }}
      />
      {dividers}
    </Box>
  );
};
