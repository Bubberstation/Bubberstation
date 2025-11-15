import React, { useState } from 'react';
import {
  Box,
  Button,
  Icon,
  NoticeBox,
  NumberInput,
  Section,
  Stack,
  Table,
  Tabs,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type RoomsData = {
  current_room: number;
  selected_template: string;
  active_rooms: any[];
  conservated_rooms: any[];
  hotel_map_list: any[];
};

const OpenRooms = ({ data, act, selected_template }) => {
  const visibleRooms = data.active_rooms.filter(
    (room) => room.room_preferences.visibility,
  );

  return (
    <Section
      title="Open Rooms"
      style={{
        paddingBottom: '0px',
      }}
    >
      {visibleRooms.length ? (
        <Box
          style={{
            height: '100%',
            overflowY: 'auto',
            width: '100%',
          }}
        >
          <Stack vertical>
            {visibleRooms?.map((room) => (
              <Stack
                fill
                key={room.number}
                style={{
                  padding: '5px 5px',
                  backgroundColor: 'rgba(138, 138, 138, 0.1)',
                }}
              >
                <Stack.Item mr={'10px'}>
                  <Box
                    style={{
                      fontSize: '20px',
                      width: '100px',
                      textAlign: 'center',
                      backgroundColor: 'rgb(0, 0, 0)',
                      border: '2px solid rgb(77, 130, 173)',
                      marginBottom: '5px',
                      color: 'rgb(115, 177, 228)',
                      padding: '0px 0px',
                      borderRadius: '2px',
                    }}
                  >
                    {room.number}
                  </Box>
                  <Button.Confirm
                    style={{
                      cursor: 'pointer',
                      width: '100px',
                      textAlign: 'center',
                    }}
                    confirmContent={'Join?'}
                    confirmColor="green"
                    onClick={() =>
                      act('checkin', {
                        room: Number(room.number),
                        template: selected_template,
                      })
                    }
                    icon="right-to-bracket"
                  >
                    Join
                  </Button.Confirm>
                </Stack.Item>
                <Stack vertical width={'100%'}>
                  <Stack.Item
                    style={{
                      width: '100%',
                    }}
                  >
                    <span
                      style={{
                        display: 'flex',
                        marginTop: '-2px',
                        marginBottom: '-6px',
                      }}
                    >
                      {' '}
                      <Icon
                        size={1.4}
                        style={{
                          marginRight: '10px',
                          marginLeft: '5px',
                          lineHeight: '24px',
                        }}
                        name={room.room_preferences.icon || 'door-open'}
                      />
                      <span
                        style={{
                          fontSize: '18px',
                        }}
                      >
                        {room.name}
                      </span>
                      <span
                        style={{
                          fontSize: '10px',
                          marginLeft: '10px',
                          lineHeight: '26px',
                        }}
                      >
                        {!room.room_preferences.privacy ? (
                          <Icon name="users" />
                        ) : (
                          <Tooltip
                            content={room.occupants.join(', ')}
                            position="top"
                          >
                            <Icon name="users" />
                          </Tooltip>
                        )}{' '}
                        {room.occupants.length}
                      </span>
                    </span>
                  </Stack.Item>
                  <Stack.Item
                    style={{
                      color: 'rgba(255, 255, 255, 0.7)',
                      fontSize: '12px',
                      lineHeight: '1.4',
                      wordWrap: 'break-word',
                      overflowWrap: 'break-word',
                      maxWidth: '400px',
                      marginBottom: '5px',
                      marginLeft: '5px',
                    }}
                  >
                    {room.room_preferences.description ? (
                      room.room_preferences.description
                    ) : (
                      <i>No description</i>
                    )}
                  </Stack.Item>
                </Stack>
              </Stack>
            ))}
          </Stack>
        </Box>
      ) : (
        <i>No open rooms now...</i>
      )}
    </Section>
  );
};

const RoomCheckIn = ({
  data,
  act,
  selectedTab,
  setSelectedTab,
  tabContent,
}) => {
  const { current_room = 1, selected_template = 'Standard' } = data;
  return (
    <Section title="Room Check-In">
      <Stack>
        <Stack.Item grow>
          <Tabs>
            <Tabs.Tab
              key={0}
              selected={selectedTab === 0}
              onClick={() => setSelectedTab(0)}
              style={{ cursor: 'pointer' }}
            >
              <Icon name="shuffle" /> Misc
            </Tabs.Tab>
            <Tabs.Tab
              key={1}
              selected={selectedTab === 1}
              onClick={() => setSelectedTab(1)}
              style={{ cursor: 'pointer' }}
            >
              <Icon name="building" /> Apartment
            </Tabs.Tab>
            <Tabs.Tab
              key={2}
              selected={selectedTab === 2}
              onClick={() => setSelectedTab(2)}
              style={{ cursor: 'pointer' }}
            >
              <Icon name="umbrella-beach" /> Beach
            </Tabs.Tab>
            <Tabs.Tab
              key={3}
              selected={selectedTab === 3}
              onClick={() => setSelectedTab(3)}
              style={{ cursor: 'pointer' }}
            >
              <Icon name="satellite" /> Station
            </Tabs.Tab>
            <Tabs.Tab
              key={4}
              selected={selectedTab === 4}
              onClick={() => setSelectedTab(4)}
              style={{ cursor: 'pointer' }}
            >
              <Icon name="snowflake" /> Winter
            </Tabs.Tab>
            <Tabs.Tab
              key={5}
              selected={selectedTab === 5}
              onClick={() => setSelectedTab(5)}
              style={{ cursor: 'pointer' }}
            >
              <Icon name="heart" /> Special
            </Tabs.Tab>
          </Tabs>
          <Box mt={1}>{tabContent[selectedTab]}</Box>
        </Stack.Item>
        <Stack.Item width="120px">
          <NumberInput
            width="100%"
            minValue={1}
            maxValue={1000000000}
            step={1}
            value={current_room}
            format={(value) => String(Math.floor(value))}
            onDrag={(value) =>
              act('update_room', {
                room: value,
              })
            }
            lineHeight={1.8}
            fontSize="20px"
          />
          <Button.Confirm
            style={{ cursor: 'pointer' }}
            width="100%"
            fluid
            textAlign="center"
            mt={1}
            confirmContent={'Confirm?'}
            onClick={() =>
              act('checkin', {
                room: current_room,
                template: selected_template,
              })
            }
            lineHeight={2}
            icon="right-to-bracket"
          >
            Check-in
          </Button.Confirm>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const ReservedRooms = ({ data }) => {
  return (
    <Section title="Reserved Rooms">
      {data.conservated_rooms.length ? (
        <Table>
          {data.conservated_rooms?.map((room) => (
            <Table.Row key={room.number}>
              <Table.Cell width="1.8em">
                <Icon name={room.room_preferences.icon} />
              </Table.Cell>
              <Table.Cell>Room {room.number}</Table.Cell>
              <Table.Cell>{room.room_preferences.name}</Table.Cell>
            </Table.Row>
          ))}
        </Table>
      ) : (
        <i>No reserved rooms now...</i>
      )}
    </Section>
  );
};

export const CheckoutMenu = (props) => {
  const { act, data } = useBackend<RoomsData>();
  const [selectedTab, setSelectedTab] = useState(0);
  const tabContent = [
    <RoomsTab
      key="misc"
      category="Misc"
      selected_template={data?.selected_template}
    />,
    <RoomsTab
      key="apartment"
      category="Apartment"
      selected_template={data?.selected_template}
    />,
    <RoomsTab
      key="beach"
      category="Beach"
      selected_template={data?.selected_template}
    />,
    <RoomsTab
      key="station"
      category="Station"
      selected_template={data?.selected_template}
    />,
    <RoomsTab
      key="winter"
      category="Winter"
      selected_template={data?.selected_template}
    />,
    <RoomsTab
      key="special"
      category="Special"
      selected_template={data?.selected_template}
    />,
  ];

  return (
    <Box
      style={{
        height: '100%',
        display: 'flex',
        flexDirection: 'column',
      }}
    >
      <RoomCheckIn
        data={data}
        act={act}
        selectedTab={selectedTab}
        setSelectedTab={setSelectedTab}
        tabContent={tabContent}
      />
      <Box
        style={{
          flex: 1,
          overflowY: 'auto',
          width: '100%',
          minHeight: 0, // This is important for Firefox
          scrollbarWidth: 'none',
        }}
      >
        <OpenRooms
          data={data}
          act={act}
          selected_template={data.selected_template}
        />
        <ReservedRooms data={data} />
      </Box>
    </Box>
  );
};

const RoomsTab = (props) => {
  const { category, selected_template } = props;
  const { act, data } = useBackend<RoomsData>();
  const { hotel_map_list = [] } = data;
  const [selectedRoom, setSelectedRoom] = useState(null);

  const targetCategory = category.toLowerCase();
  const filteredRooms = hotel_map_list.filter(
    (room) => room.category?.toLowerCase() === targetCategory,
  );

  const categoryIcons = {
    apartment: 'building',
    beach: 'umbrella-beach',
    station: 'satellite',
    winter: 'snowflake',
    special: 'heart',
    misc: 'shuffle',
  };

  return (
    <Box
      style={{
        height: '100%',
        overflowY: 'auto',
        maxHeight: '15em',
        width: '100%',
      }}
    >
      {filteredRooms.length === 0 && (
        <NoticeBox>No {category} rooms found!</NoticeBox>
      )}
      <Stack vertical fill>
        {filteredRooms.map((room, index) => (
          <Box
            key={room.name}
            mb={index < filteredRooms.length - 1 ? '5px' : '0px'}
          >
            <Stack
              className={
                room.name === selected_template ? 'selected' : undefined
              }
              onClick={() => {
                setSelectedRoom(room.name);
                act('select_room', { room: room.name });
              }}
              style={{
                lineHeight: '1.5',
                cursor: 'pointer',
                transition: 'background-color 0.2s',
                padding: '4px 4px',
                borderRadius: '2px',
                border: '1px solid rgba(150, 211, 150, 0.21)',
                backgroundColor:
                  room.name === selected_template
                    ? 'rgba(159, 212, 163, 0.64)'
                    : 'rgba(167, 212, 167, 0.1)',
              }}
            >
              <Stack.Item>
                {' '}
                <Icon
                  name={
                    categoryIcons[room.category?.toLowerCase()] || 'door-open'
                  }
                  mr={2}
                  style={{ marginLeft: '5px', marginRight: '5px' }}
                />
              </Stack.Item>
              <Stack.Item>{room.name}</Stack.Item>
            </Stack>
          </Box>
        ))}
      </Stack>
    </Box>
  );
};

export const HilbertsHotelCheckout = (props) => {
  const { act, data } = useBackend();

  return (
    <Window width={600} height={600} title="Dr. Hilbert's Hotel Room Reception">
      <Window.Content>
        <CheckoutMenu />
      </Window.Content>
    </Window>
  );
};
