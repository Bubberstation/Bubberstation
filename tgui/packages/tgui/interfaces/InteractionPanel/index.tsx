// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Modal,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend, useLocalState } from '../../backend';
import { Window } from '../../layouts';
import { ManageSelfModal } from '../RpPanel/ManageSelfModal';
import { SCENE_THEMES, sceneTheme } from '../RpPanel/themes';
import type { SelfData, StatusTag } from '../RpPanel/types';
import { InfoSection } from './InfoSection';
import { MainContent } from './MainContent';

type Interaction = {
  self: string;
  theme: string;
  ref_self: string;
  characters: { name: string; ref: string }[];
  self_data: SelfData;
  profile: {
    name: string;
    headshot: string;
    details: string[];
    tags: StatusTag[];
  };
  erp_interaction: BooleanLike;
};

export function InteractionPanel() {
  const { act, data } = useBackend<Interaction>();
  const { self, self_data, profile, erp_interaction } = data;
  const [modal, setModal] = useState<'options' | 'self' | null>(null);
  const theme = data.theme || 'default';
  const [showPortrait, setShowPortrait] = useLocalState(
    'interactionPortrait',
    true,
  );
  const [textSize, setTextSize] = useLocalState('interactionTextSize', '100%');

  return (
    <Window
      width={500}
      height={700}
      theme={sceneTheme(theme)}
      title={`Interact - ${self}`}
    >
      <Window.Content scrollable>
        {modal === 'self' && (
          <ManageSelfModal
            selfData={self_data}
            width="440px"
            onClose={() => setModal(null)}
          />
        )}
        {modal === 'options' && (
          <Modal>
            <Section title="Interaction Menu Options" width="360px">
              <Box mb={1}>Theme</Box>
              <Dropdown
                selected={theme}
                displayText={
                  SCENE_THEMES.find((entry) => entry.id === theme)?.label ??
                  'Scene Assistant'
                }
                options={SCENE_THEMES.map((entry) => ({
                  displayText: entry.label,
                  value: entry.id,
                }))}
                onSelected={(theme) => act('set_theme', { theme })}
              />
              <Box my={1}>
                <Button.Checkbox
                  checked={showPortrait}
                  onClick={() => setShowPortrait(!showPortrait)}
                >
                  Show Portrait
                </Button.Checkbox>
              </Box>
              <Box mb={1}>Text Size</Box>
              <Dropdown
                selected={textSize}
                options={['90%', '100%', '110%', '125%']}
                onSelected={setTextSize}
              />
              <Button fluid mt={1} onClick={() => setModal(null)}>
                Close
              </Button>
            </Section>
          </Modal>
        )}
        <Box style={{ fontSize: textSize }}>
          <Section>
            <Stack>
              {showPortrait && (
                <Stack.Item>
                  {profile.headshot ? (
                    <img
                      src={profile.headshot}
                      alt={`${profile.name} portrait`}
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
              )}
              <Stack.Item grow>
                <Box bold mb={0.5}>
                  {profile.name}
                </Box>
                {(Array.isArray(profile.details) ? profile.details : []).map(
                  (line) => (
                    <Box key={line} color="label" fontSize="0.85em">
                      {line}
                    </Box>
                  ),
                )}
              </Stack.Item>
            </Stack>
            <Box mt={0.75}>
              {(Array.isArray(profile.tags) ? profile.tags : []).map((tag) => (
                <Box key={tag.label} inline mr={1} fontSize="0.8em">
                  <Box inline color="label">
                    {tag.label}:
                  </Box>{' '}
                  {tag.value}
                </Box>
              ))}
            </Box>
            <Button
              fluid
              mt={0.75}
              icon="search"
              onClick={() => act('open_examine')}
            >
              Examine
            </Button>
          </Section>
          <Box mb={0.5}>
            <Dropdown
              width="100%"
              selected={data.ref_self}
              displayText={self}
              options={(Array.isArray(data.characters)
                ? data.characters
                : []
              ).map((person) => ({
                displayText: person.name,
                value: person.ref,
              }))}
              onSelected={(ref) => act('set_selected', { ref })}
            />
          </Box>
          <Stack mb={1}>
            <Stack.Item grow>
              <Button fluid icon="gear" onClick={() => setModal('options')}>
                Options
              </Button>
            </Stack.Item>
            <Stack.Item grow>
              <Button fluid onClick={() => setModal('self')}>
                Manage Self
              </Button>
            </Stack.Item>
          </Stack>
          {erp_interaction && (
            <Section>
              <Stack vertical fill>
                <Stack.Item grow>
                  <InfoSection />
                </Stack.Item>
              </Stack>
            </Section>
          )}

          <Stack>
            <Stack.Item grow>
              <MainContent />
            </Stack.Item>
          </Stack>
        </Box>
      </Window.Content>
    </Window>
  );
}
