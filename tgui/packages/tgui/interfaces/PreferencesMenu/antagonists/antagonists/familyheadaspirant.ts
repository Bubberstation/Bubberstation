import { type Antagonist, Category } from '../base';
import { GANGSTER_MECHANICAL_DESCRIPTION } from './gangster';

const FamilyHeadAspirant: Antagonist = {
  key: 'familyheadaspirant',
  name: 'Family Head Aspirant',
  description: [
    `
      A form of family leader that can activate at any point in the middle
      of the shift.
    `,
    GANGSTER_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default FamilyHeadAspirant;
