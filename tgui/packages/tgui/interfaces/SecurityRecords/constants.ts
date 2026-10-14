export const CRIMESTATUS2COLOR = {
  Arrest: 'bad',
  Discharged: 'blue',
  Incarcerated: 'brown', // BUBBER EDIT CHANGE - WARRANTS - was 'average', clashed with Alert; brown matches its lock icon
  Parole: 'good',
  Suspected: 'teal',
  // BUBBER EDIT ADDITION - WARRANTS - Alert is amber, death warrants are black
  Alert: 'orange',
  Execute: 'black',
} as const;

export const CRIMESTATUS2DESC = {
  None: 'None. No active status.', // BUBBER EDIT ADDITION - WARRANTS
  Arrest: 'Arrest. Target must have valid crimes to set this status.',
  Discharged: 'Discharged. Individual has been acquitted from wrongdoing.',
  Incarcerated: 'Incarcerated. Individual is currently serving a sentence.',
  Parole: 'Parole. Released from prison, but still under supervision.',
  Suspected: 'Suspected. Monitor closely for criminal activity.',
  // BUBBER EDIT ADDITION - WARRANTS
  Alert: 'Alert. Flagged for questioning. Stop and identify.',
  Execute: 'Execute. Uncontainable hostile, lethal force authorized.',
} as const;

// BUBBER EDIT ADDITION - WARRANTS - FontAwesome icons per status
export const CRIMESTATUS2ICON = {
  None: 'user',
  Suspected: 'magnifying-glass',
  Alert: 'triangle-exclamation',
  Arrest: 'handcuffs',
  Execute: 'skull',
  Incarcerated: 'lock',
  Parole: 'person-walking-arrow-right',
  Discharged: 'scale-balanced',
} as const;
