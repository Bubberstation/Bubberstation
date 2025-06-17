import { ComponentProps, type ReactNode, useRef, useState } from 'react';
import { Box, Button, Floating, Icon } from 'tgui-core/components';
import { KEY } from 'tgui-core/keys';
import { classes } from 'tgui-core/react';
import { unit } from 'tgui-core/ui';

type SideDropdownEntry = {
  displayText: ReactNode;
  value: string | number;
};

type SideDropdownOption = string | SideDropdownEntry;

type BoxProps = ComponentProps<typeof Box>;

type Props = {
  /** Called when a value is picked from the list, `value` is the value that was picked */
  onSelected: (value: any) => void;
  /** An array of strings which will be displayed in the
  dropdown when open. See Dropdown.tsx for more advanced usage with DropdownEntry */
  options: SideDropdownOption[];
  /** Currently selected entry to display. Can be left stateless to permanently display this value. */
  selected: SideDropdownOption | null | undefined;
} & Partial<{
  /** Whether to scroll automatically on open. Defaults to true */
  autoScroll: boolean;
  /** Whether to display previous / next buttons */
  buttons: boolean;
  /** Color of dropdown button */
  color: string;
  /** Disables the dropdown */
  disabled: boolean;
  /** Overwrites selection text with this. Good for objects etc. */
  displayText: ReactNode;
  /** Icon to display in dropdown button */
  icon: string;
  /** Whether the icon should be displayed alone */
  iconOnly: boolean;
  /** Angle of the icon */
  iconRotation: number;
  /** Whether or not the icon should spin */
  iconSpin: boolean;
  /** Width of the dropdown menu in box units. Default: 15 */
  menuWidth: string | number;
  /** Whether or not the arrow on the right hand side of the dropdown button is visible */
  noChevron: boolean;
  /** Text to show when nothing has been selected. */
  placeholder: string;
  /** @deprecated If you want to allow dropdown breaks layout, set width 100% */
  clipSelectedText: boolean;
  /** Called when dropdown button is clicked */
  onClick: (event) => void;
  /** Dropdown renders over instead of below */
  over: boolean;
}> &
  BoxProps;

enum DIRECTION {
  Current = 'current',
  Next = 'next',
  Previous = 'previous',
}

const NONE = -1;

function getOptionValue(option: SideDropdownOption) {
  return typeof option === 'string' ? option : option.value;
}

/**
 * ## Dropdown
 * A simple dropdown box component. Lets the user select from a list of options
 * and displays selected entry.
 */
export function SideDropdown(props: Props) {
  const {
    autoScroll = true,
    buttons,
    className,
    color = 'default',
    disabled,
    displayText,
    icon,
    iconRotation,
    iconSpin,
    iconOnly,
    menuWidth,
    noChevron,
    onClick,
    onSelected,
    options = [],
    placeholder = 'Select...',
    selected,
    width = 15,
  } = props;

  const [open, setOpen] = useState(false);
  const innerRef = useRef<HTMLDivElement>(null);

  const selectedIndex =
    options.findIndex((option) => getOptionValue(option) === selected) || 0;

  function scrollToElement(position: number) {
    let scrollPos = position;
    if (position < selectedIndex) {
      scrollPos = position < 2 ? 0 : position - 2;
    } else {
      scrollPos =
        position > options.length - 3 ? options.length - 1 : position - 2;
    }

    const dropdownMenu = innerRef.current;
    const element = dropdownMenu?.children[scrollPos] as HTMLElement;
    if (dropdownMenu && element) {
      dropdownMenu.scrollTop = element.offsetTop;
    }
  }

  /** Update the selected value when clicking the left/right buttons */
  function updateSelected(direction: DIRECTION) {
    if (options.length < 1 || disabled) {
      return;
    }

    const startIndex = 0;
    const endIndex = options.length - 1;

    let newIndex: number;
    if (selectedIndex < 0) {
      newIndex = direction === 'next' ? endIndex : startIndex; // No selection yet
    } else if (direction === 'next') {
      newIndex = selectedIndex === endIndex ? startIndex : selectedIndex + 1; // Move to next option
    } else {
      newIndex = selectedIndex === startIndex ? endIndex : selectedIndex - 1; // Move to previous option
    }

    if (open && autoScroll) {
      scrollToElement(newIndex);
    }
    onSelected?.(getOptionValue(options[newIndex]));
  }

  return (
    <div className="Dropdown">
      <Floating
        allowedOutsideClasses=".Dropdown__button"
        closeAfterInteract
        contentAutoWidth={!menuWidth}
        contentClasses="Dropdown__menu--wrapper"
        contentStyles={{ width: menuWidth ? unit(menuWidth) : undefined }}
        disabled={disabled}
        onOpenChange={setOpen}
        placement="right-end"
        content={
          <div ref={innerRef} className="Dropdown__menu">
            {options.length === 0 ? (
              <div className="Dropdown__menu--entry">No options</div>
            ) : (
              options.map((option) => {
                const value = getOptionValue(option);
                return (
                  <div
                    className={classes([
                      'Dropdown__menu--entry',
                      selected === value && 'selected',
                    ])}
                    key={value}
                    onClick={() => {
                      onSelected?.(value);
                    }}
                    onKeyDown={(event) => {
                      if (event.key === KEY.Enter) {
                        onSelected?.(value);
                      }
                    }}
                  >
                    {typeof option === 'string' ? option : option.displayText}
                  </div>
                );
              })
            )}
          </div>
        }
        onMounted={() => {
          if (open && autoScroll && selectedIndex !== NONE) {
            /**
             * Floating uses async FloatingPortal,
             * the dropdown content is not yet ready when you open it.
             */

            scrollToElement(selectedIndex);
          }
        }}
      >
        <div
          className={classes([
            'Dropdown__control',
            `Button--color--${color}`,
            disabled && 'Button--disabled',
            iconOnly && 'Dropdown__control--icon-only',
            className,
          ])}
          style={{ width: unit(width) }}
          onClick={(event) => {
            if (disabled && !open) {
              return;
            }
            onClick?.(event);
          }}
          onKeyDown={(event) => {
            if (event.key === KEY.Enter && !disabled) {
              onClick?.(event);
            }
          }}
        >
          {icon && (
            <Icon
              className="Dropdown__icon"
              name={icon}
              rotation={iconRotation}
              spin={iconSpin}
            />
          )}
          {!iconOnly && (
            <>
              <span className="Dropdown__selected-text">
                {displayText ||
                  (selected && getOptionValue(selected)) ||
                  placeholder}
              </span>

              {!noChevron && (
                <Icon
                  className={classes([
                    'Dropdown__icon',
                    'Dropdown__icon--arrow',
                    open && 'open',
                  ])}
                  name="chevron-down"
                />
              )}
            </>
          )}
        </div>
      </Floating>
      {buttons && (
        <>
          <Button
            className="Dropdown__button"
            disabled={disabled}
            icon="chevron-left"
            onClick={() => {
              updateSelected(DIRECTION.Previous);
            }}
          />

          <Button
            className="Dropdown__button"
            disabled={disabled}
            icon="chevron-right"
            onClick={() => {
              updateSelected(DIRECTION.Next);
            }}
          />
        </>
      )}
    </div>
  );
}
