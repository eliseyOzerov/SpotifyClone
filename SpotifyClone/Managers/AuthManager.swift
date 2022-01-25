//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by Elisey Ozerov on 24/01/2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com"
        let redirectURI = "https://www.iosacademy.io"
        let scopes = "user-read-private"
        let string = "\(base)/authorize?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=true"
        return URL(string: string)
    }
    
    struct Constants {
        static let clientID = "a9368423f35d4c0f8d2b2781175b8296"
        static let clientSecret = "4334745220024b6abfd5930a45e312d9"
        static let tokenAPIURL = "https://accounts.cpotify.com/api/token"
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            } catch {
                completion(false)
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
    	
