import { useState } from 'react';
import { useBackend, useLocalState } from 'tgui/backend';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { CharacterPreview } from '../common/CharacterPreview';
import { EditableText } from '../common/EditableText';
import { CRIMESTATUS2COLOR, CRIMESTATUS2DESC, CRIMESTATUS2ICON } from './constants';
import { CrimeWatcher } from './CrimeWatcher';
import { getSecurityRecord } from './helpers';
import { RecordPrint } from './RecordPrint';
import type { SecurityRecordsData } from './types';

/** Views a selected record. */
export const SecurityRecordView = (props) => {
  const foundRecord = getSecurityRecord();
  if (!foundRecord) return <NoticeBox>Nothing selected.</NoticeBox>;

  const { data } = useBackend<SecurityRecordsData>();
  const { assigned_view } = data;

  const [open] = useLocalState<boolean>('printOpen', false);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <CharacterPreview height="100%" id={assigned_view} />
          </Stack.Item>
          <Stack.Item grow>
            <CrimeWatcher />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>{open ? <RecordPrint /> : <RecordInfo />}</Stack.Item>
    </Stack>
  );
};

const RecordInfo = (props) => {
  const foundRecord = getSecurityRecord();
  if (!foundRecord) return <NoticeBox>Nothing selected.</NoticeBox>;

  const { act, data } = useBackend<SecurityRecordsData>();
  const { available_statuses, can_death_warrant } = data; // BUBBER EDIT CHANGE - WARRANTS
  const [open, setOpen] = useLocalState<boolean>('printOpen', false);

  // const { min_age, max_age } = data; // ORIGINAL
  const { min_age, max_age, max_chrono_age } = data; // SKYRAT EDIT CHANGE - Chronological age

  const {
    age,
    chrono_age, // SKYRAT EDIT ADDITION - Chronological age
    crew_ref,
    crimes,
    fingerprint,
    gender,
    name,
    note,
    rank,
    species,
    wanted_status,
    warrant_ready, // BUBBER EDIT ADDITION - WARRANTS
    voice,
    // SKYRAT EDIT START - RP Records
    past_general_records,
    past_security_records,
    // SKYRAT EDIT END
  } = foundRecord;

  const [isValid, setIsValid] = useState(true);

  const hasValidCrimes = !!crimes.find((crime) => !!crime.valid);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section
          buttons={
            <Stack>
              <Stack.Item>
                <Button
                  height="1.7rem"
                  icon="print"
                  onClick={() => setOpen(true)}
                  tooltip="Print a rapsheet or poster."
                >
                  Print
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button.Confirm
                  icon="trash"
                  onClick={() => act('delete_record', { crew_ref: crew_ref })}
                  tooltip="Delete record data."
                >
                  Delete
                </Button.Confirm>
              </Stack.Item>
            </Stack>
          }
          fill
          title={
            <Table.Cell backgroundColor={CRIMESTATUS2COLOR[wanted_status]} color="white"> {/* BUBBER EDIT CHANGE - WARRANTS - Original: color={CRIMESTATUS2COLOR[wanted_status]} */}
              {name}
            </Table.Cell>
          }
        >
          <LabeledList>
            {/* BUBBER EDIT CHANGE START - WARRANTS - the eight statuses do not fit one row, so they wrap under the swatch instead of running off the panel */}
            <LabeledList.Item label="Status">
              <Box
                backgroundColor={CRIMESTATUS2COLOR[wanted_status]}
                color="white"
                inline
                px={0.5}
              >
                {wanted_status}
              </Box>
              <Box
                mt={0.5}
                style={{ display: 'flex', flexWrap: 'wrap', gap: '0.25em' }}
              >
                {available_statuses.map((button, index) => {
                  const isSelected = button === wanted_status;
                  const isExecute = button === 'Execute';
                  const execBlocked =
                    isExecute &&
                    !(can_death_warrant && warrant_ready) &&
                    !isSelected;
                  const disabled =
                    (button === 'Arrest' && !hasValidCrimes) || execBlocked;
                  let tip = CRIMESTATUS2DESC[button] || '';
                  if (execBlocked) {
                    tip =
                      'Death warrants require Captain or Head of Security authorization at amber alert or above.';
                  }
                  return (
                    <Button
                      color={isSelected ? CRIMESTATUS2COLOR[button] : 'grey'}
                      disabled={disabled}
                      icon={CRIMESTATUS2ICON[button] || 'question'}
                      key={index}
                      onClick={() =>
                        act('set_wanted', {
                          crew_ref: crew_ref,
                          status: button,
                        })
                      }
                      selected={isSelected}
                      tooltip={tip}
                      tooltipPosition="bottom-start"
                    >
                      {button}
                    </Button>
                  );
                })}
              </Box>
            </LabeledList.Item>
            {/* BUBBER EDIT CHANGE END */}
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow={2}>
        <Section fill scrollable>
          <LabeledList>
            <LabeledList.Item label="Name">
              <EditableText field="name" target_ref={crew_ref} text={name} />
            </LabeledList.Item>
            <LabeledList.Item label="Job">
              <EditableText field="rank" target_ref={crew_ref} text={rank} />
            </LabeledList.Item>
            {/* <LabeledList.Item label="Age"> // ORIGINAL */}
            {/* SKYRAT EDIT CHANGE BEGIN - Chronological age */}
            <LabeledList.Item label="Physical Age">
              {/* SKYRAT EDIT CHANGE END */}
              <RestrictedInput
                minValue={min_age}
                maxValue={max_age}
                onEnter={(value) =>
                  isValid &&
                  act('edit_field', {
                    crew_ref: crew_ref,
                    field: 'age',
                    value: value,
                  })
                }
                onValidationChange={setIsValid}
                value={age}
              />
            </LabeledList.Item>
            {/* SKYRAT EDIT ADDITION BEGIN - Chronological age */}
            <LabeledList.Item label="Chronological Age">
              <RestrictedInput
                minValue={min_age}
                maxValue={max_chrono_age}
                onEnter={(value) =>
                  act('edit_field', {
                    crew_ref: crew_ref,
                    field: 'chrono_age',
                    value: value,
                  })
                }
                value={chrono_age}
              />
            </LabeledList.Item>
            {/* SKYRAT EDIT ADDITION END */}
            <LabeledList.Item label="Species">
              <EditableText
                field="species"
                target_ref={crew_ref}
                text={species}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Gender">
              <EditableText
                field="gender"
                target_ref={crew_ref}
                text={gender}
              />
            </LabeledList.Item>
            <LabeledList.Item color="good" label="Fingerprint">
              <EditableText
                color="good"
                field="fingerprint"
                target_ref={crew_ref}
                text={fingerprint}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Voice">
              <EditableText field="voice" target_ref={crew_ref} text={voice} />
            </LabeledList.Item>
            <LabeledList.Item label="Note">
              <EditableText
                field="security_note"
                target_ref={crew_ref}
                text={note}
              />
            </LabeledList.Item>
            {/* SKYRAT EDIT START - RP Records (Not pretty but it's there) */}
            <LabeledList.Item label="General Records">
              <Box maxWidth="100%" preserveWhitespace>
                {past_general_records || 'N/A'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Past Security Records">
              <Box maxWidth="100%" preserveWhitespace>
                {past_security_records || 'N/A'}
              </Box>
            </LabeledList.Item>
            {/* SKYRAT EDIT END */}
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
