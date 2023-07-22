# Blood Bank Mobile App - Connecting Lifesavers

Welcome to the Blood Bank app, a lifesaving platform designed to bridge the gap between blood donors and recipients. Our user-friendly mobile application, built using Flutter for both iOS and Android, aims to create a seamless experience for users to connect, donate, and request blood. With a secure login system, comprehensive user profiles, and convenient features, we are committed to making blood donation a hassle-free and rewarding experience.

## Features

1. **Mobile Number Sign-in and Register**:
   - Users can swiftly sign in or create a new account by providing their mobile number.
   - This feature enhances user convenience and eliminates the need for lengthy registration processes.
   - Users can easily recover their accounts in case of password loss since the mobile number serves as a primary identifier.

2. **OTP Login for Existing Users**:
   - Existing users can log in quickly and securely using a One-Time Password (OTP) sent to their registered mobile number.
   - This feature ensures a higher level of security by reducing the risk of unauthorized access.
   - By bypassing traditional password-based logins, users can access the app seamlessly and with ease.

3. **User Profile**:
   - Upon logging in, users are presented with their basic profile information, such as name, blood type, and contact details.
   - This profile view provides users with a quick overview of their essential details at a glance.
   - Users can easily update their profile information, ensuring the accuracy of their data and preferences.

4. **Signup Form**:
   - New users are presented with a comprehensive signup form to enter essential details about themselves.
   - This form includes information such as blood type, age, weight, and any existing medical conditions.
   - Collecting this data facilitates precise matching between donors and recipients, increasing the likelihood of successful blood donations.

5. **Donate or Request Blood**:
   - Users can choose to be blood donors and actively offer to donate blood when needed.
   - On the other hand, recipients can request blood when they require it for medical treatment.
   - This feature fosters a community of mutual support and encourages users to come forward and help during emergencies.

6. **Side Drawer Menu**:
   - The app's side drawer provides easy access to various essential features, making navigation effortless.
   - Users can open the side drawer by swiping from the left or tapping on the menu icon.
   - This organized menu structure ensures a clutter-free and user-friendly experience.

7. **Donation History**:
   - Users can view their donation history, which displays details of past blood donations made by them.
   - This feature encourages regular donors by showing them the impact of their contributions and the number of lives they've touched.
   - It also serves as a reminder for users to donate regularly and help maintain a steady blood supply.

8. **Received Blood History**:
   - For recipients, the app keeps a record of the blood they've received for medical treatments.
   - This feature helps recipients keep track of their medical history, making it easier to communicate their requirements to healthcare providers.
   - Users can access details such as the date, blood type received, and the donor's information (if available).

9. **Messaging System**:
   - The in-app messaging system allows seamless communication between blood donors and recipients.
   - Users can contact each other securely through the app, discussing logistics, availability, or any specific requirements.
   - This feature enhances transparency and coordination during the blood donation process.

10. **Settings**:
    - The settings section empowers users to customize their app experience according to their preferences.
    - Users can adjust notification settings, update contact details, and modify privacy preferences.
    - This feature ensures that users have a personalized and tailored experience while using the app.

## Backend - Firebase

The Blood Bank Mobile App backend is powered by Firebase, a powerful and scalable platform provided by Google. Firebase offers a range of services that enable seamless integration with the app's features, including authentication, database management, and messaging.

### Firebase Services Used:

- **Firebase Authentication**:
  - Enables secure mobile number sign-in and OTP login for existing users.
  - Provides a reliable and user-friendly authentication mechanism.

- **Firebase Realtime Database**:
  - Stores and manages user profiles, donation history, and received blood history.
  - Facilitates real-time data synchronization between the app and the backend.

## How to Contribute

We welcome contributions to the Blood Bank Mobile App! If you'd like to get involved, follow these steps:

1. Fork the repository on GitHub.
2. Create a new branch from the `main` branch: `git checkout -b feature/new-feature`.
3. Make your changes and test them thoroughly.
4. Commit your changes: `git commit -m "Add new feature"`.
5. Push your branch to your fork: `git push origin feature/new-feature`.
6. Open a pull request and describe the changes you've made.

Please ensure your pull requests adhere to our code of conduct and coding guidelines.

We hope the Blood Bank app serves as a powerful tool in connecting lifesavers and making a positive impact in people's lives. Thank you for being a part of this lifesaving journey!
