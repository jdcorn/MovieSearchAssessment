//
//  Movie.swift
//  MovieSearchAssessment
//
//  Created by jdcorn on 11/22/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

import Foundation

struct MovieResults: Codable {
    var poster_path: String
    var title: String
    var overview: String
    var vote_average: Int
    var id: Int
}
