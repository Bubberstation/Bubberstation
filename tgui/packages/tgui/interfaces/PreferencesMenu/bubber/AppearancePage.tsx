import { useState } from 'react';
import { useBackend } from '../../../backend';
import { PreferencesMenuData } from '../data';
import { Stack } from '../../../components';
import { ServerPreferencesFetcher } from '../ServerPreferencesFetcher';
import { BubberPrefStack } from './BubberPrefStack';

export const AppearancePage = (props) => {
  const { act, data } = useBackend<PreferencesMenuData>();

  return (
    <ServerPreferencesFetcher
      render={(serverData) => {
        return (
          <BubberPrefStack category="appearance" serverData={serverData} />
        );
      }}
    />
  );
};
