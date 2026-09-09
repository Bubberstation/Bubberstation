// THIS IS A BUBBER UI FILE #BUBBERGANG😝
import { CheckboxInput, type Feature } from '../../base';

export const well_trained__prefers_males: Feature<boolean> = {
  name: 'Subs To He/Him',
  component: CheckboxInput,
};

export const well_trained__prefers_females: Feature<boolean> = {
  name: 'Subs To She/Her',
  component: CheckboxInput,
};

export const well_trained__prefers_plurals: Feature<boolean> = {
  name: 'Subs To They/Them',
  component: CheckboxInput,
};

export const well_trained__prefers_neuters: Feature<boolean> = {
  name: 'Subs To It/Its',
  component: CheckboxInput,
};

export const well_trained__prefers_other: Feature<boolean> = {
  name: 'Subs To Any Other Genders',
  component: CheckboxInput,
};

export const well_trained__snap: Feature<boolean> = {
  name: 'Be Commanded With *snap',
  component: CheckboxInput,
};

export const well_trained__snap2: Feature<boolean> = {
  name: 'Be Commanded With *snap2',
  component: CheckboxInput,
};

export const well_trained__snap3: Feature<boolean> = {
  name: 'Be Commanded With *snap3',
  component: CheckboxInput,
};

export const well_trained__clicker: Feature<boolean> = {
  name: 'Be Commanded With Clicker',
  component: CheckboxInput,
};

export const well_trained__sub_inspect_dom: Feature<boolean> = {
  name: 'Be Embarassed Upon Examining Dom',
  component: CheckboxInput,
  description:
    'If unchecked, you will not blush and turn when inspecting a compatible dom. ',
};

export const well_trained__sub_sense_dom: Feature<boolean> = {
  name: 'Dom Sense',
  component: CheckboxInput,
  description:
    'If unchecked, you will not be alerted to the presence of compatible doms automatically, and will not recieve a positive moodlet for being near them. ',
};
