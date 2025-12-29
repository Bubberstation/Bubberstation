import {
  Box,
  Button,
  Divider,
  LabeledList,
  Section,
} from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

export const TrainMovementController = () => {
  const { act, data } = useBackend<{
    moving: boolean;
    num_turfs: number;
    stations: Array<{ type: string; name: string }>;
    current_station: string | null;
  }>();

  const { moving, num_turfs, stations, current_station } = data;

  return (
    <Window title="Train Controller" width={450} height={580}>
      <Window.Content scrollable>
        {/* Основное управление поездом */}
        <Section title="Movement Control">
          <LabeledList>
            <LabeledList.Item label="Status">
              <Box color={moving ? 'good' : 'average'}>
                <b>{moving ? 'MOVING' : 'STOPPED'}</b>
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Processing Turfs">
              <Box color="label">{num_turfs}</Box>
            </LabeledList.Item>
            <LabeledList.Item label="Current Station">
              <Box color={current_station ? 'good' : 'average'}>
                <b>{current_station || 'None (In Transit)'}</b>
              </Box>
            </LabeledList.Item>
          </LabeledList>

          <Box mt={2}>
            <Button
              icon="play"
              color="good"
              disabled={moving}
              onClick={() => act('start_moving')}
            >
              Start Movement
            </Button>
            <Button
              icon="stop"
              color="bad"
              disabled={!moving}
              onClick={() => act('stop_moving')}
            >
              Stop Movement
            </Button>
            <Button
              icon="bug"
              tooltip="Open Variables Viewer (Admin only)"
              onClick={() => act('open_vv')}
            >
              VV
            </Button>
          </Box>
        </Section>

        <Divider />

        {/* Управление станциями */}
        <Section title="Station Management">
          <Box mb={1}>
            <Button
              fluid
              icon="eject"
              color="bad"
              disabled={!current_station}
              onClick={() => act('unload_station')}
            >
              Unload Current Station ({current_station || '—'})
            </Button>
          </Box>

          <Box>
            <Box bold mb={1}>
              Available Stations:
            </Box>
            {stations.length === 0 ? (
              <Box color="average">No stations registered.</Box>
            ) : (
              stations.map((station) => (
                <Button
                  key={station.type}
                  fluid
                  icon="train"
                  color={current_station === station.name ? 'good' : 'default'}
                  onClick={() =>
                    act('load_station', { station_type: station.type })
                  }
                >
                  {station.name}
                  {current_station === station.name && ' (Loaded)'}
                </Button>
              ))
            )}
          </Box>
        </Section>

        <Divider />
        {/* Информация и подсказки */}
        <Section title="Info">
          <Box italic color="label">
            • Use "Load" to dock at a station and stop the train.
            <br />• Unload to depart and resume transit.
            <br />• Background movement simulates train travel between stops.
            <br />• Event by: Fenysha
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
