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
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  private let viewModel = WeatherViewModel()
  
  override func viewDidLoad() {
    viewModel.locationName.bind { [weak self] locationName in
      self?.cityLabel.text = locationName
    }
    
    viewModel.date.bind { [weak self] date in
      self?.dateLabel.text = date
    }
    
    viewModel.icon.bind { [weak self] image in
      self?.currentIcon.image = image
    }
    
    viewModel.summary.bind { [weak self] summary in
      self?.currentSummaryLabel.text = summary
    }
    
    viewModel.forecastSummary.bind { [weak self] forecast in
      self?.forecastSummary.text = forecast
    }
    
  }
  
  @IBAction func promptForLocation(_ sender: Any) {
    //1
    let alert = UIAlertController(
      title: "Choose location",
      message: nil,
      preferredStyle: .alert)
    alert.addTextField()
    //2
    let submitAction = UIAlertAction(
      title: "Submit",
      style: .default) { [unowned alert, weak self] _ in
        guard let newLocation = alert.textFields?.first?.text else { return }
        self?.viewModel.changeLocation(to: newLocation)
    }
    alert.addAction(submitAction)
    //3
    present(alert, animated: true)
  }
}
