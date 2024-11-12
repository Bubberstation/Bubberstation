import { Stack } from 'tgui-core/components';
import {
  PreferencesMenuData,
  RandomSetting,
  ServerData,
  createSetPreference,
} from '../data';
import {
  FeatureChoicedServerData,
  FeatureValueInput,
} from '../preferences/features/base';
import {
  CLOTHING_SELECTION_CELL_SIZE,
  CLOTHING_SELECTION_MULTIPLIER,
  CLOTHING_SELECTION_WIDTH,
  PreferenceList,
  createSetRandomization,
  getRandomization,
  searchInCatalog,
} from '../MainPage';
import { useBackend } from '../../../backend';
import { useRandomToggleState } from '../useRandomToggleState';
import {
  Autofocus,
  Box,
  Button,
  Dimmer,
  Flex,
  Input,
  LabeledList,
  Modal,
  Section,
} from '../../../components';
import { classes } from 'common/react';
import { RandomizationButton } from '../RandomizationButton';
import { useState } from 'react';
import features from '../preferences/features';
import { BetterPrefList, SlightlyLessCrappyLabeledListItem } from './utils';

export const BubberPrefStack = (props: {
  category: string;
  serverData: ServerData | undefined;
}) => {
  const { category, serverData } = props;

  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPref, setCurrentPref] = useState<string | null>(null);

  const mainFeatures = data.character_preferences[category + '_iconed'];

  const listExists = !!data.character_preferences[category];
  const mainFeaturesExist = !!mainFeatures;
  const selectedPrefCatalogue =
    !!serverData &&
    !!currentPref &&
    (serverData[currentPref] as FeatureChoicedServerData & {
      name: string;
      supplemental_feature?: string;
    });

  return (
    <>
      {currentPref && selectedPrefCatalogue && (
        <Stack vertical fill>
          <Stack.Item height="100%">
            <BubberPrefDetails
              catalog={selectedPrefCatalogue}
              currentValue={data.character_preferences[category][currentPref]}
              supplementalFeature={selectedPrefCatalogue.supplemental_feature}
              supplementalValue={
                selectedPrefCatalogue.supplemental_feature &&
                data.character_preferences.supplemental_features[
                  selectedPrefCatalogue.supplemental_feature
                ]
              }
              onSelect={createSetPreference(act, currentPref)}
            />
          </Stack.Item>
          <Stack.Item align="center">
            <Button
              icon="check"
              p="5px"
              pr="20px"
              pl="20px"
              onClick={() => setCurrentPref(null)}
              fontSize={1.2}
            >
              Done
            </Button>
          </Stack.Item>
        </Stack>
      )}
      {!currentPref && mainFeaturesExist && (
        <TwinStack
          first={
            <Stack wrap>
              <StackHeader>Main settings for {category}</StackHeader>
              {Object.entries(mainFeatures).map(([entryKey, entry]) => {
                const catalog =
                  serverData &&
                  (serverData[entryKey] as FeatureChoicedServerData & {
                    name: string;
                  });

                return (
                  catalog && (
                    <MainFeature
                      key={entryKey}
                      catalog={catalog}
                      currentValue={entry as string}
                      handleOpen={() => {
                        setCurrentPref(entryKey);
                      }}
                      setRandomization={createSetRandomization(act, entryKey)}
                    />
                  )
                );
              })}
            </Stack>
          }
          second={
            listExists && (
              <Stack wrap>
                <StackHeader>Secondary settings for {category}</StackHeader>
                <Stack.Item grow>
                  <BetterPrefList
                    act={act}
                    preferences={data.character_preferences[category]}
                    randomizations={getRandomization(
                      data.character_preferences.secondary_features || [],
                      serverData,
                      data.character_preferences['misc'].random_body !==
                        RandomSetting.Disabled || useRandomToggleState()[0],
                    )}
                  />
                </Stack.Item>
              </Stack>
            )
          }
        />
      )}
    </>
  );
};

export const StackHeader = (props: { children }) => {
  return (
    <Stack.Item minHeight="2rem" width="100%">
      <Box
        style={{
          borderBottom: '1px solid #888',
          fontWeight: 'bold',
          fontSize: '14px',
          textAlign: 'center',
        }}
      >
        {props.children}
      </Box>
    </Stack.Item>
  );
};

const TwinStack = (props: { first; second }) => {
  return (
    <Stack fill>
      <Stack.Item
        height="100%"
        width={props.second ? '50%' : '100%'}
        style={{
          background: 'rgba(0, 0, 0, 0.5)',
          padding: '4px',
        }}
        overflowX="hidden"
        overflowY="scroll"
      >
        {props.first}
      </Stack.Item>
      {!!props.second && (
        <Stack.Item
          height="100%"
          width="50%"
          style={{
            background: 'rgba(0, 0, 0, 0.5)',
            padding: '4px',
          }}
          overflowX="hidden"
          overflowY="scroll"
        >
          {props.second}
        </Stack.Item>
      )}
    </Stack>
  );
};

