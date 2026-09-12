/** Shared Scene Assistant palette choices for both interaction interfaces. */
export const SCENE_THEMES = [
  { id: 'default', label: 'Scene Assistant', theme: 'scene_assistant' },
  { id: 'light', label: 'Frost', theme: 'scene_frost' },
  { id: 'cream', label: 'Cream', theme: 'scene_cream' },
  { id: 'strawberry', label: 'Strawberry', theme: 'scene_strawberry' },
  { id: 'super_dark', label: 'Super Dark', theme: 'scene_super_dark' },
  { id: 'apple', label: 'Apple', theme: 'scene_apple' },
  { id: 'syndicate', label: 'Syndicate Red', theme: 'scene_syndicate' },
];

export function sceneTheme(id: string) {
  return (
    SCENE_THEMES.find((theme) => theme.id === id)?.theme ?? 'scene_assistant'
  );
}
