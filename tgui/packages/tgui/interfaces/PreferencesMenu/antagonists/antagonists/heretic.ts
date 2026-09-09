import { type Antagonist, Category } from '../base';
// BUBBER EDIT CHANGE - description completely rewritten
export const HERETIC_MECHANICAL_DESCRIPTION = `
      Find hidden influences and ways to gain magical
      powers and become powerful as one of several paths.
   `;

const Heretic: Antagonist = {
  key: 'heretic',
  name: 'Acolyte', // BUBBER EDIT CHANGE - renamed to Acolyte
  description: [
    `
      Forgotten, devoured, gutted. Humanity has forgotten the eldritch forces
      of decay, but the mansus veil has weakened. We will make them taste fear
      again...
    `,
    HERETIC_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Heretic;
