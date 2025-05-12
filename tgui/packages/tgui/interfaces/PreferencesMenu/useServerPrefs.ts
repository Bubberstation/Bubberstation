import { createContext, useContext } from 'react';

import { ServerData } from './types';

export const ServerPrefs = createContext<ServerData | undefined>({
  jobs: {
    departments: {},
    jobs: {},
  },
  names: {
    types: {},
  },
  quirks: {
    max_positive_quirks: -1,
    quirk_info: {},
    quirk_blacklist: [],
    points_enabled: false,
  },
  random: {
    randomizable: [],
  },
  loadout: {
    loadout_tabs: [],
  },
  species: {},
  background_state: {
    /* BUBBER EDIT ADDITION: Background Selection - LINES 26 - 29 */
    choices: [],
  },
});
export function useServerPrefs() {
  return useContext(ServerPrefs);
}
