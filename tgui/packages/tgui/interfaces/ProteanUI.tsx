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
} from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type ProteanData = {
  metal: number;
  metal_max: number;
  low_power: boolean;
  lock: boolean;
  icon: string;
  icon_state: string;
};

export const ProteanUI = () => {
  return (
    <Window width={400} height={270}>
      <Protean />
    </Window>
  );
};

export const Protean = () => {
  const { data, act } = useBackend<ProteanData>();
  const { lock, metal, metal_max, icon, icon_state, low_power } = data;

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
          <ProgressBar
            value={metal / metal_max}
            ranges={{
              good: [0.5, Infinity],
              average: [0.2, 0.5],
              bad: [-Infinity, 0.2],
            }}
          >
            <AnimatedNumber value={Number(metal?.toFixed(2))} />
          </ProgressBar>
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
        </Table.Row>
      </Table>
      <Divider />
      <Stack
        style={{ display: 'flex', justifyContent: 'right', width: '100%' }}
      >
        <ImageButton
          dmIcon={icon}
          dmIconState={icon_state}
          style={{ display: 'inline-flex' }}
          tooltipPosition="top"
          tooltip="Modsuit UI"
          onClick={() => act('openui')}
        />
      </Stack>
    </Section>
  );
};
