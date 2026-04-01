// THIS IS A BUBBER UI FILE
import { Icon, ProgressBar, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../../backend';

type HeaderInfo = {
  isTargetSelf: BooleanLike;
  pleasure: number;
  arousal: number;
  pain: number;
  theirPleasure: number;
  theirArousal: number;
  theirPain: number;
  arousalLimit: number;
  theirName: string;
  yourName: string;
};

export const InfoSection = () => {
  const { data } = useBackend<HeaderInfo>();
  const {
    isTargetSelf,
    pleasure,
    arousal,
    pain,
    theirPleasure,
    theirArousal,
    theirPain,
    yourName,
    theirName,
    arousalLimit,
  } = data;
  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item grow>
          <Stack>
            <Stack.Item grow>{yourName}</Stack.Item>
            {!isTargetSelf ? <Stack.Item grow>{theirName}</Stack.Item> : null}
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item grow>
              <Stack vertical>
                <Stack.Item>
                  <ProgressBar
                    value={pleasure}
                    maxValue={arousalLimit}
                    color="purple"
                  >
                    <Icon name="heart" /> Pleasure
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar
                    value={arousal}
                    maxValue={arousalLimit}
                    color="pink"
                  >
                    <Icon name="tint" /> Arousal
                  </ProgressBar>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar value={pain} maxValue={arousalLimit} color="red">
                    <Icon name="bolt" /> Pain
                  </ProgressBar>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            {!isTargetSelf ? (
              <Stack.Item grow>
                <Stack vertical>
                  <Stack.Item>
                    <ProgressBar
                      value={theirPleasure}
                      maxValue={arousalLimit}
                      color="purple"
                    >
                      <Icon name="heart" /> Pleasure
                    </ProgressBar>
                  </Stack.Item>
                  <Stack.Item>
                    <ProgressBar
                      value={theirArousal}
                      maxValue={arousalLimit}
                      color="pink"
                    >
                      <Icon name="tint" /> Arousal
                    </ProgressBar>
                  </Stack.Item>
                  <Stack.Item>
                    <ProgressBar
                      value={theirPain}
                      maxValue={arousalLimit}
                      color="red"
                    >
                      <Icon name="bolt" /> Pain
                    </ProgressBar>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ) : null}
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
