# StackOverflow Users App
An iOS app built with UIKit and Combine that displays the top StackOverflow users, including support for follow/unfollow functionality with local persistence.


**Features**

- Fetch and display the top 20 StackOverflow users
- Show user profile image, display name, and reputation
- Follow and unfollow users locally (no API call)
- Persist follow status using UserDefaults
- Display an error message if the API call fails
- No third-party libraries used


**Architecture**

- MVVM pattern
- Combine used for reactive data binding
- URLSession for network calls
- UserDefaults to store follow state
- Testable and modular code



**Getting Started**

**Clone the repository:**
git clone git@github.com:binshadkb/StackOverflow.git

**Open in Xcode:**
open StackOverflow.xcodeproj
Build and run on iOS 14 or later




