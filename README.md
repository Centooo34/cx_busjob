# FiveM Bus Job Script

This is a simple **bus job** script for **FiveM** servers where players can perform bus driving duties, transporting passengers between different bus stops and earning income for each stop completed. It includes features such as spawning a bus, setting waypoints to bus stops, and collecting rewards.

## Features

- **Bus Job**: Players can start and stop work, drive a bus between random bus stops, and complete the route to earn money.
- **Blips**: Displays bus stop locations on the map with custom blips for easy navigation.
- **Income**: Players earn money per stop they complete. The amount is configurable.
- **Vehicle Spawning**: The script automatically spawns a bus for the player to use, and ensures that the spawn point is clear before spawning.
- **Customizable Stops**: Easily add or modify the bus stops in the `Config.Stops` table.
- **Guide Book**: A simple guide on how to start and complete the bus job.

## Installation

### Requirements:
- **FiveM** server
- **ox_lib** (for notifications, context menus, and other UI elements)
- Basic Lua knowledge to modify the script as needed.

### Steps to install:

1. **Download the Script:**
   - Clone or download this repository to your server’s `resources` folder.
   
2. **Install Dependencies:**
   - Ensure that `ox_lib` is installed and properly configured in your `resources` folder. You can find `ox_lib` [here](https://github.com/overextended/ox_lib).
   
3. **Configuration:**
   - Open the `config.lua` file located in the script folder.
   - Modify the following settings as needed:
     - `Config.Stops`: Define the coordinates for bus stops.
     - `Config.CarSpawn`: The spawn location for the bus.
     - `Config.MoneyPerStop`: The amount of money earned per stop (randomized within a range).
     - `Config.UseBlip`: Set to `true` if you want to display bus stops on the map.
     - `Config.Blip`: Set the name of the blip shown on the map.

4. **Add to `server.cfg`:**
   - Add the following line to your `server.cfg` file to ensure the script runs on startup:
     ```plaintext
     start busjob
     ```

5. **Start the Server:**
   - After completing the installation, restart your server. The script should now be running, and players can start the bus job.

## Usage

### Start the Job:
1. Approach the NPC (set up in `coords` in the script).
2. Interact with the NPC to open the context menu and select "Start Work".
3. The bus will spawn at the designated spawn point, and you can begin the job.
4. The bus stops will be assigned randomly. Drive to each bus stop and complete the task to earn money.

### Stop the Job:
1. While working, you can stop the job anytime by interacting with the NPC and selecting "Stop Working".
2. The bus will be deleted, and you will be notified that the work has ended.

### Collect Income:
1. After completing bus stops, you can collect your income by selecting the "Collect Income" option from the NPC's menu. This will calculate the total income based on the number of stops completed and give you the payment.

## Script Overview

This script enables the bus job system by:
- Spawning a bus for the player.
- Randomly assigning bus stops from a list.
- Creating a blip on the map for each bus stop.
- Freezing the bus when the player arrives at the stop and waiting for them to complete the task.
- Notifying the player when they finish the job and allowing them to collect income based on the number of stops completed.

## Customization

- **Bus Stops**: Modify the `Config.Stops` table to add or remove stops.
- **NPC Location**: Change the `coords` variable to adjust where the NPC spawns.
- **Money Per Stop**: Modify the `Config.MoneyPerStop` variable to adjust the income per stop completed.

## License

This script is provided under the **MIT License**. Feel free to modify it and use it as needed.
