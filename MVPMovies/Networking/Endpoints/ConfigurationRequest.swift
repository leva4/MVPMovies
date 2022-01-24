//
//  ConfigurationRequest.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

class ConfigurationRequest: APIRequest {
    var method = RequestType.get
    var path = "configuration"
    var parameters = [String: String]()
}
