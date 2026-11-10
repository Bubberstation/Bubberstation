import { Box, Button, Icon, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  on: boolean;
  open: boolean;
  mode: string;
  activeMode: string;
  apcPower: boolean;
  hasCell: boolean;
  cellName: string | null;
  cellCharge: number;
  targetTemp: number;
  minTemp: number;
  maxTemp: number;
  defaultTemp: number;
  currentTemp: number | null;
  history: number[];
  fahrenheit: boolean;
  conflict: boolean;
  hazardMin: number;
  hazardMax: number;
};

// graph zones, in celsius
const COLD_LIMIT = 15;
const HOT_LIMIT = 30;
// matches HEAT_PUMP_HISTORY_INTERVAL on the dm side
const SAMPLE_SECONDS = 10;
const GAUGE_SEGMENTS = 10;
// degrees moved by a shift-click on the target arrows
const SHIFT_STEP = 5;

// heat and cool match the machine sprite
const COLOR_COLD = '#47a1b3';
const COLOR_COMFY = '#8fd16a';
const COLOR_HOT = '#cd4456';
const COLOR_ORANGE = '#d15b1b';

const zoneColor = (celsius: number) => {
  if (celsius < COLD_LIMIT) {
    return COLOR_COLD;
  }
  if (celsius > HOT_LIMIT) {
    return COLOR_HOT;
  }
  return COLOR_COMFY;
};

const toFahrenheit = (celsius: number) => (celsius * 9) / 5 + 32;
const toCelsius = (fahrenheit: number) => ((fahrenheit - 32) * 5) / 9;

type Status = {
  lamp: string;
  label: string;
  color: string;
};

const getStatus = (data: Data): Status => {
  if (!data.on) {
    return { lamp: '', label: 'OFF', color: '#8a8a9e' };
  }
  if (!data.hasCell || data.cellCharge <= 0) {
    return { lamp: 'warning', label: 'NO CHARGE', color: '#ffb347' };
  }
  if (data.activeMode === 'heat') {
    return { lamp: 'heat', label: 'HEATING', color: COLOR_HOT };
  }
  if (data.activeMode === 'cool') {
    return { lamp: 'cool', label: 'COOLING', color: COLOR_COLD };
  }
  return { lamp: 'standby', label: 'STANDBY', color: COLOR_COMFY };
};

export const HeatPump = (props) => {
  const { act, data } = useBackend<Data>();
  const fahrenheit = !!data.fahrenheit;
  const unitLabel = fahrenheit ? '°F' : '°C';
  const toUnit = (celsius: number) =>
    fahrenheit ? toFahrenheit(celsius) : celsius;
  const status = getStatus(data);

  return (
    <Window width={430} height={570} theme="heatpump">
      <Window.Content>
        <Box className="HeatPump__hazard" />
        <Box className="HeatPump__header">
          <Box>
            <Box className="HeatPump__maker">AKH FRONTIER</Box>
            <Box className="HeatPump__model">HEAT PUMP</Box>
          </Box>
          <Box className="HeatPump__header-right">
            <Box className="HeatPump__status" style={{ color: status.color }}>
              {status.label}
            </Box>
            <Box
              className={`HeatPump__lamp${status.lamp ? ` HeatPump__lamp--${status.lamp}` : ''}`}
            />
            <Button
              icon="power-off"
              selected={!!data.on}
              onClick={() => act('power')}
            >
              {data.on ? 'On' : 'Off'}
            </Button>
          </Box>
        </Box>
        {!!data.conflict && (
          <Box className="HeatPump__warning">
            <Icon name="exclamation-triangle" />
            Possible conflict. Consider moving one unit.
          </Box>
        )}
        <Readout toUnit={toUnit} unitLabel={unitLabel} />
        <Box className="HeatPump__stencil">MODE</Box>
        <Stack mb={1}>
          <Stack.Item grow>
            <Button
              fluid
              textAlign="center"
              icon="thermometer-half"
              selected={data.mode === 'auto'}
              onClick={() => act('mode', { mode: 'auto' })}
            >
              Auto
            </Button>
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              textAlign="center"
              icon="fire-alt"
              className="HeatPump__mode--heat"
              selected={data.mode === 'heat'}
              onClick={() => act('mode', { mode: 'heat' })}
            >
              Heat
            </Button>
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              textAlign="center"
              icon="fan"
              className="HeatPump__mode--cool"
              selected={data.mode === 'cool'}
              onClick={() => act('mode', { mode: 'cool' })}
            >
              Cool
            </Button>
          </Stack.Item>
        </Stack>
        <Bezel label="TEMPERATURE HISTORY">
          <Box className="HeatPump__lcd" p={0.5}>
            <TemperatureGraph
              history={data.history || []}
              target={data.targetTemp}
              toUnit={toUnit}
              unitLabel={unitLabel}
            />
          </Box>
        </Bezel>
        <PowerPlate />
      </Window.Content>
    </Window>
  );
};

