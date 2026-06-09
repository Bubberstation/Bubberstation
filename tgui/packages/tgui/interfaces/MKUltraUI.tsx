import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Button, Divider, Section, Stack, Table } from 'tgui-core/components';
import { capitalizeAll } from 'tgui-core/string';

type Commands = {
  commands: Data[];
};

type Data = {
  name: string;
  description: string;
  trigger: string;
  erp: boolean;
};

export const MKUltraUI = () => {
  const { data } = useBackend<Commands>();
  const { commands } = data;
  commands.sort((a, b) => (a.erp < b.erp ? -1 : 1));
  return (
    <Window title="MKUltra Commands" width={550} height={375}>
      <Window.Content scrollable>
        <Stack fill vertical>
          <Stack.Item grow>
            <Section fill scrollable>
              <Table>
                <Table.Row
                  fontSize="15px"
                  header
                  style={{
                    borderBottom: 'thin solid',
                  }}
                >
                  <Table.Cell align="center">Name</Table.Cell>
                  <Table.Cell align="center">Description</Table.Cell>
                  <Table.Cell align="center">Triggers</Table.Cell>
                </Table.Row>

                <Divider hidden />
                {commands.map((commands, id) => (
                  <Table.Row
                    key={id}
                    style={{
                      background: commands.erp ? '#83006241' : undefined,
                      borderBottom: 'thin solid #333',
                      marginBottom: '4px',
                    }}
                  >
                    <Table.Cell
                      fontSize="15px"
                      color="label"
                      align="center"
                      style={{ width: '30%' }}
                    >
                      {capitalizeAll(commands.name)}
                    </Table.Cell>
                    <Table.Cell align="center">
                      <Button
                        color="transparent"
                        icon="info"
                        tooltipPosition="top"
                        tooltip={commands.description}
                      />
                    </Table.Cell>
                    <Table.Cell textAlign="Center">
                      {capitalizeAll(commands.trigger)}
                    </Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
