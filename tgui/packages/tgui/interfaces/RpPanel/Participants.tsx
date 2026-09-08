import { useEffect, useState } from 'react';
import { Box, Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { Person, RpPanelData } from './types';

export function Participants() {
  const { act, data } = useBackend<RpPanelData>();
  const { participants = [], nearby = [], scene_details } = data;
  const [picking, setPicking] = useState<'invite' | 'remove' | null>(null);
  const [details, setDetails] = useState(scene_details || '');

  useEffect(() => {
    setDetails(scene_details || '');
  }, [scene_details]);

  return (
    <Stack fill>
      <Stack.Item basis="38%">
        <Section
          fill
          title="Participants"
          buttons={
            <>
              <Button
                icon="plus"
                tooltip="Invite"
                onClick={() =>
                  setPicking(picking === 'invite' ? null : 'invite')
                }
              />
              <Button
                icon="minus"
                tooltip="Remove"
                onClick={() =>
                  setPicking(picking === 'remove' ? null : 'remove')
                }
              />
            </>
          }
        >
          {participants.map((person) => (
            <PersonRow
              key={person.ref}
              person={person}
              onClick={() => act('open_examine', { ref: person.ref })}
            />
          ))}
          {picking === 'invite' && (
            <Box mt={0.75}>
              <Box bold mb={0.3}>
                Nearby
              </Box>
              {!nearby.length && (
                <Box color="label">Nobody in range to invite.</Box>
              )}
              {nearby.map((person) => (
                <PersonRow
                  key={person.ref}
                  person={person}
                  actionLabel="Invite"
                  onAction={() => {
                    act('invite_participant', { ref: person.ref });
                    setPicking(null);
                  }}
                />
              ))}
            </Box>
          )}
          {picking === 'remove' && (
            <Box mt={0.75}>
              {participants
                .filter((person) => !person.is_you)
                .map((person) => (
                  <PersonRow
                    key={person.ref}
                    person={person}
                    actionLabel="Remove"
                    onAction={() => {
                      act('remove_participant', { ref: person.ref });
                      setPicking(null);
                    }}
                  />
                ))}
            </Box>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section fill title="Scene Details">
          <textarea
            className="SceneAssistant__details"
            placeholder="Type anything notable about the environment, positioning or other elements here."
            value={details}
            onChange={(event) => setDetails(event.target.value)}
            onBlur={() => act('set_scene_details', { details })}
          />
        </Section>
      </Stack.Item>
    </Stack>
  );
}

type PersonRowProps = {
  person: Person;
  onClick?: () => void;
  actionLabel?: string;
  onAction?: () => void;
};

function PersonRow(props: PersonRowProps) {
  const { person, onClick, actionLabel, onAction } = props;
  return (
    <Stack>
      <Stack.Item grow>
        <Box
          style={{ color: person.color, cursor: onClick ? 'pointer' : 'default' }}
          onClick={onClick}
        >
          {person.name}
          {person.is_you ? ' (You)' : ''}
        </Box>
      </Stack.Item>
      {!!actionLabel && (
        <Stack.Item>
          <Button onClick={onAction}>{actionLabel}</Button>
        </Stack.Item>
      )}
    </Stack>
  );
}