const Bezel = (props) => {
  const { label, children } = props;
  return (
    <Box className="HeatPump__bezel">
      <Box className="HeatPump__rivet HeatPump__rivet--tl" />
      <Box className="HeatPump__rivet HeatPump__rivet--tr" />
      <Box className="HeatPump__rivet HeatPump__rivet--bl" />
      <Box className="HeatPump__rivet HeatPump__rivet--br" />
      {!!label && <Box className="HeatPump__bezel-label">{label}</Box>}
      {children}
    </Box>
  );
};

type ReadoutProps = {
  toUnit: (celsius: number) => number;
  unitLabel: string;
};

const Readout = (props: ReadoutProps) => {
  const { act, data } = useBackend<Data>();
  const { toUnit, unitLabel } = props;
  const fahrenheit = !!data.fahrenheit;

  // one whole degree in whatever unit is showing; the server stores the exact celsius
  const shownTarget = Math.round(toUnit(data.targetTemp));
  const targetAfterStep = (direction: number) =>
    fahrenheit
      ? toCelsius(shownTarget + direction)
      : Math.round(data.targetTemp) + direction;
  const canStep = (direction: number) => {
    const next = targetAfterStep(direction);
    return next >= data.minTemp && next <= data.maxTemp;
  };
  const stepTarget = (direction: number, event) => {
    const steps = event?.shiftKey ? direction * SHIFT_STEP : direction;
    const next = targetAfterStep(steps);
    act('set_target', {
      target: Math.min(data.maxTemp, Math.max(data.minTemp, next)),
    });
  };

  // cold and hot hazards get their own colours, the same limits the game damages people at
  const hazardOf = (celsius: number | null) => {
    if (celsius === null) {
      return '';
    }
    if (celsius <= data.hazardMin) {
      return 'cold';
    }
    if (celsius >= data.hazardMax) {
      return 'hot';
    }
    return '';
  };
  const roomHazard = hazardOf(data.currentTemp);
  const targetHazard = hazardOf(data.targetTemp);

  const shownRoom =
    data.currentTemp === null ? null : Math.round(toUnit(data.currentTemp));
  const hasReading = shownRoom !== null;
  const offset = shownRoom === null ? 0 : shownRoom - shownTarget;
  let offsetText = '';
  if (hasReading) {
    offsetText =
      offset === 0
        ? 'ON TARGET'
        : `${offset > 0 ? '+' : ''}${offset}${unitLabel} FROM TARGET`;
  }

  return (
    <Bezel>
      <Box className={`HeatPump__lcd${data.on ? '' : ' HeatPump__lcd--off'}`}>
        <Stack align="center">
          <Stack.Item grow>
            <Box className="HeatPump__lcd-label">
              INSIDE
              {!!roomHazard && (
                <span
                  className={`HeatPump__lcd-hazard HeatPump__lcd-hazard--${roomHazard}`}
                >
                  <Icon name="exclamation-triangle" /> HAZARD
                </span>
              )}
            </Box>
            <Box
              className={`HeatPump__lcd-big${roomHazard ? ` HeatPump__lcd-big--${roomHazard}` : ''}`}
            >
              {hasReading ? shownRoom : '--'}
              <span className="HeatPump__lcd-unit">{unitLabel}</span>
            </Box>
            <Box className="HeatPump__lcd-offset">{offsetText}</Box>
          </Stack.Item>
          <Stack.Item align="flex-end">
            <Button
              compact
              tooltip={`Show ${fahrenheit ? 'Celsius' : 'Fahrenheit'}`}
              onClick={() => act('toggle_unit')}
            >
              {fahrenheit ? '°C' : '°F'}
            </Button>
          </Stack.Item>
          <Stack.Item className="HeatPump__lcd-divider" />
          <Stack.Item>
            <Box className="HeatPump__lcd-label">SET TO</Box>
            <Stack align="center">
              <Stack.Item>
                <Box
                  className={`HeatPump__lcd-mid${targetHazard ? ` HeatPump__lcd-mid--${targetHazard}` : ''}`}
                >
                  {shownTarget}
                  <span className="HeatPump__lcd-unit">{unitLabel}</span>
                </Box>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical>
                  <Stack.Item>
                    <Button
                      compact
                      icon="chevron-up"
                      tooltip="Shift-click to step 5"
                      disabled={!canStep(1)}
                      onClick={(event) => stepTarget(1, event)}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      compact
                      icon="rotate-left"
                      tooltip={`Reset to ${Math.round(toUnit(data.defaultTemp))}${unitLabel}`}
                      onClick={() => act('reset_target')}
                    />
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      compact
                      icon="chevron-down"
                      tooltip="Shift-click to step 5"
                      disabled={!canStep(-1)}
                      onClick={(event) => stepTarget(-1, event)}
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Box>
    </Bezel>
  );
};

