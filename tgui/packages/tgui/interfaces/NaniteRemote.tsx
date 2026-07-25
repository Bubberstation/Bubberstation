import {
  Button,
  Input,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const NaniteRemote = (props, context) => {
  return (
    <Window width={420} height={500}>
      <Window.Content scrollable>
        <NaniteRemoteContent />
      </Window.Content>
    </Window>
  );
};

interface NaniteProgramProps {
  code: number;
  locked: boolean;
  mode: string;
  program_name: string;
  relay_code: number;
  comms: boolean;
  message: string;
  saved_settings: Array<SavedSetting>;
}

interface SavedSetting {
  id: string;
  name: string;
  mode: string;
  code: number;
  relay_code: number;
}

export const NaniteRemoteContent = () => {
  const { act, data } = useBackend<NaniteProgramProps>();
  const {
    code,
    locked,
    mode,
    program_name,
    relay_code,
    comms,
    message,
    saved_settings = [],
  } = data;

  const modes = ['Off', 'Local', 'Targeted', 'Area', 'Relay'];

  if (locked) {
    return <NoticeBox>This interface is locked.</NoticeBox>;
  }

  return (
    <>
      <Section
        title="Nanite Control"
        buttons={
          <Button icon="lock" onClick={() => act('lock')}>
            Lock Interface
          </Button>
        }
      >
        <LabeledList>
          <LabeledList.Item label="Name">
            <Input
              value={program_name}
              maxLength={14}
              width="130px"
              onChange={(value) =>
                act('update_name', {
                  name: value,
                })
              }
            />
            <Button icon="save" onClick={() => act('save')}>
              Save
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label={comms ? 'Comm Code' : 'Signal Code'}>
            <NumberInput
              value={code}
              minValue={0}
              maxValue={9999}
              width="47px"
              step={1}
              stepPixelSize={2}
              onChange={(value) =>
                act('set_code', {
                  code: value,
                })
              }
            />
          </LabeledList.Item>
          {!!comms && (
            <LabeledList.Item label="Message">
              <Input
                value={message}
                width="270px"
                onChange={(value) =>
                  act('set_message', {
                    value: value,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {mode === 'Relay' && (
            <LabeledList.Item label="Relay Code">
              <NumberInput
                value={relay_code}
                minValue={0}
                maxValue={9999}
                width="47px"
                step={1}
                stepPixelSize={2}
                onChange={(value) =>
                  act('set_relay_code', {
                    code: value,
                  })
                }
              />
            </LabeledList.Item>
          )}
          <LabeledList.Item label="Signal Mode">
            {modes.map((key) => (
              <Button
                key={key}
                selected={mode === key}
                onClick={() =>
                  act('select_mode', {
                    mode: key,
                  })
                }
              >
                {key}
              </Button>
            ))}
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Saved Settings">
        {saved_settings.length > 0 ? (
          <Table>
            <Table.Row header>
              <Table.Cell width="35%">Name</Table.Cell>
              <Table.Cell width="20%">Mode</Table.Cell>
              <Table.Cell collapsing>Code</Table.Cell>
              <Table.Cell collapsing>Relay</Table.Cell>
            </Table.Row>
            {saved_settings.map((setting) => (
              <Table.Row key={setting.id} className="candystripe">
                <Table.Cell bold color="label">
                  {setting.name}:
                </Table.Cell>
                <Table.Cell>{setting.mode}</Table.Cell>
                <Table.Cell>{setting.code}</Table.Cell>
                <Table.Cell>
                  {setting.mode === 'Relay' && setting.relay_code}
                </Table.Cell>
                <Table.Cell textAlign="right">
                  <Button
                    icon="upload"
                    color="good"
                    onClick={() =>
                      act('load', {
                        save_id: setting.id,
                      })
                    }
                  />
                  <Button
                    icon="minus"
                    color="bad"
                    onClick={() =>
                      act('remove_save', {
                        save_id: setting.id,
                      })
                    }
                  />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        ) : (
          <NoticeBox>No settings currently saved</NoticeBox>
        )}
      </Section>
    </>
  );
};
