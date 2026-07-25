// THIS IS A BUBBER UI FILE
import { useMemo } from 'react';
import {
  Box,
  Button,
  Collapsible,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../../../backend';

type Interaction = {
  categories: string[];
  interactions: Record<string, string[]>;
  descriptions: Record<string, string>;
  colors: Record<string, string>;
  self: string;
  ref_self: string;
  ref_user: string;
  block_interact: BooleanLike;
};

type InteractionsTabProps = {
  searchText: string;
  showCategories: boolean;
};

export const InteractionsTab = (props: InteractionsTabProps) => {
  const { act, data } = useBackend<Interaction>();
  const {
    categories = [],
    interactions = {},
    descriptions = {},
    colors = {},
    ref_self,
    ref_user,
    block_interact,
  } = data;
  const { searchText, showCategories } = props;

  const searchLower = searchText.toLowerCase();

  const renderInteractionButton = (interaction: string) => {
    return (
      <Button
        key={interaction}
        width="150px"
        lineHeight={1.75}
        disabled={block_interact}
        color={block_interact ? 'grey' : colors[interaction]}
        tooltip={
          block_interact
            ? 'You cannot interact right now'
            : descriptions[interaction]
        }
        icon="exclamation-circle"
        onClick={() =>
          act('interact', {
            interaction: interaction,
            selfref: ref_self,
            userref: ref_user,
          })
        }
      >
        {interaction}
      </Button>
    );
  };

  const filterInteractions = (category: string) => {
    let categoryInteractions = interactions[category] || [];
    if (searchText) {
      categoryInteractions = categoryInteractions.filter((interaction) =>
        interaction.toLowerCase().includes(searchLower),
      );
    }
    return categoryInteractions;
  };

  const allInteractions = useMemo(() => {
    return categories.flatMap((category) =>
      filterInteractions(category).map((interaction) => ({
        name: interaction,
        category,
      })),
    );
  }, [categories, searchLower]);

  return (
    <Stack fill vertical>
      <NoticeBox>
        {block_interact ? 'Unable to Interact' : 'Able to Interact'}
      </NoticeBox>
      <Stack.Item grow>
        {showCategories ? (
          categories.map((category) => {
            const filteredInteractions = filterInteractions(category);
            if (filteredInteractions.length === 0) return null;
            return (
              <Collapsible
                key={category}
                title={category}
                buttons={
                  <Box inline color="grey" fontSize={0.9}>
                    {filteredInteractions.length}
                    {' interactions'}
                  </Box>
                }
              >
                <Section fill>
                  <Box mt={0.2}>
                    {filteredInteractions.map((interaction) =>
                      renderInteractionButton(interaction),
                    )}
                  </Box>
                </Section>
              </Collapsible>
            );
          })
        ) : (
          <Section fill>
            <Box mt={0.2}>
              {allInteractions.map(({ name, category }) =>
                renderInteractionButton(name),
              )}
            </Box>
          </Section>
        )}
      </Stack.Item>
    </Stack>
  );
};
