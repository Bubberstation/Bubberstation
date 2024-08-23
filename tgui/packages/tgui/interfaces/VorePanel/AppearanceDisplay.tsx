import { BooleanLike } from 'common/react';
import { useEffect, useRef, useState } from 'react';
import { Color } from 'tgui-core/color';
import { Box, Icon, Image } from 'tgui-core/components';

/**
 * Waits until two XMLHttpRequests have loaded at iconSrc before calling cb().
 * @param iconSrc
 * @param cb
 */
function getTwice(iconSrc: string, cb: () => void) {
  const xhr = new XMLHttpRequest();
  // Block effect until we load
  xhr.open('GET', iconSrc + '?preload');
  xhr.send();
  xhr.onload = () => {
    const xhr = new XMLHttpRequest();
    // Block effect until we load
    xhr.open('GET', iconSrc + '?preload2');
    xhr.send();
    xhr.onload = cb;
  };
}

export const AppearanceDisplay = (props: { iconSrc: string }) => {
  const { iconSrc } = props;
  const [icon, setIcon] = useState<string>();

  // This forces two XMLHttpRequests to go through
  // before we try and render the icon for real.
  // Basically just makes sure BYOND knows we really want this icon instead of possibly getting back a transparent png.
  useEffect(() => {
    getTwice(iconSrc, () => {
      setIcon(iconSrc);
    });
  }, [iconSrc]);

  if (icon) {
    return (
      <Image fixErrors src={icon} ml={-1} mt={-1} height="64px" width="64px" />
    );
  } else {
    return <Icon name="spinner" size={2.2} spin color="gray" />;
  }
};

export const renderImage = (
  image: HTMLImageElement,
  canvas: HTMLCanvasElement,
  context: CanvasRenderingContext2D,
  color: string,
  recolorable: BooleanLike,
) => {
  context.drawImage(image, 0, 0, canvas.width, canvas.height);

  if (recolorable) {
    let color_rgb = Color.fromHex(color);
    let imageData = context.getImageData(0, 0, canvas.width, canvas.height);
    const pixelsPerProcess = 4 * canvas.width * 8;

    let frames = 0;
    let i = 0;
    const recolor = () => {
      let start = i;
      while (i - start < pixelsPerProcess) {
        imageData.data[i + 0] *= color_rgb.r / 255;
        imageData.data[i + 1] *= color_rgb.g / 255;
        imageData.data[i + 2] *= color_rgb.b / 255;
        i += 4;
      }

      // Give a few incremental updates
      // just to let users know it's happening
      frames += 1;
      if (frames > 3) {
        context.putImageData(imageData, 0, 0);
        frames = 0;
      }

      if (i < imageData.data.length) {
        window.requestAnimationFrame(recolor);
      } else {
        context.putImageData(imageData, 0, 0);
      }
    };
    recolor();
  }
};

let loadedImages = {};

export const BellyFullscreenIcon = (props: {
  icon: string;
  icon_state: string;
  color: string;
  recolorable: BooleanLike;
}) => {
  const { icon, icon_state, color, recolorable } = props;

  const iconRef = Byond.iconRefMap?.[icon];

  const canvasRef = useRef<HTMLCanvasElement>(null);
  useEffect(() => {
    if (!iconRef) {
      return;
    }
    const canvas = canvasRef.current;
    if (!canvas) {
      return;
    }
    const context = canvas.getContext('2d');
    if (!context) {
      return;
    }

    let src = `${iconRef}?state=${icon_state}`;

    if (loadedImages[src]) {
      let image = loadedImages[src];
      renderImage(image, canvas, context, color, recolorable);
      return;
    }

    const image = document.createElement('img');
    document.body.appendChild(image);
    image.setAttribute('style', 'display:none');
    image.src = src;
    image.onload = () => {
      loadedImages[image.src] = image;
      renderImage(image, canvas, context, color, recolorable);
    };
    image.onerror = () => {
      context.fillStyle = 'red';
      context.fillText('Error', 0, 0, 248);
    };
  }, [icon, icon_state, color, recolorable]);

  if (!iconRef) {
    return <Icon name="spinner" />;
  }

  return (
    <Box width={21} height={21}>
      <canvas ref={canvasRef} width={248} height={248} />
    </Box>
  );
};
