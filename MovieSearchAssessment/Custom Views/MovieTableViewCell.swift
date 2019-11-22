//
//  MovieTableViewCell.swift
//  MovieSearchAssessment
//
//  Created by jdcorn on 11/22/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var movieResults: MovieResults? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieTextView: UITextView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // How do I get movie info into the cell?
    
    // MARK: - Functions
    
    func updateViews() {
        guard let movie = movieResults else { return }
        MovieController.fetchImageFor(movie: movie) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.movieImageView.image = image
                case .failure(let error):
                    print(error)
                }
                
                self.movieTitleLabel.text = movie.title
                self.movieTextView.text = movie.overview
                self.movieRatingLabel.text = "\(movie.vote_average)"
                
            }
        }
    }
}
