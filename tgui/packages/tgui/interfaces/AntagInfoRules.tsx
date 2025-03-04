// THIS IS A SKYRAT UI FILE
import { Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Objective } from './common/Objectives';

type Info = {
  antag_name: string;
  objectives: Objective[];
};

export const Rules = (props) => {
  const { data } = useBackend<Info>();
  const { antag_name } = data;
  switch (antag_name) {
    case 'Abductor Agent':
    case 'Abductor Scientist':
    case 'Abductor Solo':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Drifting Contractor':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Cortical Borer':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Venus Human Trap':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Obsessed':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Revenant':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Space Dragon':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Space Pirate':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Blob':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Changeling':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'ClockCult':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'AssaultOps':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Heretic':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Malf AI':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Morph':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Nightmare':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Ninja':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Wizard':
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    default:
      return (
        // Bubberstation Edit
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.bubberstation.org/index.php?title=Rules">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
  }
};
