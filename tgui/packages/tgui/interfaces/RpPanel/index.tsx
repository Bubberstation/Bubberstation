import { useState } from 'react';
import { Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { ManageSelfModal } from './ManageSelfModal';
import { Participants } from './Participants';
import { SceneLog } from './SceneLog';
import { SettingsModal } from './SettingsModal';
import { Sidebar } from './Sidebar';
import { sceneTheme } from './themes';
import type { RpPanelData } from './types';

export function RpPanel() {
  const { act, data } = useBackend<RpPanelData>();
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [manageSelfOpen, setManageSelfOpen] = useState(false);
  const theme = sceneTheme(data.settings?.theme || 'default');

  return (
    <Window title="Scene Assistant" width={1180} height={740} theme={theme}>
      <Window.Content
        fitted
        className="SceneAssistant"
        onMouseDown={(event) => {
          event.stopPropagation();
        }}
      >
        <Stack fill>
          <Stack.Item basis="340px" className="SceneAssistant__sidebar">
            <Sidebar
              onOpenSettings={() => setSettingsOpen(true)}
              onOpenManageSelf={() => setManageSelfOpen(true)}
            />
          </Stack.Item>
          <Stack.Item grow className="SceneAssistant__main">
            <Stack fill vertical>
              <Stack.Item basis="160px" className="SceneAssistant__header">
                <Participants />
              </Stack.Item>
              <Stack.Item grow className="SceneAssistant__logColumn">
                <SceneLog onExamine={(ref) => act('open_examine', { ref })} />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
        {!!settingsOpen && (
          <SettingsModal onClose={() => setSettingsOpen(false)} />
        )}
        {!!manageSelfOpen && (
          <ManageSelfModal onClose={() => setManageSelfOpen(false)} />
        )}
      </Window.Content>
    </Window>
  );
}
