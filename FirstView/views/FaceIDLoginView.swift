//
//  FaceIDLoginView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/26/25.
//


import SwiftUI
import LocalAuthentication

struct FaceIDLoginView: View {
    @State private var isAuthenticated = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isAuthenticated {
                Text("Login Successful!")
                    .font(.title)
                    .foregroundColor(.green)
            } else {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: authenticateWithFaceID) {
                    Label("Login with Face ID", systemImage: "faceid")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .onAppear(perform: checkBiometricsAvailability) // check biometrics on view appear.
    }

    func checkBiometricsAvailability() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Biometrics are available, but don't automatically authenticate.
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
                        errorMessage = nil // clear error message on success.
                    } else {
                        errorMessage = authenticationError?.localizedDescription ?? "Authentication failed."
                    }
                }
            }
        } else {
            errorMessage = error?.localizedDescription ?? "Face ID not available"
        }
    }
}

struct FaceIDLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDLoginView()
    }
}