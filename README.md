# TaskFlipKartInSwift

Points and Matches Tracker
Overview
This iOS project is designed to manage and display a leaderboard of players based on match results. It fetches data from an external API, calculates the points table, and displays it in a table view. The project uses Swift and follows best practices for network requests, data handling, and UI updates.

# Features
Fetch and display player and match data from an API.
Display a points table with player scores and rankings.
Navigate to detailed match views for each player.
Loader UI to indicate data loading.
Error handling with Snackbar notifications for failed API calls.

# Usage
Run the app in Xcode or on a physical device.
The main screen displays a points table where each row represents a player's rank and score.
Tap on a player to view details of matches played.

# Project Structure
ApiManager: Handles API requests and data fetching.
PointListViewModel: Manages the business logic for fetching and processing data.
PointListViewController: Displays the points table in a table view.
MatchesListViewController: Displays match details for a selected player.

# Dependencies
UIKit for UI components.
URLSession for network requests.
