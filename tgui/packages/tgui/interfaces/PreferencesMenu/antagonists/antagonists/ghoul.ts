import { Antagonist, Category } from '../base';

export const GHOUL_MECHANICAL_DESCRIPTION = `
Serve your undead masters as a Ghoul.
Use the powers your master has bestowed upon you to see your master's will done.
Protect them at any cost, and help them rise to power over Space Station 13.
`;

const Ghoul: Antagonist = {
  key: 'ghoul',
  name: 'Ghoul',
  description: [GHOUL_MECHANICAL_DESCRIPTION],
  category: Category.Roundstart,
};

export default Ghoul;
