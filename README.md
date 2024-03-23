# Coffeee (Test App)

![3](https://github.com/MelnykovMykyta/Coffeee/assets/127539076/e6a7803b-44b9-468c-9798-bf3c39fa265a)

#### The program is an application for a coffee shop named "Coffeee". It includes modules for user authentication, management of favorite items, and display of promotions. 

## Technologies and Libraries

- **Programming Language:** Swift.
- **Architecture:** MVVM (Model-View-ViewModel) with RxSwift.
- **User Authentication:** Firebase Authentication for phone number authentication.
- **Data:** Firebase Realtime Database for storing and managing user data, promotions, menu and favorite menu items.
- **Image Loading:** SDWebImage library for efficient asynchronous image loading and caching.
- **UI Components:** Utilizes UIKit for building a polished UI, including various components like UITableView. Constraint handling is done using SnapKit.
- **Reactive Programming:** Utilizes RxSwift and RxCocoa for reactive programming paradigms.
- **Other Dependencies:**
  - FlagPhoneNumber: Seamless phone number selection and input.
  - DPOTPView: Streamlined one-time password input functionality.
  - StatusAlert: Displaying informative messages to the user.
  - CircleProgressView: Provides visually appealing circular progress indicators.
  - SimpleQRCode: Integration for efficient QR code generation.
- **Animation:** Lottie library for incorporating animations into the UI.

## Design

![1](https://github.com/MelnykovMykyta/Coffeee/assets/127539076/4fb39168-2e7e-4629-93b3-dc421265c956)

![2](https://github.com/MelnykovMykyta/Coffeee/assets/127539076/0f05e0cb-4756-4776-bff5-a914bb3bdafc)

![0-02-05-8161bc912f513a30fad54a12524b661668b67d29df77dfcaf6750e4447e38463_1c6dbbc182ca39](https://github.com/MelnykovMykyta/Coffeee/assets/127539076/b9c1ad13-0ae0-4548-afb4-1e499433b48d)

## Main Features

1. **Phone Registration/Auth:**
   - Enables user registration and authentication via phone numbers.
2. **User Data Retrieval:**
   - Fetches user data from Firebase Realtime Database.
3. **Promotions Information:**
   - Retrieves and presents detailed information about promotions from Firebase Realtime Database.
4. **Menu Collection:**
   - Displays a visually appealing collection of menu items with detailed information.
5. **Favorites Management:**
   - Allows users to effortlessly add and remove menu items from their favorites list.
6. **Image Handling:**
   - Loads and displays menu items and promotions posters using the SDWebImage library.
7. **Gesture Interaction:**
   - Implements a user-friendly long-press gesture for adding/removing a menu item to/from favorites.

## Usage

To run this project locally, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/MelnykovMykyta/Coffeee
2. **Install dependencies:**
    ```bash 
    pod install
  
3. **Set up Firebase:**
Create a new project in Firebase Console.
Follow the instructions to add your iOS app to the Firebase project. Make sure to download the GoogleService-Info.plist file.
Place the downloaded GoogleService-Info.plist file in the root directory of your Xcode project.

4. **Open the Xcode workspace:**
    ```bash
    open Coffeee.xcworkspace

5. **Build and run the project:**
Select your target device or simulator in Xcode.
Press the play button to build and run the project.
Enjoy using Coffeee!

