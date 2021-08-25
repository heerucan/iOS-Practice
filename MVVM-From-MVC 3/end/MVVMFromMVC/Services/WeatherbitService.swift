/// Copyright (c) 2020 Razeware LLC
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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

enum OpenWeatherMapError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}

class WeatherbitService {
  typealias WeatherDataCompletion = (WeatherbitData?, OpenWeatherMapError?) -> ()
  
  private static let apiKey = "9a8e59b84c754008aca1a9be88e0de5f"
  private static let host = "api.weatherbit.io"
  private static let path = "/v2.0/current"
  private static let fahrenheit = "I"
  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd:HH"
    return formatter
  }()
  
  static func weatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
    var urlBuilder = URLComponents()
    urlBuilder.scheme = "https"
    urlBuilder.host = host
    urlBuilder.path = path
    urlBuilder.queryItems = [
      URLQueryItem(name: "key", value: apiKey),
      URLQueryItem(name: "units", value: fahrenheit),
      URLQueryItem(name: "lat", value: "\(latitude)"),
      URLQueryItem(name: "lon", value: "\(longitude)")
    ]
    
    let url = urlBuilder.url!
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      //execute completion handler on main thread
      DispatchQueue.main.async {
        guard error == nil else {
          print("Failed request from Weatherbit: \(error!.localizedDescription)")
          completion(nil, .failedRequest)
          return
        }
        
        guard let data = data else {
          print("No data returned from Weatherbit")
          completion(nil, .noData)
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          print("Unable to process Weatherbit response")
          completion(nil, .invalidResponse)
          return
        }
        
        guard response.statusCode == 200 else {
          print("Failure response from Weatherbit: \(response.statusCode)")
          completion(nil, .failedRequest)
          return
        }
        
        do {
          let decoder = JSONDecoder()
          let weatherData: WeatherbitData = try decoder.decode(WeatherbitData.self, from: data)
          completion(weatherData, nil)
        } catch {
          print("Unable to decode Weatherbit response: \(error.localizedDescription)")
          completion(nil, .invalidData)
        }
      }
    }.resume()
  }
}
