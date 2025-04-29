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
import { TechwebWarning } from './Nanites/NoTechwebWarning';
import { NaniteProgram, Techweb } from './Nanites/types';

interface NaniteInfoBoxProps {
  has_disk: boolean;
  has_program: boolean;
  disk: NaniteProgram;
  current_view: number;
  backup_id: number;
  new_backup_id: number;
  techweb: Techweb;
  min_cloud_id: number;
  max_cloud_id: number;
}

export const NaniteDiskBox = (props, context) => {
  const { data } = useBackend<NaniteInfoBoxProps>();
  const { has_disk, has_program, disk } = data;
  if (!has_disk) {
    return <NoticeBox>No disk inserted</NoticeBox>;
  }
  if (!has_program) {
    return <NoticeBox>Inserted disk has no program</NoticeBox>;
  }
  return <NaniteInfoBox program={disk} />;
};

export const NaniteInfoBox = (props) => {
  const { program } = props;
  const {
    name,
    desc,
    activated,
    use_rate,
    can_trigger,
    trigger_cost,
    trigger_cooldown,
    activation_code,
    deactivation_code,
    kill_code,
    trigger_code,
    timer_restart,
    timer_shutdown,
    timer_trigger,
    timer_trigger_delay,
    extra_settings,
  }: NaniteProgram = program;
  return (
    <Section
      title={name}
      buttons={
        <Box inline bold color={activated ? 'good' : 'bad'}>
          {activated ? 'Activated' : 'Deactivated'}
        </Box>
      }
    >
      <Stack>
        <Stack.Item mr={1}>{desc}</Stack.Item>
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
      <Stack>
        <Stack.Item>
          <Section title="Codes" mr={1}>
            <LabeledList>
              <LabeledList.Item label="Activation">
                {activation_code}
              </LabeledList.Item>
              <LabeledList.Item label="Deactivation">
                {deactivation_code}
              </LabeledList.Item>
              <LabeledList.Item label="Kill">{kill_code}</LabeledList.Item>
              {!!can_trigger && (
                <LabeledList.Item label="Trigger">
                  {trigger_code}
                </LabeledList.Item>
              )}
            </LabeledList>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <Section title="Delays" mr={1}>
            <LabeledList>
              <LabeledList.Item label="Restart">
                {timer_restart} s
              </LabeledList.Item>
              <LabeledList.Item label="Shutdown">
                {timer_shutdown} s
              </LabeledList.Item>
              {!!can_trigger && (
                <>
                  <LabeledList.Item label="Trigger">
                    {timer_trigger} s
                  </LabeledList.Item>
                  <LabeledList.Item label="Trigger Delay">
                    {timer_trigger_delay} s
                  </LabeledList.Item>
                </>
              )}
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
      <Section title="Extra Settings">
        <LabeledList>
          {extra_settings?.map((setting) => {
            const naniteTypesDisplayMap = {
              number: (
                <>
                  {setting.value}
                  {setting.unit}
                </>
              ),
              text: setting.value,
              type: setting.value,
              boolean: setting.value ? setting.true_text : setting.false_text,
            };
            return (
              <LabeledList.Item key={setting.name} label={setting.name}>
                {naniteTypesDisplayMap[setting.type]}
              </LabeledList.Item>
            );
          })}
        </LabeledList>
      </Section>
    </Section>
  );
};

interface NaniteCloudBackupProps {
  cloud_id: number;
  cloud_programs: NaniteProgram[];
  cloud_backups: CloudBackups[];
}

interface CloudBackups {
  cloud_id: number;
  cloud_programs: NaniteProgram[];
}

export const NaniteCloudBackupList = () => {
  const { act, data } = useBackend<NaniteCloudBackupProps>();
  const { cloud_backups = [] } = data;

  return cloud_backups.map((backup) => (
    <Button
      fluid
      key={backup.cloud_id}
      textAlign="center"
      onClick={() =>
        act('set_view', {
          view: backup.cloud_id,
        })
      }
    >
      {'Backup #' + backup.cloud_id}
    </Button>
  ));
};

