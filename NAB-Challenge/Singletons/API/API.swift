//
//  API.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import Moya

enum API {
  case getForecasts(city: String)
}

extension API: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.openweathermap.org")!
  }

  var path: String {
    switch self {
    case .getForecasts: return "/data/2.5/forecast/daily"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getForecasts: return .get
    }
  }

  var task: Task {
    switch self {
    case .getForecasts(let city):
      let params: [String: Any] = ["q": city, "cnt": 7, "appid": "60c6fbeb4b93ac653c492ba806fc346d", "units": "metric"]
      return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
  }

  var headers: [String: String]? {
    return nil
  }

  var sampleData: Data { return Data() }
}
