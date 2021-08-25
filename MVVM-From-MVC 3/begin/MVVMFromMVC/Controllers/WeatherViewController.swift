/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class WeatherViewController: UIViewController {
  private let geocoder = LocationGeocoder()
  private let defaultAddress = "McGaheysville, VA"
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
  }()
  private let tempFormatter: NumberFormatter = {
    let tempFormatter = NumberFormatter()
    tempFormatter.numberStyle = .none
    return tempFormatter
  }()
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  override func viewDidLoad() {
    geocoder.geocode(addressString: defaultAddress) { [weak self] locations in
      guard
        let self = self,
        let location = locations.first
        else {
          return
        }
      self.cityLabel.text = location.name
      self.fetchWeatherForLocation(location)
    }
  }

  func fetchWeatherForLocation(_ location: Location) {
    //1
    WeatherbitService.weatherDataForLocation(
      latitude: location.latitude,
      longitude: location.longitude) { [weak self] (weatherData, error) in
      //2
      guard
        let self = self,
        let weatherData = weatherData
        else {
          return
        }
      self.dateLabel.text =
        self.dateFormatter.string(from: weatherData.date)
      self.currentIcon.image = UIImage(named: weatherData.iconName)
      let temp = self.tempFormatter.string(
        from: weatherData.currentTemp as NSNumber) ?? ""
      self.currentSummaryLabel.text =
        "\(weatherData.description) - \(temp)℉"
      self.forecastSummary.text = "\nSummary: \(weatherData.description)"
    }
  }
}
