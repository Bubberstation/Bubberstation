import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  Dropdown,
  Flex,
  Icon,
  Input,
  LabeledList,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import * as types from './types';

export const Savefile = (props: {
  setTab: React.Dispatch<React.SetStateAction<number>>;
}) => {
  const { act, data } = useBackend<types.Data>();
  const { setTab } = props;
  const [editing, setEditing] = useState(false);

  return (
    <Flex align="center" justify="center" height="100%">
      <Flex.Item width={40}>
        <LabeledList>
          <LabeledList.Item
            label="Currently Loaded Belly Slot"
            buttons={
              <Button
                selected={editing}
                onClick={() => setEditing(!editing)}
                disabled={data.not_our_owner}
              >
                <Icon name="pencil" />
              </Button>
            }
          >
            {editing && !data.not_our_owner ? (
              <Input
                width={21}
                value={data.current_slot}
                onChange={(e, name) => act('set_slot_name', { name })}
              />
            ) : (
              data.current_slot
            )}
          </LabeledList.Item>
        </LabeledList>
        <Stack vertical width={40} mt={4}>
          <Stack.Item>
            <Stack>
              <Stack.Item grow>
                <Stack vertical>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="tasks"
                      onClick={() => {
                        act('load_slot');
                        setTab(0);
                      }}
                      disabled={data.not_our_owner}
                    >
                      Load Slot
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="upload"
                      onClick={() => act('import_bellies')}
                    >
                      Import
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item grow>
                <Stack vertical>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="copy"
                      onClick={() => act('copy_to_slot')}
                      disabled={data.not_our_owner}
                    >
                      Copy To Slot
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="download"
                      onClick={() => act('export_bellies')}
                      disabled={data.not_our_owner}
                    >
                      Export
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Button
              fluid
              icon="cloud-download-alt"
              onClick={() => act('belly_backups')}
              disabled={data.not_our_owner}
            >
              Download Backup
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button
              fluid
              icon="magnifying-glass"
              onClick={() => act('toggle_lookup_data')}
              disabled={data.not_our_owner}
            >
              Associate Character Slots with Belly Layouts
            </Button>
          </Stack.Item>
        </Stack>
      </Flex.Item>
    </Flex>
  );
};

