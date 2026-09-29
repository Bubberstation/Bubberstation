import { sortBy } from 'es-toolkit';
import { filter } from 'es-toolkit/compat';
import { useState } from 'react';
import { useBackend, useLocalState } from 'tgui/backend';
import {
  Box,
  Button,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { JOB2ICON } from '../common/JobToIcon';
import { CRIMESTATUS2COLOR } from './constants';
import { isRecordMatch } from './helpers';
import type { SecurityRecord, SecurityRecordsData } from './types';

/** Tabs on left, with search bar */
export const SecurityRecordTabs = (props) => {
  const { act, data } = useBackend<SecurityRecordsData>();
  const { higher_access, records = [], station_z } = data;

  const errorMessage = !records.length
    ? 'No records found.'
    : 'No match. Refine your search.';

  const [search, setSearch] = useState('');

  const sorted = sortBy(
    filter(records, (record) => isRecordMatch(record, search)),
    [(record) => record.name],
  );

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Input
          fluid
          placeholder="Name/Job/Fingerprints"
          onChange={setSearch}
          expensive
        />
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable>
          <Tabs vertical>
            {!sorted.length ? (
              <NoticeBox>{errorMessage}</NoticeBox>
            ) : (
              sorted.map((record, index) => (
                <CrewTab index={index} record={record} key={index} />
              ))
            )}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item align="center">
        <Stack fill>
          <Stack.Item>
            <Button
              disabled
              icon="plus"
              tooltip="Add new records by inserting a 1 by 1 meter photo into the terminal. You do not need this screen open."
            >
              Create
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              content="Purge"
              disabled={!higher_access || !station_z}
              icon="trash"
              onClick={() => act('purge_records')}
              tooltip="Wipe criminal record data."
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

/** Individual record */
const CrewTab = (props: { record: SecurityRecord; index: number }) => {
  const [selectedRecord, setSelectedRecord] = useLocalState<
    SecurityRecord | undefined
  >('securityRecord', undefined);

  const { act, data } = useBackend<SecurityRecordsData>();
  const { assigned_view } = data;
  const { record, index } = props;
  const { crew_ref, name, trim, wanted_status } = record;

  /** Chooses a record */
  const selectRecord = (record: SecurityRecord) => {
    if (selectedRecord?.crew_ref === crew_ref) {
      setSelectedRecord(undefined);
    } else {
      // See MedicalRecords/RecordTabs.tsx for explanation
      if (selectedRecord === undefined) {
        setTimeout(() => {
          act('view_record', {
            assigned_view: assigned_view,
            crew_ref: crew_ref,
          });
        });
      }
      setSelectedRecord(record);
      act('view_record', { assigned_view: assigned_view, crew_ref: crew_ref });
    }
  };

  const isSelected = selectedRecord?.crew_ref === crew_ref;
  const statusColor = CRIMESTATUS2COLOR[wanted_status]; // BUBBER EDIT ADDITION - WARRANTS

  return (
    // BUBBER EDIT CHANGE START - WARRANTS - a flagged record fills its whole row with the status colour and a white name.
    // The colour goes on the tab itself rather than an inner box so there is no gap around it, and the candystripe class
    // comes off when it does, because that rule paints a gradient over any background colour underneath it. The bar then
    // carries its own light/dark alternation on the same row parity, so ten wanted people still read as stripes.
    <Tabs.Tab
      backgroundColor={statusColor}
      className={statusColor ? undefined : 'candystripe'}
      onClick={() => selectRecord(record)}
      selected={isSelected}
      style={
        statusColor && index % 2 ? { filter: 'brightness(0.85)' } : undefined
      }
    >
      <Box bold={isSelected} color={statusColor ? 'white' : undefined}>
        <Icon name={JOB2ICON[trim] || 'question'} /> {name}
      </Box>
    </Tabs.Tab>
    // BUBBER EDIT CHANGE END
  );
};
