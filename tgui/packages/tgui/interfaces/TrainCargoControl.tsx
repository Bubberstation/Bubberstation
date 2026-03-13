import {
  Box,
  Flex,
  ProgressBar,
  Section,
  Slider,
  Stack,
} from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type CargoData = {
  connected: boolean;
  container_health?: number | null;
  container_temperature?: number | null;
  max_temperature?: number | null;
  minimal_temperature?: number | null;
  gyro_position?: number | null;
  gyro_required?: number | null;
  gyro_desired?: number | null;
  moving: boolean;
  powered: boolean;
};

const getHealthColor = (health: number): string => {
  if (health > 65) return '#00ff9d';
  if (health > 35) return '#ffd000';
  return '#ff2d00';
};

const safeNum = (
  val: number | null | undefined,
  fallback: number = 0,
): number => (typeof val === 'number' && !Number.isNaN(val) ? val : fallback);

const safeToFixed = (
  val: number | null | undefined,
  digits: number = 1,
): string => safeNum(val).toFixed(digits);

export const TrainCargoControl = () => {
  const { act, data } = useBackend<CargoData>();

  // Safe values with fallbacks
  const connected = !!data.connected;
  const health = safeNum(data.container_health, 100);
  const temperature = safeNum(data.container_temperature, 40);
  const maxTemp = safeNum(data.max_temperature, 70);
  const minTemp = safeNum(data.minimal_temperature, 15);
  const gyroPos = safeNum(data.gyro_position, 0);
  const gyroReq = safeNum(data.gyro_required, 0);
  const gyroDes = safeNum(data.gyro_desired, 0);
  const isMoving = !!data.moving;
  const isPowered = !!data.powered;

  const gyroDiff = Math.abs(gyroPos - gyroDes);
  const isCritical =
    health < 30 ||
    gyroDiff > 28 ||
    temperature < minTemp - 5 ||
    temperature > maxTemp + 5;

  return (
    <Window
      title="CARGO CONTROL SYSTEM • CLASSIFIED"
      width={460}
      height={800}
      theme="abductor"
    >
      <Window.Content backgroundColor="#0a0a12" scrollable>
        <Stack fill vertical>
          {/* === Контейнер (круглый визуализатор) === */}
          <Stack.Item>
            <Box
              style={{
                width: '260px',
                height: '260px',
                margin: '20px auto',
                position: 'relative',
              }}
            >
              {/* Кольцо целостности */}
              <Box
                style={{
                  position: 'absolute',
                  inset: '-14px',
                  borderRadius: '50%',
                  background: `conic-gradient(
                    ${getHealthColor(health)} 0deg,
                    ${getHealthColor(health)} ${health * 3.6}deg,
                    #1a1a2e ${health * 3.6}deg,
                    #1a1a2e 360deg
                  )`,
                  boxShadow: `0 0 40px ${getHealthColor(health)}88`,
                  filter: 'blur(6px)',
                }}
              />

              {/* Сам контейнер */}
              <Box
                style={{
                  position: 'absolute',
                  inset: '10px',
                  borderRadius: '50%',
                  background: '#0f0f1f',
                  border: '8px solid #00ccff',
                  boxShadow:
                    'inset 0 0 60px rgba(0,0,0,0.9), 0 0 30px #00ccff33',
                  overflow: 'hidden',
                  transform: `rotate(${gyroPos * 0.9}deg)`,
                  transition: 'transform 0.4s ease-out',
                }}
              >
                <Box
                  style={{
                    position: 'absolute',
                    inset: '22px',
                    borderRadius: '50%',
                    border: '3px solid #334455',
                    background:
                      'radial-gradient(circle at center, #1a2333, #0b0f1f)',
                  }}
                >
                  <Box
                    style={{
                      position: 'absolute',
                      left: `calc(50% + ${gyroPos * 1.35}px)`,
                      top: '50%',
                      transform: 'translate(-50%, -50%)',
                      width: '34px',
                      height: '34px',
                      borderRadius: '50%',
                      background: '#00ffcc',
                      boxShadow: '0 0 25px #00ffcc, inset 0 0 12px #ffffff88',
                      transition: 'left 0.25s ease-out',
                    }}
                  />
                  <Box
                    style={{
                      position: 'absolute',
                      left: '50%',
                      top: '50%',
                      width: '4px',
                      height: '4px',
                      background: '#ffcc00',
                      borderRadius: '50%',
                      transform: 'translate(-50%, -50%)',
                      boxShadow: '0 0 12px #ffcc00',
                    }}
                  />
                </Box>
              </Box>

              <Box
                style={{
                  position: 'absolute',
                  inset: '0',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  flexDirection: 'column',
                  color: '#aaccff',
                  textShadow: '0 0 12px #000',
                  pointerEvents: 'none',
                }}
              >
                <Box fontSize="28px" bold fontFamily="Courier New">
                  CARGO
                </Box>
                <Box fontSize="11px" opacity={0.6} mt={-0.5}>
                  ANOMALOUS CONTAINMENT
                </Box>
              </Box>
            </Box>
          </Stack.Item>

          {/* === Гироскоп (полукруглая шкала) === */}
          <Stack.Item>
            <Section title="Gyroscope Control" textAlign="center">
              <Box
                style={{
                  position: 'relative',
                  width: '340px',
                  height: '200px',
                  margin: '20px auto 10px auto',
                }}
              >
                {/* Полукруглый фон */}
                <Box
                  style={{
                    position: 'absolute',
                    width: '300px',
                    height: '150px',
                    left: '50%',
                    top: '0',
                    transform: 'translateX(-50%)',
                    border: '3px solid #334455',
                    borderBottom: 'none',
                    borderRadius: '150px 150px 0 0',
                    pointerEvents: 'none',
                  }}
                />

                {/* Метки градусов по дуге */}
                {[-50, -40, -30, -20, -10, 0, 10, 20, 30, 40, 50].map((deg) => {
                  const angle = deg * (180 / 100); // от -50 до 50 → -90° .. +90°
                  const rad = (angle * Math.PI) / 180;
                  const radius = 125;
                  const x = 170 + Math.cos(rad - Math.PI / 2) * radius;
                  const y = 150 + Math.sin(rad - Math.PI / 2) * radius;

                  return (
                    <Box
                      key={deg}
                      style={{
                        position: 'absolute',
                        left: `${x}px`,
                        top: `${y}px`,
                        transform: 'translate(-50%, -50%)',
                        color:
                          Math.abs(deg) >= 40
                            ? '#ff5555'
                            : Math.abs(deg) >= 20
                              ? '#ffaa55'
                              : '#88ccff',
                        fontSize:
                          Math.abs(deg) === 50 || Math.abs(deg) === 0
                            ? '13px'
                            : '11px',
                        fontWeight: Math.abs(deg) === 0 ? 'bold' : 'normal',
                        fontFamily: 'monospace',
                        pointerEvents: 'none',
                        textShadow: '0 0 5px #000000aa',
                      }}
                    >
                      {deg}
                    </Box>
                  );
                })}

                {(() => {
                  const angleDeg = gyroReq * (180 / 100);
                  const rad = (angleDeg * Math.PI) / 180;
                  const radius = 115;
                  const x = 170 + Math.cos(rad - Math.PI / 2) * radius;
                  const y = 150 + Math.sin(rad - Math.PI / 2) * radius;

                  return (
                    <Box
                      style={{
                        position: 'absolute',
                        left: `${x}px`,
                        top: `${y}px`,
                        transform: `translate(-50%, -50%) rotate(${angleDeg}deg)`,
                        width: '20px',
                        height: '20px',
                        background: '#ffcc00',
                        clipPath:
                          'polygon(50% 0%, 0% 80%, 40% 100%, 60% 100%, 100% 80%)',
                        boxShadow: '0 0 12px #ffcc00, 0 0 20px #ffcc0088',
                        transition:
                          'left 0.4s ease-out, top 0.4s ease-out, transform 0.4s ease-out',
                        pointerEvents: 'none',
                        zIndex: 5,
                      }}
                    />
                  );
                })()}

                {/* Текущее положение (зелёная линия + круг) */}
                <Box
                  style={{
                    position: 'absolute',
                    left: '50%',
                    top: '0',
                    width: '4px',
                    height: '160px',
                    background: '#00ffcc',
                    transform: `translateX(-50%) rotate(${gyroPos * (180 / 100)}deg)`,
                    transformOrigin: '50% 150px',
                    transition: 'transform 0.35s ease-out',
                    boxShadow: '0 0 12px #00ffcc',
                    borderRadius: '4px',
                    zIndex: 3,
                  }}
                >
                  <Box
                    style={{
                      position: 'absolute',
                      top: '-10px',
                      left: '50%',
                      transform: 'translateX(-50%)',
                      width: '18px',
                      height: '18px',
                      background: '#00ffcc',
                      borderRadius: '50%',
                      boxShadow: '0 0 15px #00ffcc, inset 0 0 6px #ffffff',
                    }}
                  />
                </Box>

                {/* Текст Current / Target */}
                <Box
                  style={{
                    position: 'absolute',
                    bottom: '-10px',
                    left: '50%',
                    transform: 'translateX(-50%)',
                    color: '#aaccff',
                    fontSize: '15px',
                    fontFamily: 'monospace',
                    textShadow: '0 0 6px #000',
                    whiteSpace: 'nowrap',
                  }}
                >
                  Current:{' '}
                  <span
                    style={{ color: gyroDiff > 25 ? '#ff4444' : '#00ffcc' }}
                  >
                    {safeToFixed(data.gyro_position)}°
                  </span>
                  {'  •  '}
                  Target:{' '}
                  <span style={{ color: '#ffcc00' }}>
                    {safeToFixed(data.gyro_required)}°
                  </span>
                  {'  •  '}
                  Required:{' '}
                  <span style={{ color: '#88ccff' }}>
                    {safeToFixed(data.gyro_desired)}°
                  </span>
                </Box>
              </Box>

              {/* Скрытый/полупрозрачный слайдер для управления */}
              <Slider
                value={gyroReq}
                minValue={-50}
                maxValue={50}
                step={0.25}
                onChange={(_, v) =>
                  act('set_gyro_target', { value: Number(v.toFixed()) })
                }
                format={(v) => `${Number(v).toFixed(1)}°`}
                color="transparent"
                style={{
                  opacity: 0.8,
                  height: '6px',
                  marginTop: '30px',
                  pointerEvents: 'auto',
                }}
              />
            </Section>
          </Stack.Item>

          {/* === Температура и целостность === */}
          <Stack.Item grow>
            <Flex fill>
              <Flex.Item grow basis={0}>
                <Section title="Temperature" textAlign="center">
                  <ProgressBar
                    value={temperature}
                    minValue={minTemp - 30}
                    maxValue={maxTemp + 30}
                    ranges={{
                      bad: [minTemp - 30, minTemp],
                      good: [minTemp, maxTemp],
                    }}
                  >
                    {safeToFixed(
                      data.container_temperature
                        ? data.container_temperature - 273.15
                        : 0,
                    )}{' '}
                    °C
                  </ProgressBar>
                </Section>
              </Flex.Item>

              <Flex.Item grow basis={0}>
                <Section title="Containment Integrity" textAlign="center">
                  <ProgressBar
                    value={health}
                    minValue={0}
                    maxValue={100}
                    color={getHealthColor(health)}
                  >
                    {safeToFixed(data.container_health, 0)}%
                  </ProgressBar>
                </Section>
              </Flex.Item>
            </Flex>
          </Stack.Item>

          {/* === Критические предупреждения === */}
          {isCritical && (
            <Stack.Item>
              <Section
                title="⚠ CRITICAL DESTABILIZATION"
                color="bad"
                bold
                textAlign="center"
              >
                {health < 30 && <Box>Field integrity critical!</Box>}
                {gyroDiff > 25 && <Box>Gyroscope severely unbalanced!</Box>}
                {(temperature < minTemp - 5 || temperature > maxTemp + 5) && (
                  <Box>Temperature anomaly detected!</Box>
                )}
                {!isPowered && <Box>Stabilizer power failure!</Box>}
              </Section>
            </Stack.Item>
          )}

          {/* === Статус поезда === */}
          <Stack.Item>
            <Box textAlign="center" opacity={0.7} fontSize="12px">
              Train: <b>{isMoving ? 'MOVING' : 'STATIONARY'}</b> • Power:{' '}
              <b>{isPowered ? 'STABLE' : 'FAIL'}</b>
            </Box>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
