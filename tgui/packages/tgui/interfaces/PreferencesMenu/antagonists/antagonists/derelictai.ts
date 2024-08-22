import { Antagonist, Category } from '../base';

export const DERELICT_AI_MECHANICAL_DESCRIPTION = `
You are an AI that was sent drifting through space in an aging modsuit.
Your suit is designed to link your desires to those who wear it.
Get someone to wear your suit and work together to accomplish your goals.
`;

const DerelictAI: Antagonist = {
  key: 'derelict ai',
  name: 'Derelict AI',
  description: [DERELICT_AI_MECHANICAL_DESCRIPTION],
  category: Category.Midround,
};

export default DerelictAI;
