import { useCallback, useEffect, useRef, useState } from 'react';
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Window } from '../layouts';

const MAP_WIDTH = 5000;
const MAP_HEIGHT = 5000;
const NODE_RADIUS = 14;
const HUB_RADIUS = 22;
const PATH_CURVE_STRENGTH = 0.18;

export interface TrainMapObject {
  id: string;
  name: string;
  desc: string;
  region: string;
  x: number;
  y: number;
  is_current: BooleanLike;
  is_next: BooleanLike;
  visited: number;
  is_local_center: BooleanLike;
  station_type: string;
}

export interface TrainMapPath {
  start_x: number;
  start_y: number;
  end_x: number;
  end_y: number;
}

export interface TrainPosition {
  x: number;
  y: number;
  angle: number;
}

export interface MapData {
  objects: TrainMapObject[];
  paths: TrainMapPath[];
  train: TrainPosition;
}

export interface PossibleNextStation {
  name: string;
  type: string;
}

export interface TrainControlData {
  read_only: BooleanLike;
  is_moving: BooleanLike;
  train_engine_active: BooleanLike;
  current_station: string;
  planned_station: string;
  progress: number;
  time_remaining: number;
  possible_next: PossibleNextStation[];
  map_data: MapData;
}

/** Region color (stable hash) */
function getRegionColor(region: string): string {
  let hash = 0;
  for (let i = 0; i < region.length; i++) {
    hash = region.charCodeAt(i) + ((hash << 5) - hash);
  }
  const hue = Math.abs(hash) % 360;
  return `hsl(${hue}, 70%, 52%)`;
}

/** Quadratic Bezier control point (metro kink style) */
function getPathKinkPoint(
  startX: number,
  startY: number,
  endX: number,
  endY: number,
  kinkRatio: number = 0.42,
): { cx: number; cy: number } {
  const dx = endX - startX;
  const dy = endY - startY;
  const len = Math.sqrt(dx * dx + dy * dy) || 1;

  const px = startX + dx * kinkRatio;
  const py = startY + dy * kinkRatio;

  const perpX = -dy / len;
  const perpY = dx / len;

  const bend = len * PATH_CURVE_STRENGTH;

  return {
    cx: px + perpX * bend,
    cy: py + perpY * bend,
  };
}

type TrainMapCanvasProps = {
  map_data: MapData;
  scale: number;
  offsetX: number;
  offsetY: number;
  selectedId: string | null;
  onSelect: (id: string) => void;
  onZoom: (newScale: number, newOffsetX: number, newOffsetY: number) => void;
  onDragStart: (clientX: number, clientY: number) => void;
};

