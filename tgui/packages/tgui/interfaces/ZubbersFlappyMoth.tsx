import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { globalEvents } from '../events';

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

    // Controls handling!!
    this.handle_mousedown = this.handle_mousedown.bind(this);
    this.handle_mouseup = this.handle_mouseup.bind(this);
    this.handleKeyDown = this.handleKeyDown.bind(this);
    this.handleKeyUp = this.handleKeyUp.bind(this);
    this.handle_ctrldown = this.handle_ctrldown.bind(this);
    this.handle_ctrlup = this.handle_ctrlup.bind(this);

    // Updates the animation
    this.updateAnimation = this.updateAnimation.bind(this);

    // Binds the moff movement
    this.moveMoth = this.moveMoth.bind(this);
  }
  componentDidMount() {
    // add binds blah blah
    document.addEventListener('mousedown', this.handle_mousedown);
    document.addEventListener('mouseup', this.handle_mouseup);
    this.animation_id = window.requestAnimationFrame(this.updateAnimation);
    globalEvents.on('byond/mousedown', this.handle_mousedown);
    globalEvents.on('byond/mouseup', this.handle_mouseup);
    globalEvents.on('byond/ctrldown', this.handle_ctrldown);
    globalEvents.on('byond/ctrlup', this.handle_ctrlup);
  }

  componentWillUnmount() {
    document.removeEventListener('mousedown', this.handle_mousedown);
    document.removeEventListener('mouseup', this.handle_mouseup);
    window.cancelAnimationFrame(this.animation_id);
    globalEvents.off('byond/mousedown', this.handle_mousedown);
    globalEvents.off('byond/mouseup', this.handle_mouseup);
    globalEvents.off('byond/ctrldown', this.handle_ctrldown);
    globalEvents.off('byond/ctrlup', this.handle_ctrlup);
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
    // let newVelocity = player.velocity; why

    // Bounding the position so we don't flap our way out
    if (newPosition < 0) {
      newPosition = 0;
      player.velocity = 0;
    } else if (newPosition + player.hitbox > this.gameheight) {
      newPosition = this.gameheight - player.hitbox;
      player.velocity = 0;
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
