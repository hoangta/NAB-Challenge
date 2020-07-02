//
//  HomeViewController.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {
  @IBOutlet weak var viewModel: HomeViewModel!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupSearchController()
    setupTableView()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSearch()
  }

  private func setupNavigationBar() {
    navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.preferredFont(forTextStyle: .headline)]
  }

  private func setupSearchController() {
    let search = UISearchController()
    search.hidesNavigationBarDuringPresentation = false
    search.obscuresBackgroundDuringPresentation = false
    search.searchBar.placeholder = "Search city"
    search.searchBar.searchTextField.font(.preferredFont(forTextStyle: .body))
    self.navigationItem.searchController = search
  }

  private func setupTableView() {
    tableView.tableFooterView = UIView()
    tableView.register(ForecastViewCell.self)
  }

  private func setupSearch() {
    self.navigationItem.searchController?.searchBar.rx.text
      .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
      .flatMapLatest { [unowned self] keyword -> Observable<[Forecast]> in
        guard let keyword = keyword, keyword.count > 2 else { // Search with keyword of minimum length of 3
          return .just([])
        }
        return self.viewModel.getForecasts(keyword: keyword)
          .catchErrorJustReturn([])
      }
      .bind(to: tableView.rx.items(ForecastViewCell.self)) { _, forecast, cell in
        cell.setForecast(forecast)
      }
      .disposed(by: rx.disposeBag)
  }
}
