//
//  HomeViewController.swift
//  NAB-Challenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
  @IBOutlet weak var viewModel: HomeViewModel!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupSearchController()
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
}

// MARK: Actions
extension HomeViewController {}
