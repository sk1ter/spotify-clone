//
//  AuthManager.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 20/03/23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "<client id>"
        static let clientSecret = "<client secret>"
        static let baseURL =  "https://accounts.spotify.com"
        static let redirectUrl = "https://iosacademy.io"
        static let scopes = "user-read-private,playlist-read-private,playlist-modify-private,playlist-modify-public,user-follow-read,user-library-modify,user-library-read"
    }
    
    var signInURL: URL?  {
        let url = "\(Constants.baseURL)/authorize?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectUrl)&show_dialog=true"
        return URL(string: url)
    }
    
    private var refreshingToken = false
    
    private init() {}

    var isSignedIn: Bool {
        return accessToken != nil
    }

    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }

    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }

    private var expirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiration_date") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = expirationDate else {
            return true
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            refreshTokenIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/api/token") else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectUrl),
        ]
        
        guard let basicToken = "\(Constants.clientID):\(Constants.clientSecret)".data(using: .utf8)?.base64EncodedString() else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(basicToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result)
                completion(true)
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
            
        }
        task.resume()
    }
    
    public func refreshTokenIfNeeded(completion: ((Bool) -> Void)?) {
        if refreshingToken {
            return
        }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        guard let url = URL(string: "\(Constants.baseURL)/api/token") else {
            return
        }
        refreshingToken = true
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        guard let basicToken = "\(Constants.clientID):\(Constants.clientSecret)".data(using: .utf8)?.base64EncodedString() else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(basicToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            self?.refreshingToken = false
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach {$0(result.access_token)}
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result)
                completion?(true)
            } catch {
                print("Error: \(error.localizedDescription)")
                completion?(false)
            }
            
        }
        task.resume()
    }
    
    private func cacheToken(_ result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expiration_date")
    }
}
