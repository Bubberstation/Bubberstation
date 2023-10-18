import { sortBy } from 'common/collections';
import { useBackend } from '../backend';
import { Box, Button, Section, Table, Icon } from '../components';
import { COLORS } from '../constants';
import { Window } from '../layouts';

const STAT_LIVING = 0;
const STAT_DEAD = 4;

const HEALTH_COLOR_BY_LEVEL = [
  '#17d568',
  '#c4cf2d',
  '#e67e22',
  '#ed5100',
  '#e74c3c',
  '#801308',
];
const HEALTH_ICON_BY_LEVEL = [
  'heart',
  'heart',
  'heart',
  'heart-circle-exclamation',
  'heartbeat',
  'heart-crack',
];
const jobIsHead = (jobId) => jobId % 10 === 0;

const jobToColor = (jobId) => {
  if (jobId >= 0 && jobId < 50) {
    return COLORS.department.centcom;
  }
  if (jobId >= 50 && jobId < 200) {
    return COLORS.department.captain;
  }
  if (jobId >= 200 && jobId < 300) {
    return COLORS.department.security;
  }
  if (jobId >= 300 && jobId < 400) {
    return COLORS.department.medbay;
  }
  if (jobId >= 400 && jobId < 500) {
    return COLORS.department.science;
  }
  if (jobId >= 500 && jobId < 600) {
    return COLORS.department.engineering;
  }
  if (jobId >= 600 && jobId < 700) {
    return COLORS.department.cargo;
  }
  if (jobId >= 700 && jobId < 800) {
    return COLORS.department.service;
  }
  if (jobId === 801) {
    return COLORS.department.assistant;
  }
  if (jobId === 803) {
    return COLORS.department.prisoner;
  }
  return COLORS.department.other;
};

const healthToAttribute = (oxy, tox, burn, brute, attributeList) => {
  const healthSum = oxy + tox + burn + brute;
  const level = Math.min(Math.max(Math.ceil(healthSum / 50), 0), 5);
  // 200 Default Health, Sum Divided by 50, 6 Health States
  return attributeList[level];
};

const HealthStat = (props) => {
  const { type, value } = props;
  return (
    <Box inline width={2} color={COLORS.damageType[type]} textAlign="center">
      {value}
    </Box>
  );
};

export const CrewConsoleBubbers = () => {
  return (
    <Window title="Crew Monitor" width={600} height={600}>
      <Window.Content scrollable>
        <Section minHeight="540px">
          <CrewTable />
        </Section>
      </Window.Content>
    </Window>
  );
};

const CrewTable = (props, context) => {
  const { act, data } = useBackend(context);
  const sensors = sortBy((s) =>
    s.brutedam + s.burndam + s.toxdam + s.oxydam > 50
      ? -(s.brutedam + s.burndam + s.toxdam + s.oxydam)
      : s.ijob
  )(data.sensors ?? []);
  return (
    <Table cellpadding="3">
      <Table.Row>
        <Table.Cell bold colspan="2">
          Name
        </Table.Cell>
        <Table.Cell bold collapsing textAlign="center">
          Status
        </Table.Cell>
        <Table.Cell bold collapsing textAlign="center">
          Vitals
        </Table.Cell>
        <Table.Cell bold width="180px" collapsing textAlign="center">
          Position
        </Table.Cell>
      </Table.Row>
      {sensors.map((sensor) => (
        <CrewTableEntry sensor_data={sensor} key={sensor.ref} />
      ))}
    </Table>
  );
};

const CrewTableEntry = (props, context) => {
  const { act, data } = useBackend(context);
  const { link_allowed } = data;
  const { sensor_data } = props;
  const {
    name,
    assignment,
    ijob,
    is_robot,
    is_dnr,
    life_status,
    oxydam,
    toxdam,
    burndam,
    brutedam,
    area,
    can_track,
  } = sensor_data;

  return (
    <Table.Row>
      <Table.Cell bold={jobIsHead(ijob)} color={jobToColor(ijob)}>
        {name}
        {assignment !== undefined ? ` (${assignment})` : ''}
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        {is_robot ? (
          <Icon name="user-cog" color="#CCCCCC" size={1} />
        ) : (
          <Icon name="user" color="#EFEFEF" size={1} />
        )}
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        {life_status === STAT_DEAD ? (
          <Icon name="skull" color="#801308" size={1} />
        ) : oxydam !== undefined ? (
          <Icon
            name={healthToAttribute(
              oxydam,
              toxdam,
              burndam,
              brutedam,
              HEALTH_ICON_BY_LEVEL
            )}
            color={healthToAttribute(
              oxydam,
              toxdam,
              burndam,
              brutedam,
              HEALTH_COLOR_BY_LEVEL
            )}
            size={1}
          />
        ) : (
          <Icon name="heart" color="#FFFFFF" size={1} />
        )}
        {life_status === STAT_DEAD && is_dnr ? ' (DNR)' : ''}
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        {oxydam !== undefined ? (
          <Box inline>
            <HealthStat type="oxy" value={oxydam} />
            {'/'}
            <HealthStat type="toxin" value={toxdam} />
            {'/'}
            <HealthStat type="burn" value={burndam} />
            {'/'}
            <HealthStat type="brute" value={brutedam} />
          </Box>
        ) : life_status !== STAT_DEAD ? (
          'Alive'
        ) : (
          'DEAD'
        )}
      </Table.Cell>
      <Table.Cell>
        {area !== undefined ? (
          area
        ) : (
          <Icon name="question" color="#ffffff" size={1} />
        )}
      </Table.Cell>
      {!!link_allowed && (
        <Table.Cell collapsing>
          <Button
            content="Track"
            disabled={!can_track}
            onClick={() =>
              act('select_person', {
                name: name,
              })
            }
          />
        </Table.Cell>
      )}
    </Table.Row>
  );
};
