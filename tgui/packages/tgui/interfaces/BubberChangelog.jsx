import dateformat from 'dateformat';
import yaml from 'js-yaml';
import { useEffect, useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Icon,
  Image,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

const icons = {
  add: { icon: 'check-circle', color: 'green' },
  admin: { icon: 'user-shield', color: 'purple' },
  balance: { icon: 'balance-scale-right', color: 'yellow' },
  bugfix: { icon: 'bug', color: 'green' },
  code_imp: { icon: 'code', color: 'green' },
  config: { icon: 'cogs', color: 'purple' },
  expansion: { icon: 'check-circle', color: 'green' },
  experiment: { icon: 'radiation', color: 'yellow' },
  image: { icon: 'image', color: 'green' },
  imageadd: { icon: 'tg-image-plus', color: 'green' },
  imagedel: { icon: 'tg-image-minus', color: 'red' },
  qol: { icon: 'hand-holding-heart', color: 'green' },
  refactor: { icon: 'tools', color: 'green' },
  rscadd: { icon: 'check-circle', color: 'green' },
  rscdel: { icon: 'times-circle', color: 'red' },
  server: { icon: 'server', color: 'purple' },
  sound: { icon: 'volume-high', color: 'green' },
  soundadd: { icon: 'tg-sound-plus', color: 'green' },
  sounddel: { icon: 'tg-sound-minus', color: 'red' },
  spellcheck: { icon: 'spell-check', color: 'green' },
  map: { icon: 'map', color: 'green' },
  tgs: { icon: 'toolbox', color: 'purple' },
  tweak: { icon: 'wrench', color: 'green' },
  unknown: { icon: 'info-circle', color: 'label' },
  wip: { icon: 'hammer', color: 'orange' },
};

const DateDropdown = (props) => {
  const { dates, selectedDate, setSelectedDate } = props;
  const [selectedIndex, setSelectedIndex] = useState(0);

  return (
    dates.length > 0 && (
      <Stack mb={1}>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === 0}
            icon={'chevron-left'}
            onClick={() => {
              const index = selectedIndex - 1;

              setSelectedIndex(index);
              setSelectedDate(dates[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            autoScroll={false}
            options={dates}
            onSelected={(value) => {
              const index = dates.indexOf(value);

              setSelectedIndex(index);
              setSelectedDate(value);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
            }}
            selected={selectedDate}
            width="150px"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === dates.length - 1}
            icon={'chevron-right'}
            onClick={() => {
              const index = selectedIndex + 1;

              setSelectedIndex(index);
              setSelectedDate(dates[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
            }}
          />
        </Stack.Item>
      </Stack>
    )
  );
};

const ChangelogList = (props) => {
  const { contents, bubberContents } = props;

  const combinedDates = {};
  Object.assign(
    combinedDates,
    typeof contents === 'object' ? contents : {},
    typeof bubberContents === 'object' ? bubberContents : {},
  );

  if (Object.keys(combinedDates).length < 1) {
    return <p>{contents}</p>;
  }

  return Object.keys(combinedDates)
    .sort()
    .reverse()
    .map((date) => (
      <Section key={date} title={dateformat(date, 'd mmmm yyyy', true)} pb={1}>
        <Box ml={3}>
          {bubberContents[date] && (
            <Section mb={-2}>
              {Object.entries(bubberContents[date]).map(([name, changes]) => (
                <BubberChangelogEntry
                  key={name}
                  author={name}
                  changes={changes}
                />
              ))}
            </Section>
          )}
          {contents[date] && (
            <Section mt={-1}>
              {Object.entries(contents[date]).map(([name, changes]) => (
                <ChangelogEntry key={name} author={name} changes={changes} />
              ))}
            </Section>
          )}
        </Box>
      </Section>
    ));
};

const BubberChangelogEntry = (props) => {
  const { author, changes } = props;

  return (
    <Stack.Item mb={-1} pb={1} key={author}>
      <Box>
        <h4>
          <Image verticalAlign="bottom" src={resolveAsset('bubber_16.png')} />{' '}
          {author} changed:
        </h4>
      </Box>
      <Box ml={3} mt={-0.2}>
        <Table>
          {changes.map((change) => {
            const changeType = Object.keys(change)[0];
            return (
              <Table.Row key={changeType + change[changeType]}>
                <Table.Cell
                  className={classes([
                    'Changelog__Cell',
                    'Changelog__Cell--Icon',
                  ])}
                >
                  <Icon
                    color={
                      icons[changeType]
                        ? icons[changeType].color
                        : icons['unknown'].color
                    }
                    name={
                      icons[changeType]
                        ? icons[changeType].icon
                        : icons['unknown'].icon
                    }
                    verticalAlign="middle"
                  />
                </Table.Cell>
                <Table.Cell className="Changelog__Cell">
                  {change[changeType]}
                </Table.Cell>
              </Table.Row>
            );
          })}
        </Table>
      </Box>
    </Stack.Item>
  );
};

const ChangelogEntry = (props) => {
  const { author, changes } = props;

  return (
    <Stack.Item mb={-1} pb={1} key={author}>
      <Box>
        <h4>
          <Image verticalAlign="bottom" src={resolveAsset('tg_16.png')} />{' '}
          {author} changed:
        </h4>
      </Box>
      <Box ml={3} mt={-0.2}>
        <Table>
          {changes.map((change) => {
            const changeType = Object.keys(change)[0];
            return (
              <Table.Row key={changeType + change[changeType]}>
                <Table.Cell
                  className={classes([
                    'Changelog__Cell',
                    'Changelog__Cell--Icon',
                  ])}
                >
                  <Icon
                    color={
                      icons[changeType]
                        ? icons[changeType].color
                        : icons['unknown'].color
                    }
                    name={
                      icons[changeType]
                        ? icons[changeType].icon
                        : icons['unknown'].icon
                    }
                    verticalAlign="middle"
                  />
                </Table.Cell>
                <Table.Cell className="Changelog__Cell">
                  {change[changeType]}
                </Table.Cell>
              </Table.Row>
            );
          })}
        </Table>
      </Box>
    </Stack.Item>
  );
};

export const BubberChangelog = (props) => {
  const { data } = useBackend();
  const { dates } = data;
  const [contents, setContents] = useState('');
  const [bubberContents, setBubberContents] = useState('');
  const [selectedDate, setSelectedDate] = useState(dates[0]);

  useEffect(() => {
    setContents('Loading changelog data...');
    setBubberContents('Loading changelog data...');
    getData(selectedDate);
  }, [selectedDate]);

  function getData(date, attemptNumber = 1) {
    const { act } = useBackend();
    const maxAttempts = 6;

    if (attemptNumber > maxAttempts) {
      setContents('Failed to load data after ' + maxAttempts + ' attempts.');
      return;
    }

    act('get_month', { date });

    Promise.all([
      fetch(resolveAsset(date + '.yml')),
      fetch(resolveAsset('bubber_' + date + '.yml')),
    ]).then(async (links) => {
      const result = await links[0].text();
      const bubberResult = await links[1].text();

      if (links[0].status !== 200 && links[1].status !== 200) {
        const timeout = 50 + attemptNumber * 50;

        setContents('Loading changelog data' + '.'.repeat(attemptNumber + 3));
        setBubberContents(
          'Loading changelog data' + '.'.repeat(attemptNumber + 3),
        );
        setTimeout(() => {
          getData(date, attemptNumber + 1);
        }, timeout);
      } else {
        if (links[0].status === 200) {
          setContents(yaml.load(result, { schema: yaml.CORE_SCHEMA }));
        }
        if (links[1].status === 200) {
          setBubberContents(
            yaml.load(bubberResult, { schema: yaml.CORE_SCHEMA }),
          );
        }
      }
    });
  }

  const header = (
    <Section>
      <h1>Bubberstation 13</h1>
      <p>
        <b>Thanks to: </b>
        /tg/station 13, Effigy, Stellar Haven, Baystation 12, /vg/station,
        NTstation, CDK Station devs, FacepunchStation, GoonStation devs, the
        original Space Station 13 developers, and the countless others who have
        contributed to the game.
      </p>
      <p>
        {'Current organization members can be found '}
        <a href="https://github.com/orgs/Bubberstation/people">here</a>
        {', recent GitHub contributors can be found '}
        <a href="https://github.com/Bubberstation/Bubberstation/pulse/monthly">
          here
        </a>
        .
      </p>
      <p>
        {'You can also join our discord '}
        <a href="https://discord.com/invite/AvjrTqnqEx">here</a>!
      </p>
      <DateDropdown
        dates={dates}
        selectedDate={selectedDate}
        setSelectedDate={setSelectedDate}
      />
    </Section>
  );

  const footer = (
    <Section>
      <DateDropdown
        dates={dates}
        selectedDate={selectedDate}
        setSelectedDate={setSelectedDate}
      />
      <h2>Licenses</h2>
      <Section title="Bubberstation 13">
        <p>
          {'All code is licensed under '}
          <a href="https://www.gnu.org/licenses/agpl-3.0.html">GNU AGPL v3</a>.
          {' See '}
          <a href="https://github.com/bubberstation/bubberstation/blob/master/LICENSE">
            LICENSE
          </a>{' '}
          for more details.
        </p>
        <p>
          {'All assets including icons and sound are under a '}
          <a href="https://creativecommons.org/licenses/by-sa/3.0/">
            Creative Commons 3.0 BY-SA license
          </a>
          {' unless otherwise indicated.'}
        </p>
      </Section>
      <Section title="TGS">
        <p>
          The TGS DMAPI API is licensed as a subproject under the MIT license.
        </p>
        <p>
          {' See the footer of '}
          <a
            href={
              'https://github.com/tgstation/tgstation/blob/master' +
              '/code/__DEFINES/tgs.dm'
            }
          >
            code/__DEFINES/tgs.dm
          </a>
          {' and '}
          <a
            href={
              'https://github.com/tgstation/tgstation/blob/master' +
              '/code/modules/tgs/LICENSE'
            }
          >
            code/modules/tgs/LICENSE
          </a>
          {' for the MIT license.'}
        </p>
      </Section>
      <Section title="/tg/station 13">
        <p>
          {'All code after '}
          <a
            href={
              'https://github.com/tgstation/tgstation/commit/' +
              '333c566b88108de218d882840e61928a9b759d8f'
            }
          >
            commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at
            4:38 PM PST
          </a>
          {' is licensed under '}
          <a href="https://www.gnu.org/licenses/agpl-3.0.html">GNU AGPL v3</a>.
        </p>
        <p>
          {'All code before that commit is licensed under '}
          <a href="https://www.gnu.org/licenses/gpl-3.0.html">GNU GPL v3</a>
          {', including tools unless their readme specifies otherwise. See '}
          <a href="https://github.com/tgstation/tgstation/blob/master/LICENSE">
            LICENSE
          </a>
          {' and '}
          <a href="https://github.com/tgstation/tgstation/blob/master/GPLv3.txt">
            GPLv3.txt
          </a>
          {' for more details.'}
        </p>
        <p>
          {'All assets including icons and sound are under a '}
          <a href="https://creativecommons.org/licenses/by-sa/3.0/">
            Creative Commons 3.0 BY-SA license
          </a>
          {' unless otherwise indicated.'}
        </p>
      </Section>
      <Section title="Goonstation SS13">
        <p>
          <b>Coders: </b>
          Stuntwaffle, Showtime, Pantaloons, Nannek, Keelin, Exadv1, hobnob,
          Justicefries, 0staf, sniperchance, AngriestIBM, BrianOBlivion
        </p>
        <p>
          <b>Spriters: </b>
          Supernorn, Haruhi, Stuntwaffle, Pantaloons, Rho, SynthOrange, I Said
          No
        </p>
        <p>
          Bubberstation and /tg/station 13 are thankful to the GoonStation 13
          Development Team for its work on the game up to the
          {' r4407 release. The changelog for changes up to r4407 can be seen '}
          <a href="https://wiki.ss13.co/Pre-2016_Changelog#April_2010">here</a>.
        </p>
        <p>
          {'Except where otherwise noted, Goon Station 13 is licensed under a '}
          <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/">
            Creative Commons Attribution-Noncommercial-Share Alike 3.0 License
          </a>
          .
        </p>
        <p>
          {'Rights are currently extended to '}
          <a href="http://forums.somethingawful.com/">SomethingAwful Goons</a>
          {' only.'}
        </p>
      </Section>
    </Section>
  );

  return (
    <Window title="Changelog" width={730} height={700}>
      <Window.Content scrollable>
        {header}
        <ChangelogList contents={contents} bubberContents={bubberContents} />
        {footer}
      </Window.Content>
    </Window>
  );
};