export const TrainMapCanvas = (props: TrainMapCanvasProps) => {
  const { map_data, scale, offsetX, offsetY, onZoom, onDragStart } = props;
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [canvasSize, setCanvasSize] = useState({
    width: MAP_WIDTH,
    height: MAP_HEIGHT,
  });
  const [isDragging, setIsDragging] = useState(false);

  useEffect(() => {
    const updateSize = () => {
      if (containerRef.current) {
        const { width, height } = containerRef.current.getBoundingClientRect();
        setCanvasSize({ width: Math.round(width), height: Math.round(height) });
      }
    };
    updateSize();
    window.addEventListener('resize', updateSize);
    return () => window.removeEventListener('resize', updateSize);
  }, []);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (canvas) {
      canvas.width = canvasSize.width;
      canvas.height = canvasSize.height;
    }
  }, [canvasSize]);

  const redraw = useCallback(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.save();
    ctx.translate(offsetX, offsetY);
    ctx.scale(scale, scale);

    ctx.strokeStyle = 'rgba(60, 80, 120, 0.18)';
    ctx.lineWidth = 1;

    const gridStepMajor = 100;
    const gridStepMinor = 20;

    ctx.beginPath();
    for (let x = 0; x <= MAP_WIDTH; x += gridStepMinor) {
      ctx.moveTo(x, 0);
      ctx.lineTo(x, MAP_HEIGHT);
    }
    for (let y = 0; y <= MAP_HEIGHT; y += gridStepMinor) {
      ctx.moveTo(0, y);
      ctx.lineTo(MAP_WIDTH, y);
    }
    ctx.stroke();

    ctx.strokeStyle = 'rgba(80, 100, 140, 0.35)';
    ctx.beginPath();
    for (let x = 0; x <= MAP_WIDTH; x += gridStepMajor) {
      ctx.moveTo(x, 0);
      ctx.lineTo(x, MAP_HEIGHT);
    }
    for (let y = 0; y <= MAP_HEIGHT; y += gridStepMajor) {
      ctx.moveTo(0, y);
      ctx.lineTo(MAP_WIDTH, y);
    }
    ctx.stroke();

    // ─── Metro-style rail lines ──────────────────────────────────────────────
    for (const path of map_data.paths) {
      const { cx, cy } = getPathKinkPoint(
        path.start_x,
        path.start_y,
        path.end_x,
        path.end_y,
      );

      const railGap = Math.max(1.5, 4.5 / scale);
      const railWidth = Math.max(1, 2.4 / scale);

      ctx.strokeStyle = 'rgb(70, 80, 110)';
      ctx.lineWidth = railWidth;
      ctx.lineCap = 'round';
      ctx.lineJoin = 'miter';

      const dx = path.end_x - path.start_x;
      const dy = path.end_y - path.start_y;
      const len = Math.hypot(dx, dy) || 1;
      const perpX = -dy / len;
      const perpY = dx / len;

      // Left rail
      ctx.beginPath();
      ctx.moveTo(
        path.start_x + perpX * railGap,
        path.start_y + perpY * railGap,
      );
      ctx.lineTo(cx + perpX * railGap, cy + perpX * railGap);
      ctx.lineTo(path.end_x + perpX * railGap, path.end_y + perpY * railGap);
      ctx.stroke();

      // Right rail
      ctx.beginPath();
      ctx.moveTo(
        path.start_x - perpX * railGap,
        path.start_y - perpY * railGap,
      );
      ctx.lineTo(cx - perpX * railGap, cy - perpY * railGap);
      ctx.lineTo(path.end_x - perpX * railGap, path.end_y - perpY * railGap);
      ctx.stroke();
    }

    const t = map_data.train;
    ctx.save();
    ctx.translate(t.x, t.y);
    ctx.rotate((t.angle * Math.PI) / 180);
    ctx.fillStyle = '#e67e22';
    ctx.strokeStyle = '#2c2c2c';
    ctx.lineWidth = 2 / scale;
    ctx.beginPath();
    ctx.moveTo(26, 0);
    ctx.lineTo(-20, -16);
    ctx.lineTo(-14, 0);
    ctx.lineTo(-20, 16);
    ctx.closePath();
    ctx.fill();
    ctx.stroke();
    ctx.fillStyle = '#1a1a1a';
    ctx.beginPath();
    ctx.arc(-9, 11, 7, 0, Math.PI * 2);
    ctx.fill();
    ctx.beginPath();
    ctx.arc(-9, -11, 7, 0, Math.PI * 2);
    ctx.fill();
    ctx.restore();

    ctx.restore();
  }, [map_data, scale, offsetX, offsetY]);

  useEffect(() => {
    redraw();
  }, [redraw]);

  const handleWheel = (e: React.WheelEvent<HTMLCanvasElement>) => {
    e.preventDefault();
    const canvas = canvasRef.current;
    if (!canvas) return;
    const rect = canvas.getBoundingClientRect();
    const mouseX = e.clientX - rect.left;
    const mouseY = e.clientY - rect.top;
    const wxBefore = (mouseX - offsetX) / scale;
    const wyBefore = (mouseY - offsetY) / scale;
    const factor = e.deltaY > 0 ? 0.92 : 1 / 0.92;
    const newScale = Math.max(0.25, Math.min(4, scale * factor));
    const wxAfter = (mouseX - offsetX) / newScale;
    const wyAfter = (mouseY - offsetY) / newScale;
    const corrX = (wxBefore - wxAfter) * newScale;
    const corrY = (wyBefore - wyAfter) * newScale;
    onZoom(newScale, offsetX + corrX, offsetY + corrY);
  };

  return (
    <div
      ref={containerRef}
      style={{
        width: '100%',
        height: '100%',
        position: 'relative',
        overflow: 'hidden',
        background: 'linear-gradient(160deg, #1a1f2e 0%, #0f1219 100%)',
        borderRadius: '8px',
      }}
    >
      <canvas
        ref={canvasRef}
        style={{
          position: 'absolute',
          inset: 0,
          cursor: isDragging ? 'grabbing' : 'grab',
          touchAction: 'none',
        }}
        onMouseDown={(e) => {
          if (e.button === 0) {
            setIsDragging(true);
            onDragStart(e.clientX, e.clientY);
          }
        }}
        onMouseUp={() => setIsDragging(false)}
        onMouseLeave={() => setIsDragging(false)}
        onWheel={handleWheel}
      />
    </div>
  );
};

