import { useEffect, useState } from 'react';
import { Icon, Image } from 'tgui-core/components';

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
