import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Icon, LabeledList, Section, Table } from '../components';
import { Window } from '../layouts';

const erpTagColor = {
  'Unset': 'label',
  'Yes': 'red',
  'Yes - Dom': 'red',
  'Yes - Sub': 'blue',
  'Yes - Switch': 'yellow',
  'Check OOC': 'black',
  'Ask': 'black',
  'No': 'black',
};

export const ZubbersCharacterDirectory = (props, context) => {
  const { act, data } = useBackend(context);

  const { personalVisibility, personalTag, personalErpTag, prefsOnly } = data;

  const [overlay, setOverlay] = useLocalState(context, 'overlay', null);

  const [overwritePrefs, setOverwritePrefs] = useLocalState(
    context,
    'overwritePrefs',
    prefsOnly
  );

  return (
    <Window width={640} height={480} resizeable>
      <Window.Content scrollable>
        {(overlay && <ViewCharacter />) || (
          <Fragment>
            <Section title="Controls">
              <LabeledList>
                <LabeledList.Item label="Visibility">
                  <Button
                    fluid
                    content={personalVisibility ? 'Shown' : 'Not Shown'}
                    onClick={() =>
                      act('setVisible', { overwrite_prefs: overwritePrefs })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Vore Tag">
                  <Button
                    fluid
                    content={personalTag}
                    onClick={() =>
                      act('setTag', { overwrite_prefs: overwritePrefs })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item label="ERP Tag">
                  <Button
                    fluid
                    content={personalErpTag}
                    onClick={() =>
                      act('setErpTag', { overwrite_prefs: overwritePrefs })
                    }
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <CharacterDirectoryList />
          </Fragment>
        )}
      </Window.Content>
    </Window>
  );
};

const ViewCharacter = (props, context) => {
  const [overlay, setOverlay] = useLocalState(context, 'overlay', null);

  return (
    <Section
      title={overlay.name}
      buttons={
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => setOverlay(null)}
        />
      }>
      <Section level={2} title="Species">
        <Box>{overlay.species}</Box>
      </Section>
      <Section level={2} title="Vore Tag">
        <Box>{overlay.tag}</Box>
      </Section>
      <Section level={2} title="ERP Tag">
        <Box p={1} backgroundColor={erpTagColor[overlay.erptag]}>
          {overlay.erptag}
        </Box>
      </Section>
      <Section level={2} title="Character Ad">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.character_ad || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="OOC Notes">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.ooc_notes || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="Flavor Text">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.flavor_text || 'Unset.'}
        </Box>
      </Section>
    </Section>
  );
};

const CharacterDirectoryList = (props, context) => {
  const { act, data } = useBackend(context);

  const { directory, canOrbit } = data;

  const [sortId, _setSortId] = useLocalState(context, 'sortId', 'name');
  const [sortOrder, _setSortOrder] = useLocalState(
    context,
    'sortOrder',
    'name'
  );
  const [overlay, setOverlay] = useLocalState(context, 'overlay', null);

  return (
    <Section
      title="Directory"
      buttons={
        <Button icon="sync" content="Refresh" onClick={() => act('refresh')} />
      }>
      <Table>
        <Table.Row bold>
          <SortButton id="name">Name</SortButton>
          <SortButton id="species">Species</SortButton>
          <SortButton id="tag">Vore Tag</SortButton>
          <SortButton id="erptag">ERP Tag</SortButton>
          <Table.Cell collapsing textAlign="right">
            Advertisement
          </Table.Cell>
        </Table.Row>
        {directory
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            return a[sortId].localeCompare(b[sortId]) * i;
          })
          .map((character, i) => (
            <Table.Row key={i} backgroundColor={erpTagColor[character.erptag]}>
              <Table.Cell p={1}>
                {canOrbit ? (
                  <Button
                    color={erpTagColor[character.erptag]}
                    icon="ghost"
                    tooltip="Orbit"
                    content={character.name}
                    onClick={() => act('orbit', { ref: character.ref })}
                  />
                ) : (
                  character.name
                )}
              </Table.Cell>
              <Table.Cell>{character.species}</Table.Cell>
              <Table.Cell>{character.tag}</Table.Cell>
              <Table.Cell>{character.erptag}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  onClick={() => setOverlay(character)}
                  color="transparent"
                  icon="sticky-note"
                  mr={1}
                  content="View"
                />
              </Table.Cell>
            </Table.Row>
          ))}
      </Table>
    </Section>
  );
};

const SortButton = (props, context) => {
  const { act, data } = useBackend(context);

  const { id, children } = props;

  // Hey, same keys mean same data~
  const [sortId, setSortId] = useLocalState(context, 'sortId', 'name');
  const [sortOrder, setSortOrder] = useLocalState(context, 'sortOrder', 'name');

  return (
    <Table.Cell collapsing>
      <Button
        width="100%"
        color={sortId !== id && 'transparent'}
        onClick={() => {
          if (sortId === id) {
            setSortOrder(!sortOrder);
          } else {
            setSortId(id);
            setSortOrder(true);
          }
        }}>
        {children}
        {sortId === id && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml="0.25rem;" />
        )}
      </Button>
    </Table.Cell>
  );
};
