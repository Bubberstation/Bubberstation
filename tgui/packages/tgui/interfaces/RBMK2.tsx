import { useBackend } from '../backend';
import {
  Button,
  LabeledList,
  ProgressBar,
  Section,
  NoticeBox,
} from '../components';
import { Window } from '../layouts';
import { BooleanLike } from 'common/react';

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
                value={parseInt(data.last_power_output)}
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
              {data.consuming}
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
              children={data.active ? 'Deactivate' : 'Activate'}
              selected={data.active}
              onClick={() => act('activate')}
            />
            {data.rod ? (
              <Button.Confirm
                tooltip="Reactor Activation/Deactivation Button"
                textAlign="center"
                width="100%"
                icon="fa-eject"
                color="purple"
                children={'Eject Fuel Rod'}
                onClick={() => act('eject')}
              />
            ) : (
              <NoticeBox danger margin="0" textAlign="center">
                No control rod to eject
              </NoticeBox>
            )}
            <Button.Confirm
              tooltip="Reactor Activation/Deactivation Button"
              textAlign="center"
              width="100%"
              icon="fa-fan"
              color="green"
              children={'Toggle Vents'}
              onClick={() => act('venttoggle')}
            />
            <Button.Confirm
              tooltip="Reactor Activation/Deactivation Button"
              textAlign="center"
              width="100%"
              icon="fa-clock-rotate-left"
              color="blue"
              children={'Change Vents Direction'}
              onClick={() => act('changeventdirection')}
            />
            <Button.Confirm
              tooltip="Reactor Activation/Deactivation Button"
              textAlign="center"
              width="100%"
              icon="fa-helmet-safety"
              color="red"
              children={'Turn Off Safeties'}
              onClick={() => act('safetytoggle')}
            />
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
