// BUBBER TGUI FILE
import {
  AnimatedNumber,
  Button,
  Divider,
  ImageButton,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';
import { formatSiUnit } from 'tgui-core/format';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type ProteanData = {
  metal: number;
  metal_max: number;
  cell_max_charge: number | null;
  cell_charge: number;
  charge_rate: number;
  can_convert: boolean;
  actively_converting: boolean;
  low_power: boolean;
  transformation: boolean;
  lock: boolean;
  assimilated: boolean;
  is_owner: boolean;
  icon: string;
  icon_state: string;
};

export const ProteanUI = () => {
  return (
    <Window width={400} height={320}>
      <Protean />
    </Window>
  );
};

export const Protean = () => {
  const { data, act } = useBackend<ProteanData>();
  const {
    lock,
    metal,
    metal_max,
    cell_charge,
    cell_max_charge,
    charge_rate,
    can_convert,
    actively_converting,
    icon,
    icon_state,
    low_power,
    transformation,
    assimilated,
    is_owner,
  } = data;

  return (
    <Section
      fill
      title="Suit Lock"
      buttons={
        <Button
          style={{ flex: 0.2 }}
          onClick={() => act('lock')}
          color={lock ? 'bad' : 'good'}
        >
          {lock ? 'Locked' : 'Unlocked'}
        </Button>
      }
    >
      <NoticeBox color={lock ? 'bad' : 'good'} />
      <Divider />
      <LabeledList>
        <LabeledList.Item label="Metal Storage">
          <Stack>
            <Stack.Item width="85%">
              <ProgressBar
                value={metal / metal_max}
                style={{
                  textShadow: '1px 1px 0 black',
                }}
                ranges={{
                  teal: [1, Infinity],
                  good: [0.5, 1],
                  average: [0.2, 0.5],
                  bad: [-Infinity, 0.2],
                }}
              >
                <AnimatedNumber value={Number(metal?.toFixed(2))} />
              </ProgressBar>
            </Stack.Item>
            <Stack.Item right>
              <Button
                color={actively_converting ? 'green' : 'default'}
                icon="fa-charging-station"
                tooltip="Convert Metal into Suit Charge"
                onClick={() => act('convert')}
                disabled={!can_convert}
              />
            </Stack.Item>
          </Stack>
        </LabeledList.Item>
        <LabeledList.Item label="Suit Power">
          <Stack>
            <Stack.Item width="85%">
              <ProgressBar
                value={cell_max_charge ? cell_charge / cell_max_charge : 0}
                style={{
                  textShadow: '1px 1px 0 black',
                }}
                ranges={{
                  white: [0, 0],
                  teal: [0, Infinity],
                }}
              >
                {cell_max_charge
                  ? `${formatSiUnit(cell_charge, 0, 'J')} / ${formatSiUnit(cell_max_charge, 0, 'J')}`
                  : 'Power Cell Missing'}
              </ProgressBar>
            </Stack.Item>
            <Stack.Item textColor="grey" fontSize={0.9} right>
              <Tooltip content="Efficiency rate of metal to power conversion. This can be upgraded with better cells">
                <b>{charge_rate ? charge_rate / 200 : 0}%</b>
              </Tooltip>
            </Stack.Item>
          </Stack>
        </LabeledList.Item>
      </LabeledList>
      <Divider />
      <Table>
        <Table.Row header>
          <Table.Cell fontSize="10px" textAlign="center">
            Low Power Mode
          </Table.Cell>
          <Table.Cell fontSize="10px" textAlign="center">
            Suit Transformation
          </Table.Cell>
          <Table.Cell fontSize="10px" textAlign="center">
            Heal Organs
          </Table.Cell>
          <Table.Cell fontSize="10px" textAlign="center">
            Wearer Transformation
          </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell textAlign="center">
            <Button
              color={low_power ? 'bad' : 'default'}
              icon="plug"
              onClick={() => act('power')}
            />
          </Table.Cell>
          <Table.Cell textAlign="center">
            <Button
              color="default"
              icon="suitcase"
              onClick={() => act('transform')}
            />
          </Table.Cell>
          <Table.Cell textAlign="center">
            <Button color="default" icon="heart" onClick={() => act('heal')} />
          </Table.Cell>
          <Table.Cell textAlign="center">
            <Button
              color={transformation ? 'good' : 'default'}
              icon="video-camera"
              tooltip="Make your current wearer temporarily look like you"
              onClick={() => act('protean_transform')}
            />
          </Table.Cell>
        </Table.Row>
      </Table>
      <Divider />
      <Stack justify="flex-end">
        <Stack.Item>
          <Stack vertical align="center">
            <Stack.Item>
              <ImageButton
                dmIcon={icon}
                dmIconState={icon_state}
                style={{ display: 'inline-flex' }}
                tooltipPosition="top"
                tooltip="Modsuit UI"
                onClick={() => act('openui')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button.Confirm
                fluid
                textAlign="center"
                icon="right-from-bracket"
                color="good"
                confirmColor="bad"
                confirmContent="Are you sure?"
                disabled={!assimilated || !is_owner}
                tooltip={
                  assimilated
                    ? 'Extract the modsuit you absorbed from your body'
                    : 'No assimilated modsuit'
                }
                onClick={() => act('eject_modsuit')}
              >
                Eject Suit
              </Button.Confirm>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
