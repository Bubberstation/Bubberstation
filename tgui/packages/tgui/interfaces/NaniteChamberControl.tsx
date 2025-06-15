import {
  Box,
  Button,
  Collapsible,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { NaniteProgram } from './Nanites/types';

export const NaniteChamberControl = (props, context) => {
  return (
    <Window width={380} height={570}>
      <Window.Content scrollable>
        <NaniteChamberControlContent />
      </Window.Content>
    </Window>
  );
};

interface NaniteChamberProps {
  status_msg: string;
  locked: boolean;
  occupant_name: string;
  has_nanites: boolean;
  nanite_volume: number;
  regen_rate: number;
  safety_threshold: number;
  cloud_id: number;
  scan_level: number;
  mob_programs: NaniteProgram[];
  min_cloud_id: number;
  max_cloud_id: number;
}

export const NaniteChamberControlContent = () => {
  const { act, data } = useBackend<NaniteChamberProps>();
  const {
    status_msg,
    locked,
    occupant_name,
    has_nanites,
    nanite_volume,
    regen_rate,
    safety_threshold,
    cloud_id,
    scan_level,
    mob_programs = [],
    min_cloud_id,
    max_cloud_id,
  } = data;

  if (status_msg) {
    return <NoticeBox textAlign="center">{status_msg}</NoticeBox>;
  }

  return (
    <Section
      title={'Chamber: ' + occupant_name}
      buttons={
        <Button
          icon={locked ? 'lock' : 'lock-open'}
          color={locked ? 'bad' : 'default'}
          onClick={() => act('toggle_lock')}
        >
          {locked ? 'Locked' : 'Unlocked'}
        </Button>
      }
    >
      {!has_nanites ? (
        <>
          <Box bold color="bad" textAlign="center" fontSize="30px" mb={1}>
            No Nanites Detected
          </Box>
          <Button
            fluid
            bold
            icon="syringe"
            color="green"
            textAlign="center"
            fontSize="30px"
            lineHeight="50px"
            onClick={() => act('nanite_injection')}
          >
            Implant Nanites
          </Button>
        </>
      ) : (
        <>
          <Section
            title="Status"
            buttons={
              <Button
                icon="exclamation-triangle"
                color="bad"
                onClick={() => act('remove_nanites')}
              >
                Destroy Nanites
              </Button>
            }
          >
            <Stack>
              <Stack.Item>
                <LabeledList>
                  <LabeledList.Item label="Nanite Volume">
                    {nanite_volume}
                  </LabeledList.Item>
                  <LabeledList.Item label="Growth Rate">
                    {regen_rate}
                  </LabeledList.Item>
                </LabeledList>
              </Stack.Item>
              <Stack.Item>
                <LabeledList>
                  <LabeledList.Item label="Safety Threshold">
                    <NumberInput
                      value={safety_threshold}
                      minValue={0}
                      maxValue={500}
                      step={10}
                      width="39px"
                      onChange={(value) =>
                        act('set_safety', {
                          value: value,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Cloud ID">
                    <NumberInput
                      value={cloud_id}
                      minValue={min_cloud_id}
                      maxValue={max_cloud_id}
                      step={1}
                      stepPixelSize={3}
                      width="39px"
                      onChange={(value) =>
                        act('set_cloud', {
                          value: value,
                        })
                      }
                    />
                  </LabeledList.Item>
                </LabeledList>
              </Stack.Item>
            </Stack>
          </Section>
          <Section title="Programs">
            {mob_programs?.map((program) => {
              const extra_settings = program.extra_settings || [];
              const rules = program.rules || [];
              return (
                <Collapsible key={program.name} title={program.name}>
                  <Section>
                    <Stack vertical>
                      {scan_level >= 2 && (
                        <Stack.Item>
                          <LabeledList>
                            <LabeledList.Item label="Activation Status">
                              <Box color={program.activated ? 'good' : 'bad'}>
                                {program.activated ? 'Active' : 'Inactive'}
                              </Box>
                            </LabeledList.Item>
                            <LabeledList.Item label="Nanites Consumed">
                              {program.use_rate}/s
                            </LabeledList.Item>
                          </LabeledList>
                        </Stack.Item>
                      )}
                      <Stack.Item>{program.desc}</Stack.Item>
                    </Stack>
                    {scan_level >= 2 && (
                      <Stack>
                        {!!program.can_trigger && (
                          <Stack.Item>
                            <Section title="Triggers">
                              <LabeledList>
                                <LabeledList.Item label="Trigger Cost">
                                  {program.trigger_cost}
                                </LabeledList.Item>
                                <LabeledList.Item label="Trigger Cooldown">
                                  {program.trigger_cooldown}
                                </LabeledList.Item>
                                {!!program.timer_trigger_delay && (
                                  <LabeledList.Item label="Trigger Delay">
                                    {program.timer_trigger_delay} s
                                  </LabeledList.Item>
                                )}
                                {!!program.timer_trigger && (
                                  <LabeledList.Item label="Trigger Repeat Timer">
                                    {program.timer_trigger} s
                                  </LabeledList.Item>
                                )}
                              </LabeledList>
                            </Section>
                          </Stack.Item>
                        )}
                        {!!(
                          program.timer_restart || program.timer_shutdown
                        ) && (
                          <Stack.Item>
                            <Section>
                              <LabeledList>
                                {/* I mean, bruh, this indentation level
                                    is ABSOLUTELY INSANE!!! */}
                                {program.timer_restart && (
                                  <LabeledList.Item label="Restart Timer">
                                    {program.timer_restart} s
                                  </LabeledList.Item>
                                )}
                                {program.timer_shutdown && (
                                  <LabeledList.Item label="Shutdown Timer">
                                    {program.timer_shutdown} s
                                  </LabeledList.Item>
                                )}
                              </LabeledList>
                            </Section>
                          </Stack.Item>
                        )}
                      </Stack>
                    )}
                    {scan_level >= 3 && !!program.has_extra_settings && (
                      <Section title="Extra Settings">
                        <LabeledList>
                          {extra_settings.map((extra_setting) => (
                            <LabeledList.Item
                              key={extra_setting.name}
                              label={extra_setting.name}
                            >
                              {extra_setting.value}
                            </LabeledList.Item>
                          ))}
                        </LabeledList>
                      </Section>
                    )}
                    {scan_level >= 4 && (
                      <Stack>
                        <Stack.Item>
                          <Section title="Codes">
                            <LabeledList>
                              {!!program.activation_code && (
                                <LabeledList.Item label="Activation">
                                  {program.activation_code}
                                </LabeledList.Item>
                              )}
                              {!!program.deactivation_code && (
                                <LabeledList.Item label="Deactivation">
                                  {program.deactivation_code}
                                </LabeledList.Item>
                              )}
                              {!!program.kill_code && (
                                <LabeledList.Item label="Kill">
                                  {program.kill_code}
                                </LabeledList.Item>
                              )}
                              {!!program.can_trigger &&
                                !!program.trigger_code && (
                                  <LabeledList.Item label="Trigger">
                                    {program.trigger_code}
                                  </LabeledList.Item>
                                )}
                            </LabeledList>
                          </Section>
                        </Stack.Item>
                        {program.has_rules && (
                          <Stack.Item>
                            <Section title="Rules">
                              {rules.map((rule) => (
                                <Box key={rule.display}>{rule.display}</Box>
                              ))}
                            </Section>
                          </Stack.Item>
                        )}
                      </Stack>
                    )}
                  </Section>
                </Collapsible>
              );
            })}
          </Section>
        </>
      )}
    </Section>
  );
};
