# SignUpandLoginFirebase

SignUpandLoginFirebase is the login interface where you can login and register using Firebase.

## Descriptions

- UIKit

- [SnapKit](https://github.com/SnapKit/SnapKit)

- [Firebase](https://firebase.google.com/) (Realtime Database, Authentication)

- MVVM Design Pattern

- Delegation Pattern

## Requirements

### Firebase Realtime Database Security Rules

```bash
{
  "rules": {
		"users": {
      ".read": true,
      ".write": "(auth!=null)",
      ".indexOn" : ["username"]
    }
  }
}
```

- Make sure you have an internet connection.

## Support Me

Please contact me if you find any bad code, I am eager to learn more.

## Screenshots

### App Screenshots

![Login Screen Screenshot](ReadmeAssets/login.png)
![Sign Up Screen Screenshot](ReadmeAssets/signup.png)
![Enter Username Screen Screenshot](ReadmeAssets/enterusername.png)
![Home Screen Screenshot](ReadmeAssets/welcomeapp.png)
![Google Sign In Screenshot](ReadmeAssets/googlesignin.png)

### Firebase Screenshots

![Firebase Auth Screenshot](ReadmeAssets/firebaseauth.png)
![Realtime Database Screenshot](ReadmeAssets/realtimedatabase.png)

### App Gifs

![Normal Sign Up Gif](ReadmeAssets/normalsignup.gif)
![Sign In With Google](ReadmeAssets/signinwith.gif)

## License

**SignUpandLoginFirebase** is available under the MIT license. See the LICENSE file for more info.

## Authors

- [@tahabozdemir](https://www.github.com/tahabozdemir)
