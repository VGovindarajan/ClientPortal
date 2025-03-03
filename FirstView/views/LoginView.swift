//
//  ContentView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/12/25.
//

import SwiftUI

public struct LoginView: View {

    @State private var userName = ""
    @State private var password = ""
    @State private var loginTapped = false
    @State private var unauthorized = false
    @StateObject var apiClient = ApiClient()
    @FocusState private var isFocused: Bool  // Track focus state
    @State private var showNextView = false  // Control presentation
    @State private var navigateToNextView = false  // Control presentation
    @State private var user: User? = nil  //For passing it to the main view
    @State private var errorMessage: String? = nil  // For error handling

    public var body: some View {
        VStack {
            if unauthorized {
                Text("UserName / password is incorrect")
                    .padding([.all], 16)
                    .font(.system(size: 18, weight: .bold, design: .default))  // Font styling
                    .foregroundColor(.red)  // Text color
            }
            Image("App_Logo")
                .resizable()  // Make the image resizable
                .scaledToFit()  // Maintain aspect ratio and fit within bounds
                .frame(width: 96, height: 96)  // Set a specific size (adjust as needed)
                .padding(.all, 16)  // Add some spacing to the right
            Text("Phillip Capital Client Portal")
                .padding([.all], 16)
                .font(.system(size: 18, weight: .bold, design: .default))  // Font styling
                .foregroundColor(.blue)  // Text color
            TextField("Username", text: $userName)
                .autocorrectionDisabled()
                .autocorrectionDisabled()
                .font(.system(size: 18, weight: .bold, design: .default))  // Font styling
                .foregroundColor(.black)  // Text color
                .padding(.all, 16)  // Add some padding around the text field
                .background(Color.gray.opacity(0.2))  // Background color with opacity
                .cornerRadius(8)  // Rounded corners
                .focused($isFocused)  // Bind the focus state
                .onAppear {
                    DispatchQueue.main.async {  // Ensure view has loaded
                        isFocused = true  // Set focus
                    }
                }
            SecureField("Password", text: $password)
                .textContentType(.password)
                .privacySensitive()  // Crucial!
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled()
                .autocorrectionDisabled()
                .font(.system(size: 18, weight: .bold, design: .default))  // Font styling
                .foregroundColor(.black)  // Text color
                .padding(.all, 16)  // Add some padding around the text field
                .background(Color.gray.opacity(0.2))  // Background color with opacity
                .cornerRadius(8)  // Rounded corners

            Button(action: {
                loginTapped = true  // Update state when button is tapped
                unauthorized = false
                // Perform your action here
                print("Button tapped! Text: \(userName)")
                Task {
                    await apiClient.login(
                        username: userName, password: password
                    ) { (result: Result<User, ApiError>) in
                        DispatchQueue.main.async {
                            let _ = apiClient.setLoading(loading: false)  // Set loading to false after API call
                            switch result {
                            case .success(let _user):
                                user = _user
                                showNextView = true
                                navigateToNextView = true
                                let _ = apiClient.setErrorMessage(message: nil)  // Clear any previous errors
                                break
                            case .failure(ApiError.unauthorized):
                                unauthorized = true
                                break
                            case .failure(let error):
                                let _ = apiClient.setErrorMessage(
                                    message: error.localizedDescription)  // Set the error message
                                errorMessage = error.localizedDescription
                                break
                            }
                        }
                    }
                }
            }
            ) {
                Text("Login")
                    .font(.system(size: 16, weight: .bold))  // Bold font
                    .foregroundColor(.white)  // White text
                    .padding(.all, 20)  // More horizontal padding
                    .background(
                        RoundedRectangle(cornerRadius: 8)  // Rounded background
                            .fill(Color.blue)  // Blue fill
                            .overlay(  // Overlay for the border
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 2)  // White border
                            )
                    )
            }
        }
        .padding()
        .navigationDestination(isPresented: $navigateToNextView) {  // For Navigation
            if let _user = user {
                PassCodeView(user: _user)
            } else if let errorMessage = errorMessage {  // Show error if API fails
                Text("Error: \(errorMessage)")
            }
        }
    }
}

#Preview {
    LoginView()
}
