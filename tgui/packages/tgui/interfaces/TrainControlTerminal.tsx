import {
  Box,
  Button,
  Divider,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Window } from '../layouts';

interface TrainControlData {
  is_moving: boolean;
  current_station: string;
  planned_station: string;
  blocking: boolean;
  possible_next: Array<{
    name: string;
    type: string;
  }>;
  progress: number;
  time_remaining: number;
  read_only: BooleanLike;
}

export const TrainControlTerminal = (props: any, context: any) => {
  const { act, data } = useBackend<TrainControlData>();

  const {
    is_moving = false,
    current_station = 'Неизвестно',
    planned_station = 'None',
    blocking = false,
    read_only = false,
    possible_next = [],
    progress = 0,
    time_remaining = 0,
  } = data;

  const readOnly = read_only || false;
  const safePossibleNext = Array.isArray(possible_next) ? possible_next : [];

  const formatTime = (seconds: number): string => {
    if (seconds <= 0) return 'Прибытие';
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs < 10 ? '0' : ''}${secs}`;
  };

  const renderTravelView = () => (
    <Section title="Движение по маршруту" fill>
      <Stack vertical align="center" mt={6}>
        <Stack.Item>
          <Box fontSize="2rem" bold color="good">
            {current_station} → {planned_station}
          </Box>
        </Stack.Item>
        <Stack.Item mt={4} width="90%">
          <ProgressBar
            value={progress}
            minValue={0}
            maxValue={1}
            color="good"
            height="40px"
          >
            <Box textAlign="center" lineHeight="40px" fontSize="1.8rem">
              🚂 {Math.round(progress * 100)}%
            </Box>
          </ProgressBar>
        </Stack.Item>
        <Stack.Item mt={3} fontSize="1.6rem" opacity={0.8}>
          Осталось:{' '}
          <Box inline color="good" bold>
            {formatTime(time_remaining)}
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );

  const renderMapView = () => {
    const numOptions = safePossibleNext.length;
    if (numOptions === 0) {
      return (
        <Section title="Карта маршрута" fill textAlign="center" py={8}>
          <Box color="average" fontSize="1.6rem">
            Нет доступных маршрутов
          </Box>
        </Section>
      );
    }

    const centerX = 300;
    const centerY = 140;
    const radius = 160;

    return (
      <Section title="Карта маршрута" fill>
        <Box textAlign="center" py={2}>
          <svg
            width="90%"
            height="380"
            viewBox="0 0 500 300"
            preserveAspectRatio="xMidYMid meet"
          >
            {safePossibleNext.map((station, index) => {
              const angleStep = (Math.PI * 0.85) / (numOptions - 1 || 1);
              const angle = -Math.PI * 0.425 + index * angleStep;
              const endX = centerX + Math.sin(angle) * radius;
              const endY = centerY + Math.cos(angle) * radius;

              return (
                <g key={station.type}>
                  <line
                    x1={centerX}
                    y1={centerY}
                    x2={endX}
                    y2={endY}
                    stroke="#222233"
                    strokeWidth="14"
                    opacity="0.9"
                  />
                  <line
                    x1={centerX}
                    y1={centerY}
                    x2={endX}
                    y2={endY}
                    stroke="#88CCFF"
                    strokeWidth="6"
                    strokeDasharray="12,6"
                    opacity="0.8"
                  />
                  <g
                    onClick={() =>
                      act('choose_next', { station_type: station.type })
                    }
                    style={{ cursor: 'pointer' }}
                  >
                    <circle
                      cx={endX + 3}
                      cy={endY + 3}
                      r={station.name === planned_station ? 28 : 24}
                      fill="#000000"
                      opacity="0.4"
                    />
                    <circle
                      cx={endX}
                      cy={endY}
                      r={station.name === planned_station ? 28 : 24}
                      fill={
                        station.name === planned_station ? '#00CC00' : '#4466CC'
                      }
                      stroke={
                        station.name === planned_station ? '#00FF00' : '#88AAFF'
                      }
                      strokeWidth="4"
                    />
                    <text
                      x={endX}
                      y={endY + 8}
                      textAnchor="middle"
                      fontSize="28"
                      fill="#FFFFFF"
                    >
                      🚉
                    </text>
                  </g>
                  <text
                    x={endX}
                    y={endY + 60}
                    textAnchor="middle"
                    fontSize="16"
                    fontWeight="bold"
                    fill="#FFFFFF"
                    style={{ pointerEvents: 'none' }}
                  >
                    {station.name}
                    {station.name === planned_station && ' ✓'}
                  </text>
                </g>
              );
            })}

            <circle
              cx={centerX}
              cy={centerY}
              r="34"
              fill="#CC0000"
              stroke="#FF4444"
              strokeWidth="5"
            />
            <circle
              cx={centerX}
              cy={centerY}
              r="40"
              fill="none"
              stroke="#FF0000"
              strokeWidth="3"
              opacity="0.5"
            />
            <text
              x={centerX}
              y={centerY - 50}
              textAnchor="middle"
              fontSize="20"
              fontWeight="bold"
              fill="#FFFFFF"
            >
              {current_station}
            </text>
            <text
              x={centerX}
              y={centerY + 12}
              textAnchor="middle"
              fontSize="36"
              fill="#FFFFFF"
            >
              🚉
            </text>
          </svg>
        </Box>
        <Box textAlign="center" mt={1} color="label" fontSize="1.1rem">
          Нажмите на станцию на карте для выбора маршрута
        </Box>
      </Section>
    );
  };

  return (
    <Window
      title="Терминал управления поездом"
      width={920}
      height={680}
      theme="ntos"
    >
      <Window.Content scrollable>
        <Stack vertical>
          <Stack.Item>
            <Section title="Статус поезда">
              {/* Индикаторы в горизонтальном ряду */}
              <Stack>
                <Stack.Item grow>
                  <Box
                    backgroundColor="rgba(0, 100, 0, 0.2)"
                    p={2}
                    textAlign="center"
                    style={{ borderRadius: '8px' }}
                  >
                    <Box fontSize="1.1rem" color="label">
                      Текущая станция
                    </Box>
                    <Box fontSize="1.6rem" bold mt={1}>
                      {current_station}
                    </Box>
                  </Box>
                </Stack.Item>
                <Stack.Item grow mx={2}>
                  <Box
                    backgroundColor="rgba(0, 80, 150, 0.2)"
                    p={2}
                    textAlign="center"
                    style={{ borderRadius: '8px' }}
                  >
                    <Box fontSize="1.1rem" color="label">
                      Следующая станция
                    </Box>
                    <Box
                      fontSize="1.6rem"
                      bold
                      mt={1}
                      color={planned_station === 'None' ? 'average' : 'good'}
                    >
                      {planned_station}
                    </Box>
                  </Box>
                </Stack.Item>
                <Stack.Item grow>
                  <Box
                    backgroundColor="rgba(100, 100, 0, 0.2)"
                    p={2}
                    textAlign="center"
                    style={{ borderRadius: '8px' }}
                  >
                    <Box fontSize="1.1rem" color="label">
                      Состояние
                    </Box>
                    <Box
                      fontSize="1.6rem"
                      bold
                      mt={1}
                      color={is_moving ? 'good' : 'average'}
                    >
                      {is_moving ? 'В пути' : 'На станции'}
                    </Box>
                  </Box>
                </Stack.Item>
              </Stack>
              {(blocking && (
                <>
                  <Divider />
                  <Box bold color="bad" textAlign="center" fontSize="1.8rem">
                    ⚠ ДВИЖЕНИЕ ЗАБЛОКИРОВАНО!
                  </Box>
                </>
              )) ||
                ' '}
              {readOnly ? (
                ' '
              ) : (
                <Button
                  icon={is_moving ? 'exclamation-triangle' : 'rocket'}
                  iconColor={is_moving ? 'white' : undefined}
                  color={is_moving ? 'bad' : 'good'}
                  onClick={() =>
                    act(is_moving ? 'stop_moving' : 'start_moving')
                  }
                  disabled={
                    blocking || (!is_moving && planned_station === 'None')
                  }
                  fluid
                  mt={3}
                  height="50px"
                  fontSize="1.8rem"
                  bold
                >
                  {is_moving ? 'ЭКСТРЕННОЕ ТОРМОЖЕНИЕ' : 'ОТПРАВИТЬСЯ'}
                </Button>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            {readOnly
              ? renderTravelView()
              : is_moving
                ? renderTravelView()
                : renderMapView()}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
