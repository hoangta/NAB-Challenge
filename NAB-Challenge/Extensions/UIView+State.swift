//
//  UIView+State.swift
//  NABChallenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import UIKit

private extension Int {
  static let stateTag = 100
}

extension UIView {
  enum ViewState {
    case normal
    case loading
    case empty(UIView)
    case retry(block: () -> Void)
  }

  func setState(_ state: ViewState) {
    switch state {
    case .normal: removeStateViews(enableView: true, hideSubviews: false)
    case .loading: setLoading()
    case .empty(let view): setEmpty(view)
    case .retry(let block): setRetry(block)
    }
  }

  private func removeStateViews(enableView: Bool, hideSubviews: Bool) {
    for view in subviews where view.tag == .stateTag {
      view.removeFromSuperview()
    }
    isUserInteractionEnabled = enableView
    subviews.forEach { $0.isHidden = hideSubviews }
  }

  private func setLoading() {
    removeStateViews(enableView: false, hideSubviews: true)

    // Holder
    let stateHolder = UIView().tag(.stateTag)
    addSubview(stateHolder)
    stateHolder.edgesToSuperview()
    stateHolder.centerInSuperview()

    // Indicator
    let indicator = UIActivityIndicatorView(style: .medium)
    stateHolder.addSubview(indicator)
    indicator.centerInSuperview()
    indicator.startAnimating()
  }

  private func setEmpty(_ emptyView: UIView) {
    removeStateViews(enableView: true, hideSubviews: true)

    // Holder
    let stateHolder = UIView().tag(.stateTag)
    addSubview(stateHolder)
    stateHolder.edgesToSuperview()
    stateHolder.centerInSuperview()

    // Empty
    stateHolder.addSubview(emptyView)
    emptyView.edgesToSuperview()
  }

  private func setRetry(_ block: @escaping () -> Void) {
    removeStateViews(enableView: true, hideSubviews: true)

    // Holder
    let stateHolder = UIView().tag(.stateTag)
    addSubview(stateHolder)
    stateHolder.edgesToSuperview()
    stateHolder.centerInSuperview()

    // Retry
    let retry = UIButton(type: .system).title("Retry").titleColor(.blue)
    retry.titleLabel?.font = .preferredFont(forTextStyle: .body)
    retry.rx.tap
      .subscribe(onNext: {
        block()
        retry.removeFromSuperview()
      })
      .disposed(by: retry.rx.disposeBag)
    stateHolder.addSubview(retry)
    retry.centerInSuperview()
  }
}
