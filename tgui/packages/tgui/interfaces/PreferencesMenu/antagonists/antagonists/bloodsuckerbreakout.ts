import { Antagonist, Category } from '../base';

export const VAMPIRE_MECHANICAL_DESCRIPTION = `
After your death, you awaken to see yourself as an undead monster.
Use your Vampiric abilities as best you can.
Scrape by Space Station 13, or take over it, vassalizing your way.
`;

const BloodsuckerBreakout: Antagonist = {
  key: 'bloodsuckerlatejoin',
  name: 'Bloodsucker (Latejoin)',
  description: [VAMPIRE_MECHANICAL_DESCRIPTION],
  category: Category.Latejoin,
};

export default BloodsuckerBreakout;
