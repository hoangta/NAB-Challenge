//
//  API+Cache.swift
//  NABChallenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import Moya
import RxSwift

protocol HasCachePolicy {
  var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: NSObject, PluginType {
  override init() {
    super.init()
    if !Calendar.current.isDateInToday(UserDefaults.standard.cachingDate) {
      URLCache.shared.removeAllCachedResponses()
    }
    UserDefaults.standard.cachingDate = Date()
  }

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    if let hasCachePolicy = target as? HasCachePolicy {
      var request = request
      request.cachePolicy = hasCachePolicy.cachePolicy
      return request
    }
    return request
  }
}

private extension UserDefaults {
  var cachingDate: Date {
    get { return object(forKey: #function) as? Date ?? Date() }
    set { set(newValue, forKey: #function) }
  }
}
