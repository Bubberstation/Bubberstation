import { exhaustiveCheck } from '../../../common/exhaustive';
import { useState } from 'react';

import { useBackend } from '../../backend';
import { Box, Dimmer, Dropdown, Flex, Icon, Stack } from '../../components'; // SKYRAT EDIT CHANGE - ORIGINAL: import { Button, Stack } from '../../components';
import { Window } from '../../layouts';
import { AntagsPage } from './AntagsPage';
import { PreferencesMenuData } from './data';
import { JobsPage } from './JobsPage';
// SKYRAT EDIT
import { LanguagesPage } from './LanguagesMenu';
import { LimbsPage } from './LimbsPage';
// SKYRAT EDIT END
import { LoadoutPage } from './loadout/index';
import { PageButton } from './PageButton';
import { QuirksPage } from './QuirksPage';
import { SpeciesPage } from './SpeciesPage';
import { IndexPage } from './bubber/IndexPage';
import { Button } from 'tgui-core/components';
import { MultiNameInput, NameInput } from './names';
import { LoadoutPreviewSection } from './bubber/utils';

export enum Page { // BUBBER EDIT: Original: enum Page {
  Antags,
  Main,
  Jobs,
  Species,
  Quirks,
  Loadout,
  // BUBBER EDIT
  Limbs,
  Languages,
  Appearance,
  OOC,
  Food,
  Inspection,
  Misc,
  // BUBBER EDIT END
}

const CharacterProfiles = (props: {
  activeSlot: number;
  onClick: (index: number) => void;
  profiles: (string | null)[];
}) => {
  const { profiles, activeSlot, onClick } = props; // SKYRAT EDIT CHANGE

  return (
    <Flex /* SKYRAT EDIT CHANGE START - Skyrat uses a dropdown instead of buttons */
      align="center"
      justify="center"
    >
      <Flex.Item width="25%">
        <Dropdown
          width="100%"
          selected={activeSlot as unknown as string}
          displayText={profiles[activeSlot]}
          options={profiles.map((profile, slot) => ({
            value: slot,
            displayText: profile ?? 'New Character',
          }))}
          onSelected={(slot) => {
            onClick(slot);
          }}
        />
      </Flex.Item>
    </Flex> /* SKYRAT EDIT CHANGE END */
  );
};

export const CharacterPreferenceWindow = (props) => {
  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPage, setCurrentPage] = useState(Page.Main);

  let pageContents: String | React.JSX.Element = '';
  let [multiNameInputOpen, setMultiNameInputOpen] = useState(false); // BUBBER EDIT ADDITION
  const [tutorialStatus, setTutorialStatus] = useState<string | null>(); // BUBBER EDIT ADDITION

  switch (currentPage) {
    case Page.Antags:
      pageContents = <AntagsPage />;
      break;
    case Page.Jobs:
      pageContents = <JobsPage />;
      break;
    case Page.Main:
      pageContents = pageContents = (
        <IndexPage
          setCurrentPage={(page: Page) => setCurrentPage(page)}
          setTutorialStatus={setTutorialStatus}
        />
      ); // BUBBER EDIT: ORIGINAL: (<MainPage openSpecies={() => setCurrentPage(Page.Species)} />)
      break;
    case Page.Species:
      pageContents = (
        <SpeciesPage closeSpecies={() => setCurrentPage(Page.Main)} />
      );

      break;
    case Page.Quirks:
      pageContents = <QuirksPage />;
      break;

    case Page.Loadout:
      pageContents = <LoadoutPage />;
      break;

    // BUBBER EDIT
    case Page.Limbs:
      pageContents = <LimbsPage />;
      break;
    case Page.Languages:
      pageContents = <LanguagesPage />;
      break;
    case Page.Appearance:
      pageContents = 'null';
      break;
    case Page.OOC:
      pageContents = 'null';
      break;
    case Page.Food:
      pageContents = 'null';
      break;
    case Page.Inspection:
      pageContents = 'null';
      break;
    case Page.Misc:
      pageContents = 'null';
      break;
    // BUBBER EDIT END

    default:
      exhaustiveCheck(currentPage);
  }

  // BUBBER EDIT START: See further on for the original code. This is very different from upstream from here on.
  return (
    <Window title="Character Preferences" width={1200} height={770}>
      <Window.Content scrollable>
        {multiNameInputOpen && (
          <MultiNameInput
            handleClose={() => setMultiNameInputOpen(false)}
            handleRandomizeName={(preference) =>
              act('randomize_name', {
                preference,
              })
            }
            handleUpdateName={(nameType, value) =>
              act('set_preference', {
                preference: nameType,
                value,
              })
            }
            names={data.character_preferences.names}
          />
        )}
        {tutorialStatus === 'new_player' && (
          <Dimmer>
            <Stack vertical align="center">
              <Stack.Item preserveWhitespace>
                So you&apos;re new here, and you want to make your first
                character? Here&apos;s the lowdown:
                <ul>
                  <li>
                    Pick your species. This will make figuring out what the heck
                    you&apos;re going to do later on much much easier.
                  </li>
                  <li>
                    Generally speaking, start in the top left, and work your way
                    to the bottom right.
                    <br />
                    I&apos;ve tried to keep things in order of importance for
                    new players.
                  </li>
                  <li>
                    If you want to read up on some of the lore, see{' '}
                    <a href="https://wiki.bubberstation.org/index.php?title=Lore">
                      our wiki
                    </a>{' '}
                    for some!
                  </li>
                </ul>
              </Stack.Item>
              <Stack.Item>
                <Button
                  mt={1}
                  align="center"
                  onClick={() => setTutorialStatus(null)}
                >
                  Okay.
                </Button>
              </Stack.Item>
            </Stack>
          </Dimmer>
        )}
        <Stack vertical fill>
          <Stack.Item>
            {!(currentPage === Page.Main) && (
              <Box width="8em" position="absolute">
                <PageButton
                  currentPage={currentPage}
                  page={Page.Main}
                  setPage={setCurrentPage}
                >
                  <Icon name="arrow-left" />
                  Index
                </PageButton>
              </Box>
            )}
            <CharacterProfiles
              activeSlot={data.active_slot - 1}
              onClick={(slot) => {
                act('change_slot', {
                  slot: slot + 1,
                });
              }}
              profiles={data.character_profiles}
            />
            <Box position="absolute" right={0.5} top={0.5}></Box>
          </Stack.Item>
          {!data.content_unlocked && (
            <Stack.Item align="center">
              Buy BYOND premium for more slots!
            </Stack.Item>
          )}

          <Stack.Divider />

          <Stack.Item height="100%">
            <Stack fill>
              <Stack.Item style={{ width: '280px' }}>
                <LoadoutPreviewSection
                  tutorialStatus={tutorialStatus}
                  setMultiNameInputOpen={setMultiNameInputOpen}
                />
              </Stack.Item>
              <Stack.Divider />
              <Stack.Item width="100%" height="100%">
                {pageContents}
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

// BUBBER EDIT REMOVAL: I need to change so much of this shit, that it's best just sharded like this so maints have an easier time merging upstream.
/*
  return (
    <Window title="Character Preferences" width={920} height={770}>
      <Window.Content scrollable>
        <Stack vertical fill>
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
          {!data.content_unlocked && (
            <Stack.Item align="center">
              Buy BYOND premium for more slots!
            </Stack.Item>
          )}
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
                  *\/}
                  Occupations
                </PageButton>
              </Stack.Item>
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
                  Quirks
                </PageButton>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>{pageContents}</Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};*/
// BUBBER EDIT END
