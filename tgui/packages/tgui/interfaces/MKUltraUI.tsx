import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Button, Divider, Section, Stack, Table } from 'tgui-core/components';
import { round } from 'tgui-core/math';
import { capitalizeAll } from 'tgui-core/string';

type Commands = {
  commands: Data[];
};

type Data = {
  name: string;
  description: string;
  trigger: string;
  erp: boolean;
  cooldown?: number;
  phase: number;
};

export const MKUltraUI = () => {
  const { data } = useBackend<Commands>();
  const { commands } = data;
  commands.sort((a, b) => (a.erp < b.erp ? -1 : 1));
  return (
    <Window title="MKUltra Commands" width={700} height={375}>
      <Window.Content>
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
                  <Table.Cell align="center">Cooldown</Table.Cell>
                </Table.Row>
                <Divider hidden />
                {commands.map((commands, id) => (
                  <>
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
                        style={{ width: '30%', verticalAlign: 'middle' }}
                      >
                        {capitalizeAll(commands.name)}
                      </Table.Cell>
                      <Table.Cell align="center" fontSize="10px" color="label">
                        Phase: {commands.phase.toString()}
                        <br />
                        <Button
                          iconSize={1.5}
                          color="transparent"
                          icon="info"
                          tooltipPosition="top"
                          tooltip={commands.description}
                        />
                      </Table.Cell>
                      <Table.Cell
                        textAlign="Center"
                        style={{ verticalAlign: 'middle' }}
                      >
                        {capitalizeAll(commands.trigger)}
                      </Table.Cell>
                      <Table.Cell
                        align="center"
                        style={{ verticalAlign: 'middle' }}
                      >
                        {commands.cooldown ? (
                          <Button
                            color="transparent"
                            icon="clock"
                            tooltipPosition="top"
                            tooltip={
                              commands.cooldown > 1
                                ? `${commands.cooldown} minutes`
                                : `${round(commands.cooldown * 60, 1)} seconds`
                            }
                          />
                        ) : undefined}
                      </Table.Cell>
                    </Table.Row>
                    {commands.name.toLowerCase() === 'brainwash' ? (
                      <Table.Row height="20px">
                        <Table.Cell />
                        <Table.Cell
                          colSpan={3}
                          align="center"
                          textColor="#ff0000ff"
                          fontSize="10px"
                          style={{
                            borderBottom: 'thin solid #333',
                            borderLeft: 'thin solid #333',
                            borderTop: 'thin solid #00000001',
                          }}
                        >
                          <b>
                            This is mechanical brainwashing and it is only
                            available to the MKUltra chemical.
                          </b>
                        </Table.Cell>
                      </Table.Row>
                    ) : undefined}
                  </>
                ))}
              </Table>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
