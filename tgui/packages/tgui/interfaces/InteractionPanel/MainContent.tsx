// THIS IS A BUBBER UI FILE

import { useState } from 'react';
import {
  Button,
  Icon,
  Input,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../../backend';

type Interaction = {
  erp_interaction: BooleanLike;
};

import { InteractionsTab, LewdItemsTab } from './tabs';

export const MainContent = () => {
  const [searchText, setSearchText] = useState('');
  const [tabIndex, setTabIndex] = useState(0);
  const [showCategories, setShowCategories] = useState(true);
  const { data } = useBackend<Interaction>();
  const { erp_interaction } = data;
  const placeholder =
    tabIndex === 0
      ? 'Search for an interaction'
      : tabIndex === 1
        ? 'Search for an item'
        : 'Searching is unavailable for this tab';

  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item>
          <Tabs fluid textAlign="center">
            <Tabs.Tab selected={tabIndex === 0} onClick={() => setTabIndex(0)}>
              Interactions
            </Tabs.Tab>
            {erp_interaction && (
              <Tabs.Tab
                selected={tabIndex === 1}
                onClick={() => setTabIndex(1)}
              >
                Lewd Items
              </Tabs.Tab>
            )}
          </Tabs>
        </Stack.Item>
        <Stack.Item>
          <Stack align="baseline" fill>
            <Stack.Item>
              <Icon name="search" />
            </Stack.Item>
            <Stack.Item grow>
              <Input
                fluid
                value={searchText}
                placeholder={placeholder}
                onChange={(value) => setSearchText(value)}
              />
            </Stack.Item>
            {tabIndex === 0 && (
              <Stack.Item>
                <Button
                  icon={showCategories ? 'folder' : 'list'}
                  color="green"
                  tooltip={
                    showCategories ? 'Hide Categories' : 'Show Categories'
                  }
                  onClick={() => setShowCategories(!showCategories)}
                />
              </Stack.Item>
            )}
          </Stack>
        </Stack.Item>
        <Stack.Item grow mb={-1.6}>
          <Section fill>
            {tabIndex === 1 ? (
              <LewdItemsTab searchText={searchText} />
            ) : (
              <InteractionsTab
                searchText={searchText}
                showCategories={showCategories}
              />
            )}
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
