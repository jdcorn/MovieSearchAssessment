//
//  MovieTableViewController.swift
//  MovieSearchAssessment
//
//  Created by jdcorn on 11/22/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    // MARK: - Propterites
    var movies: [MovieResults] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    // MARK: - View lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        
        let movie = movies[indexPath.row]
        cell.movieResults = movie

        return cell
    }
}

extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        MovieController.fetchMovie(movie: searchText) { (result) in
            switch result {
            case .success(let movies):
                self.movies = [movies]
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
