export const ANTAG2COLOR = {
  Abductors: 'pink',
  'Ash Walkers': 'olive',
  Biohazards: 'brown',
  'Bounty Hunters': 'yellow',
  CentCom: 'teal',
  'Digital Anomalies': 'teal',
  'Emergency Response Team': 'teal',
  'Escaped Fugitives': 'orange',
  'Xenomorph Infestation': 'violet',
  'Spacetime Aberrations': 'white',
  'Deviant Crew': 'white',
  'Invasive Overgrowth': 'green',
} as const;

type Department = {
  color: string;
  trims: string[];
};

export const DEPARTMENT2COLOR: Record<string, Department> = {
  cargo: {
    color: 'brown',
    trims: ['Bitrunner', 'Cargo Technician', 'Shaft Miner', 'Quartermaster', 'Blacksmith', 'Customs Agent' ],
    // BUBBER EDIT ADDITION - Blacksmith, Customs Agent
  },
  command: {
    color: 'blue',
    trims: ['Captain', 'Head of Personnel', 'Nanotrasen Consultant', 'Blueshield', 'Bridge Assistant'],
    // BUBBER EDIT ADDITION - Nanotrasen Consultant, Blueshield, Bridge Assistant
  },
  engineering: {
    color: 'orange',
    trims: ['Atmospheric Technician', 'Chief Engineer', 'Station Engineer', 'Telecomms Specialist', 'Engineering Guard'],
    // BUBBER EDIT ADDITION - Telecomms Specialist, Engineering Guard
  },
  medical: {
    color: 'teal',
    trims: [
      'Chemist',
      'Chief Medical Officer',
      'Coroner',
      'Medical Doctor',
      'Paramedic',
      'Orderly',  // BUBBER EDIT ADDITION
    ],
  },
  science: {
    color: 'pink',
    trims: ['Geneticist', 'Research Director', 'Roboticist', 'Scientist', 'Science Guard'],
    // BUBBER EDIT ADDITION - Science Guard
  },
  security: {
    color: 'red',
    trims: ['Detective', 'Head of Security', 'Security Officer', 'Warden', 'Security Medic', 'Corrections Officer'],
    // BUBBER EDIT ADDITION - Security Medic, Corrections Officer
  },
  service: {
    color: 'green',
    trims: [
      'Bartender',
      'Botanist',
      'Chaplain',
      'Chef',
      'Clown',
      'Cook',
      'Curator',
      'Janitor',
      'Lawyer',
      'Mime',
      'Psychologist',
      'Barber',  // BUBBER EDIT ADDITION
      'Bouncer',  // BUBBER EDIT ADDITION
    ],
  },
};

export const THREAT = {
  Low: 1,
  Medium: 5,
  High: 8,
} as const;

export const HEALTH = {
  Good: 69, // nice
  Average: 19,
  Bad: 0,
  Crit: -30,
  Dead: -100,
  Ruined: -200,
} as const;

export const VIEWMODE = {
  Health: 'heart',
  Orbiters: 'ghost',
  Department: 'id-badge',
} as const;
