# Ecommerce App

This is a Flutter application that integrates with Firebase to provide an ecommerce experience. Users can register and log in to the app using Firebase authentication. Once logged in, they can browse a list of products, search for products by name, and view detailed product information.

## Features

- User authentication using Firebase
- List of products with descriptions and prices
- Search functionality to find products by name
- View and edit product details including photo, name, description, price, and availability
- Add new products with photos using the device's camera

## Dependencies

The app uses the following dependencies:

- `cupertino_icons` - Provides the Cupertino icons used in the app.
- `flutter_secure_storage` - Enables secure storage of user authentication tokens.
- `google_fonts` - Allows the usage of custom fonts from the Google Fonts library.
- `http` - Provides HTTP networking capabilities for fetching data from Firebase.
- `image_picker` - Allows users to pick images from the device's gallery or capture images using the camera.
- `provider` - Implements state management and dependency injection in the app.


## Getting Started

To run the app locally, make sure you have Flutter installed. Then, follow these steps:

1. Clone this repository: `git clone https://github.com/your/repo.git`
2. Change to the app directory: `cd ecommerce_app`
3. Fetch the dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
