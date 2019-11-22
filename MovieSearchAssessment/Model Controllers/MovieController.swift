//
//  MovieController.swift
//  MovieSearchAssessment
//
//  Created by jdcorn on 11/22/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

import UIKit

class MovieController {
    
    static func fetchMovie(movie: String, completion: @escaping (Result<MovieResults, MovieResultsAPIError>) -> Void) {
        
        // Build URL
        guard let baseURL = URL(string: "https://api.themoviedb.org/3") else { return completion(.failure(.invalidURL))}
        
        let searchComponentURL = baseURL.appendingPathComponent("search").appendingPathComponent("movie")
        
        /// I'm not sure what the "name: " should be, I thought emptry string, because that's where the search term would go. Example - (name: "star wars")
        let movieQueryTitle = URLQueryItem(name: "", value: movie)
        
        let movieQueryAPIkey = URLQueryItem(name: "api_key", value: "1c22df5949de6e4243d3f54553ddfbf1")
        
        var urlComponents = URLComponents(url: searchComponentURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [movieQueryTitle, movieQueryAPIkey]
        
        guard let url = urlComponents?.url else { return completion(.failure(.invalidURL))}
        
        // dataTask
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(.failure(.communicationError))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let movie = try JSONDecoder().decode(MovieResults.self, from: data)
                print(movie)
                completion(.success(movie))
            } catch {
                print(error)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchImageFor(movie: MovieResults, completion: @escaping (Result<UIImage, MovieResultsAPIError>) -> Void) {
        
        guard let url = URL(string: movie.poster_path) else {
            completion(.failure(.invalidURL)); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(.failure(.communicationError))
            }
            
            guard let data = data else { completion(.failure(.noData)); return }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.unableToDecode)); return }
            completion(.success(image))
        }.resume()
        
    }
    
}


enum MovieResultsAPIError: LocalizedError {
    case invalidURL
    case communicationError
    case noData
    case unableToDecode
}
