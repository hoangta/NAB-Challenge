//
//  UITableView+Ex.swift
//  NABChallenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// Those helpers help omit cellIdentifier, but please make sure we use the class name as identifier
extension UITableView {
  func register(_ cellClass: AnyClass...) {
    cellClass.forEach { register($0, forCellReuseIdentifier: String(describing: $0)) }
  }
}

extension Reactive where Base: UITableView {
  func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
    (_ cellClass: Cell.Type)
    -> (_ source: Source)
    -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
    -> Disposable
    where Source.Element == Sequence {
      return items(cellIdentifier: String(describing: cellClass), cellType: cellClass)
  }
}
