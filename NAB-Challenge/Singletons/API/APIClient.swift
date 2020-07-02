//
//  APIClient.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import Moya
import RxSwift

extension APIClient {
  enum APIError: Error, LocalizedError {
    case cityNotFound
    case unknown

    var errorDescription: String? {
      switch self {
      case .cityNotFound: return "City not found."
      case .unknown: return "Something went wrong."
      }
    }
  }
}

final class APIClient: NSObject {
  static let shared = APIClient()

  private static let provider = MoyaProvider<API>()

  func request<Object: Decodable>(_ API: API, for type: Object.Type, using provider: MoyaProvider<API> = provider) -> Single<Object> {
    return Single<Object>.create { single in
      let cancellable = provider.request(API, completion: { result in
        switch result {
        case let .success(response):
          switch response.statusCode {
          case 200:
            do {
              let object = try response.map(Object.self)
              single(.success(object))
            } catch {
              single(.error(error))
            }

          case 404:
            single(.error(APIError.cityNotFound))

          default:
            single(.error(APIError.unknown))
          }

        case let .failure(error):
          single(.error(error))
        }
      })

      return Disposables.create { cancellable.cancel() }
    }
  }
}
