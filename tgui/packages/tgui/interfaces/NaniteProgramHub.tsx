import { map } from 'es-toolkit/compat';
import {
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  Section,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { TechwebWarning } from './Nanites/NoTechwebWarning';
import type { NaniteProgram, Techweb } from './Nanites/types';

interface NaniteProgramHubProps {
  detail_view: boolean;
  disk: {
    name: string;
    desc: string;
  };
  techweb: Techweb;
  has_disk: boolean;
  has_program: boolean;
  programs: Record<string, Array<NaniteProgram>>;
}

export const NaniteProgramHub = (props, context) => {
  const { act, data } = useBackend<NaniteProgramHubProps>();
  const {
    detail_view,
    disk,
    has_disk,
    has_program,
    programs = {},
    techweb,
  } = data;
  const [selectedCategory, setSelectedCategory] = useSharedState<string | null>(
    'category',
    null,
  );
  const programsInCategory =
    (programs && selectedCategory && programs[selectedCategory]) || [];

  return (
    <Window width={500} height={700}>
      <Window.Content scrollable>
        <TechwebWarning display={!techweb} />
        <Section
          title="Program Disk"
          buttons={
            <>
              <Button
                disabled={!has_disk}
                icon="eject"
                onClick={() => act('eject')}
              >
                Eject
              </Button>
              <Button
                disabled={!has_disk}
                icon="minus-circle"
                onClick={() => act('clear')}
              >
                Delete Program
              </Button>
            </>
          }
        >
          {has_disk ? (
            has_program ? (
              <LabeledList>
                <LabeledList.Item label="Program Name">
                  {disk.name}
                </LabeledList.Item>
                <LabeledList.Item label="Description">
                  {disk.desc}
                </LabeledList.Item>
              </LabeledList>
            ) : (
              <NoticeBox>No Program Installed</NoticeBox>
            )
          ) : (
            <NoticeBox>Insert Disk</NoticeBox>
          )}
        </Section>
        <Section
          title="Programs"
          buttons={
            <>
              <Button
                icon={detail_view ? 'info' : 'list'}
                onClick={() => act('toggle_details')}
              >
                {detail_view ? 'Detailed' : 'Compact'}
              </Button>
              <Button icon="sync" onClick={() => act('refresh')}>
                Sync Research
              </Button>
            </>
          }
        >
          {programs !== null ? (
            <Flex>
              <Flex.Item minWidth="110px" style={{ marginRight: '15px' }}>
                <Tabs vertical>
                  {map(programs, (cat_contents, category) => {
                    // Backend was sending stupid data that would have been
                    // annoying to fix
                    const tabLabel = category.substring(0, category.length - 8);
                    return (
                      <Tabs.Tab
                        key={category}
                        selected={category === selectedCategory}
                        onClick={() => setSelectedCategory(category)}
                      >
                        {tabLabel}
                      </Tabs.Tab>
                    );
                  })}
                </Tabs>
              </Flex.Item>
              <Flex.Item grow={1} basis={0}>
                {detail_view ? (
                  programsInCategory.map((program) => (
                    <Section
                      key={program.id}
                      title={program.name}
                      buttons={
                        <Button
                          icon="download"
                          disabled={!has_disk}
                          onClick={() =>
                            act('download', {
                              program_id: program.id,
                            })
                          }
                        >
                          Download
                        </Button>
                      }
                    >
                      {program.desc}
                    </Section>
                  ))
                ) : (
                  <LabeledList>
                    {programsInCategory.map((program) => (
                      <LabeledList.Item
                        key={program.id}
                        label={program.name}
                        buttons={
                          <Button
                            icon="download"
                            disabled={!has_disk}
                            onClick={() =>
                              act('download', {
                                program_id: program.id,
                              })
                            }
                          >
                            Download
                          </Button>
                        }
                      />
                    ))}
                  </LabeledList>
                )}
              </Flex.Item>
            </Flex>
          ) : (
            <NoticeBox>No nanite programs are currently researched.</NoticeBox>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
