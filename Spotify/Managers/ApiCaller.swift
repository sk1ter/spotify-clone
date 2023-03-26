//
//  ApiCaller.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 20/03/23.
//

import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    
    private init() {}
    
    struct Constants {
        static let baseUrl = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    enum HTTPMethods: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethods, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url  else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
        
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseUrl)/me"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseUrl)/browse/new-releases?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping (Result<PlaylistResponse, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseUrl)/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PlaylistResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(seed: Set<String>, completion: @escaping (Result<RecommendedTracksResponse, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseUrl)/recommendations?seed_genres=\(seed.joined(separator: ","))"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendedTracksResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseUrl)/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }

}
