import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

// The player character
type FlapMoth = {
  position: number; // y position
  velocity: number; // y velocity
  hitbox: number; // y range of hitbox when passing obstacles
};

// The obstacles we avoid
type FlapObstacle = {
  upperlimit: number; // top edge of passage
  lowerlimit: number; // bot edge of passage
  position: number; // x position (0 is the moth)
  hitbox: number; // x range of hitbox
};

// Any extra prop controlling - Might use later
type FlapProps = {};

type FlapState = {
  player: FlapMoth;
};

// FLAPPY MOTH minigame class
class FlapMinigame {
  animation_id: number;
  last_frame: number;
  state: FlapState;
  gameheight: number = 500;

  playerhitbox: number = 10;

  constructor() {
    this.state = {
      player: {
        position: this.gameheight / 2,
        velocity: 0,
        hitbox: this.playerhitbox,
      },
    };
  }
}

export const ZubbersFlappyMoth = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <NtosWindow width={600} height={572}>
      <NtosWindow.Content>
        <FlapMinigame />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
