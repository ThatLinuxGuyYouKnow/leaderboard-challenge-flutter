# live_leaderboard_flutter

A leaderboard application built with Flutter for a coding challenge.

It's live [here](https://leaderboard-live.netlify.app/)
## Objective
Create a dynamic leaderboard component that updates automatically at a regular interval.

## Task Description
Build a leaderboard component that:
*   Displays a list of participants and their scores.
*   Updates the leaderboard data dynamically based on a function you write.
*   Renders the updated data in real-time in the UI.

## Implementation
This Flutter application implements a live leaderboard that:
*   Fetches and displays participant data.
*   Dynamically updates scores using a `Timer` and `setState` for UI updates.
*   Sorts participants based on their scores in descending order.
*   Presents the leaderboard in a visually appealing table and bar chart.

## Design Decisions
*   The UI is designed to be clean and responsive, suitable for various screen sizes.
*   Mock data is used to initialize the leaderboard for demonstration purposes.
*   The update interval is set to 2 seconds, but this can be easily adjusted.

## Instructions to Run the Project

1.  Ensure you have Flutter installed and configured on your machine.  See [Flutter's install guide](https://docs.flutter.dev/get-started/install).
2.  Clone this repository: `git clone git@github.com:ThatLinuxGuyYouKnow/live_leaderboard_flutter.git`
3.  Navigate to the project directory: `cd live_leaderboard_flutter`
4.  Run `flutter pub get` to install dependencies.
5.  Execute the app using `flutter run`.

## Directory Structure
```
├── README.md
├── lib
│   ├── main.dart
│   └── models
│       └── participant.dart
├── ... (other Flutter project files and directories)
```

## Deliverables
1.  A leaderboard component that:
    *   Displays a list of participants and their scores.
    *   Updates the leaderboard data dynamically based on a function you write.
    *   Renders the updated data in real-time in the UI.
2.  Logic for generating updates:
    *   Each update modifies the participants' scores randomly (e.g., increase/decrease by a small amount).
    *   The time frame for updates is set to every 2 seconds.
3.  Implemented using Flutter (for mobile and web).
4.  A visually appealing UI to demonstrate design sense.

## Notes
*   Clean, well-documented code is provided.
*   Focus is on dynamic data updates and state management.
*   Mock data is used to initialize the leaderboard.

## Author
Alabi Ayobami ([ThatLinuxGuyYouKnow](https://github.com/ThatLinuxGuyYouKnow))