function getStationColor(station: TrainMapObject): string {
  switch (station.region) {
    case 'Cargo':
      return '#f1c40f';
    case 'Emergency':
      return '#f1c40f';
    case 'Military':
      return '#27ae60';
    case 'City':
      return '#f1c40f';
    default:
      return getRegionColor(station.region);
  }
}

type StationNodeProps = {
  obj: TrainMapObject;
  scale: number;
  isSelected: boolean;
  onClick: () => void;
};

const StationNode = (props: StationNodeProps) => {
  const { obj, scale, isSelected, onClick } = props;
  const isCur = !!obj.is_current;
  const isNxt = !!obj.is_next;
  const isLocal = !!obj.is_local_center;
  const radius = isLocal ? HUB_RADIUS : NODE_RADIUS;
  const color = isCur
    ? '#27ae60'
    : isNxt
      ? '#f1c40f'
      : getStationColor(props.obj);

  const showLabel = scale > 0.5 || isLocal;
  const labelSize = isLocal ? 12 : 10;
  const strokeWidth = Math.max(1.5, 3.5 / scale);

  return (
    <Box
      style={{
        position: 'absolute',
        left: obj.x,
        top: obj.y,
        width: 0,
        height: 0,
        transform: 'translate(-50%, -50%)',
        pointerEvents: 'auto',
        cursor: 'pointer',
        zIndex: isCur || isNxt || isSelected ? 20 : 10,
      }}
      onClick={(e) => {
        e.stopPropagation();
        onClick();
      }}
    >
      {showLabel && (
        <Box
          style={{
            position: 'absolute',
            left: '50%',
            bottom: '100%',
            transform: 'translate(-50%, -6px)',
            whiteSpace: 'nowrap',
            fontSize: `${labelSize}px`,
            fontWeight: isLocal ? 700 : 500,
            color: '#e8e8e8',
            textShadow: '0 1px 2px rgba(0,0,0,0.8)',
            pointerEvents: 'none',
            userSelect: 'none',
          }}
        >
          {obj.name}
          {isLocal ? ' ★' : ''}
        </Box>
      )}
      <Box
        style={{
          width: radius * 2,
          height: radius * 2,
          marginLeft: -radius,
          marginTop: -radius,
          borderRadius: '50%',
          backgroundColor: color,
          boxShadow: `0 0 0 ${strokeWidth}px ${isLocal ? '#fff' : 'rgba(255,255,255,0.4)'}, 0 2px 8px rgba(0,0,0,0.4)`,
          border:
            isSelected || isCur || isNxt
              ? `${Math.max(2, 4 / scale)}px solid #fff`
              : 'none',
        }}
      />
    </Box>
  );
};

type StationsOverlayProps = {
  map_data: MapData;
  scale: number;
  offsetX: number;
  offsetY: number;
  selectedId: string | null;
  onSelect: (id: string) => void;
};

const StationsOverlay = (props: StationsOverlayProps) => {
  const { map_data, scale, offsetX, offsetY, selectedId, onSelect } = props;
  return (
    <Box
      style={{
        position: 'absolute',
        left: 0,
        top: 0,
        width: MAP_WIDTH,
        height: MAP_HEIGHT,
        transform: `translate(${offsetX}px, ${offsetY}px) scale(${scale})`,
        transformOrigin: '0 0',
        pointerEvents: 'none',
      }}
    >
      {map_data.objects.map((obj) => (
        <StationNode
          key={obj.id}
          obj={obj}
          scale={scale}
          isSelected={obj.id === selectedId}
          onClick={() => onSelect(obj.id)}
        />
      ))}
    </Box>
  );
};

