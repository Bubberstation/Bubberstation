// THIS IS A BUBBER UI FILE #BUBBERGANG😝
import { CheckboxInput, type Feature } from '../../base';

export const dom_aura__prefers_males: Feature<boolean> = {
  name: 'Is Dom To He/Him',
  component: CheckboxInput,
};

export const dom_aura__prefers_females: Feature<boolean> = {
  name: 'Is Dom To She/Her',
  component: CheckboxInput,
};

export const dom_aura__prefers_plurals: Feature<boolean> = {
  name: 'Is Dom To They/Them',
  component: CheckboxInput,
};

export const dom_aura__prefers_neuters: Feature<boolean> = {
  name: 'Is Dom To It/Its',
  component: CheckboxInput,
};

export const dom_aura__prefers_other: Feature<boolean> = {
  name: 'Is Dom To Any Other Genders',
  component: CheckboxInput,
};

export const dom_aura__snap: Feature<boolean> = {
  name: 'Command Subs With *snap',
  component: CheckboxInput,
};

export const dom_aura__snap2: Feature<boolean> = {
  name: 'Command Subs With *snap2',
  component: CheckboxInput,
};

export const dom_aura__snap3: Feature<boolean> = {
  name: 'Command Subs With *snap3',
  component: CheckboxInput,
};

export const dom_aura__clicker: Feature<boolean> = {
  name: 'Command Subs With Clicker',
  component: CheckboxInput,
};

export const dom_aura__sub_inspect_dom: Feature<boolean> = {
  name: 'Embarass Subs If They Examine You',
  component: CheckboxInput,
  description:
    'If unchecked, compatible subs will not blush and turn when inspecting you. ',
};

export const dom_aura__sub_sense_dom: Feature<boolean> = {
  name: 'Aura',
  component: CheckboxInput,
  description:
    'If unchecked, compatible subs will not be alerted to your presence automatically, and will not recieve a positive moodlet for being near you. ',
};
