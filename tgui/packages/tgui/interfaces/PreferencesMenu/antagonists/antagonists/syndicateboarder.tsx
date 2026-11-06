// THIS IS A SKYRAT UI FILE
import { type Antagonist, Category } from '../base';

const SyndicateBoarder: Antagonist = {
  key: 'syndicateboarder',
  name: 'Syndicate Boarder',
  description: [
    `A midround traitor that can spawn near the station, equipped with
    a Syndicate Modsuit and equipment befitting a station boarder.
    Float onto the station and complete your objectives.
    This is a significantly harder version of traitor, meant to provide a challenge.
    Not to be confused with Lone Operative.`,
  ],
  category: Category.Midround,
};

export default SyndicateBoarder;
