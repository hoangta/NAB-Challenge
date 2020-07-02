//
//  HomeViewModel.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import RxSwift

final class HomeViewModel: NSObject {
  @IBOutlet private weak var viewController: HomeViewController!
}

// MARK: Networks
extension HomeViewModel {
  func getForecasts(keyword: String) -> Observable<[Forecast]> {
    APIClient.shared.request(.getForecasts(city: keyword), for: Forecasts.self)
      .map { $0.list }
      .asObservable()
  }
}
