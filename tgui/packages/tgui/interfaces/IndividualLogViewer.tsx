import { useState } from 'react';
import {
  Box,
  Button,
  Input,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';

type IndividualLogViewerData = {
  mob_name: string;
  mob_type: string;
  source_type: string;
  current_log_type: number;
  available_sources: LogSource[];
  available_types: LogType[];
  entries: LogEntry[];
};

type LogSource = {
  name: string;
  source: string;
};

type LogType = {
  name: string;
  type: number;
};

type LogEntry = {
  timestamp: string;
  message: string;
  formatted_message: string;
};

export const IndividualLogViewer = (_: any) => {
  const { data, act } = useBackend<IndividualLogViewerData>();

  return (
    <Window width={800} height={600}>
      <Window.Content scrollable>
        <Section>
          <Button icon="sync" onClick={() => act('refresh')} />
        </Section>
        <SourceTypeBar
          sources={data.available_sources}
          activeSource={data.source_type}
          setSource={(source) => act('change_source', { source })}
        />
        <LogTypeBar
          types={data.available_types}
          activeType={data.current_log_type}
          setType={(log_type) => act('change_type', { log_type })}
        />
        <LogEntriesViewer
          mobName={data.mob_name}
          mobType={data.mob_type}
          entries={data.entries}
        />
      </Window.Content>
    </Window>
  );
};

type SourceTypeBarProps = {
  sources: LogSource[];
  activeSource: string;
  setSource: (source: string) => void;
};

const SourceTypeBar = (props: SourceTypeBarProps) => {
  return (
    <Section title="Source Type">
      <Stack>
        {props.sources?.map((source) => (
          <Stack.Item key={source.source}>
            <Button
              selected={props.activeSource === source.source}
              onClick={() => props.setSource(source.source)}
            >
              {source.name}
            </Button>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

type LogTypeBarProps = {
  types: LogType[];
  activeType: number;
  setType: (type: number) => void;
};

const LogTypeBar = (props: LogTypeBarProps) => {
  return (
    <Section title="Log Type">
      <Stack wrap>
        {props.types?.map((type) => (
          <Stack.Item key={type.type}>
            <Button
              selected={props.activeType === type.type}
              onClick={() => props.setType(type.type)}
            >
              {type.name}
            </Button>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

type LogEntriesViewerProps = {
  mobName: string;
  mobType: string;
  entries: LogEntry[];
};

const validateRegExp = (str: string) => {
  try {
    new RegExp(str);
    return true;
  } catch (e) {
    return e;
  }
};

const LogEntriesViewer = (props: LogEntriesViewerProps) => {
  const [search, setSearch] = useState('');
  let [searchRegex, setSearchRegex] = useState(false);
  let [caseSensitive, setCaseSensitive] = useState(false);
  const [sortAscending, setSortAscending] = useState(false);

  if (!search && searchRegex) {
    setSearchRegex(false);
    searchRegex = false;
  }

  let regexValidation: boolean | SyntaxError = true;
  if (searchRegex) {
    regexValidation = validateRegExp(search);
  }

  // Sort entries by timestamp
  const sortedEntries = [...(props.entries || [])].sort((a, b) => {
    if (sortAscending) {
      return a.timestamp.localeCompare(b.timestamp); // oldest first
    } else {
      return b.timestamp.localeCompare(a.timestamp); // newest first
    }
  });

  const filteredEntries = sortedEntries?.filter((entry) => {
    if (!search) return true;

    if (searchRegex) {
      if (regexValidation !== true) return false;
      const regex = new RegExp(search, caseSensitive ? 'g' : 'gi');
      return regex.test(entry.message);
    } else {
      if (caseSensitive) {
        return entry.message.includes(search);
      } else {
        return entry.message.toLowerCase().includes(search.toLowerCase());
      }
    }
  });

  return (
    <Section
      title={`Individual Logs - ${props.mobName} (${props.mobType}) [${filteredEntries?.length || 0}]`}
      buttons={
        <>
          <Input
            placeholder="Search logs..."
            value={search}
            onChange={setSearch}
            expensive
          />
          <Button
            icon="code"
            tooltip="RegEx Search"
            selected={searchRegex}
            onClick={() => setSearchRegex(!searchRegex)}
          />
          <Button
            icon="font"
            selected={caseSensitive}
            tooltip="Case Sensitive"
            onClick={() => setCaseSensitive(!caseSensitive)}
          />
          <Button
            icon={sortAscending ? 'sort-up' : 'sort-down'}
            tooltip={sortAscending ? 'Oldest First' : 'Newest First'}
            selected={!sortAscending}
            onClick={() => setSortAscending(!sortAscending)}
          />
          <Button
            icon="trash"
            tooltip="Clear Search"
            color="bad"
            onClick={() => {
              setSearch('');
              setSearchRegex(false);
            }}
          />
        </>
      }
    >
      <Stack vertical>
        {!searchRegex || regexValidation === true ? (
          filteredEntries?.length ? (
            filteredEntries.map((entry, index) => (
              <Stack.Item key={index}>
                <div
                  style={{
                    padding: '8px',
                    marginBottom: '4px',
                    backgroundColor: index % 2 === 0 ? '#1a1a1a' : '#2a2a2a',
                    borderRadius: '4px',
                    borderLeft: '3px solid #4a9eff',
                  }}
                >
                  <div
                    style={{
                      color: '#4a9eff',
                      fontSize: '11px',
                      fontWeight: 'bold',
                      marginBottom: '4px',
                    }}
                  >
                    {entry.timestamp}
                  </div>
                  {/* eslint-disable-next-line react/no-danger */}
                  <Box
                    style={{
                      fontFamily: 'monospace',
                      fontSize: '12px',
                      lineHeight: '1.4',
                      whiteSpace: 'pre-wrap',
                      wordBreak: 'break-word',
                      color: '#ffffff',
                    }}
                    dangerouslySetInnerHTML={{
                      __html: sanitizeText(entry.formatted_message),
                    }}
                  />
                </div>
              </Stack.Item>
            ))
          ) : (
            <NoticeBox>No log entries found.</NoticeBox>
          )
        ) : (
          <NoticeBox danger>
            Invalid RegEx: {(regexValidation as SyntaxError).message}
          </NoticeBox>
        )}
      </Stack>
    </Section>
  );
};
