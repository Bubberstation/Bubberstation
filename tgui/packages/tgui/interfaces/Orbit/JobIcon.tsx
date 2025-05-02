import { DmIcon, Icon } from 'tgui-core/components';

import { JOB2ICON } from '../common/JobToIcon';
import { Antagonist, Observable } from './types';

// BUBBER EDIT ADDITION BEGIN - Custom observe menu icons
const customJobs = [
  'Telecomms Specialist',
  'Barber',
  'Blueshield',
  'Bouncer',
  'Corrections Officer',
  'Customs Agent',
  'Engineering Guard',
  'Nanotrasen Consultant',
  'Orderly',
  'Science Guard',
  'Security Medic',
  'Persistence Hostage',
  'Persistence General Staff',
  'Persistence Sanitation Technician',
  'Persistence Researcher',
  'Persistence Engineering Officer',
  'Persistence Medical Officer',
  'Persistence Cargo Technician',
  'Persistence Master At Arms',
  'Persistence Brig Officer',
  'Syndicate Corporate Liaison',
  'Persistence Admiral',
  'Tarkon Ensign',
];
// BUBBER EDIT ADDITION END - Custom observe menu icons

type Props = {
  item: Observable | Antagonist;
  realNameDisplay: boolean;
};

type IconSettings = {
  dmi: string;
  transform: string;
};

const normalIcon: IconSettings = {
  dmi: 'icons/mob/huds/hud.dmi',
  transform: 'scale(2.3) translateX(9px) translateY(1px)',
};

const antagIcon: IconSettings = {
  dmi: 'icons/mob/huds/antag_hud.dmi',
  transform: 'scale(1.8) translateX(-16px) translateY(7px)',
};

// BUBBER EDIT ADDITION BEGIN - Custom observe menu icons
const customIcon: IconSettings = {
  dmi: 'modular_zubbers/icons/mob/huds/hud.dmi',
  transform: 'scale(2.3) translateX(9px) translateY(1px)',
};
// BUBBER EDIT ADDITION END - Custom observe menu icons

export function JobIcon(props: Props) {
  const { item, realNameDisplay } = props;

  // We don't need to cast here but typescript isn't smart enough to know that
  const { icon = '', job = '', mind_icon = '', mind_job = '' } = item;
  let usedIcon = realNameDisplay ? mind_icon || icon : icon;
  let usedJob = realNameDisplay ? mind_job || job : job;

  let iconSettings: IconSettings;
  if ('antag' in item && !realNameDisplay) {
    iconSettings = antagIcon;
    usedJob = item.antag;
    usedIcon = item.antag_icon;
    // BUBBER EDIT ADDITION BEGIN - Custom observe menu icons
  } else if (customJobs.includes(usedJob)) {
    iconSettings = customIcon;
    // BUBBER EDIT ADDITION END - Custom observe menu icons
  } else {
    iconSettings = normalIcon;
  }

  return (
    <div className="JobIcon">
      {icon === 'borg' ? (
        <Icon color="lightblue" name={JOB2ICON[usedJob]} ml={0.3} mt={0.4} />
      ) : (
        <DmIcon
          icon={iconSettings.dmi}
          icon_state={usedIcon}
          style={{
            transform: iconSettings.transform,
          }}
        />
      )}
    </div>
  );
}
