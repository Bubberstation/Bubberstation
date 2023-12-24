import { useState } from 'react';
import { useBackend } from '../backend';
import { Box, Button, Icon, LabeledList, Section, Table } from '../components';
import { Window } from '../layouts';

const erpTagColor = {
  Unset: 'label',
  'Yes - Dom': '#570000',
  'Yes - Sub': '#002B57',
  'Yes - Switch': '#022E00',
  Yes: '#022E00',
  'Check OOC': '#222222',
  Ask: '#222222',
  No: '#000000',
};

export const ZubbersCharacterDirectory = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    personalVisibility,
    personalAttraction,
    personalGender,
    personalErpTag,
    personalVoreTag,
    personalHypnoTag,
    personalNonconTag,
    prefsOnly,
  } = data;

  const [overlay, setOverlay] = useState(null);

  const [overwritePrefs, setOverwritePrefs] = useState(prefsOnly);

  return (
    <Window width={640} height={480} resizeable>
      <Window.Content scrollable>
        {(overlay && <ViewCharacter />) || (
          <>
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
                <LabeledList.Item label="Attraction">
                  <Button fluid content={personalAttraction} />
                </LabeledList.Item>
                <LabeledList.Item label="Gender">
                  <Button fluid content={personalGender} />
                </LabeledList.Item>
                <LabeledList.Item label="ERP">
                  <Button
                    fluid
                    content={personalErpTag}
                    onClick={() =>
                      act('setErpTag', { overwrite_prefs: overwritePrefs })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Vore">
                  <Button
                    fluid
                    content={personalVoreTag}
                    onClick={() =>
                      act('setTag', { overwrite_prefs: overwritePrefs })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Hypno">
                  <Button
                    fluid
                    content={personalHypnoTag}
                    onClick={() =>
                      act('setHypnoTag', { overwrite_prefs: overwritePrefs })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Noncon">
                  <Button
                    fluid
                    content={personalNonconTag}
                    onClick={() =>
                      act('setNonconTag', { overwrite_prefs: overwritePrefs })
                    }
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <CharacterDirectoryList />
          </>
        )}
      </Window.Content>
    </Window>
  );
};

const ViewCharacter = (props, context) => {
  const [overlay, setOverlay] = useState(null);

  return (
    <Section
      title={overlay.name}
      buttons={
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => setOverlay(null)}
        />
      }
    >
      <Section level={2} title="Species">
        <Box>{overlay.species}</Box>
      </Section>
      <Section level={2} title="Attraction">
        <Box>{overlay.attraction}</Box>
      </Section>
      <Section level={2} title="Gender">
        <Box>{overlay.gender}</Box>
      </Section>
      <Section level={2} title="ERP">
        <Box p={1} backgroundColor={erpTagColor[overlay.erp]}>
          {overlay.erp}
        </Box>
        <Section level={2} title="Vore">
          <Box>{overlay.vore}</Box>
        </Section>
      </Section>
      <Section level={2} title="Hypno">
        <Box>{overlay.hypno}</Box>
      </Section>
      <Section level={2} title="Noncon">
        <Box>{overlay.noncon}</Box>
      </Section>
      <Section level={2} title="Character Ad">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.character_ad || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="Exploitable">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.exploitable || 'Unset.'}
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

  const [sortId, _setSortId] = useState('name');
  const [sortOrder, _setSortOrder] = useState('name');
  const [overlay, setOverlay] = useState(null);

  return (
    <Section
      title="Directory"
      buttons={
        <Button icon="sync" content="Refresh" onClick={() => act('refresh')} />
      }
    >
      <Table>
        <Table.Row bold>
          <SortButton id="name">Name</SortButton>
          <SortButton id="species">Species</SortButton>
          <SortButton id="attraction">Attraction</SortButton>
          <SortButton id="gender">Gender</SortButton>
          <SortButton id="erp">ERP</SortButton>
          <SortButton id="vore">Vore</SortButton>
          <SortButton id="hypno">Hypno</SortButton>
          <SortButton id="noncon">Noncon</SortButton>
          <Table.Cell collapsing textAlign="right">
            Advert
          </Table.Cell>
        </Table.Row>
        {directory
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            return a[sortId].localeCompare(b[sortId]) * i;
          })
          .map((character, i) => (
            <Table.Row key={i} backgroundColor={erpTagColor[character.erp]}>
              <Table.Cell p={1}>
                {canOrbit ? (
                  <Button
                    color={erpTagColor[character.erp]}
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
              <Table.Cell>{character.attraction}</Table.Cell>
              <Table.Cell>{character.gender}</Table.Cell>
              <Table.Cell>{character.erp}</Table.Cell>
              <Table.Cell>{character.vore}</Table.Cell>
              <Table.Cell>{character.hypno}</Table.Cell>
              <Table.Cell>{character.noncon}</Table.Cell>
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
  const [sortId, setSortId] = useState('name');
  const [sortOrder, setSortOrder] = useState('name');

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
        }}
      >
        {children}
        {sortId === id && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml="0.25rem;" />
        )}
      </Button>
    </Table.Cell>
  );
};