const PowerPlate = (props) => {
  const { act, data } = useBackend<Data>();
  const charge = data.hasCell ? data.cellCharge : 0;
  const litSegments = Math.ceil((charge / 100) * GAUGE_SEGMENTS);
  const gaugeLevel = charge >= 60 ? 'good' : charge >= 30 ? 'average' : 'bad';

  return (
    <Box className="HeatPump__plate">
      <Stack align="center" mb={1}>
        <Stack.Item>
          <Box
            className={`HeatPump__lamp HeatPump__lamp--${data.apcPower ? 'standby' : 'bad'}`}
          />
        </Stack.Item>
        <Stack.Item grow>
          <Box className="HeatPump__stencil" mb={0}>
            {data.apcPower ? 'APC POWER: AVAILABLE' : 'APC POWER: UNAVAILABLE'}
          </Box>
        </Stack.Item>
        <Stack.Item>
          <Button
            icon="eject"
            disabled={!data.hasCell || !data.open}
            tooltip={data.open ? undefined : 'Open the hatch first'}
            onClick={() => act('eject')}
          >
            Eject Cell
          </Button>
        </Stack.Item>
      </Stack>
      <Stack align="center">
        <Stack.Item grow>
          <Box className="HeatPump__gauge">
            {Array.from({ length: GAUGE_SEGMENTS }, (_, index) => (
              <Box
                key={index}
                className={`HeatPump__gauge-segment${index < litSegments ? ` HeatPump__gauge-segment--${gaugeLevel}` : ''}`}
              />
            ))}
          </Box>
        </Stack.Item>
        <Stack.Item width="44px" textAlign="right" bold>
          {data.hasCell ? `${charge}%` : '--'}
        </Stack.Item>
      </Stack>
      <Box mt={0.5} fontSize="0.85em" color={data.hasCell ? 'label' : 'bad'}>
        {data.hasCell ? data.cellName : 'No power cell installed'}
      </Box>
    </Box>
  );
};

type GraphProps = {
  history: number[];
  target: number;
  toUnit: (celsius: number) => number;
  unitLabel: string;
};

const GRAPH_WIDTH = 360;
const GRAPH_HEIGHT = 110;
const PLOT_LEFT = 36;
const PLOT_RIGHT = GRAPH_WIDTH - 6;
const PLOT_TOP = 6;
const PLOT_BOTTOM = GRAPH_HEIGHT - 16;
// keeps a flat line from turning tiny wobbles into cliffs
const MIN_SPAN = 4;

