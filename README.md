# Flutter News Application

## Introduction

The Flutter News Application is a mobile app that fetches live news from the [News API](https://newsapi.org/) and displays it in a user-friendly interface. The app features multiple screens, including a homepage that displays the latest news articles, a detailed news page, and a category-based news filter. The application utilizes state management techniques to efficiently handle dynamic data and provides pagination for seamless scrolling through news articles.

## Features

- **API Integration**: Fetches news articles from the News API in JSON format.
- **Home Screen**: Displays a scrollable list of the latest news articles with:
  - News headline
  - Image 
  - Source of the news
  - Brief description or snippet
  - Search bar for article keywords
- **News Detail Page**: Shows the complete content of a selected news article, including:
  - Full headline
  - Image 
  - Full content or body of the news
  - Published date
  - Button to open the original news URL in a browser
- **Category-based Filtering**: Allows users to filter news articles by categories such as Technology, Sports, Health, Business, and Entertainment.
- **State Management**: Utilizes [Provider](https://pub.dev/packages/provider) for effective state management across the app.
- **Pagination**: Implements pagination to load more articles as the user scrolls to the bottom of the list.

## Prerequisites

- Flutter SDK
- Dart SDK
- An API key from [News API](https://newsapi.org/) (free tier available)

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/flutter_news_app.git
   cd flutter_news_app


2. **Install dependenciesy**:
   ```bash
   flutter pub get

3. **Setting up ENV variables**:
```bash
   create a .env file
   copy the contents of .env.example 
   add your API KEY
   ```

4. **Run the app**:
```bash
   flutter run