interface NaniteCloudBackupDetailsProps {
  cloud_programs: NaniteProgram[];
  cloud_backup: CloudBackups;
  current_view: number;
  disk: NaniteProgram;
  has_program: boolean;
}

export const NaniteCloudBackupDetails = () => {
  const { act, data } = useBackend<NaniteCloudBackupDetailsProps>();
  const { current_view, disk, has_program, cloud_backup } = data;
  const can_rule = (disk && disk.can_rule) || false;
  if (!cloud_backup) {
    return <NoticeBox>ERROR: Backup not found</NoticeBox>;
  }
  const cloud_programs = data.cloud_programs || [];
  return (
    <Section
      title={'Backup #' + current_view}
      buttons={
        !!has_program && (
          <Button
            icon="upload"
            color="good"
            onClick={() => act('upload_program')}
          >
            Upload Program from Disk
          </Button>
        )
      }
    >
      {cloud_programs.map((program) => {
        const rules = program.rules || [];
        return (
          <Collapsible
            key={program.name}
            title={program.name}
            buttons={
              <Button
                icon="minus-circle"
                color="bad"
                onClick={() =>
                  act('remove_program', {
                    program_id: program.id,
                  })
                }
              />
            }
          >
            <Section>
              <NaniteInfoBox program={program} />
              {(!!can_rule || !!program.has_rules) && (
                <Section
                  mt={-2}
                  title="Rules"
                  buttons={
                    <>
                      {!!can_rule && (
                        <Button
                          icon="plus"
                          color="good"
                          onClick={() =>
                            act('add_rule', {
                              program_id: program.id,
                            })
                          }
                        >
                          Add Rule from Disk
                        </Button>
                      )}
                      <Button
                        icon={
                          program.all_rules_required ? 'check-double' : 'check'
                        }
                        onClick={() =>
                          act('toggle_rule_logic', {
                            program_id: program.id,
                          })
                        }
                      >
                        {program.all_rules_required ? 'Meet all' : 'Meet any'}
                      </Button>
                    </>
                  }
                >
                  {program.has_rules ? (
                    rules.map((rule) => (
                      <Box key={rule.display}>
                        <Button
                          icon="minus-circle"
                          color="bad"
                          onClick={() =>
                            act('remove_rule', {
                              program_id: program.id,
                              rule_id: rule.id,
                            })
                          }
                        />
                        {` ${rule.display}`}
                      </Box>
                    ))
                  ) : (
                    <Box color="bad">No Active Rules</Box>
                  )}
                </Section>
              )}
            </Section>
          </Collapsible>
        );
      })}
    </Section>
  );
};

export const NaniteCloudControl = () => {
  const { act, data } = useBackend<NaniteInfoBoxProps>();
  const {
    has_disk,
    current_view,
    new_backup_id,
    techweb,
    min_cloud_id,
    max_cloud_id,
  } = data;
  return (
    <Window width={375} height={700}>
      <Window.Content scrollable>
        <TechwebWarning display={!techweb} />
        <Section
          title="Program Disk"
          buttons={
            <Button
              icon="eject"
              disabled={!has_disk}
              onClick={() => act('eject')}
            >
              Eject
            </Button>
          }
        >
          <NaniteDiskBox />
        </Section>
        <Section
          title="Cloud Storage"
          buttons={
            current_view ? (
              <Button
                icon="arrow-left"
                onClick={() =>
                  act('set_view', {
                    view: 0,
                  })
                }
              >
                Return
              </Button>
            ) : (
              <>
                {'New Backup: '}
                <NumberInput
                  value={new_backup_id}
                  minValue={min_cloud_id + 1}
                  maxValue={max_cloud_id}
                  stepPixelSize={4}
                  step={1}
                  width="39px"
                  onChange={(value) =>
                    act('update_new_backup_value', {
                      value: value,
                    })
                  }
                />
                <Button icon="plus" onClick={() => act('create_backup')} />
              </>
            )
          }
        >
          {!data.current_view ? (
            <NaniteCloudBackupList />
          ) : (
            <NaniteCloudBackupDetails />
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