const TemperatureGraph = (props: GraphProps) => {
  const { history, target, toUnit, unitLabel } = props;
  if (history.length < 2) {
    return (
      <Box className="HeatPump__lcd-label" textAlign="center" py={5}>
        PLEASE WAIT...
      </Box>
    );
  }

  const shown = history.map(toUnit);
  const shownTarget = toUnit(target);
  let low = Math.min(...shown, shownTarget);
  let high = Math.max(...shown, shownTarget);
  if (high - low < MIN_SPAN) {
    const middle = (high + low) / 2;
    low = middle - MIN_SPAN / 2;
    high = middle + MIN_SPAN / 2;
  }
  const padding = (high - low) * 0.1;
  low -= padding;
  high += padding;

  const xFor = (index: number) =>
    PLOT_LEFT + (index / (shown.length - 1)) * (PLOT_RIGHT - PLOT_LEFT);
  const yFor = (value: number) =>
    PLOT_BOTTOM - ((value - low) / (high - low)) * (PLOT_BOTTOM - PLOT_TOP);

  // midpoint curves so the line reads smooth without overshooting the samples
  let path = `M ${xFor(0)} ${yFor(shown[0])}`;
  for (let index = 1; index < shown.length; index++) {
    const previousX = xFor(index - 1);
    const previousY = yFor(shown[index - 1]);
    const midX = (previousX + xFor(index)) / 2;
    const midY = (previousY + yFor(shown[index])) / 2;
    path += ` Q ${previousX} ${previousY} ${midX} ${midY}`;
  }
  path += ` L ${xFor(shown.length - 1)} ${yFor(shown[shown.length - 1])}`;

  const clampToPlot = (y: number) =>
    Math.max(PLOT_TOP, Math.min(PLOT_BOTTOM, y));
  const comfyTop = clampToPlot(yFor(toUnit(HOT_LIMIT)));
  const comfyBottom = clampToPlot(yFor(toUnit(COLD_LIMIT)));
  const targetY = yFor(shownTarget);
  const gridValues = [high - padding, (high + low) / 2, low + padding];
  const secondsShown = (shown.length - 1) * SAMPLE_SECONDS;
  const oldestLabel =
    secondsShown < 60
      ? `-${secondsShown}s`
      : `-${Math.round(secondsShown / 60)}m`;

  return (
    <svg
      viewBox={`0 0 ${GRAPH_WIDTH} ${GRAPH_HEIGHT}`}
      width="100%"
      style={{ display: 'block' }}
    >
      <defs>
        <linearGradient
          id="heat-pump-line"
          gradientUnits="userSpaceOnUse"
          x1={PLOT_LEFT}
          x2={PLOT_RIGHT}
          y1={0}
          y2={0}
        >
          {history.map((celsius, index) => (
            <stop
              key={index}
              offset={index / (history.length - 1)}
              stopColor={zoneColor(celsius)}
            />
          ))}
        </linearGradient>
      </defs>
      {comfyTop > PLOT_TOP && (
        <rect
          x={PLOT_LEFT}
          y={PLOT_TOP}
          width={PLOT_RIGHT - PLOT_LEFT}
          height={comfyTop - PLOT_TOP}
          fill={COLOR_HOT}
          fillOpacity={0.1}
        />
      )}
      {comfyBottom > comfyTop && (
        <rect
          x={PLOT_LEFT}
          y={comfyTop}
          width={PLOT_RIGHT - PLOT_LEFT}
          height={comfyBottom - comfyTop}
          fill={COLOR_COMFY}
          fillOpacity={0.06}
        />
      )}
      {PLOT_BOTTOM > comfyBottom && (
        <rect
          x={PLOT_LEFT}
          y={comfyBottom}
          width={PLOT_RIGHT - PLOT_LEFT}
          height={PLOT_BOTTOM - comfyBottom}
          fill={COLOR_COLD}
          fillOpacity={0.1}
        />
      )}
      {gridValues.map((value) => (
        <g key={value}>
          <line
            x1={PLOT_LEFT}
            x2={PLOT_RIGHT}
            y1={yFor(value)}
            y2={yFor(value)}
            stroke="rgba(255, 179, 71, 0.12)"
          />
          <text
            className="HeatPump__graph-text"
            x={PLOT_LEFT - 4}
            y={yFor(value) + 3}
            textAnchor="end"
            fontSize="9"
          >
            {`${Math.round(value)}${unitLabel}`}
          </text>
        </g>
      ))}
      <line
        x1={PLOT_LEFT}
        x2={PLOT_RIGHT}
        y1={targetY}
        y2={targetY}
        stroke={COLOR_ORANGE}
        strokeOpacity={0.8}
        strokeDasharray="4 3"
      />
      <text
        className="HeatPump__graph-text"
        x={PLOT_LEFT + 3}
        y={targetY - 3}
        fontSize="8"
      >
        SET
      </text>
      <path
        d={path}
        fill="none"
        stroke="url(#heat-pump-line)"
        strokeWidth={2}
        strokeLinecap="round"
      />
      <text
        className="HeatPump__graph-text"
        x={PLOT_LEFT}
        y={GRAPH_HEIGHT - 3}
        fontSize="9"
      >
        {oldestLabel}
      </text>
      <text
        className="HeatPump__graph-text"
        x={PLOT_RIGHT}
        y={GRAPH_HEIGHT - 3}
        textAnchor="end"
        fontSize="9"
      >
        NOW
      </text>
    </svg>
  );
};
