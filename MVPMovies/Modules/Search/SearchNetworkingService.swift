//
//  SearchNetworkingService.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import RxSwift

class SearchNetworkingService: SearchNetworkingServiceProtocol {
    func search(for query: String) -> Single<[Media]> {
        let searchRequest = SearchRequest(name: query)

        let response: Single<PaginateResponse<Media>> = APIClient.shared
            .request(apiRequest: searchRequest)
            .asSingle()

        return response
            .map(\.results)
    }
}
