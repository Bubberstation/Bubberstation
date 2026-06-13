// THIS IS A BUBBER UI FILE
import { useState } from 'react';
import { Button, Section } from 'tgui-core/components';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import type { NifPanelData } from './data';
import { NifProductInfo } from './NifProductInfo';
import { NifProgramList } from './NifProgramList';
import { NifSettings } from './NifSettings';
import { NifStats } from './NifStats';

export function NifPanel() {
  const { data } = useBackend<NifPanelData>();
  const { linked_mob_name, current_theme } = data;
  const [settingsOpen, setSettingsOpen] = useState(false);

  return (
    <Window
      title="Nanite Implant Framework"
      width={500}
      height={400}
      theme={current_theme}
    >
      <Window.Content scrollable>
        <Section
          title={`Welcome to your NIF, ${linked_mob_name}`}
          buttons={
            <Button
              icon="cogs"
              tooltip="NIF Settings"
              tooltipPosition="bottom-end"
              selected={settingsOpen}
              onClick={() => setSettingsOpen(!settingsOpen)}
            />
          }
        >
          {settingsOpen ? <NifSettings /> : <NifStats />}
        </Section>
        {!settingsOpen ? <NifProgramList /> : <NifProductInfo />}
      </Window.Content>
    </Window>
  );
}
