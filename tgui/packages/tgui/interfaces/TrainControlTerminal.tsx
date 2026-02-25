import { Box, Button, LabeledList, ProgressBar, Section, Stack } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { useState, useRef, useEffect, useCallback } from 'react';
import { BooleanLike } from 'tgui-core/react';

const MAP_WIDTH = 1000;
const MAP_HEIGHT = 1000;
const NODE_RADIUS = 14;

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
}

export interface TrainMapPath {
  start_x: number;
  start_y: number;
  end_x: number;
  end_y: number;
  angle: number;
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
  const { map_data, scale, offsetX, offsetY, selectedId, onSelect, onZoom, onDragStart } = props;

  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);

  const [canvasSize, setCanvasSize] = useState({ width: 800, height: 600 });
  const [isDragging, setIsDragging] = useState(false);

  // Обновляем размер canvas под контейнер
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

  // Устанавливаем внутренний размер canvas = отображаемому (для чёткости)
  useEffect(() => {
    const canvas = canvasRef.current;
    if (canvas) {
      canvas.width = canvasSize.width;
      canvas.height = canvasSize.height;
    }
  }, [canvasSize]);

  const getRegionColor = (region: string): string => {
    let hash = 0;
    for (let i = 0; i < region.length; i++) {
      hash = region.charCodeAt(i) + ((hash << 5) - hash);
    }
    const hue = Math.abs(hash) % 360;
    return `hsl(${hue}, 75%, 58%)`;
  };

  const redraw = useCallback(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.save();
    ctx.translate(offsetX, offsetY);
    ctx.scale(scale, scale);

    ctx.strokeStyle = '#2a2a2a';
    ctx.lineWidth = 5.5 / scale;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    for (const path of map_data.paths) {
      ctx.beginPath();
      ctx.moveTo(path.start_x, path.start_y);
      ctx.lineTo(path.end_x, path.end_y);
      ctx.stroke();
    }


    for (const obj of map_data.objects) {
      const isCur = !!obj.is_current;
      const isNxt = !!obj.is_next;
      const isSel = obj.id === selectedId;
      const isLocal = !!obj.is_local_center;

      const radius = isLocal ? NODE_RADIUS * 1.6 : NODE_RADIUS;

      ctx.fillStyle = isCur ? '#0f0' : isNxt ? '#ff0' : getRegionColor(obj.region);
      ctx.beginPath();
      ctx.arc(obj.x, obj.y, radius, 0, Math.PI * 2);
      ctx.fill();

      if (isLocal) {
        ctx.strokeStyle = '#ffffff';
        ctx.lineWidth = 3.5 / scale;
        ctx.beginPath();
        ctx.arc(obj.x, obj.y, radius + 4, 0, Math.PI * 2);
        ctx.stroke();
      }

      if (isSel || isCur || isNxt) {
        ctx.strokeStyle = '#fff';
        ctx.lineWidth = 4 / scale;
        ctx.beginPath();
        ctx.arc(obj.x, obj.y, radius + 6, 0, Math.PI * 2);
        ctx.stroke();
      }

      if (scale > 0.65 || isLocal) {
        ctx.fillStyle = '#ffffff';
        ctx.font = `${(isLocal ? 15 : 13) / scale}px Arial`;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.shadowColor = '#000';
        ctx.shadowBlur = 6;
        ctx.fillText(
          obj.name + (isLocal ? ' ★' : ''),
          obj.x,
          obj.y - radius - (isLocal ? 18 : 14)
        );
        ctx.shadowBlur = 0;
      }
    }

    const t = map_data.train;
    ctx.save();
    ctx.translate(t.x, t.y);
    ctx.rotate((t.angle * Math.PI) / 180);

    ctx.fillStyle = '#f80';
    ctx.beginPath();
    ctx.moveTo(26, 0);
    ctx.lineTo(-20, -16);
    ctx.lineTo(-14, 0);
    ctx.lineTo(-20, 16);
    ctx.closePath();
    ctx.fill();

    ctx.fillStyle = '#111';
    ctx.beginPath(); ctx.arc(-9, 11, 7, 0, Math.PI * 2); ctx.fill();
    ctx.beginPath(); ctx.arc(-9, -11, 7, 0, Math.PI * 2); ctx.fill();

    ctx.restore();
    ctx.restore();
  }, [map_data, scale, offsetX, offsetY, selectedId]);

  useEffect(() => { redraw(); }, [redraw]);

  const handleClick = (e: React.MouseEvent<HTMLCanvasElement>) => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const rect = canvas.getBoundingClientRect();
    const screenX = e.clientX - rect.left;
    const screenY = e.clientY - rect.top;

    const worldX = (screenX - offsetX) / scale;
    const worldY = (screenY - offsetY) / scale;

    for (const obj of map_data.objects) {
      const isLocal = !!obj.is_local_center;
      const r = isLocal ? NODE_RADIUS * 1.6 : NODE_RADIUS;
      const dx = worldX - obj.x;
      const dy = worldY - obj.y;
      if (dx * dx + dy * dy <= r * r * 2.4) {
        onSelect(obj.id);
        return;
      }
    }
  };

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
      }}
    >
      <canvas
        ref={canvasRef}
        style={{
          position: 'absolute',
          inset: 0,
          imageRendering: 'pixelated',
          cursor: isDragging ? 'grabbing' : 'grab',
          touchAction: 'none',
        }}
        onMouseDown={(e) => {
          if (e.button === 0) {
            setIsDragging(true);
            onDragStart(e.clientX, e.clientY);
          }
        }}
        onWheel={handleWheel}
        onClick={handleClick}
      />
    </div>
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
  <Section title="Статус поезда">
    <LabeledList>
      <LabeledList.Item label="Текущая станция">{props.current_station}</LabeledList.Item>
      <LabeledList.Item label="Следующая">{props.planned_station}</LabeledList.Item>
      <LabeledList.Item label="Движение">
        <ProgressBar value={props.progress} color={props.is_moving ? 'good' : 'average'}>
          {props.is_moving ? `${props.time_remaining} сек` : 'Остановлен'}
        </ProgressBar>
      </LabeledList.Item>
    </LabeledList>

    {!props.read_only && (
      <Stack mt={2} justify="space-between">
        <Button
          icon="play"
          color="good"
          disabled={!props.train_engine_active || !!props.is_moving || !props.planned_station}
          onClick={props.onStart}
        >
          Отправить поезд
        </Button>
        <Button
          icon="stop"
          color="bad"
          disabled={!props.is_moving}
          onClick={props.onStop}
        >
          Остановить
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
    title={`Выбрано: ${props.selectedObject.name}`}
    buttons={<Button icon="times" color="transparent" onClick={props.onClose} />}
  >
    <LabeledList>
      <LabeledList.Item label="Регион">{props.selectedObject.region}</LabeledList.Item>
      {props.selectedObject.is_local_center && (
        <LabeledList.Item label="Тип" color="good">
          ЛОКАЛЬНЫЙ ЦЕНТР (ХАБ)
        </LabeledList.Item>
      )}
      <LabeledList.Item label="Посещено">{props.selectedObject.visited} раз</LabeledList.Item>
      <LabeledList.Item label="Описание">{props.selectedObject.desc}</LabeledList.Item>
    </LabeledList>

    {!props.read_only && props.possibleSet.has(props.selectedObject.id) && !props.is_moving && (
      <Button mt={2} fluid icon="arrow-right" color="good" onClick={props.onSetAsNext}>
        Выбрать как следующую станцию
      </Button>
    )}
  </Section>
);
type PossibleNextListProps = {
  possible_next: PossibleNextStation[];
  onChoose: (type: string) => void;
};

const PossibleNextList = (props: PossibleNextListProps) => (
  <Section title="Возможные направления">
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

  const handleZoom = (newScale: number, newOffsetX: number, newOffsetY: number) => {
    setScale(newScale);
    setOffsetX(newOffsetX);
    setOffsetY(newOffsetY);
  };

  const handleDragStart = (clientX: number, clientY: number) => {
    setDragStart({ x: clientX - offsetX, y: clientY - offsetY });
  };

  const handleMouseMove = useCallback(
    (e: MouseEvent) => {
      if (!dragStart.x && !dragStart.y) return;
      const newX = e.clientX - dragStart.x;
      const newY = e.clientY - dragStart.y;
      setOffsetX(newX);
      setOffsetY(newY);
    },
    [dragStart],
  );

  const handleMouseUp = useCallback(() => {
    setDragStart({ x: 0, y: 0 });
  }, []);

  useEffect(() => {
    if (dragStart.x || dragStart.y) {
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
      <Window.Content>
        <Stack height="100%" direction="row">
          <Stack.Item grow={1} style={{ position: 'relative', minHeight: 0 }}>
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

            <Box
              position="absolute"
              top="8px"
              left="8px"
              backgroundColor="rgba(0,0,0,0.7)"
              p={1}
              style={{ borderRadius: '4px', zIndex: 10 }}
            >
              <Button onClick={resetView}>Сбросить вид</Button>
              <Button onClick={() => setScale(s => Math.min(4, s * 1.25))}>+</Button>
              <Button onClick={() => setScale(s => Math.max(0.25, s * 0.8))}>-</Button>
            </Box>

            <Box
              position="absolute"
              bottom="8px"
              left="8px"
              backgroundColor="rgba(0,0,0,0.7)"
              p={1}
              style={{ borderRadius: '4px', zIndex: 10 }}
            >
              Масштаб: {Math.round(scale * 100)}%
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
