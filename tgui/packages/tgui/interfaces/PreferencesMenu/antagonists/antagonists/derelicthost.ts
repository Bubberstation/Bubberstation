import { Antagonist, Category } from '../base';

export const DERELICT_HOST_MECHANICAL_DESCRIPTION = `
You've found yourself wearing an abandoned prototype modsuit.
`;

const DerelictHost: Antagonist = {
  key: 'derelicthost',
  name: 'Derelict Host',
  description: [DERELICT_HOST_MECHANICAL_DESCRIPTION],
  category: Category.Midround,
};

export default DerelictHost;
