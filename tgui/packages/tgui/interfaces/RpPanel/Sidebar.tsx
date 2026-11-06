import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Dropdown,
  Icon,
  Input,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { asArray, type RpPanelData } from './types';

type SidebarProps = {
  onOpenSettings: () => void;
  onOpenManageSelf: () => void;
};

export function Sidebar(props: SidebarProps) {
  const { act, data } = useBackend<RpPanelData>();
  const { onOpenSettings, onOpenManageSelf } = props;
  const { target, selected_ref, self, arousal_limit } = data;
  const participants = asArray(data.participants);
  const [tab, setTab] = useState(0);
  const [search, setSearch] = useState('');
  const showErp = !!target?.show_erp;
  const activeTab = showErp ? tab : 0;
  const searchLower = search.toLowerCase();
  if (!target) {
    return null;
  }

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <Stack>
            <Stack.Item>
              {target.headshot ? (
                <img
                  src={target.headshot}
                  width={96}
                  height={96}
                  style={{ objectFit: 'cover', borderRadius: '4px' }}
                />
              ) : (
                <Box
                  width="96px"
                  height="96px"
                  backgroundColor="rgba(0,0,0,0.4)"
                  textAlign="center"
                  pt={5}
                  color="label"
                >
                  No headshot
                </Box>
              )}
            </Stack.Item>
            <Stack.Item grow>
              <Box bold mb={0.5}>
                {target.name}
              </Box>
              {asArray(target.details).map((line) => (
                <Box key={line} color="label" fontSize="0.85em">
                  {line}
                </Box>
              ))}
            </Stack.Item>
          </Stack>
          <Box mt={0.75}>
            {asArray(target.tags).map((tag) => (
              <Box key={tag.label} inline mr={1} fontSize="0.8em">
                <Box inline color="label">
                  {tag.label}:
                </Box>{' '}
                {tag.value}
              </Box>
            ))}
          </Box>
          <Stack mt={0.75}>
            <Stack.Item grow>
              <Button
                fluid
                icon="search"
                onClick={() => act('open_examine', { ref: target.ref })}
              >
                Examine
              </Button>
            </Stack.Item>
            {!!target.has_reference && (
              <Stack.Item grow>
                <Button fluid icon="image" onClick={() => act('open_reference')}>
                  Reference
                </Button>
              </Stack.Item>
            )}
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <DropdownSelect
          selected={selected_ref}
          people={participants}
          onSelect={(ref) => act('set_selected', { ref })}
        />
        <Stack mt={0.5}>
          <Stack.Item grow>
            <Button fluid icon="gear" onClick={onOpenSettings}>
              Options
            </Button>
          </Stack.Item>
          <Stack.Item grow>
            <Button fluid onClick={onOpenManageSelf}>
              Manage Self
            </Button>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      {!!target.show_erp && (
        <Stack.Item>
          <Stack>
            <Stack.Item grow>
              <Button
                fluid
                color={self?.autocum ? 'good' : 'default'}
                onClick={() => act('toggle_autocum')}
              >
                Auto-climax: {self?.autocum ? 'Enabled' : 'Disabled'}
              </Button>
            </Stack.Item>
            <Stack.Item grow>
              <Button fluid color="pink" icon="heart" onClick={() => act('trigger_climax')}>
                Climax
              </Button>
            </Stack.Item>
          </Stack>
          <Stack mt={0.5}>
            <Stack.Item grow>
              <StatColumn
                name={target.your_name || ''}
                pleasure={target.pleasure || 0}
                arousal={target.arousal || 0}
                pain={target.pain || 0}
                max={arousal_limit}
              />
            </Stack.Item>
            {!!target.their_name && (
              <Stack.Item grow>
                <StatColumn
                  name={target.their_name}
                  pleasure={target.their_pleasure || 0}
                  arousal={target.their_arousal || 0}
                  pain={target.their_pain || 0}
                  max={arousal_limit}
                />
              </Stack.Item>
            )}
          </Stack>
        </Stack.Item>
      )}
      <Stack.Item grow>
        <Section fill>
          <Tabs>
            <Tabs.Tab selected={activeTab === 0} onClick={() => setTab(0)}>
              Interactions
            </Tabs.Tab>
            {!!showErp && (
              <Tabs.Tab selected={activeTab === 1} onClick={() => setTab(1)}>
                Lewd Items
              </Tabs.Tab>
            )}
          </Tabs>
          <Input
            fluid
            expensive
            placeholder="Search for an interaction."
            value={search}
            onChange={setSearch}
          />
          {activeTab === 0 ? (
            <Box mt={0.5}>
              <NoticeBox>
                {target.block_interact ? 'Unable to Interact' : 'Able to Interact'}
              </NoticeBox>
              {asArray(target.categories).map((category) => {
                const verbs = asArray(target.interactions?.[category]).filter(
                  (name) => name.toLowerCase().includes(searchLower),
                );
                if (!verbs.length) {
                  return null;
                }
                return (
                  <Collapsible
                    key={category}
                    title={`${category} (${verbs.length} interactions)`}
                  >
                    {verbs.map((name) => (
                      <Button
                        key={name}
                        m={0.2}
                        disabled={!!target.block_interact}
                        color={target.block_interact ? 'grey' : target.colors[name]}
                        tooltip={target.descriptions[name]}
                        onClick={() => act('trigger_interaction', { interaction: name })}
                      >
                        {name}
                      </Button>
                    ))}
                  </Collapsible>
                );
              })}
            </Box>
          ) : (
            <Box mt={0.5}>
              {asArray(target.lewd_slots)
                .filter(
                  (slot) =>
                    slot?.name?.toLowerCase().includes(searchLower),
                )
                .map((slot) => (
                  <Button
                    key={slot.name}
                    color="pink"
                    m={0.3}
                    tooltip={slot.name}
                    onClick={() => act('remove_lewd_item', { item_slot: slot.name })}
                  >
                    {slot.img ? (
                      <img
                        src={`data:image/png;base64,${slot.img}`}
                        width={32}
                        height={32}
                      />
                    ) : (
                      <Icon name="eye-slash" />
                    )}
                  </Button>
                ))}
            </Box>
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
}

type StatColumnProps = {
  name: string;
  pleasure: number;
  arousal: number;
  pain: number;
  max: number;
};

function StatColumn(props: StatColumnProps) {
  return (
    <Box>
      <Box mb={0.3}>{props.name}</Box>
      <ProgressBar value={props.pleasure} maxValue={props.max} color="purple">
        <Icon name="heart" /> Pleasure
      </ProgressBar>
      <ProgressBar value={props.arousal} maxValue={props.max} color="pink" mt={0.3}>
        <Icon name="tint" /> Arousal
      </ProgressBar>
      <ProgressBar value={props.pain} maxValue={props.max} color="yellow" mt={0.3}>
        <Icon name="bolt" /> Pain
      </ProgressBar>
    </Box>
  );
}

type DropdownSelectProps = {
  selected: string;
  people: { name: string; ref: string }[];
  onSelect: (ref: string) => void;
};

function DropdownSelect(props: DropdownSelectProps) {
  const selectedRef = props.selected || props.people[0]?.ref || '';
  const selectedPerson =
    props.people.find((person) => person.ref === selectedRef) ||
    props.people[0];
  return (
    <Dropdown
      width="100%"
      selected={selectedRef}
      displayText={selectedPerson?.name || 'Select...'}
      options={props.people.map((person) => ({
        displayText: person.name,
        value: person.ref,
      }))}
      onSelected={(ref: string) => {
        if (ref) {
          props.onSelect(ref);
        }
      }}
    />
  );
}
