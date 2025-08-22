// THIS IS A SKYRAT UI FILE
import { Box, Button, Section, Stack, Tooltip } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { PreferencesMenuData } from './types';

export const KnownLanguage = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <Stack.Item>
      <Section title={props.language.name}>
        {props.language.description}
        <br />
        <br />
        {props.language.can_understand
          ? 'Can understand.'
          : 'Cannot understand.'}{' '}
        {props.language.can_speak ? 'Can speak.' : 'Cannot speak.'}
        <br />
        <Button
          color="bad"
          onClick={() =>
            act('remove_language', { language_name: props.language.name })
          }
        >
          Forget <Box className={`languages16x16 ${props.language.icon}`} />
        </Button>
      </Section>
    </Stack.Item>
  );
};

export const UnknownLanguage = ({ language, isAtLimit, remaining }) => {
  const { act } = useBackend<PreferencesMenuData>();
  const tooltipContent = isAtLimit
    ? "You've reached the maximum number of languages."
    : `You have ${remaining} language${remaining === 1 ? '' : 's'} remaining.`;

  return (
    <Stack.Item>
      <Section title={language.name}>
        {language.description}
        <br />
        <Tooltip content={tooltipContent}>
          <Button
            color="good"
            disabled={isAtLimit}
            onClick={() =>
              !isAtLimit &&
              act('give_language', { language_name: language.name })
            }
          >
            Learn <Box className={`languages16x16 ${language.icon}`} />
          </Button>
        </Tooltip>
      </Section>
    </Stack.Item>
  );
};

export const LanguagesPage = (props) => {
  const { data } = useBackend<PreferencesMenuData>();

  const currentCount = data.selected_languages.length;
  const maxAllowed = data.total_language_points;
  const isAtLimit = currentCount >= maxAllowed;
  const remaining = Math.max(maxAllowed - currentCount, 0);

  return (
    <Stack>
      <Stack.Item minWidth="50%" style={{ marginRight: '6px' }}>
        <Section title={`Available Languages (${remaining} remaining)`}>
          <Stack vertical>
            {data.unselected_languages.map((val) => (
              <UnknownLanguage
                key={val.icon}
                language={val}
                isAtLimit={isAtLimit}
                remaining={remaining}
              />
            ))}
          </Stack>
        </Section>
      </Stack.Item>

      <Stack.Item minWidth="50%">
        <Section title={`Known Languages (${currentCount} of ${maxAllowed})`}>
          {isAtLimit && (
            <Box color="bad" mb={1}>
              You have reached the maximum number of languages.
            </Box>
          )}
          <Stack vertical>
            {data.selected_languages.map((val) => (
              <KnownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