const MainFeature = (props: {
  catalog: FeatureChoicedServerData & {
    name: string;
    supplemental_feature?: string;
  };
  currentValue: string;
  handleOpen: () => void;
  randomization?: RandomSetting;
  setRandomization: (newSetting: RandomSetting) => void;
}) => {
  const { catalog, currentValue, handleOpen, randomization, setRandomization } =
    props;

  return (
    <Stack.Item
      height={`48px`}
      mt={0.5}
      pr={2}
      pb={1}
      ml={0}
      width={'45%' /* I hate this */}
      position="relative"
    >
      <Stack>
        <Stack.Item>
          <Button
            inline
            onClick={(event) => {
              event.stopPropagation();
              handleOpen();
            }}
            style={{
              height: `48px`,
              width: `48px`,
            }}
            position="relative"
          >
            <Box
              className={classes([
                'preferences32x32',
                catalog.icons![currentValue],
                'centered-image',
              ])}
              style={{
                transform: randomization
                  ? 'translateX(-70%) translateY(-70%) scale(1.1)'
                  : 'translateX(-50%) translateY(-50%) scale(1.3)',
              }}
            />

            {randomization && (
              <RandomizationButton
                dropdownProps={{
                  dropdownStyle: {
                    bottom: 0,
                    position: 'absolute',
                    right: '1px',
                  },

                  onOpen: (event) => {
                    // We're a button inside a button.
                    // Did you know that's against the W3C standard? :)
                    event.cancelBubble = true;
                    event.stopPropagation();
                  },
                }}
                value={randomization}
                setValue={setRandomization}
              />
            )}
          </Button>
        </Stack.Item>
        {/* There's probably a better way of doing this, but oh my fucking god I hate css - Rimi */}
        <Stack.Item fontSize={1.2} ml="5px" height="48px">
          <Box
            mt="auto"
            position="relative"
            top="50%"
            style={{ transform: 'translateY(-50%)' }}
          >
            {catalog.name}
          </Box>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const BubberPrefDetails = (props: {
  catalog: FeatureChoicedServerData & {
    name: string;
  };
  currentValue: string;
  supplementalFeature?: string;
  supplementalValue?: unknown;
  onSelect: (value: string) => void;
}) => {
  const {
    catalog,
    currentValue,
    supplementalFeature,
    supplementalValue,
    onSelect,
  } = props;

  const { act } = useBackend();

  return (
    <TwinStack
      first={
        <ChoicedSelection
          name={catalog.name}
          catalog={catalog}
          selected={currentValue}
          onSelect={onSelect}
        />
      }
      second={
        <Stack vertical fill>
          <Stack.Item minHeight="2rem">
            <Box
              style={{
                borderBottom: '1px solid #888',
                fontWeight: 'bold',
                fontSize: '14px',
                textAlign: 'center',
              }}
            >
              Extra options for {catalog.name.toLowerCase()}
            </Box>
          </Stack.Item>
          <Stack.Item grow>
            {(supplementalFeature && (
              <BetterPrefList key={supplementalFeature}>
                <SlightlyLessCrappyLabeledListItem
                  label={features[supplementalFeature].name}
                  tooltip={features[supplementalFeature].description}
                >
                  <FeatureValueInput
                    act={act}
                    feature={features[supplementalFeature]}
                    featureId={supplementalFeature}
                    shrink
                    value={supplementalValue}
                  />
                </SlightlyLessCrappyLabeledListItem>
              </BetterPrefList>
            )) ||
              'Nothing here!'}
          </Stack.Item>
        </Stack>
      }
    />
  );
};

const ChoicedSelection = (props: {
  name: string;
  selected: string;
  catalog: FeatureChoicedServerData;
  onSelect: (value: string) => void;
}) => {
  const { act } = useBackend<PreferencesMenuData>();

  const { catalog } = props;
  const [getSearchText, searchTextSet] = useState('');

  if (!catalog.icons) {
    return <Box color="red">Provided catalog had no icons!</Box>;
  }

  return (
    <Stack vertical height="100%">
      <Stack.Item>
        <Stack vertical fill>
          <Stack.Item grow minHeight="2rem">
            <Box
              style={{
                borderBottom: '1px solid #888',
                fontWeight: 'bold',
                fontSize: '14px',
                textAlign: 'center',
              }}
            >
              Select {props.name.toLowerCase()}
            </Box>
          </Stack.Item>

          <Stack.Item>
            <Input
              placeholder="Search..."
              style={{
                margin: '0px 5px',
                width: '95%',
              }}
              onInput={(_, value) => searchTextSet(value)}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>

      <Stack.Item overflowX="hidden" overflowY="scroll" height="100%">
        <Autofocus>
          <Stack wrap>
            {searchInCatalog(getSearchText, catalog.icons).map(
              ([name, image], index) => {
                return (
                  <Stack.Item width="48%" ml="1px">
                    <Stack fill>
                      <Stack.Item>
                        <Button
                          onClick={() => {
                            props.onSelect(name);
                          }}
                          selected={name === props.selected}
                          tooltip={name}
                          tooltipPosition="right"
                          style={{
                            height: `${CLOTHING_SELECTION_CELL_SIZE}px`,
                            width: `${CLOTHING_SELECTION_CELL_SIZE}px`,
                          }}
                        >
                          <Box
                            className={classes([
                              'preferences32x32',
                              image,
                              'centered-image',
                            ])}
                          />
                        </Button>
                      </Stack.Item>
                      {/* There's probably a better way of doing this, but oh my fucking god I hate css - Rimi */}
                      <Stack.Item mr="5px">
                        <Box
                          mt="auto"
                          position="relative"
                          top="50%"
                          style={{ transform: 'translateY(-50%)' }}
                        >
                          {name}
                        </Box>
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                );
              },
            )}
          </Stack>
        </Autofocus>
      </Stack.Item>
    </Stack>
  );
};
