import { useBackend } from '../backend';
import { Button, Section } from 'tgui-core/components';
import { Window } from '../layouts';

interface PrivacyPolicyData {
  policy_text: string;
}

export const PrivacyPolicy = () => {
  const { act, data } = useBackend<PrivacyPolicyData>();
  const { policy_text } = data;

  return (
    <Window
      width={600}
      height={500}
      title="Privacy Policy">
      <Window.Content scrollable>
        <Section>
          <div style={{ whiteSpace: 'pre-wrap' }}>
            {policy_text}
          </div>
        </Section>

        <Button
          fluid
          color="good"
          onClick={() => act('accept')}>
          I Agree
        </Button>
      </Window.Content>
    </Window>
  );
};
