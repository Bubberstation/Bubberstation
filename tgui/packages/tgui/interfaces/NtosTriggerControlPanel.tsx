import { Button, LabeledList, NoticeBox, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

enum TriggerType {
  BUTTON = 'button',
  TOGGLE = 'toggle',
  SWITCH = 'switch',
}

type TriggerAction = {
  name?: string;
  key: string;
  trigger_type: TriggerType;
  del_on_use: BooleanLike;
  active?: BooleanLike;
};

export const NtosTriggerControlPanel = () => {
  const { act, data } = useBackend<{ actions: TriggerAction[] }>();
  const { actions = [] } = data;

  const handleButton = (key: string, del_on_use: BooleanLike) => {
    act('on_action_press', { action_key: key });
    if (del_on_use) {
    }
  };

  const handleToggle = (key: string, checked: boolean) => {
    act('on_action_toggle', { action_key: key, value: checked });
  };

  if (!actions.length) {
    return (
      <NtosWindow title="Trigger Panel" width={500} height={480}>
        <NtosWindow.Content>
          <NoticeBox>No available controls</NoticeBox>
        </NtosWindow.Content>
      </NtosWindow>
    );
  }

  return (
    <NtosWindow title="Trigger Panel" width={500} height={600}>
      <NtosWindow.Content scrollable>
        <Section title="Controls">
          <LabeledList>
            {actions.map((action) => {
              const label = action.name || action.key;

              switch (action.trigger_type) {
                case TriggerType.BUTTON:
                  return (
                    <LabeledList.Item key={action.key} label={label}>
                      <Button
                        color={action.del_on_use ? 'red' : 'default'}
                        onClick={() =>
                          handleButton(action.key, action.del_on_use)
                        }
                      >
                        Activate
                      </Button>
                    </LabeledList.Item>
                  );

                case TriggerType.TOGGLE:
                case TriggerType.SWITCH:
                  return (
                    <LabeledList.Item key={action.key} label={label}>
                      <Button.Checkbox
                        onClick={(value) => handleToggle(action.key, value)}
                      >
                        {action.active ? 'ON' : 'OFF'}
                      </Button.Checkbox>
                    </LabeledList.Item>
                  );

                default:
                  return null;
              }
            })}
          </LabeledList>
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
