import { Button, NoticeBox, Section, Table } from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

export const SiliconJobManager = (props) => {
  return (
    <NtosWindow width={400} height={300}>
      <NtosWindow.Content scrollable>
        <SiliconManagerContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const SiliconManagerContent = (props) => {
  const { act, data } = useBackend();
  const { authed, slots = [], prioritized = [] } = data;
  if (!authed) {
    return (
      <NoticeBox>
        Current ID does not have access permissions to change job slots.
      </NoticeBox>
    );
  }
  return (
    <Section>
      <Table>
        <Table.Row header>
          <Table.Cell>Prioritized</Table.Cell>
          <Table.Cell>Slots</Table.Cell>
        </Table.Row>
        {slots.map((slot) => (
          <Table.Row key={slot.title} className="candystripe">
            <Table.Cell bold>
              <Button.Checkbox
                fluid
                content={slot.title}
                disabled={slot.total <= 0}
                checked={slot.total > 0 && prioritized.includes(slot.title)}
                onClick={() =>
                  act('Silicon_priority', {
                    target: slot.title,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell collapsing>
              {slot.current} / {slot.total}
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};
