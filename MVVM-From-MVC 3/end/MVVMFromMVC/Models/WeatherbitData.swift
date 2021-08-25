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

// see https://openweathermap.org/current#current_JSON for details
struct WeatherbitData: Decodable {
  
  private static let dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  //MARK: - JSON Decodables
  
  let observation: [Observation]
  
  struct Observation: Decodable {
    let temp: Double
    let datetime: String
    
    let weather: Weather
    
    struct Weather: Decodable {
      let icon: String
      let description: String
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case observation = "data"
  }
  
  //MARK: - Convenience getters
  
  var currentTemp: Double {
    observation[0].temp
  }
  
  var iconName: String {
    observation[0].weather.icon
  }
  
  var description: String {
    observation[0].weather.description
  }
  
  var date: Date {
    //strip off the time
    let dateString = String(observation[0].datetime.prefix(10))
    //use current date if unable to parse
    return Self.dateFormatter.date(from: dateString) ?? Date()
  }
  
}



