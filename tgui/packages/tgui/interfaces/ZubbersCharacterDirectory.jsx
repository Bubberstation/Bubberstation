import { useState } from 'react';

import { useBackend } from '../backend';
import {
  Button,
  Icon,
  Input,
  LabeledList,
  Section,
  Table,
  Tooltip,
} from '../components';
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

export const ZubbersCharacterDirectory = (props) => {
  const { data } = useBackend();

  const {
    personalVisibility,
    personalAttraction,
    personalGender,
    personalErpTag,
    personalVoreTag,
    personalHypnoTag,
    personalNonconTag,
  } = data;

  return (
    <Window width={900} height={640} resizeable>
      <Window.Content scrollable>
        <Section title="Controls">
          <LabeledList>
            <LabeledList.Item label="Visibility">
              <Button fluid>
                {personalVisibility ? 'Shown' : 'Not Shown'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Attraction">
              <Button fluid>{personalAttraction}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Gender">
              <Button fluid>{personalGender}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="ERP">
              <Button fluid>{personalErpTag}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Vore">
              <Button fluid>{personalVoreTag}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Hypno">
              <Button fluid>{personalHypnoTag}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Noncon">
              <Button fluid>{personalNonconTag}</Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <CharacterDirectoryList />
      </Window.Content>
    </Window>
  );
};

const CharacterDirectoryList = (props) => {
  const { act, data } = useBackend();

  const { directory, canOrbit } = data;
  const [searchTerm, setSearchTerm] = useState('');

  const [sortId, setSortId] = useState('name');
  const [sortOrder, setSortOrder] = useState('asc');

  const handleSort = (id) => {
    if (sortId === id) {
      setSortOrder(sortOrder === 'asc' ? 'desc' : 'asc');
    } else {
      setSortId(id);
      setSortOrder('asc');
    }
  };

  const handleSearchChange = (e) => {
    setSearchTerm(e.target.value);
  };

  const handleRandomView = () => {
    if (directory.length > 0) {
      const randomIndex = Math.floor(Math.random() * directory.length);
      const randomCharacter = directory[randomIndex];
      act('view', { ref: randomCharacter.ref });
    }
  };

  const filteredDirectory = directory.filter((character) =>
    character.name.toLowerCase().includes(searchTerm.toLowerCase()),
  );

  const sortedDirectory = filteredDirectory.slice().sort((a, b) => {
    const sortOrderValue = sortOrder === 'asc' ? 1 : -1;
    return sortOrderValue * a[sortId].localeCompare(b[sortId]);
  });

  return (
    <Section
      title="Directory"
      buttons={
        <>
          <Button icon="sync" onClick={() => act('refresh')}>
            {'Refresh'}
          </Button>
          <Tooltip content="Display a random player's advert. Click if you dare.">
            <Button icon="random" onClick={handleRandomView}>
              {'I Feel Lucky'}
            </Button>
          </Tooltip>
        </>
      }
    >
      <Input
        placeholder="Search name..."
        onChange={(e) => setSearchTerm(e.target.value)}
        value={searchTerm}
        mb={2}
      />
      <Table>
        <Table.Row bold>
          <SortButton
            id="name"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Name
          </SortButton>
          <SortButton
            id="species"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Species
          </SortButton>
          <SortButton
            id="attraction"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Attraction
          </SortButton>
          <SortButton
            id="gender"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Gender
          </SortButton>
          <SortButton
            id="erp"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            ERP
          </SortButton>
          <SortButton
            id="vore"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Vore
          </SortButton>
          <SortButton
            id="hypno"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Hypno
          </SortButton>
          <SortButton
            id="noncon"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            Noncon
          </SortButton>
          <Table.Cell collapsing textAlign="right">
            Advert
          </Table.Cell>
        </Table.Row>
        {sortedDirectory.map((character, i) => (
          <Table.Row key={i} backgroundColor={erpTagColor[character.erp]}>
            <Table.Cell p={1}>
              {canOrbit ? (
                <Button
                  color={erpTagColor[character.erp]}
                  icon="ghost"
                  tooltip="Orbit"
                  onClick={() => act('orbit', { ref: character.ref })}
                >
                  {character.name}
                </Button>
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
                onClick={() => act('view', { ref: character.ref })}
                color="transparent"
                icon="sticky-note"
                mr={1}
              >
                {'View'}
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const SortButton = ({ id, sortId, sortOrder, onClick, children }) => (
  <Table.Cell collapsing>
    <Button
      width="100%"
      color={sortId !== id ? 'transparent' : undefined}
      onClick={() => onClick(id)}
    >
      {children}
      {sortId === id && (
        <Icon
          name={sortOrder === 'asc' ? 'sort-up' : 'sort-down'}
          ml="0.25rem;"
        />
      )}
    </Button>
  </Table.Cell>
);
