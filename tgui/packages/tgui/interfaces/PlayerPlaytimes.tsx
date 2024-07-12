import { useBackend } from '../backend';
import { Box, Button, Icon, Section, Table, Tooltip } from '../components';
import { Window } from '../layouts';

type Data = {
  clients: {
    ckey: string;
    name: string;
    observer: boolean;
    ingame: boolean;
    new_account: string;
    playtime_hours: number;
    flags: {
      icon: string;
      tooltip: string;
    }[];
  }[];
};

export const PlayerPlaytimes = () => {
  const { act, data } = useBackend<Data>();
  const { clients } = data;
  return (
    <Window title="Player Playtimes" width={600} height={700}>
      <Window.Content overflow="auto">
        <Section>
          <Table>
            <Table.Row>
              <Table.Cell>
                <center>
                  <Icon name="clock" />
                </center>
              </Table.Cell>
              <Table.Cell pb={1}>
                <center>Ckey</center>
              </Table.Cell>
              <Table.Cell>
                <center>Real Name</center>
              </Table.Cell>
              <Table.Cell>
                <center>Flags</center>
              </Table.Cell>
              <Table.Cell>
                <center>Actions</center>
              </Table.Cell>
            </Table.Row>
            {clients.map((client) => (
              <Table.Row key={client.name} className="Table__row candystripe">
                <Table.Cell>
                  <center>
                    <Button
                      content={client.playtime_hours}
                      color="transparent"
                      tooltip="View playtime for this player"
                      tooltipPosition="bottom"
                      onClick={() =>
                        act('view_playtime', {
                          ckey: client.ckey,
                        })
                      }
                    />
                  </center>
                </Table.Cell>
                <Table.Cell>
                  <center>
                    {!!client.new_account && (
                      <Tooltip content={client.new_account}>
                        <Icon name="sparkles" />
                      </Tooltip>
                    )}{' '}
                    {client.ckey}
                  </center>
                </Table.Cell>
                <Table.Cell>
                  <center>
                    {!client.ingame ? (
                      <Box color="cyan">(At lobby)</Box>
                    ) : (
                      !!client.observer && (
                        <Tooltip content="This player is observing">
                          <Icon name="ghost" />
                        </Tooltip>
                      )
                    )}{' '}
                    {client.name}
                  </center>
                </Table.Cell>
                <Table.Cell>
                  <center>
                    {client.flags.map((flag) => (
                      <Button
                        key={flag.icon}
                        icon={flag.icon}
                        color="average"
                        tooltip={flag.tooltip}
                      />
                    ))}
                  </center>
                </Table.Cell>
                <Table.Cell>
                  <center>
                    <Button
                      content={<b>PM</b>}
                      color="transparent"
                      tooltip="Send a private message to this player"
                      tooltipPosition="bottom"
                      onClick={() =>
                        act('admin_pm', {
                          ckey: client.ckey,
                        })
                      }
                    />
                    <Button
                      icon="user"
                      color="transparent"
                      tooltip="Open player panel"
                      tooltipPosition="bottom"
                      onClick={() =>
                        act('player_panel', {
                          ckey: client.ckey,
                        })
                      }
                    />
                    <Button
                      icon="terminal"
                      color="transparent"
                      tooltip="View Variables"
                      tooltipPosition="bottom"
                      onClick={() =>
                        act('view_variables', {
                          ckey: client.ckey,
                        })
                      }
                    />
                    <Button
                      icon="ghost"
                      color="transparent"
                      tooltip="Admin-follow"
                      tooltipPosition="bottom"
                      onClick={() =>
                        act('observe', {
                          ckey: client.ckey,
                        })
                      }
                    />
                  </center>
                </Table.Cell>
                <br />
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
