/// BUBBER UI FILE

import { MODsuitContent } from './MODsuit';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Icon, LabeledList, Modal, Section, Input } from 'tgui-core/components';
import { useState } from 'react';

type Data = {
  ui_theme?: string;
  linked_suit?: boolean;
  wearer?: boolean;
  erp_pref_check?: boolean;
};
export const MODsuitremote = (props) => {
  const { data } = useBackend<Data>();
  const { ui_theme } = data;
  return (
    <Window
      theme={ui_theme}
      width={600}
      height={600}
      title="MOD Remote Interface"
    >
      <Window.Content scrollable>
        <RemoteMODsuitContent />
      </Window.Content>
    </Window>
  );
};

const RemoteSection = (props) => {
  const { act, data } = useBackend<Data>();
  const { erp_pref_check } = data;
  const [emote, setEmote] = useState('');
  return (
    <Section title="Remote Control">
      <LabeledList>
        <LabeledList.Item label="Force Emote">
          <Input
            fluid
            selfClear
            onChange={setEmote}
            disabled={!erp_pref_check}
            onEnter={() => act('emote', { emote: emote })}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
const RemoteMODsuitContent = (props) => {
  const { data } = useBackend<Data>();
  const { linked_suit, wearer } = data;
  if (!linked_suit) {
    return (
      <Modal>
        <center>
          <Icon size={5} name="triangle-exclamation" />
        </center>
        <br />
        Not installed
      </Modal>
    );
  }
  if (!wearer) {
    return (
      <Modal>
        <center>
          <Icon size={5} name="triangle-exclamation" />
        </center>
        <br />
        MODsuit Not Worn
      </Modal>
    );
  }
  return (
    <>
      <RemoteSection />
      <MODsuitContent />
    </>
  );
};
