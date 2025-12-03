import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { NoticeBox, Stack, Button } from 'tgui-core/components'; // BUBBER EDIT CHANGE - ORIGINAL : import { NoticeBox, Stack } from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';

import { SideDropdown } from '../../../bubber_components/SideDropdown'; // BUBBER EDIT ADDITION
import { PageButton } from '../components/PageButton';
import { LanguagesPage } from '../LanguagesMenu'; // BUBBER EDIT ADDITION
import { LimbsPage } from '../LimbsPage'; // BUBBER EDIT ADDITION
import type { PreferencesMenuData } from '../types';
import { AntagsPage } from './AntagsPage';
import { JobsPage } from './JobsPage';
import { LoadoutPage } from './loadout';
import { MainPage } from './MainPage';
import { QuirkPersonalityPage } from './QuirksPage';
import { SpeciesPage } from './SpeciesPage';

enum Page {
  Antags,
  Main,
  Jobs,
  Species,
  Quirks,
  Loadout,
  // BUBBER EDIT ADDITION BEGIN
  Limbs,
  Languages,
  // BUBBER EDIT ADDITION END
}

type ProfileProps = {
  activeSlot: number;
  onClick: (index: number) => void;
  profiles: (string | null)[];
};

function CharacterProfiles(props: ProfileProps) {
  const { activeSlot, onClick, profiles } = props;

  /* BUBBER EDIT CHANGE BEGIN
  return (
    <Stack justify="center" wrap>
      {profiles.map((profile, slot) => (
        <Stack.Item key={slot} mb={1}>
          <Button
            selected={slot === activeSlot}
            onClick={() => {
              onClick(slot);
            }}
            fluid
          >
            {profile ?? 'New Character'}
          </Button>
        </Stack.Item>
      ))}
    </Stack>
  ); */
  return (
    <Stack align="center" justify="left">
      <Stack.Item width="285px">
        <SideDropdown
          selected={profiles[activeSlot]}
          options={profiles.map((profile, slot) => ({
            value: slot,
            displayText: profile ?? 'New Character',
          }))}
          onSelected={(slot) => {
            onClick(slot);
          }}
        />
      </Stack.Item>
    </Stack>
  );
  // BUBBER EDIT CHANGE END
}

export function CharacterPreferenceWindow(props) {
  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPage, setCurrentPage] = useState(Page.Main);

  let pageContents;

  switch (currentPage) {
    case Page.Antags:
      pageContents = <AntagsPage />;
      break;
    case Page.Jobs:
      pageContents = <JobsPage />;
      break;
    case Page.Main:
      pageContents = (
        <MainPage openSpecies={() => setCurrentPage(Page.Species)} />
      );

      break;
    case Page.Species:
      pageContents = (
        <SpeciesPage closeSpecies={() => setCurrentPage(Page.Main)} />
      );

      break;

    // BUBBER EDIT ADDITION BEGIN
    case Page.Limbs:
      pageContents = <LimbsPage />;
      break;

    case Page.Languages:
      pageContents = <LanguagesPage />;
      break;
    // BUBBER EDIT ADDITION END

    case Page.Quirks:
      pageContents = <QuirkPersonalityPage />;
      break;

    case Page.Loadout:
      pageContents = <LoadoutPage />;
      break;

    default:
      exhaustiveCheck(currentPage);
  }

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <CharacterProfiles
              activeSlot={data.active_slot - 1}
              onClick={(slot) => {
                act('change_slot', {
                  slot: slot + 1,
                });
              }}
              profiles={data.character_profiles}
            />
          </Stack.Item>
          {/* BUBBER EDIT ADDITION BEGIN */}
          <Stack.Item>
            <Button
              onClick={() => {act('duplicate_current_slot');}}
              fontSize="13px"
              icon="copy"
              tooltip="Duplicate Current Character (Experimental)" //Delete this comment about being experimental before merge
              tooltipPosition="top"
            />
            {/* BUBBER EDIT ADDITION END */}
          </Stack.Item>
          {!data.content_unlocked && (
            <Stack.Item grow align="center" mb={-1}>
              <NoticeBox color="grey">
                <a href="https://www.byond.com/membership">
                  Become a BYOND Member to unlock more character slots and other
                  members-only benefits!
                </a>
              </NoticeBox>
            </Stack.Item>
          )}
        </Stack>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item>
        <Stack fill>
          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Main}
              setPage={setCurrentPage}
              otherActivePages={[Page.Species]}
            >
              Character
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Loadout}
              setPage={setCurrentPage}
            >
              Loadout
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Jobs}
              setPage={setCurrentPage}
            >
              {/*
                    Fun fact: This isn't "Jobs" so that it intentionally
                    catches your eyes, because it's really important!
                  */}
              Occupations
            </PageButton>
          </Stack.Item>

          {/* BUBBER EDIT ADDITION BEGIN */}
          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Limbs}
              setPage={setCurrentPage}
            >
              Augments+
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Languages}
              setPage={setCurrentPage}
            >
              Languages
            </PageButton>
          </Stack.Item>
          {/* BUBBER EDIT ADDITION END */}

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Antags}
              setPage={setCurrentPage}
            >
              Antagonists
            </PageButton>
          </Stack.Item>

          <Stack.Item grow>
            <PageButton
              currentPage={currentPage}
              page={Page.Quirks}
              setPage={setCurrentPage}
            >
              Quirks and Personality
            </PageButton>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item grow position="relative" overflowX="hidden" overflowY="auto">
        {pageContents}
      </Stack.Item>
    </Stack>
  );
}
