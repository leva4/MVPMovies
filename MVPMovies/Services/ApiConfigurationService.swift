//
//  ApiConfigurationService.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation
import RxSwift

class ApiConfigurationService {
    private let disposeBag = DisposeBag()

    public var configuration: ApiConfiguration?

    static let shared = ApiConfigurationService()
    private init() {}

    public func configure() {
        getConfiguration()
            .subscribe(onSuccess: { [weak self] configuration in
                self?.configuration = configuration
            })
            .disposed(by: disposeBag)
    }

    private func getConfiguration() -> Single<ApiConfiguration> {
        let configurationRequest = ConfigurationRequest()

        let response: Single<ApiConfiguration> = APIClient.shared
            .request(apiRequest: configurationRequest)
            .asSingle()

        return response
    }
}
