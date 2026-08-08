// THIS IS A NOVA SECTOR UI FILE
import { Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { InfoSection } from './InfoSection';
import { MainContent } from './MainContent';

type Interaction = {
  self;
  erp_interaction: BooleanLike;
};

export function InteractionPanel() {
  const { act, data } = useBackend<Interaction>();
  const { self, erp_interaction } = data;

  return (
    <Window width={500} height={600} title={`Interact - ${self}`}>
      <Window.Content scrollable>
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
      </Window.Content>
    </Window>
  );
}
