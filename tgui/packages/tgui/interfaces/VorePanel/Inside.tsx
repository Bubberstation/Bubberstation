import { useBackend } from 'tgui/backend';
import { Box, Collapsible, Section } from 'tgui-core/components';

import { BellyContents } from './BellyUI';
import * as types from './types';

export const Inside = (props) => {
  const { data } = useBackend<types.Data>();
  const { inside } = data;

  if (!inside) {
    return <Section title="Inside!">You are not inside anyone!</Section>;
  }

  const preyMode = types.digestModeToPreyMode[inside.digest_mode];

  return (
    <Section title="Inside!">
      <Box>
        <Box color="yellow" inline>
          You are currently inside
        </Box>{' '}
        <Box inline color="blue">
          {inside.owner_name || 'someone'}
          &apos;s
        </Box>{' '}
        <Box inline color="red">
          {inside.name}
        </Box>{' '}
        <Box inline color="yellow">
          and you are
        </Box>{' '}
        <Box inline color={preyMode.color}>
          {preyMode.text}
        </Box>
      </Box>
      <Box mb={1} color="label" preserveWhitespace>
        {inside.desc}
      </Box>
      {inside.contents.length ? (
        <Collapsible title="Belly Contents">
          <BellyContents contents={inside.contents} />
        </Collapsible>
      ) : (
        'There is nothing else around you.'
      )}
    </Section>
  );
};
