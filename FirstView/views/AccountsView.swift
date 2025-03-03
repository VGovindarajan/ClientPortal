//
//  AccountsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//

import SwiftUI

struct AccountsView: View {
    @StateObject var apiClient = ApiClient()
    @State private var accounts: [Account] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var selectedAccountId: Int? = nil

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading Accounts...")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                GeometryReader { geometry in
                    List {
                        Section(header:
                            HStack {
                                Text("Select an account")
                                    .font(.title)
                                }
                        )
                        {
                            ForEach(accounts){ account in
                                HStack {
                                    Text(account.accountName)
                                        .font(
                                            selectedAccountId == account.id
                                            ? .headline.bold() : .headline
                                        )
                                        .frame(
                                            maxWidth: geometry.size.width * 0.33,
                                            alignment: .leading)  // Fixed width at 33%
                                    Text(account.accountNumber)
                                        .font(.subheadline)
                                        .frame(
                                            maxWidth: geometry.size.width * 0.33,
                                            alignment: .leading)  // Fixed width at 33%
                                    Spacer()
                                    Toggle(
                                        "",
                                        isOn: Binding(
                                            get: { selectedAccountId == account.id },
                                            set: { newValue in
                                                selectedAccountId =
                                                newValue ? account.id : nil
                                            }
                                        )
                                    )
                                    .labelsHidden()
                                    .frame(
                                        maxWidth: geometry.size.width * 0.25,
                                        alignment: .trailing)
                                }
                            }
                        }
                    }

                }
            }
        }
        .onAppear {
            Task {
                await loadAccounts()
            }
        }
    }

    @MainActor
    private func loadAccounts() async {
        isLoading = true
        errorMessage = nil

        do {
            accounts = try await apiClient.getAccounts()
            isLoading = false
        } catch let apiError as ApiError {
            errorMessage = String(describing: apiError)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}

#Preview {
    AccountsView()
}
