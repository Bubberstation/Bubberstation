import {
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type ReactorInfo = {
  active: BooleanLike;
  last_power_output: string;
  efficiency: number;
  consuming: string;
  rod: BooleanLike;
};

export const RBMK2 = (props) => {
  const { act, data } = useBackend<ReactorInfo>();
  return (
    <Window width={300} height={350}>
      <Window.Content>
        <Section textAlign="center" title="Status">
          <LabeledList>
            <LabeledList.Item label="Power Generation">
              <ProgressBar
                value={parseInt(data.last_power_output, 10)}
                ranges={{
                  good: [100, Infinity],
                  average: [30, 60],
                  bad: [-Infinity, 30],
                }}
              >
                {data.last_power_output}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Tritium Usage">
              {data.consuming} μmol/s
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls" textAlign="center">
          <LabeledList>
            <Button.Confirm
              tooltip="Reactor Activation/Deactivation Button"
              textAlign="center"
              width="100%"
              icon="fa-power-off"
              confirmContent="Are you sure?"
              selected={data.active}
              onClick={() => act('activate')}
            >
              {data.active ? 'Deactivate' : 'Activate'}
            </Button.Confirm>
            {data.rod ? (
              <Button.Confirm
                tooltip="Fuel Rod Ejection Button"
                textAlign="center"
                width="100%"
                icon="fa-eject"
                color="purple"
                onClick={() => act('eject')}
              >
                Eject Fuel Rod
              </Button.Confirm>
            ) : (
              <NoticeBox danger textAlign="center">
                No control rod to eject
              </NoticeBox>
            )}
            <Button.Confirm
              tooltip="Vent Control Button"
              textAlign="center"
              width="100%"
              icon="fa-fan"
              color="green"
              onClick={() => act('venttoggle')}
            >
              Toggle Vents
            </Button.Confirm>
            <Button.Confirm
              tooltip="Vent Direction Change Button"
              textAlign="center"
              width="100%"
              icon="fa-clock-rotate-left"
              color="blue"
              onClick={() => act('ventdirection')}
            >
              Change Vents Direction
            </Button.Confirm>
            <Button.Confirm
              tooltip="Safety Toggle Button"
              textAlign="center"
              width="100%"
              icon="fa-helmet-safety"
              color="red"
              onClick={() => act('safetytoggle')}
            >
              Turn Off Safeties
            </Button.Confirm>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
