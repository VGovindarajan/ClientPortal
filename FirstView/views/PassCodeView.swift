//
//  OTPScreen.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/26/25.
//


import SwiftUI

struct PassCodeView: View {
    @State private var otpDigits: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    @State private var isOTPValid = true
    @State private var showResend = false
    @State private var resendTimer = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var showNextView = false // Control presentation
    @State private var navigateToNextView = false // Control presentation
    var user:User? = nil //For passing it to the main view
    
    
    var body: some View {
        VStack {
            Text("Enter Passcode")
                .font(.title)
                .padding(.bottom, 20)

            HStack {
                ForEach(0..<6, id: \.self) { index in
                    TextField("", text: $otpDigits[index])
                        .keyboardType(.numberPad)
                        .frame(width: 40, height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .multilineTextAlignment(.center)
                        .focused($focusedField, equals: index)
                        .onChange(of: otpDigits[index]) { newValue in
                            if newValue.count > 1 {
                                otpDigits[index] = String(newValue.last!)
                            }
                            if !newValue.isEmpty && index < 5 {
                                focusedField = index + 1
                            } else if newValue.isEmpty && index > 0{
                                focusedField = index - 1
                            }
                        }
                }
            }
            .padding(.bottom, 10)

            if !isOTPValid {
                Text("Invalid Passcode")
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }

            Button(action: {
                validatePasscode()
            }) {
                Text("Verify")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom, 10)

            if showResend {
                Button(action: {
                    resendOTP()
                }) {
                    Text("Resend Passcode")
                        .foregroundColor(.blue)
                }
            } else {
                Text("Resend Passcode in \(resendTimer) seconds")
                    .onReceive(timer) { _ in
                        if resendTimer > 0 {
                            resendTimer -= 1
                        } else {
                            showResend = true
                        }
                    }

            }
        }
        .padding()
        .navigationDestination(isPresented: $navigateToNextView) { // For Navigation
            if let _user = user {
                MainView(user: _user)
                    .navigationBarBackButtonHidden(true) // Hides the back button
            }
        }        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                focusedField = 0
            }
        }
    }

    func validatePasscode() {
        let enteredOTP = otpDigits.joined()
        // Replace with your actual OTP validation logic
        if enteredOTP == "123456" { // Example validation
            isOTPValid = true
            showNextView = true
            navigateToNextView = true
            print("Passcode Validated!")
            // Proceed to the next screen or perform actions
        } else {
            isOTPValid = false
            print("Invalid Passcode")
        }
    }

    func resendOTP() {
        // Replace with your actual OTP resend logic
        print("Resending OTP...")
        showResend = false
        resendTimer = 30
        // Resend logic here.
    }
}

struct OTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        PassCodeView()
    }
}
