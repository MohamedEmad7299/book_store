# 📚 Book Store

A Flutter application for browsing and searching books, with offline caching support using Hive.

---

## 🚀 How to Build and Run

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/book_store.git
   cd book_store


## 🧠 Design Decisions and Assumptions

State Management:
Used flutter_bloc for handling application states like loading, success, and error across fetching and searching books.

Networking:
Built a DioHelper class around the Dio package for API interaction, adding error handling and logging interceptors.

Offline Caching:
Implemented using Hive for caching books locally to ensure data is available even without an internet connection.

Pagination:
Handled infinite scrolling to fetch more books as the user scrolls near the end of the list.

Search:
Search results are fetched through API calls and cached separately.

Error Handling:
If the API fails and cached data exists, it will load from the cache instead of showing an error immediately.

Responsiveness:
Added early pagination trigger (300px before the end) for smoother user experience.


## 🛠️ Libraries Used

flutter_bloc - State management

bloc - Core bloc implementation

dio - HTTP client for API calls

hive - Lightweight local storage

hive_flutter - Hive integration with Flutter

intl - Date formatting (if needed in the future)

connectivity_plus - To check network status (planned usage)

fluttertoast - Displaying quick user messages

flutter_svg - Rendering SVG images

## ✨ Features

 - List books from GutenDex API

- Search for books by title or author

- Infinite scroll loading for books

- Caching the latest fetched data for offline use

- Graceful handling of empty search results

- Detailed error and loading states

## 📌 Notes

- The search functionality will use the API directly and update the cache based on the search query.

- While scrolling, it automatically fetches more books without needing user interaction.

- When an error occurs during API requests, cached data will be used if available.

- A default placeholder image is shown if a book does not have an image.

- No authentication or complex user management is involved — it's focused purely on book exploration.

## 🧹 Future Improvements

- Add favorite books feature.

- Improve UI/UX with animations and better state indicators.

- Add unit testing and widget testing.

## 📸 Preview
https://youtube.com/shorts/X2_iIG8LO1k?si=Y1HZwS5mHGsRezQL 
