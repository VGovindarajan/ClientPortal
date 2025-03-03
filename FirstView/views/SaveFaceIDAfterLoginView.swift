//
//  SubsequentFaceIDLoginView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/26/25.
//


import SwiftUI
import LocalAuthentication

struct SaveFaceIDAfterLoginView: View {
    @State private var isAuthenticated = false
    @State private var errorMessage: String?
    @State private var showFaceIDPrompt = false // Control when to show the prompt

    var body: some View {
        VStack {
            if isAuthenticated {
                Text("Welcome back!")
                    .font(.title)
                    .foregroundColor(.green)
            } else {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                if showFaceIDPrompt {
                    Button(action: authenticateWithFaceID) {
                        Label("Login with Face ID", systemImage: "faceid")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                } else {
                    Text("Enable Face ID for faster logins?")
                        .padding()
                    HStack {
                        Button("Enable") {
                            showFaceIDPrompt = true
                            authenticateWithFaceID() // Immediately try to authenticate.
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        Button("Skip") {
                            // Proceed without Face ID.
                            isAuthenticated = true // Simulate successful login.
                        }
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }

                }
            }
        }
        .padding()
        .onAppear(perform: checkBiometricsAvailability)
    }

    func checkBiometricsAvailability() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Biometrics are available.
        } else {
            errorMessage = error?.localizedDescription ?? "Face ID not available"
        }
    }

    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to log in."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isAuthenticated = true
                        errorMessage = nil
                    } else {
                        errorMessage = authenticationError?.localizedDescription ?? "Authentication failed."
                        showFaceIDPrompt = true // Keep prompting after failure.
                    }
                }
            }
        } else {
            errorMessage = error?.localizedDescription ?? "Face ID not available"
        }
    }
}

struct SaveFaceIDAfterLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SaveFaceIDAfterLoginView()
    }
}
