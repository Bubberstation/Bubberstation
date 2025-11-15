import { useEffect, useState } from 'react';
import {
  Box,
  Button,
  Icon,
  Modal,
  Section,
  Stack,
  Table,
  TextArea,
  Tooltip,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

type RoomData = {
  room_number: number;
  bluespace_box: boolean;
  id_card: string;
  user: string;
  room_preferences: {
    status: number;
    visibility: number;
    privacy: number;
    description: string;
    name: string;
    icon: string;
  };
  access_restrictions: {
    room_owner: string;
    trusted_guests: string[];
  };
};

const AVAILABLE_ICONS = [
  'door-open',
  'bed',
  'coffee',
  'glass-water',
  'burger',
  'dice',
  'gamepad',
  'heart',
  'music',
  'palette',
  'book',
  'dumbbell',
  'skull',
  'ghost',
  'money-bill',
  'user-tag',
  'clock',
  'circle',
] as const;

export const HilbertsHotelRoomControl = (props) => {
  const { act, data } = useBackend<RoomData>();
  const [iconPickerOpen, setIconPickerOpen] = useSharedState(
    'iconPicker',
    false,
  );
  const [transferOwnershipModalOpen, setTransferOwnershipModalOpen] =
    useSharedState('transferOwnership', false);
  const [departureModalOpen, setDepartureModalOpen] = useSharedState(
    'departure',
    false,
  );

  const [statusSectionOpen, setStatusSectionOpen] = useSharedState(
    'statusSection',
    true,
  );
  const [departureSectionOpen, setDepartureSectionOpen] = useSharedState(
    'departureSection',
    true,
  );
  const [accessSectionOpen, setAccessSectionOpen] = useSharedState(
    'accessSection',
    true,
  );
  const [interfaceLocked, setInterfaceLocked] = useSharedState(
    'interfaceLocked',
    false,
  );

  const [registerNewUser, setRegisterNewUser] = useSharedState(
    'registerNewUser',
    false,
  );

  const [localName, setLocalName] = useState(data.room_preferences.name || '');
  const [localDescription, setLocalDescription] = useState(
    data.room_preferences.description || '',
  );

  useEffect(() => {
    setLocalName(data.room_preferences.name || '');
    setLocalDescription(data.room_preferences.description || '');
  }, [data.room_preferences.name, data.room_preferences.description]);

  return (
    <Window width={400} height={500} title="Room Control Panel">
      {registerNewUser && (
        <Modal
          style={{
            width: '300px',
            padding: '5px',
          }}
        >
          <Section
            title="Registration"
            buttons={
              <Button
                icon="times"
                color="bad"
                onClick={() => setRegisterNewUser(false)}
                style={{ cursor: 'pointer' }}
              />
            }
          >
            <Box>
              <Stack width="100%">
                <Stack.Item>
                  <Button
                    icon="fingerprint"
                    style={{
                      cursor: 'pointer',
                      fontSize: '1.5em',
                    }}
                    onClick={() => {
                      act('modify_trusted_guests', { action: 'add' });
                      setRegisterNewUser(false);
                    }}
                  />
                </Stack.Item>
                <Stack.Item grow>
                  Press the button to register yourself.
                </Stack.Item>
              </Stack>
            </Box>
          </Section>
        </Modal>
      )}
      {interfaceLocked && (
        <Modal
          style={{
            width: '300px',
            padding: '5px',
          }}
        >
          <Section>
            <Box>
              <Stack width="100%">
                <Stack.Item>
                  <Button
                    icon="fingerprint"
                    style={{
                      cursor: 'pointer',
                      fontSize: '1.5em',
                    }}
                    onClick={() =>
                      data.user === data.access_restrictions.room_owner &&
                      setInterfaceLocked(!interfaceLocked)
                    }
                  />
                </Stack.Item>
                <Stack.Item grow>
                  Press the button to unlock the controls.
                </Stack.Item>
              </Stack>
            </Box>
          </Section>
        </Modal>
      )}
      {!!transferOwnershipModalOpen && (
        <Modal
          style={{
            width: '300px',
            padding: '5px',
          }}
        >
          <Section
            title="Room Ownership"
            buttons={
              <Button
                icon="times"
                color="bad"
                style={{ cursor: 'pointer' }}
                onClick={() => setTransferOwnershipModalOpen(false)}
              />
            }
          >
            <Box>
              <Stack width="100%">
                <Stack.Item>
                  <Button
                    icon="fingerprint"
                    style={{
                      cursor: 'pointer',
                      fontSize: '1.5em',
                    }}
                    onClick={() => {
                      act('transfer_ownership');
                      setTransferOwnershipModalOpen(false);
                    }}
                  />
                </Stack.Item>
                <Stack.Item grow>
                  Press the button to accept the ownership transfer.
                </Stack.Item>
              </Stack>
            </Box>
          </Section>
        </Modal>
      )}
      {!!iconPickerOpen && (
        <Modal
          style={{
            width: '300px',
            padding: '5px',
          }}
        >
          <Section>
            <Box
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(6, 1fr)',
                gap: '8px',
                padding: '8px',
              }}
            >
              {AVAILABLE_ICONS.map((icon) => (
                <Button
                  key={icon}
                  onClick={() => {
                    act('set_icon', { icon });
                    setIconPickerOpen(false);
                  }}
                  style={{
                    height: '32px',
                    width: '32px',
                    padding: '3px 8px',
                    lineHeight: '32px',
                    cursor: 'pointer',
                  }}
                >
                  <Icon name={icon} size={1.5} />
                </Button>
              ))}
            </Box>
          </Section>
        </Modal>
      )}
      {!!departureModalOpen && (
        <Modal
          style={{
            width: '280px',
            padding: '5px',
          }}
        >
          <Section title="Confirm Departure">
            <Stack vertical>
              <Stack.Item>
                Departing will consume your ID card and open your job slot, as
                if you&apos;ve entered cryosleep stasis. Items you put in the
                box will be returned to the cryogenic oversight console.
              </Stack.Item>
              <Stack.Item>
                <Stack justify="space-between">
                  <Stack.Item>
                    <Button
                      icon="check"
                      color="good"
                      onClick={() => {
                        act('depart');
                        setDepartureModalOpen(false);
                      }}
                    >
                      Confirm
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="times"
                      color="bad"
                      onClick={() => setDepartureModalOpen(false)}
                    >
                      Cancel
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Section>
        </Modal>
      )}
      <Window.Content>
        <Box
          style={{
            height: '100%',
            overflowY: 'auto',
            scrollbarWidth: 'none',
            msOverflowStyle: 'none',
            // // @ts-ignore
            // '&::-webkit-scrollbar': {
            //   display: 'none',
            // },
          }}
        >
          <Section>
            <Stack>
              <Stack.Item
                style={{
                  fontSize: '20px',
                  textAlign: 'center',
                  backgroundColor: 'rgb(0, 0, 0)',
                  border: '2px solid rgb(77, 130, 173)',
                  borderRadius: '3px',
                  color: 'rgb(115, 177, 228)',
                  padding: '2px 5px',
                  minWidth: '40px',
                }}
              >
                {data.room_number || 'Err'}
              </Stack.Item>
              <Stack vertical>
                <Stack.Item
                  style={{
                    marginLeft: '10px',
                    fontSize: '8',
                    color: 'rgb(179, 179, 179)',
                    fontStyle: 'italic',
                  }}
                >
                  You&apos;re currently in...
                </Stack.Item>
                <Stack.Item
                  style={{
                    fontSize: '18px',
                    lineHeight: '0.8',
                    marginLeft: '10px',
                    marginTop: '1px',
                  }}
                >
                  {data.room_preferences.name || 'Custom Room'}
                </Stack.Item>
              </Stack>
              <Stack.Item ml="auto" mr="2px">
                <Button
                  onClick={() => setIconPickerOpen(true)}
                  style={{
                    height: '30px',
                    width: '32px',
                    cursor: 'pointer',
                    padding: '6px 8px',
                    marginTop: '1px',
                    marginRight: '1px',
                  }}
                  tooltip="Icon picker"
                >
                  <Icon
                    size={1.5}
                    name={data.room_preferences.icon || 'snowflake'}
                  />
                </Button>
              </Stack.Item>
            </Stack>
          </Section>
          <Section
            title="Room Controls"
            buttons={
              <Stack>
                {data.user === data.access_restrictions.room_owner && (
                  <Stack.Item>
                    <Button
                      fluid
                      icon={interfaceLocked ? 'lock-open' : 'lock'}
                      style={{ cursor: 'pointer' }}
                      tooltip="Lock the interface"
                      color="transparent"
                      onClick={() => setInterfaceLocked(!interfaceLocked)}
                    />
                  </Stack.Item>
                )}
                <Stack.Item>
                  <Button
                    fluid
                    icon={statusSectionOpen ? 'chevron-down' : 'chevron-up'}
                    color="transparent"
                    onClick={() => setStatusSectionOpen(!statusSectionOpen)}
                    style={{
                      cursor: 'pointer',
                    }}
                  />
                </Stack.Item>
              </Stack>
            }
          >
            {statusSectionOpen && (
              <Stack vertical>
                <Stack fill textAlign="center">
                  <Stack.Item grow>
                    <Button
                      fluid
                      icon={
                        data.room_preferences.visibility ? 'eye' : 'eye-slash'
                      }
                      onClick={() => act('toggle_visibility')}
                      lineHeight="2.2"
                      color={
                        data.room_preferences.visibility ? 'blue' : 'green'
                      }
                      style={{ cursor: 'pointer' }}
                      tooltip={
                        data.room_preferences.visibility
                          ? 'The room is visible in the room list'
                          : 'The room is invisible: only those who know the number can join'
                      }
                    >
                      {data.room_preferences.visibility
                        ? 'Visible'
                        : 'Invisible'}
                    </Button>
                  </Stack.Item>
                  <Stack.Item grow>
                    <Button
                      fluid
                      icon={
                        data.room_preferences.status === 1
                          ? 'door-open'
                          : data.room_preferences.status === 2
                            ? 'user-check'
                            : 'door-closed'
                      }
                      color={
                        data.room_preferences.status === 1
                          ? 'orange'
                          : data.room_preferences.status === 2
                            ? 'blue'
                            : 'green'
                      }
                      onClick={() => act('toggle_status')}
                      lineHeight="2.2"
                      style={{ cursor: 'pointer' }}
                      tooltip={
                        data.room_preferences.status === 1
                          ? 'Room is open: anyone can join'
                          : data.room_preferences.status === 2
                            ? 'Only guests from the list can join'
                            : 'Room is locked: nobody can join'
                      }
                    >
                      {' '}
                      {data.room_preferences.status === 1
                        ? 'Open'
                        : data.room_preferences.status === 2
                          ? 'Guests Only'
                          : 'Closed'}
                    </Button>
                  </Stack.Item>
                  <Stack.Item grow>
                    <Button
                      fluid
                      icon={
                        data.room_preferences.privacy ? 'users' : 'user-secret'
                      }
                      onClick={() => act('toggle_privacy')}
                      lineHeight="2.2"
                      color={data.room_preferences.privacy ? 'blue' : 'green'}
                      style={{ cursor: 'pointer' }}
                      tooltip={
                        data.room_preferences.privacy
                          ? 'Guest names are visible in the room list'
                          : 'Only the amount of guests is visible in the room list'
                      }
                    >
                      {data.room_preferences.privacy
                        ? 'Guest names'
                        : 'Only number'}
                    </Button>
                  </Stack.Item>
                </Stack>
                <Stack mt="6px">
                  <Stack.Item width="100%">
                    <TextArea
                      fluid
                      height="1.7em"
                      width="100%"
                      placeholder="Enter room name here..."
                      value={localName}
                      onChange={(value) => setLocalName(value)}
                      maxLength={20}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button.Confirm
                      fluid
                      icon="check"
                      tooltip="Update room name"
                      onClick={() => act('update_name', { name: localName })}
                      style={{
                        cursor: 'pointer',
                        height: '1.7em',
                        width: '1.85em',
                      }}
                      confirmContent={
                        <Tooltip content="Confirm?">
                          <Icon name="question" />
                        </Tooltip>
                      }
                      confirmColor="green"
                    />
                  </Stack.Item>
                </Stack>
                <Stack.Item>
                  <TextArea
                    fluid
                    style={{
                      width: '100%',
                      height: '8em',
                    }}
                    placeholder="Enter room description here..."
                    value={localDescription}
                    onChange={(value) => setLocalDescription(value)}
                    maxLength={220}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button.Confirm
                    fluid
                    icon="check"
                    onClick={() =>
                      act('update_description', {
                        description: localDescription,
                      })
                    }
                    confirmContent={'Confirm?'}
                    confirmColor="green"
                  >
                    Update description
                  </Button.Confirm>
                </Stack.Item>
              </Stack>
            )}
          </Section>
          <Section
            title="Departure"
            buttons={
              <Button
                fluid
                icon={departureSectionOpen ? 'chevron-down' : 'chevron-up'}
                color="transparent"
                onClick={() => setDepartureSectionOpen(!departureSectionOpen)}
                style={{
                  cursor: 'pointer',
                }}
              />
            }
          >
            {departureSectionOpen && (
              <Stack vertical>
                <Stack.Item
                  style={{
                    width: '100%',
                    height: 'fit-content',
                    padding: '5px 5px',
                    backgroundColor: 'rgb(36, 36, 36)',
                  }}
                >
                  {data.id_card ? (
                    <Button
                      fluid
                      icon="eject"
                      onClick={() => {
                        act('eject_id');
                      }}
                      lineHeight="2"
                    >
                      {data.id_card}
                    </Button>
                  ) : (
                    <Box
                      italic
                      style={{
                        lineHeight: '2',
                        marginLeft: '4px',
                        color: 'rgb(128, 128, 128)',
                      }}
                    >
                      No ID card present.
                    </Box>
                  )}
                </Stack.Item>
                <Stack.Item
                  style={{
                    width: '100%',
                    height: 'fit-content',
                    padding: '5px 5px',
                    backgroundColor: 'rgb(36, 36, 36)',
                  }}
                >
                  {data.bluespace_box ? (
                    <Button
                      fluid
                      icon="eject"
                      onClick={() => {
                        act('eject_box');
                      }}
                      lineHeight="2"
                    >
                      Eject storage
                    </Button>
                  ) : (
                    <Box
                      italic
                      style={{
                        lineHeight: '2',
                        marginLeft: '4px',
                        color: 'rgb(128, 128, 128)',
                      }}
                    >
                      Insert the storage container here.
                    </Box>
                  )}
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    icon="sign-out-alt"
                    onClick={() => setDepartureModalOpen(true)}
                    lineHeight="2"
                  >
                    Depart
                  </Button>
                </Stack.Item>
              </Stack>
            )}
          </Section>
          <Section
            title="Room Access"
            buttons={
              <Stack>
                {accessSectionOpen &&
                  data.user === data.access_restrictions.room_owner && (
                    <Stack.Item>
                      <Button
                        fluid
                        icon="plus"
                        color="transparent"
                        onClick={() => setRegisterNewUser(true)}
                        style={{
                          cursor: 'pointer',
                        }}
                      />
                    </Stack.Item>
                  )}
                {accessSectionOpen &&
                  data.user === data.access_restrictions.room_owner &&
                  data.access_restrictions.trusted_guests?.length > 0 && (
                    <Stack.Item>
                      <Button
                        icon="trash-alt"
                        color="transparent"
                        style={{ cursor: 'pointer' }}
                        tooltip="Clear all guests"
                        onClick={() =>
                          act('modify_trusted_guests', { action: 'clear' })
                        }
                      />
                    </Stack.Item>
                  )}
                <Stack.Item>
                  <Button
                    fluid
                    icon={accessSectionOpen ? 'chevron-down' : 'chevron-up'}
                    color="transparent"
                    onClick={() => setAccessSectionOpen(!accessSectionOpen)}
                    style={{
                      cursor: 'pointer',
                    }}
                  />
                </Stack.Item>
              </Stack>
            }
          >
            {accessSectionOpen && (
              <Box>
                {' '}
                <Stack lineHeight="1.6">
                  {data.user === data.access_restrictions.room_owner && (
                    <Stack.Item>
                      <Button
                        icon="exchange-alt"
                        color="transparent"
                        style={{ cursor: 'pointer' }}
                        tooltip="Transfer ownership"
                        onClick={() => setTransferOwnershipModalOpen(true)}
                      />
                    </Stack.Item>
                  )}
                  <Stack.Item>{data.access_restrictions.room_owner}</Stack.Item>
                  <Stack.Item textAlign="right" grow>
                    Room Owner
                  </Stack.Item>
                </Stack>
              </Box>
            )}
          </Section>
          {accessSectionOpen &&
            data.access_restrictions.trusted_guests?.length > 0 && (
              <Section>
                <Table>
                  <tbody>
                    {data.access_restrictions.trusted_guests?.map((guest) => (
                      <GuestRow key={guest} guest_name={guest} />
                    ))}
                  </tbody>
                </Table>
              </Section>
            )}
        </Box>
      </Window.Content>
    </Window>
  );
};

type GuestRowProps = {
  guest_name: string;
  key: string;
};

const GuestRow = (props: GuestRowProps) => {
  const { guest_name, key } = props;
  const { act, data } = useBackend<RoomData>();

  return (
    <Table.Row
      className="candystripe"
      style={{
        height: '2em',
        padding: '20px',
        lineHeight: '2em',
      }}
    >
      <Table.Cell width="100%" textAlign="left">
        {guest_name}
      </Table.Cell>
      <Table.Cell>Guest</Table.Cell>
      <Table.Cell>
        {data.user === data.access_restrictions.room_owner && (
          <Button
            icon="trash-alt"
            color="transparent"
            style={{ cursor: 'pointer' }}
            onClick={() =>
              act('modify_trusted_guests', {
                action: 'remove',
                user: guest_name,
              })
            }
          />
        )}
      </Table.Cell>
    </Table.Row>
  );
};
