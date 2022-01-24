//
//  SearchRequest.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

class SearchRequest: APIRequest {
    var method = RequestType.get
    var path = "search/multi"
    var parameters = [String: String]()

    init(name: String) {
        parameters["query"] = name
    }
}
