import { Antagonist, Category } from '../base';

export const VAMPIRE_MECHANICAL_DESCRIPTION = `
After your death, you awaken to see yourself as an undead monster.
Use your Vampiric abilities as best you can.
Scrape by Space Station 13, or take over it, ghoulizing your way.
`;

const VampiricAccident: Antagonist = {
  key: 'bloodsuckermidround',
  name: 'Bloodsucker (Midround)',
  description: [VAMPIRE_MECHANICAL_DESCRIPTION],
  category: Category.Midround,
};

export default VampiricAccident;
