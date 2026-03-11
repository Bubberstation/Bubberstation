# Vocal Bloopers

By default, no vocal bloopers are included in the repository, a sample config file is provided to demonstrate the format used.
To set things up, copy `blooper_config.json.example` and rename it to `blooper_config.json`, then add an entry for each blooper.

## Config Format

- name: Required, the user-friendly name of the voice, will be shown in the config menu
- id: Required, an internal ID for the voice, must be unique
- files: Required, a JSON array of audio file names, relative to the bloopers directory.
  If there's more than one entry, a file is randomly chosen each time the user speaks
- min_speed: Optional, the minimum value the user can set for the voice speed
- max_speed: Optional, the maximum value the user can set for the voice speed
- min_pitch: Optional, the minimum value the user can set for the voice pitch
- max_pitch: Optional, the maximum value the user can set for the voice pitch
- min_vary: Optional, the minimum value the user can set for the voice pitch variance
- max_vary: Optional, the maximum value the user can set for the voice pitch variance
