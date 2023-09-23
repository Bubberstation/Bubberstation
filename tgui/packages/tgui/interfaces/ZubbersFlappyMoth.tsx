import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { Component } from 'inferno';
import { globalEvents, KeyEvent } from '../events';
import { KEY_CTRL } from '../../common/keycodes';

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
  score: number;
};

enum FlapMovementState {
  Idle,
  Flap,
}

// FLAPPY MOTH minigame class
class FlapMinigame extends Component<FlapMovementState, FlapProps> {
  animation_id: number;
  last_frame: number;
  state: FlapState;
  movementstate: FlapMovementState;
  gameheight: number = 500;

  playerhitbox: number = 10;

  constructor(props: FlapProps) {
    super(props);

    this.state = {
      player: {
        position: this.gameheight / 2,
        velocity: 0,
        hitbox: this.playerhitbox,
      },
      score: 0,
    };

    // Controls handling!!
    this.handle_mousedown = this.handle_mousedown.bind(this);
    this.handle_keydown = this.handle_keydown.bind(this);
    this.handle_ctrldown = this.handle_ctrldown.bind(this);

    // Updates the animation
    this.updateAnimation = this.updateAnimation.bind(this);

    // Binds the moff movement
    this.moveMoth = this.moveMoth.bind(this);
  }

  // add binds
  componentDidMount() {
    document.addEventListener('mousedown', this.handle_mousedown);
    this.animation_id = window.requestAnimationFrame(this.updateAnimation);
    globalEvents.on('byond/mousedown', this.handle_mousedown);
    globalEvents.on('byond/ctrldown', this.handle_ctrldown);
  }

  // remove binds
  componentWillUnmount() {
    document.removeEventListener('mousedown', this.handle_mousedown);
    window.cancelAnimationFrame(this.animation_id);
    globalEvents.off('byond/mousedown', this.handle_mousedown);
    globalEvents.off('byond/ctrldown', this.handle_ctrldown);
  }

  moveMoth(state: FlapState, delta: number): FlapState {
    // Delta time when we lag
    const seconds = delta / 1000;
    // The moth
    const { player } = this.state;
    // Speedup when flapping
    const acceleration_up = -1500;
    // Oop here comes gravity
    const acceleration_down = 1000;

    let newPosition = player.position + seconds * player.velocity;

    let newVelocity = player.velocity;

    // Bounding the position so we don't flap our way out
    if (newPosition < 0) {
      newPosition = 0;
      newVelocity = 0;
    } else if (newPosition + player.hitbox > this.gameheight) {
      newPosition = this.gameheight - player.hitbox;
      newVelocity = 0;
    }

    if (Math.abs(player.velocity) < 0.01) {
      newVelocity = 0;
    }

    const newState: FlapState = {
      ...state,
      player: { ...player, position: newPosition, velocity: newVelocity },
    };
    return newState;
  }

  handle_mousedown(event: MouseEvent) {
    if (this.movementstate === FlapMovementState.Idle) {
      this.movementstate = FlapMovementState.Flap;
    }
  }

  handle_keydown(keyEvent: KeyEvent) {
    if (keyEvent.code === KEY_CTRL) {
      this.handle_ctrldown;
    }
  }

  handle_ctrldown() {
    if (this.movementstate === FlapMovementState.Idle) {
      this.movementstate = FlapMovementState.Flap;
    }
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
