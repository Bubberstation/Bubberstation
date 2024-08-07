import { useBackend } from '../backend';
import {
  Box,
  Button,
  Icon,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from '../components';
import { Window } from '../layouts';

type MedScannerData = {
  patient: string;
  species: string;
  dead: boolean;
  health: number;
  max_health: number;
  crit_threshold: number;
  dead_threshold: number;
  total_brute: number;
  total_burn: number;
  toxin: number;
  oxy: number;
  revivable_boolean: boolean;
  revivable_string: number;
  has_chemicals: boolean;
  chemicals_lists: object;
  limb_data_lists: object;
  limbs_damaged: object;
  damaged_organs: any[];
  ssd: string;
  blood_type: string;
  blood_amount: number;
  body_temperature: string;
  advice: any;
  accessible_theme: string;
  majquirks: any;
  minquirks: any;
};

export const MedScanner = () => {
  const { data } = useBackend<MedScannerData>();
  const {
    species,
    has_chemicals,
    limbs_damaged,
    damaged_organs,
    blood_amount,
    advice,
    accessible_theme,
  } = data;
  return (
    <Window width={515} height={615} theme={accessible_theme}>
      <Window.Content scrollable>
        <PatientBasics />
        {has_chemicals ? <PatientChemicals /> : null}
        {limbs_damaged ? <PatientLimbs /> : null}
        {damaged_organs.length ? <PatientOrgans /> : null}
        {blood_amount ? <PatientBlood /> : null}
        {advice ? <PatientAdvice /> : null}
      </Window.Content>
    </Window>
  );
};

const PatientBasics = () => {
  const { data } = useBackend<MedScannerData>();
  const {
    patient,
    species,
    dead,

    health,
    max_health,
    crit_threshold,
    dead_threshold,

    total_brute,
    total_burn,
    toxin,
    oxy,

    revivable_boolean,
    revivable_string,

    ssd,

    accessible_theme,

    majquirks,
    minquirks,
  } = data;
  return (
    <Section
      title={
        (species === 'Synthetic Humanoid' ? 'Unit: ' : 'Patient: ') + patient
      }
      buttons={
        <Button
          icon="info"
          tooltip="Most elements of this window have a tooltip for additional information. Hover your mouse over something for clarification!"
          color="transparent"
          mt={
            /* with the "hackerman" theme, the buttons have this ugly outline that messes with the section titlebar, let's fix that */
            accessible_theme
              ? species === 'Synthetic Humanoid'
                ? '-5px'
                : '0px'
              : '0px'
          }
        >
          Tooltips - hover for info
        </Button>
      }
    >
      {ssd ? (
        <NoticeBox danger>Space sleep disorder detected!</NoticeBox>
      ) : null}
      <LabeledList>
        <LabeledList.Item label="Health">
          <Tooltip
            content={
              'How healthy the patient is.' +
              (species === 'Synthetic Humanoid'
                ? ''
                : " If the patient's health dips below " +
                  crit_threshold +
                  '%, they enter critical condition and suffocate rapidly.') +
              " If the patient's health hits " +
              Math.round(dead_threshold / max_health) * 100 +
              '%, they die.'
            }
          >
            {health >= 0 ? (
              <ProgressBar
                value={health / max_health}
                ranges={{
                  good: [0.4, Infinity],
                  average: [0.2, 0.4],
                  bad: [-Infinity, 0.2],
                }}
              />
            ) : (
              <ProgressBar
                value={1 + health / max_health}
                ranges={{
                  bad: [-Infinity, Infinity],
                }}
              >
                {Math.trunc((health / max_health) * 100)}%
              </ProgressBar>
            )}
          </Tooltip>
        </LabeledList.Item>
        {dead ? (
          <LabeledList.Item label="Revivable">
            <Box
              color={
                revivable_boolean
                  ? accessible_theme
                    ? 'yellow'
                    : 'label'
                  : 'red'
              }
              bold
            >
              {revivable_string}
            </Box>
          </LabeledList.Item>
        ) : null}
        <LabeledList.Item label="Damage">
          <Tooltip
            content={
              species === 'Synthetic Humanoid'
                ? 'Brute. Sustained from sources of physical trauma such as melee combat, firefights, etc. Repaired with a welding tool or surgery.'
                : 'Brute. Sustained from sources of physical trauma such as melee combat, firefights, etc. Treated with Libital or sutures.'
            }
          >
            <Box inline>
              <ProgressBar value={0}>
                Brute:{' '}
                <Box inline bold color={'red'}>
                  {total_brute}
                </Box>
              </ProgressBar>
            </Box>
          </Tooltip>
          <Box inline width={'5px'} />
          <Tooltip
            content={
              species === 'Synthetic Humanoid'
                ? 'Burn. Sustained from sources of burning such as energy weapons, acid, fire, etc. Repaired with cable coils.'
                : 'Burn. Sustained from sources of burning such as overheating, energy weapons, acid, fire, etc. Treated with Airui or regenerative mesh.'
            }
          >
            <Box inline>
              <ProgressBar value={0}>
                Burn:{' '}
                <Box inline bold color={'#ffb833'}>
                  {total_burn}
                </Box>
              </ProgressBar>
            </Box>
          </Tooltip>
          <Box inline width={'5px'} />
          <Tooltip content="Toxin. Sustained from chemicals or organ damage. Treated with toxin healing medicine.">
            <Box inline>
              <ProgressBar value={0}>
                Tox:{' '}
                <Box inline bold color={'green'}>
                  {toxin}
                </Box>
              </ProgressBar>
            </Box>
          </Tooltip>
          <Box inline width={'5px'} />
          <Tooltip content="Oxyloss. Sustained from being in critical condition, organ damage or extreme exhaustion. Treated with CPR, oxygen healing medicine or decreases on its own if the patient isn't in critical condition.">
            <Box inline>
              <ProgressBar value={0}>
                Oxy:{' '}
                <Box inline bold color={'blue'}>
                  {oxy}
                </Box>
              </ProgressBar>
            </Box>
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label="Species">
          <Box width="50px" bold color="#42bff5" nowrap maxWidth="100px">
            {species}
          </Box>
        </LabeledList.Item>
        {majquirks ? (
          <LabeledList.Item label="Quirks">
            <Box width="100%">Subject Major Disabilities: {majquirks}</Box>
          </LabeledList.Item>
        ) : null}
        {majquirks ? (
          <LabeledList.Item>
            <Box width="100%">Subject Minor Disabilities: {minquirks}</Box>
          </LabeledList.Item>
        ) : null}
      </LabeledList>
    </Section>
  );
};

const PatientChemicals = () => {
  const { data } = useBackend<MedScannerData>();
  const { chemicals_lists } = data;
  const chemicals = Object.values(chemicals_lists);
  return (
    <Section title="Chemical Contents">
      <LabeledList>
        {chemicals.map((chemical) => (
          <LabeledList.Item key={chemical.name}>
            <Tooltip
              content={
                chemical.description +
                (chemical.od
                  ? ' (OVERDOSING)'
                  : chemical.od_threshold > 0
                    ? ' (OD: ' + chemical.od_threshold + 'u)'
                    : '')
              }
            >
              <Box
                inline
                color={chemical.dangerous ? 'red' : 'white'}
                bold={chemical.dangerous}
              >
                {chemical.amount + 'u ' + chemical.name}
              </Box>
              <Box inline width={'5px'} />
              {chemical.od ? (
                <Box inline color={'red'} bold>
                  {'OD'}
                </Box>
              ) : null}
            </Tooltip>
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Section>
  );
};

const PatientLimbs = () => {
  const row_bg_color = 'rgba(255, 255, 255, .05)';
  let row_transparency = 0;
  const { data } = useBackend<MedScannerData>();
  const { limb_data_lists, species, accessible_theme } = data;
  const limb_data = Object.values(limb_data_lists);
  return (
    <Section title="Limbs Damaged">
      <Stack vertical fill>
        <Stack height="20px">
          <Stack.Item basis="80px" />
          <Stack.Item basis="50px" bold color="red">
            Brute
          </Stack.Item>
          <Stack.Item bold color="#ffb833">
            Burn
          </Stack.Item>
          <Stack.Item grow={1} textAlign="right" nowrap>
            {'{ } = Untreated'}
          </Stack.Item>
        </Stack>
        {limb_data.map((limb) => (
          <Stack
            key={limb.name}
            width="100%"
            py="3px"
            backgroundColor={row_transparency++ % 2 === 0 ? row_bg_color : ''}
          >
            <Stack.Item basis="80px" bold pl="3px">
              {limb.name[0].toUpperCase() + limb.name.slice(1)}
            </Stack.Item>
            {limb.missing ? (
              <Tooltip
                content={
                  'Missing limbs can only be fixed through surgical intervention.'
                }
              >
                <Stack.Item color={'red'} bold>
                  MISSING
                </Stack.Item>
              </Tooltip>
            ) : (
              <>
                <Stack.Item>
                  <Tooltip
                    content={
                      limb.limb_type === 'Robotic'
                        ? 'Limb denting. Can be welded with a welding tool.'
                        : limb.bandaged
                          ? 'Treated wounds will slowly heal on their own, or can be healed faster with chemicals.'
                          : 'Untreated physical trauma. Can be bandaged with gauze or advanced trauma kits.'
                    }
                  >
                    <Box
                      inline
                      width="50px"
                      color={limb.brute > 0 ? 'red' : 'white'}
                    >
                      {limb.bandaged ? `${limb.brute}` : `{${limb.brute}}`}
                    </Box>
                  </Tooltip>
                  <Box inline width="5px" />
                  <Tooltip
                    content={
                      limb.limb_type === 'Robotic'
                        ? 'Wire scorching. Can be repaired with a cable coil.'
                        : limb.salved
                          ? 'Salved burns will slowly heal on their own, or can be healed faster with chemicals.'
                          : 'Unsalved burns. Can be salved with ointment or regenerative mesh.'
                    }
                  >
                    <Box
                      inline
                      width="40px"
                      color={limb.burn > 0 ? '#ffb833' : 'white'}
                    >
                      {limb.salved ? `${limb.burn}` : `{${limb.burn}}`}
                    </Box>
                  </Tooltip>
                  <Box inline width="5px" />
                </Stack.Item>
                <Stack.Item>
                  {limb.limb_status ? (
                    <Tooltip
                      content={
                        limb.limb_status === 'Splinted'
                          ? 'This fracture is stabilized by a splint, suppressing most of its symptoms. If this limb sustains damage, the splint might come off. It can be fully treated with surgery or cryo treatment.'
                          : limb.limb_status === 'Stabilized'
                            ? "This fracture is stabilized by the patient's armor, suppressing most of its symptoms. If their armor is removed, it'll stop being stabilized. It can be fully treated with surgery or cryo treatment."
                            : 'This limb is broken. Use a splint to stabilize it. An unsplinted head, chest or groin will cause organ damage when the patient moves. Unsplinted arms or legs will frequently give out.'
                      }
                    >
                      <Box
                        inline
                        color={
                          limb.limb_status === 'Splinted'
                            ? 'lime'
                            : limb.limb_status === 'Stabilized'
                              ? 'lime'
                              : 'white'
                        }
                        bold
                      >
                        [{limb.limb_status}]
                      </Box>
                    </Tooltip>
                  ) : null}
                  {limb.limb_type ? (
                    <Tooltip
                      content={
                        limb.limb_type === 'Robotic'
                          ? 'Robotic limbs are only fixed by welding or cable coils.'
                          : null
                      }
                    >
                      <Box
                        inline
                        color={
                          limb.limb_type === 'Robotic'
                            ? species === 'Synthetic Humanoid'
                              ? accessible_theme
                                ? 'lime'
                                : 'label'
                              : 'pink'
                            : 'tan'
                        }
                        bold
                      >
                        [{limb.limb_type}]
                      </Box>
                    </Tooltip>
                  ) : null}
                  {limb.bleeding ? (
                    <Tooltip content="This limb is bleeding and the patient is losing blood. Can be stopped with gauze or with a suture.">
                      <Box inline color={'red'} bold>
                        [Bleeding]
                      </Box>
                    </Tooltip>
                  ) : null}
                </Stack.Item>
              </>
            )}
          </Stack>
        ))}
      </Stack>
    </Section>
  );
};

const PatientOrgans = () => {
  const { data } = useBackend<MedScannerData>();
  const { damaged_organs } = data;
  return (
    <Section title="Organs Damaged">
      <LabeledList>
        {damaged_organs.map((organ) => (
          <LabeledList.Item
            key={organ.name}
            label={organ.name[0].toUpperCase() + organ.name.slice(1)}
          >
            <Tooltip content={organ.effects}>
              <Box
                inline
                color={organ.status === 'Midly Damaged' ? 'orange' : 'red'}
                bold
              >
                {organ.status + ' with ' + Math.ceil(organ.damage) + ' damage'}
              </Box>
            </Tooltip>
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Section>
  );
};

const PatientBlood = () => {
  const { data } = useBackend<MedScannerData>();
  const { blood_amount, blood_type, body_temperature } = data;
  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label={'Blood Levels:'}>
          <Tooltip content="Bloodloss causes symptoms that start as suffocation and pain, but get significantly worse as more blood is lost. Blood can be restored by eating and taking Isotonic solution.">
            <ProgressBar
              value={blood_amount / 560}
              ranges={{
                blue: [Infinity, 0.8],
                good: [0.8, 1],
                red: [-Infinity, 0.8],
              }}
            />
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label={'Body Temperature'}>
          {body_temperature}
        </LabeledList.Item>
        <LabeledList.Item color="cyan" label={'Blood Type:'}>
          {blood_type}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const PatientAdvice = () => {
  const { data } = useBackend<MedScannerData>();
  const { advice, species, accessible_theme } = data;
  return (
    <Section title="Treatment Advice">
      <Stack vertical>
        {advice.map((advice) => (
          <Stack.Item key={advice.advice}>
            <Tooltip
              content={
                advice.tooltip
                  ? advice.tooltip
                  : 'No tooltip entry for this advice.'
              }
            >
              <Box inline>
                <Icon
                  name={advice.icon}
                  ml={0.2}
                  color={
                    accessible_theme
                      ? advice.color
                      : species === 'Synthetic Humanoid'
                        ? 'label'
                        : advice.color
                  }
                />
                <Box inline width={'5px'} />
                {advice.advice}
              </Box>
            </Tooltip>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};
