//
//  ApiClient.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/16/25.
//


// ApiClient to handle API calls

import Foundation

public class ApiClient : ObservableObject{
    
    @Published private(set) var isLoading = false // Add a published property for loading state
    @Published private(set) var errorMessage: String? = nil // Published error message
    static let shared = ApiClient()
    private let baseURL = "http://127.0.0.1:5000/"
    private var authToken: String?
    
    func setLoading(loading:Bool)-> Bool{
        isLoading = loading
        return isLoading
    }
    
    func setErrorMessage(message:String?)->Bool{
        errorMessage = message
        return true
    }
    
    
    func login(username: String, password: String, completion: @escaping (Result<User, ApiError>) -> Void) async {
        let fullURLString = baseURL + "api/login" // Combine base URL and endpoint
        guard let url = URL(string: fullURLString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let credentials = ["username": username, "password": password]
        var request = URLRequest(url: url)
        do{
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(credentials)
        } catch {
            completion(.failure(.encodingError(error)))
            return
        }
        do{
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            print(data)
            print(urlResponse)
            guard let httpResponse = urlResponse as? HTTPURLResponse,
                  !(400...401).contains(httpResponse.statusCode) else {
                      completion(.failure(.unauthorized))
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse,
                              (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            let user = try JSONDecoder().decode(User.self, from: data)
            authToken = user.token
            completion(.success(user))
            return
        }catch{
            completion(.failure(.decodingError(error)))
            return
        }
    }
    
    func getAccounts() async throws -> [Account] {
        guard let token = authToken else {
            throw ApiError.unauthorized
        }
        
        guard let url = URL(string: "\(baseURL)/accounts") else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Account].self, from: data)
    }
    
    func getAccountDetails(accountNumber: String) async throws -> AccountDetails {
        guard let token = authToken else {
            throw ApiError.unauthorized
        }
        
        guard let url = URL(string: "\(baseURL)/accounts/\(accountNumber)") else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(AccountDetails.self, from: data)
    }
}

enum ApiError: Error {
    case invalidURL
    case unauthorized
    case invalidResponse
    case networkError(Error)
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case unknown
}
