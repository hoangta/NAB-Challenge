//
//  ForecastViewCell.swift
//  NABChallenge
//
//  Created by Hoang Ta on 7/2/20.
//  Copyright © 2020 ht. All rights reserved.
//

import UIKit

final class ForecastViewCell: UITableViewCell {
  private let date = UILabel().font(.preferredFont(forTextStyle: .body))
  private let temp = UILabel().font(.preferredFont(forTextStyle: .body))
  private let pressure = UILabel().font(.preferredFont(forTextStyle: .body))
  private let humidity = UILabel().font(.preferredFont(forTextStyle: .body))
  private let desc = UILabel().font(.preferredFont(forTextStyle: .body))

  required init?(coder aDecoder: NSCoder) { fatalError() }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    backgroundColor = .clear
    let stack = UIStackView(arrangedSubviews: [date, temp, pressure, humidity, desc]).axis(.vertical)
    contentView.addSubview(stack)
    stack.edgesToSuperview(insets: .init(top: 10, left: 20, bottom: 10, right: 20))
  }

  func setForecast(_ forecast: Forecast) {
    self.date.text = "Date: \(forecast.date.toString(.longDate))"
    self.temp.text = "Average Temperature: \(forecast.avgTemperature)°C"
    self.pressure.text = "Pressure: \(Int(forecast.pressure))"
    self.humidity.text = "Humidity: \(Int(forecast.humidity))%"
    self.desc.text = "Description: \(forecast.description ?? "")"
  }
}