export const SlotLookupTable = (props) => {
  const { act, data } = useBackend<types.Data>();
  const { character_slots, vore_slots, lookup_table } = data;

  if (!character_slots || !vore_slots || !lookup_table) {
    return <Box>CRITICAL ERROR</Box>;
  }

  const pickable_vore_slots = Object.keys(vore_slots).map(
    (displayText, value) => {
      return { displayText, value };
    },
  );

  const pickable_character_slots = character_slots
    .map((key, index) => {
      return {
        displayText: key || `New Slot (${index + 1})`,
        value: index + 1,
      };
    })
    .filter((value) => !(value.value in lookup_table));

  const [editingRow, setEditingRow] = useState<string | null>(null);
  const [cSlot, setCSlot] = useState<number | null>(null);
  const [vSlot, setVSlot] = useState<number | null>(null);

  return (
    <Section
      title="Character-Layout Associations"
      buttons={
        <>
          <Button
            color="green"
            tooltip={
              <Box italic mb={1}>
                To associate a belly slot with a character, click New, then pick
                the character you want, and the belly slot you want that
                character to automatically load.
              </Box>
            }
          >
            <Icon name="question" />
          </Button>
          <Button color="bad" onClick={() => act('toggle_lookup_data')}>
            <Icon name="window-close-o" />
          </Button>
        </>
      }
      fill
      scrollable
    >
      <Table>
        <Table.Row header>
          <Table.Cell width={15} header collapsing>
            Character Name
          </Table.Cell>
          <Table.Cell width={15} header collapsing>
            Belly Slot
          </Table.Cell>
          <Table.Cell header collapsing />
          <Table.Cell header />
        </Table.Row>
        {!!lookup_table &&
          Object.entries(lookup_table).map(([k, v]) => (
            <Table.Row key={k}>
              <Table.Cell width={15} collapsing verticalAlign="middle">
                {character_slots[parseInt(k, 10) - 1] || `New Slot (${k})`}
              </Table.Cell>
              <Table.Cell width={15} collapsing verticalAlign="middle">
                {editingRow === k ? (
                  <Dropdown
                    options={pickable_vore_slots}
                    selected={vSlot as any}
                    displayText={
                      <Box>
                        {pickable_vore_slots.find((x) => x.value === vSlot)
                          ?.displayText || 'None'}
                      </Box>
                    }
                    onSelected={(value) => setVSlot(value)}
                  />
                ) : (
                  pickable_vore_slots.find((p) => p.value === v)?.displayText
                )}
              </Table.Cell>
              <Table.Cell collapsing verticalAlign="middle">
                <Button
                  icon="pencil"
                  onClick={() => {
                    if (k === editingRow) {
                      setEditingRow(null);
                    } else {
                      setEditingRow(k);
                    }
                    setCSlot(parseInt(k, 10));
                    setVSlot(v);
                  }}
                  color={k === editingRow ? 'bad' : ''}
                >
                  {k === editingRow ? 'Cancel' : 'Edit'}
                </Button>
              </Table.Cell>
              <Table.Cell collapsing verticalAlign="middle">
                {k === editingRow ? (
                  <Button
                    fluid
                    icon="save"
                    color="good"
                    disabled={cSlot === null || vSlot === null}
                    onClick={() => {
                      setEditingRow(null);
                      act('set_lookup_table_entry', {
                        from: cSlot,
                        to: vSlot,
                      });
                    }}
                  >
                    Save
                  </Button>
                ) : (
                  <Button.Confirm
                    fluid
                    color="bad"
                    icon="trash"
                    onClick={() =>
                      act('delete_lookup_table_entry', { slot_to_delete: k })
                    }
                  >
                    Delete
                  </Button.Confirm>
                )}
              </Table.Cell>
              <Table.Cell />
            </Table.Row>
          ))}
        {editingRow === 'new' && (
          <Table.Row>
            <Table.Cell width={15} collapsing verticalAlign="middle">
              <Dropdown
                options={pickable_character_slots}
                selected={cSlot as any}
                displayText={
                  <Box>
                    {pickable_character_slots.find((x) => x.value === cSlot)
                      ?.displayText || 'None'}
                  </Box>
                }
                onSelected={(value) => setCSlot(value)}
              />
            </Table.Cell>
            <Table.Cell width={15} collapsing verticalAlign="middle">
              <Dropdown
                options={pickable_vore_slots}
                selected={vSlot as any}
                displayText={
                  <Box>
                    {pickable_vore_slots.find((x) => x.value === vSlot)
                      ?.displayText || 'None'}
                  </Box>
                }
                onSelected={(value) => setVSlot(value)}
              />
            </Table.Cell>
            <Table.Cell collapsing verticalAlign="middle">
              <Button
                fluid
                icon="plus"
                color="good"
                disabled={vSlot === null || cSlot === null}
                onClick={() => {
                  act('set_lookup_table_entry', { from: cSlot, to: vSlot });
                  setEditingRow(null);
                }}
              >
                Add
              </Button>
            </Table.Cell>
            <Table.Cell collapsing verticalAlign="middle">
              <Button
                fluid
                icon="times"
                color="bad"
                onClick={() => {
                  setEditingRow(null);
                }}
              >
                Cancel
              </Button>
            </Table.Cell>
            <Table.Cell />
          </Table.Row>
        )}
      </Table>
      <Button
        selected={editingRow === 'new'}
        onClick={() => {
          if (editingRow === 'new') {
            setEditingRow(null);
          } else {
            setEditingRow('new');
          }
          setCSlot(null);
          setVSlot(null);
        }}
        mt={1}
        icon="plus"
      >
        New
      </Button>
    </Section>
  );
};
