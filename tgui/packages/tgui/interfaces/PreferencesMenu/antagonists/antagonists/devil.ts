import { type Antagonist, Category } from '../base';

const Devil: Antagonist = {
  key: 'devil',
  name: 'Devil',
  description: [
    `
      You are an agent from hell with the primary goal of making deals in exchange for souls.
    `,
  ],
  category: Category.Roundstart,
};

export default Devil;