type StatusPanelProps = {
  read_only: BooleanLike;
  is_moving: BooleanLike;
  train_engine_active: BooleanLike;
  current_station: string;
  planned_station: string;
  progress: number;
  time_remaining: number;
  onStart: () => void;
  onStop: () => void;
};

const StatusPanel = (props: StatusPanelProps) => (
  <Section title="Train Status">
    <LabeledList>
      <LabeledList.Item label="Current Station">
        {props.current_station || '—'}
      </LabeledList.Item>
      <LabeledList.Item label="Next Station">
        {props.planned_station || '—'}
      </LabeledList.Item>
      <LabeledList.Item label="Movement">
        <ProgressBar
          value={props.progress}
          color={props.is_moving ? 'good' : 'average'}
        >
          {props.is_moving
            ? `${props.time_remaining / 10} sec remaining`
            : 'Stopped'}
        </ProgressBar>
      </LabeledList.Item>
    </LabeledList>
    {!props.read_only && (
      <Stack mt={2} justify="space-between">
        <Button
          icon="play"
          color="good"
          disabled={
            !props.train_engine_active ||
            !!props.is_moving ||
            !props.planned_station
          }
          onClick={props.onStart}
        >
          Depart Train
        </Button>
        <Button
          icon="stop"
          color="bad"
          disabled={!props.is_moving}
          onClick={props.onStop}
        >
          Stop Train
        </Button>
      </Stack>
    )}
  </Section>
);

type SelectedStationPanelProps = {
  selectedObject: TrainMapObject;
  possibleSet: Set<string>;
  is_moving: BooleanLike;
  read_only: BooleanLike;
  onClose: () => void;
  onSetAsNext: () => void;
};

const SelectedStationPanel = (props: SelectedStationPanelProps) => (
  <Section
    title={`Selected: ${props.selectedObject.name}`}
    buttons={
      <Button icon="times" color="transparent" onClick={props.onClose} />
    }
  >
    <LabeledList>
      <LabeledList.Item label="Region">
        {props.selectedObject.region}
      </LabeledList.Item>
      <LabeledList.Item
        label="Type"
        color={getStationColor(props.selectedObject)}
      >
        {props.selectedObject.station_type}
      </LabeledList.Item>
      <LabeledList.Item label="Visits">
        {props.selectedObject.visited} times
      </LabeledList.Item>
      <LabeledList.Item label="Description">
        {props.selectedObject.desc || 'No description'}
      </LabeledList.Item>
    </LabeledList>
    {!props.read_only &&
      props.possibleSet.has(props.selectedObject.id) &&
      !props.is_moving && (
        <Button
          mt={2}
          fluid
          icon="arrow-right"
          color="good"
          onClick={props.onSetAsNext}
        >
          Set as Next Destination
        </Button>
      )}
  </Section>
);

type PossibleNextListProps = {
  possible_next: PossibleNextStation[];
  onChoose: (type: string) => void;
};

const PossibleNextList = (props: PossibleNextListProps) => (
  <Section title="Possible Directions">
    {props.possible_next.map((st) => (
      <Button
        key={st.type}
        fluid
        mt={0.5}
        onClick={() => props.onChoose(st.type)}
      >
        → {st.name}
      </Button>
    ))}
  </Section>
);

