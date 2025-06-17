import {
  Button,
  Dropdown,
  Input,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { NaniteProgram } from './Nanites/types';

interface ExtraSetting {
  name: string;
  value: string;
  types: string[];
  unit: string;
  true_text: string;
  false_text: string;
  type: string;
}

export const NaniteCodes = () => {
  const { act, data } = useBackend<NaniteProgram>();
  const { activation_code, deactivation_code, kill_code, trigger_code } = data;
  return (
    <Section title="Codes" mr={1}>
      <LabeledList>
        <LabeledList.Item label="Activation">
          <NumberInput
            value={activation_code}
            width="47px"
            minValue={0}
            maxValue={9999}
            step={1}
            onChange={(value) =>
              act('set_code', {
                target_code: 'activation',
                code: value,
              })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="Deactivation">
          <NumberInput
            value={deactivation_code}
            width="47px"
            minValue={0}
            maxValue={9999}
            step={1}
            onChange={(value) =>
              act('set_code', {
                target_code: 'deactivation',
                code: value,
              })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="Kill">
          <NumberInput
            value={kill_code}
            width="47px"
            minValue={0}
            maxValue={9999}
            step={1}
            onChange={(value) =>
              act('set_code', {
                target_code: 'kill',
                code: value,
              })
            }
          />
        </LabeledList.Item>
        {!!data.can_trigger && (
          <LabeledList.Item label="Trigger">
            <NumberInput
              value={trigger_code}
              width="47px"
              minValue={0}
              maxValue={9999}
              step={1}
              onChange={(value) =>
                act('set_code', {
                  target_code: 'trigger',
                  code: value,
                })
              }
            />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};

export const NaniteDelays = () => {
  const { act, data } = useBackend<NaniteProgram>();

  const { timer_restart, timer_shutdown, timer_trigger, timer_trigger_delay } =
    data;

  return (
    <Section title="Delays" ml={1}>
      <LabeledList>
        <LabeledList.Item label="Restart Timer">
          <NumberInput
            value={timer_restart}
            unit="s"
            width="57px"
            minValue={0}
            maxValue={3600}
            step={1}
            onChange={(value) =>
              act('set_restart_timer', {
                delay: value,
              })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="Shutdown Timer">
          <NumberInput
            value={timer_shutdown}
            unit="s"
            width="57px"
            minValue={0}
            maxValue={3600}
            step={1}
            onChange={(value) =>
              act('set_shutdown_timer', {
                delay: value,
              })
            }
          />
        </LabeledList.Item>
        {!!data.can_trigger && (
          <>
            <LabeledList.Item label="Trigger Repeat Timer">
              <NumberInput
                value={timer_trigger}
                unit="s"
                width="57px"
                minValue={0}
                maxValue={3600}
                step={1}
                onChange={(value) =>
                  act('set_trigger_timer', {
                    delay: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Trigger Delay">
              <NumberInput
                value={timer_trigger_delay}
                unit="s"
                width="57px"
                minValue={0}
                maxValue={3600}
                step={1}
                onChange={(value) =>
                  act('set_timer_trigger_delay', {
                    delay: value,
                  })
                }
              />
            </LabeledList.Item>
          </>
        )}
      </LabeledList>
    </Section>
  );
};

export const NaniteExtraEntry = (props) => {
  const { extra_setting } = props;
  const { name, type } = extra_setting;
  const typeComponentMap = {
    number: <NaniteExtraNumber extra_setting={extra_setting} />,
    text: <NaniteExtraText extra_setting={extra_setting} />,
    type: <NaniteExtraType extra_setting={extra_setting} />,
    boolean: <NaniteExtraBoolean extra_setting={extra_setting} />,
  };
  return (
    <LabeledList.Item label={name}>{typeComponentMap[type]}</LabeledList.Item>
  );
};

export const NaniteExtraNumber = (props) => {
  const { extra_setting } = props;
  const { act } = useBackend<NaniteProgram>();
  const { name, value, min, max, unit } = extra_setting;
  return (
    <NumberInput
      value={value}
      width="64px"
      minValue={min}
      maxValue={max}
      unit={unit}
      step={1}
      onChange={(val) =>
        act('set_extra_setting', {
          target_setting: name,
          value: val,
        })
      }
    />
  );
};

export const NaniteExtraText = (props) => {
  const { extra_setting } = props;
  const { act } = useBackend();
  const { name, value }: ExtraSetting = extra_setting;
  return (
    <Input
      value={value}
      width="200px"
      onChange={(val) =>
        act('set_extra_setting', {
          target_setting: name,
          value: val,
        })
      }
    />
  );
};

export const NaniteExtraType = (props) => {
  const { extra_setting } = props;
  const { act } = useBackend();
  const { name, value, types }: ExtraSetting = extra_setting;
  return (
    <Dropdown
      over
      selected={value}
      width="150px"
      options={types}
      onSelected={(val) =>
        act('set_extra_setting', {
          target_setting: name,
          value: val,
        })
      }
    />
  );
};

interface ExtraSettingBoolean {
  name: string;
  true_text: string;
  false_text: string;
  value: boolean;
}

export const NaniteExtraBoolean = (props) => {
  const { extra_setting } = props;
  const { act } = useBackend();
  const { name, value, true_text, false_text }: ExtraSettingBoolean =
    extra_setting;
  return (
    <Button.Checkbox
      checked={value}
      onClick={() =>
        act('set_extra_setting', {
          target_setting: name,
        })
      }
    >
      {value ? true_text : false_text}
    </Button.Checkbox>
  );
};

export const NaniteProgrammer = () => {
  return (
    <Window width={420} height={550}>
      <Window.Content scrollable>
        <NaniteProgrammerContent />
      </Window.Content>
    </Window>
  );
};

interface NaniteProgrammerContentProps {
  has_disk: boolean;
  has_program: boolean;
  name: string;
  desc: string;
  use_rate: string;
  can_trigger: boolean;
  trigger_cost: number;
  trigger_cooldown: number;
  activated: boolean;
  has_extra_settings: boolean;
  extra_settings: ExtraSetting[];
}

export const NaniteProgrammerContent = () => {
  const { act, data } = useBackend<NaniteProgrammerContentProps>();
  const {
    has_disk,
    has_program,
    name,
    desc,
    use_rate,
    can_trigger,
    trigger_cost,
    trigger_cooldown,
    activated,
    has_extra_settings,
    extra_settings,
  } = data;
  if (!has_disk) {
    return (
      <NoticeBox textAlign="center">Insert a nanite program disk</NoticeBox>
    );
  }
  if (!has_program) {
    return (
      <Section
        title="Blank Disk"
        buttons={
          <Button
            disabled={!has_disk}
            icon="eject"
            onClick={() => act('eject')}
          >
            Eject
          </Button>
        }
      />
    );
  }
  return (
    <Section
      title={name}
      buttons={
        <Button icon="eject" onClick={() => act('eject')}>
          Eject
        </Button>
      }
    >
      <Section title="Info">
        <Stack>
          <Stack.Item>{desc}</Stack.Item>
          <Stack.Item>
            <table>
              <LabeledList>
                <LabeledList.Item label="Use Rate">{use_rate}</LabeledList.Item>
                {!!can_trigger && (
                  <>
                    <LabeledList.Item label="Trigger Cost">
                      {trigger_cost}
                    </LabeledList.Item>
                    <LabeledList.Item label="Trigger Cooldown">
                      {trigger_cooldown}
                    </LabeledList.Item>
                  </>
                )}
              </LabeledList>
            </table>
          </Stack.Item>
        </Stack>
      </Section>
      <Section
        title="Settings"
        buttons={
          <Button
            icon={activated ? 'power-off' : 'times'}
            selected={activated}
            color="bad"
            bold
            onClick={() => act('toggle_active')}
          >
            {activated ? 'Active' : 'Inactive'}
          </Button>
        }
      >
        <Stack>
          <Stack.Item>
            <NaniteCodes />
          </Stack.Item>
          <Stack.Item>
            <NaniteDelays />
          </Stack.Item>
        </Stack>
        {!!has_extra_settings && (
          <Section title="Special">
            <LabeledList>
              {extra_settings.map((setting) => (
                <NaniteExtraEntry key={setting.name} extra_setting={setting} />
              ))}
            </LabeledList>
          </Section>
        )}
      </Section>
    </Section>
  );
};
