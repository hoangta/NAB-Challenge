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
      .do(onNext: { [unowned self] keyword in
        // Show loading when keyword reaches length of 3
        if let keyword = keyword, keyword.count > 2 {
          self.tableView.setState(.loading)
        } else {
          self.tableView.setState(.normal)
        }
      })
      .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
      .flatMapLatest { [unowned self] keyword -> Observable<[Forecast]> in
        guard let keyword = keyword, keyword.count > 2 else { // Search with keyword of minimum length of 3
          return .just([])
        }
        return self.viewModel.getForecasts(keyword: keyword)
          .do(onNext: { [unowned self] _ in self.tableView.setState(.normal) },
              onError: { [unowned self] error in
                switch error {
                case APIClient.APIError.cityNotFound:
                  let empty = UILabel(error.localizedDescription).align(.center).font(.preferredFont(forTextStyle: .body))
                  self.tableView.setState(.empty(empty))

                default: self.tableView.setState(.retry(block: {
                  self.navigationItem.searchController?.searchBar.searchTextField.sendActions(for: .editingChanged)
                }))
                }
          })
          .catchErrorJustReturn([])
      }
      .bind(to: tableView.rx.items(ForecastViewCell.self)) { _, forecast, cell in
        cell.setForecast(forecast)
      }
      .disposed(by: rx.disposeBag)
  }
}