export const TrainControlTerminal = () => {
  const { act, data } = useBackend<TrainControlData>();
  const {
    read_only,
    is_moving,
    train_engine_active,
    current_station,
    planned_station,
    progress,
    time_remaining,
    possible_next = [],
    map_data = { objects: [], paths: [], train: { x: 500, y: 500, angle: 0 } },
  } = data;

  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [scale, setScale] = useState(0.75);
  const [offsetX, setOffsetX] = useState(80);
  const [offsetY, setOffsetY] = useState(80);
  const [dragStart, setDragStart] = useState({ x: 0, y: 0 });

  const possibleSet = new Set(possible_next.map((s) => s.type));
  const selectedObject = map_data.objects.find((o) => o.id === selectedId);

  const handleZoom = (
    newScale: number,
    newOffsetX: number,
    newOffsetY: number,
  ) => {
    setScale(newScale);
    setOffsetX(newOffsetX);
    setOffsetY(newOffsetY);
  };

  const handleDragStart = (clientX: number, clientY: number) => {
    setDragStart({ x: clientX - offsetX, y: clientY - offsetY });
  };

  const handleMouseMove = useCallback(
    (e: MouseEvent) => {
      if (dragStart.x === 0 && dragStart.y === 0) return;
      setOffsetX(e.clientX - dragStart.x);
      setOffsetY(e.clientY - dragStart.y);
    },
    [dragStart],
  );

  const handleMouseUp = useCallback(() => setDragStart({ x: 0, y: 0 }), []);

  useEffect(() => {
    if (dragStart.x !== 0 || dragStart.y !== 0) {
      window.addEventListener('mousemove', handleMouseMove);
      window.addEventListener('mouseup', handleMouseUp);
      return () => {
        window.removeEventListener('mousemove', handleMouseMove);
        window.removeEventListener('mouseup', handleMouseUp);
      };
    }
  }, [dragStart, handleMouseMove, handleMouseUp]);

  const resetView = () => {
    setScale(0.75);
    setOffsetX(80);
    setOffsetY(80);
    setSelectedId(null);
  };

  const setAsNext = () => {
    if (selectedId && possibleSet.has(selectedId)) {
      act('choose_next', { station_type: selectedId });
      setSelectedId(null);
    }
  };

  return (
    <Window title="Train Control Terminal" width={1280} height={720}>
      <Window.Content
        style={{
          background: 'linear-gradient(180deg, #1e2433 0%, #151a24 100%)',
        }}
      >
        <Stack height="100%" direction="row" fill>
          <Stack.Item grow={1} style={{ position: 'relative', minHeight: 0 }}>
            <Box
              style={{
                position: 'relative',
                width: '100%',
                height: '100%',
                overflow: 'hidden',
              }}
            >
              <TrainMapCanvas
                map_data={map_data}
                scale={scale}
                offsetX={offsetX}
                offsetY={offsetY}
                selectedId={selectedId}
                onSelect={setSelectedId}
                onZoom={handleZoom}
                onDragStart={handleDragStart}
              />
              <StationsOverlay
                map_data={map_data}
                scale={scale}
                offsetX={offsetX}
                offsetY={offsetY}
                selectedId={selectedId}
                onSelect={setSelectedId}
              />
            </Box>

            {/* Controls overlay */}
            <Box
              position="absolute"
              top="10px"
              left="10px"
              backgroundColor="rgba(0,0,0,0.75)"
              p={1}
              style={{
                borderRadius: '6px',
                zIndex: 30,
                display: 'flex',
                gap: '6px',
                flexWrap: 'wrap',
              }}
            >
              <Button onClick={resetView}>Reset View</Button>
              <Button
                icon="plus"
                onClick={() => setScale((s) => Math.min(4, s * 1.25))}
              />
              <Button
                icon="minus"
                onClick={() => setScale((s) => Math.max(0.25, s * 0.8))}
              />
            </Box>

            <Box
              position="absolute"
              bottom="10px"
              left="10px"
              backgroundColor="rgba(0,0,0,0.75)"
              p={1}
              style={{ borderRadius: '6px', zIndex: 30 }}
            >
              Zoom: {Math.round(scale * 100)}%
            </Box>
          </Stack.Item>

          <Stack.Item width="380px" style={{ overflowY: 'auto' }}>
            <StatusPanel
              read_only={read_only}
              is_moving={is_moving}
              train_engine_active={train_engine_active}
              current_station={current_station}
              planned_station={planned_station}
              progress={progress}
              time_remaining={time_remaining}
              onStart={() => act('start_moving')}
              onStop={() => act('stop_moving')}
            />

            {selectedObject && (
              <SelectedStationPanel
                selectedObject={selectedObject}
                possibleSet={possibleSet}
                is_moving={is_moving}
                read_only={read_only}
                onClose={() => setSelectedId(null)}
                onSetAsNext={setAsNext}
              />
            )}

            {!is_moving && possible_next.length > 0 && (
              <PossibleNextList
                possible_next={possible_next}
                onChoose={(type) => {
                  act('choose_next', { station_type: type });
                  setSelectedId(type);
                }}
              />
            )}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
