import { Box, Button, Section, Stack, Tooltip } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { PreferencesMenuData } from './types';

export const KnownLanguage = (props) => {
  const { act } = useBackend<PreferencesMenuData>();
  return (
    <Stack.Item>
      <Section
        title={
          <Tooltip
            content={
              <>
                <div>Spoken? {props.language.can_speak ? 'Yes' : 'No'}</div>
                <div>
                  Understood? {props.language.can_understand ? 'Yes' : 'No'}
                </div>
              </>
            }
          >
            <Box as="span">
              {props.language.name}{' '}
              <Button
                color="bad"
                onClick={() =>
                  act('remove_language', { language_name: props.language.name })
                }
              >
                Forget{' '}
                <Box className={`languages16x16 ${props.language.icon}`} />
              </Button>
            </Box>
          </Tooltip>
        }
      >
        {props.language.description}
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
      <Section
        title={
          <>
            {language.name}{' '}
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
          </>
        }
      >
        {language.description}
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
      <Stack.Item minWidth="50%" style={{ marginRight: '4px' }}>
        <Box style={{ maxHeight: '80vh', overflowY: 'auto' }}>
          <Section
            style={{
              position: 'sticky',
              top: 0,
              zIndex: 1,
            }}
            title={`Available Languages (${remaining} remaining)`}
          />
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
        </Box>
      </Stack.Item>
      <Stack.Item minWidth="50%">
        <Box style={{ maxHeight: '80vh', overflowY: 'auto' }}>
          <Section
            style={{
              position: 'sticky',
              top: 0,
              zIndex: 1,
            }}
            title={`Known Languages (${currentCount} of ${maxAllowed})`}
          >
            {isAtLimit && (
              <Box color="bad" mt={1}>
                You have reached the maximum number of languages.
              </Box>
            )}
          </Section>
          <Stack vertical>
            {data.selected_languages.map((val) => (
              <KnownLanguage key={val.icon} language={val} />
            ))}
          </Stack>
        </Box>
      </Stack.Item>
    </Stack>
  );
};
