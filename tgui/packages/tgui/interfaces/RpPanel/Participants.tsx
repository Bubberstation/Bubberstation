import { useEffect, useState } from 'react';
import { Box, Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { asArray, type Person, type RpPanelData } from './types';

export function Participants() {
  const { act, data } = useBackend<RpPanelData>();
  const { scene_details } = data;
  const participants = asArray(data.participants);
  const nearby = asArray(data.nearby);
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
                selected={picking === 'invite'}
                onClick={() => {
                  const next = picking === 'invite' ? null : 'invite';
                  setPicking(next);
                  if (next) {
                    act('refresh_roster');
                  }
                }}
              />
              <Button
                icon="minus"
                tooltip="Remove"
                selected={picking === 'remove'}
                onClick={() => {
                  const next = picking === 'remove' ? null : 'remove';
                  setPicking(next);
                  if (next) {
                    act('refresh_roster');
                  }
                }}
              />
              {participants.length > 1 && (
                <Button
                  icon="sign-out-alt"
                  color="bad"
                  tooltip="Leave scene"
                  onClick={() => act('leave_scene')}
                >
                  Leave
                </Button>
              )}
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
            onKeyDown={(event) => {
              if (event.key !== 'Enter' || event.shiftKey) {
                return;
              }
              event.preventDefault();
              act('set_scene_details', { details });
            }}
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
          style={{
            color: person.inactive ? undefined : person.color,
            cursor: onClick ? 'pointer' : 'default',
            opacity: person.inactive ? 0.65 : 1,
          }}
          color={person.inactive ? 'label' : undefined}
          onClick={onClick}
        >
          {person.name}
          {person.is_you ? ' (You)' : ''}
          {!!person.inactive ? ' (Inactive)' : ''}
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
