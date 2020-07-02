//
//  APITests.swift
//  NAB-ChallengeTests
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import XCTest
@testable import NABChallenge
@testable import Moya

class APITests: XCTestCase {
  func testGetForecasts() throws {
    // given
    let stubbingProvider = MoyaProvider<API>(endpointClosure: { target in
      let forecasts = ["list":
        [
          [
            "dt": 1593576000,
            "temp": ["day": 28],
            "pressure": 1005,
            "humidity": 83,
            "weather": [["description": "moderate rain"]]
          ]
        ]
      ]
      let data = (try? JSONSerialization.data(withJSONObject: forecasts, options: .prettyPrinted)) ?? Data()
      return Endpoint(url: target.baseURL.absoluteString + target.path,
                      sampleResponseClosure: { .networkResponse(200, data) },
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: target.headers)
    }, stubClosure: MoyaProvider.immediatelyStub)

    let sucessExpectation = expectation(description: "getForecasts")
    let errorExpectation = self.expectation(description: "getForecastsError")
    errorExpectation.isInverted = true

    // when
    APIClient.shared.request(.getForecasts(city: "Saigon"), for: Forecasts.self, using: stubbingProvider)
      .subscribe(onSuccess: { forecasts in
        // then
        XCTAssert(forecasts.list.count == 1)
        sucessExpectation.fulfill()
      }, onError: { error in
        print(error)
        errorExpectation.fulfill()
      })
      .disposed(by: rx.disposeBag)

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetEmptyForecasts() throws {
    // given
    let stubbingProvider = MoyaProvider<API>(endpointClosure: { target in
      let forecasts = ["cod": "404", "message": "city not found"]
      let data = (try? JSONSerialization.data(withJSONObject: forecasts, options: .prettyPrinted)) ?? Data()
      return Endpoint(url: target.baseURL.absoluteString + target.path,
                      sampleResponseClosure: { .networkResponse(404, data) },
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: target.headers)
    }, stubClosure: MoyaProvider.immediatelyStub)

    let sucessExpectation = expectation(description: "getEmptyForecastsError")
    sucessExpectation.isInverted = true
    let errorExpectation = self.expectation(description: "getEmptyForecastsError")

    // when
    APIClient.shared.request(.getForecasts(city: "Xaigon"), for: Forecasts.self, using: stubbingProvider)
      .subscribe(onSuccess: { _ in
        sucessExpectation.fulfill()
      }, onError: { error in
        // then
        XCTAssert(error.localizedDescription == APIClient.APIError.cityNotFound.localizedDescription)
        errorExpectation.fulfill()
      })
      .disposed(by: rx.disposeBag)

    waitForExpectations(timeout: 1, handler: nil)
  }
}
