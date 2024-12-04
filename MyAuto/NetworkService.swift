////
////  NetworkService.swift
////  MyAuto
////
////  Created by User on 02.04.24.
////
//
//import Foundation
//import UIKit
//
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse(String)
    case invalidData
}
//
//struct LoginResponse {
//    let accessToken: String
//}
//
//protocol NetworkServiceProtocol {
//    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)
//    func getCarBrands(completion: @escaping (Result<CarBrand, NetworkError>) -> Void)
//    func getCarModels(brandID: String, completion: @escaping (Result<CarModel, NetworkError>) -> Void)
//}
//
//class NetworkService: NetworkServiceProtocol {
//    func getCarModels(brandID: String, completion: @escaping (Result<CarModel, NetworkError>) -> Void) {
//        guard let url = URL(string: "\(AppKeys.baseURL)models/\(brandID)") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            // Check for errors
//            if let error = error {
//                completion(.failure(.requestFailed(error)))
//                return
//            }
//            
//            // Ensure data is received
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            // Parse JSON data into CarBrand objects
//            do {
//                let decoder = JSONDecoder()
//                let carBrands = try decoder.decode(CarModel.self, from: data)
//                completion(.success(carBrands))
//            } catch {
//                completion(.failure(.invalidResponse("Failed to decode JSON")))
//            }
//        }.resume() // Don't forget to resume the task
//    }
//    
//    func getCarBrands(completion: @escaping (Result<CarBrand, NetworkError>) -> Void) {
//        // Create URL
//        guard let url = URL(string: "\(AppKeys.baseURL)brands") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        // Create URLSession task for making the GET request
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            // Check for errors
//            if let error = error {
//                completion(.failure(.requestFailed(error)))
//                return
//            }
//            
//            // Ensure data is received
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            // Parse JSON data into CarBrand objects
//            do {
//                let decoder = JSONDecoder()
//                let carBrands = try decoder.decode(CarBrand.self, from: data)
//                completion(.success(carBrands))
//            } catch {
//                completion(.failure(.invalidResponse("Failed to decode JSON")))
//            }
//        }.resume() // Don't forget to resume the task
//    }
//
//    
//    
//    func saveAccessToken(token: String) {
//        UserDefaults.standard.set(token, forKey: "accessToken")
//    }
//
//    // Получение токена из UserDefaults
//    func getAccessToken() -> String? {
//        return UserDefaults.standard.string(forKey: "accessToken")
//    }
//
//    // Удаление токена из UserDefaults (например, при выходе пользователя)
//    func deleteAccessToken() {
//        UserDefaults.standard.removeObject(forKey: "accessToken")
//    }
//    
//    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
//        // Создаем URL-адрес
//        guard let url = URL(string: "\(AppKeys.baseURL)auth/login") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        // Создаем запрос
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        // Создаем форму для передачи данных
//        var formData = [String: String]()
//        formData["email"] = email
//        formData["password"] = password
//        
//        // Генерируем данные формы
//        var bodyData = Data()
//        for (key, value) in formData {
//            bodyData.append("--MyBoundary\r\n".data(using: .utf8)!)
//            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//            bodyData.append("\(value)\r\n".data(using: .utf8)!)
//        }
//        bodyData.append("--MyBoundary--\r\n".data(using: .utf8)!)
//        
//        let contentType = "multipart/form-data; boundary=MyBoundary"
//        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
//        
//        request.httpBody = bodyData
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//           
//            if let error = error {
//                completion(.failure(.requestFailed(error)))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    if let accessToken = json["access_token"] as? String {
//                        let loginResponse = LoginResponse(accessToken: accessToken)
//                        self.saveAccessToken(token: accessToken)
//                        completion(.success(loginResponse))
//                    } else {
//                        completion(.failure(.invalidResponse("Missing access_token")))
//                    }
//                }
//            } catch {
//                completion(.failure(.invalidResponse("Failed to parse JSON")))
//            }
//        }
//        task.resume()
//    }
//
//////  // Добавление объявления
////  func addAnnouncement(details: [String: String], completion: @escaping (Result<String, NetworkError>) -> Void) {
//////      guard let url = URL(string: "\(AppKeys.baseURL)announcement"),
//////            let accessToken = getAccessToken() else {
//////          completion(.failure(.invalidURL))
//////          return
//////      }
////    guard let url = URL(string: "\(AppKeys.baseURL)announcement") else { return }
////
////      var request = URLRequest(url: url)
////      request.httpMethod = "POST"
////      request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcyNzgxMjMxMywianRpIjoiMTIyNDQxYmItNmI2NS00NzFhLWE2YWEtZDJkZmY1YzhkYjdhIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6OSwibmJmIjoxNzI3ODEyMzEzLCJjc3JmIjoiNjU1ZjVjNWItOWI4OS00NzAwLWE5YjktNjAxZWM1MmJlNzIzIiwiZXhwIjoxNzI3ODk4NzEzfQ.WKhdX8REckzalKFp92gU9bH-I72Kbi_H1iLLs4MYFaE", forHTTPHeaderField: "Authorization")
////      let boundary = "Boundary-\(UUID().uuidString)"
////      request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
////
////      request.httpBody = createMultipartBody(for: details, boundary: boundary)
////
////      URLSession.shared.dataTask(with: request) { data, response, error in
////          if let error = error {
////              completion(.failure(.requestFailed(error)))
////              return
////          }
////
////        print(data)
////        print(response)
////          guard let data = data,
////                let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
////                let message = jsonResponse["message"] as? String else {
////              completion(.failure(.invalidResponse("Invalid data or response")))
////              return
////          }
////
////          completion(.success(message))
////      }.resume()
////  }
//
//
//  func uploadAnnouncement(announcement: AnnouncementUploadModel, jwtToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
//      let url = URL(string: "\(AppKeys.baseURL)announcement")!
//      var request = URLRequest(url: url)
//      request.httpMethod = "POST"
//      request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcyNzgxMjMxMywianRpIjoiMTIyNDQxYmItNmI2NS00NzFhLWE2YWEtZDJkZmY1YzhkYjdhIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6OSwibmJmIjoxNzI3ODEyMzEzLCJjc3JmIjoiNjU1ZjVjNWItOWI4OS00NzAwLWE5YjktNjAxZWM1MmJlNzIzIiwiZXhwIjoxNzI3ODk4NzEzfQ.WKhdX8REckzalKFp92gU9bH-I72Kbi_H1iLLs4MYFaE", forHTTPHeaderField: "Authorization")
//
//      let boundary = UUID().uuidString
//      request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//      var body = Data()
//
//      // Append text parameters
//      let params = [
//          "id": announcement.id,
//          "brand_id": announcement.brandID,
//          "miles": announcement.miles,
//          "exchange_option": announcement.exchangeOption,
//          "price": announcement.price,
//          "year": announcement.year,
//          "phone_number": announcement.phoneNumber,
//          "description": announcement.description
//      ]
//
//      for (key, value) in params {
//          body.append("--\(boundary)\r\n".data(using: .utf8)!)
//          body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//          body.append("\(value)\r\n".data(using: .utf8)!)
//      }
//
//      // Append image data
//      if let imageData = announcement.image.jpegData(compressionQuality: 0.8) {
//          let fileName = "image.jpg" // Adjust this as needed
//          body.append("--\(boundary)\r\n".data(using: .utf8)!)
//          body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//          body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//          body.append(imageData)
//          body.append("\r\n".data(using: .utf8)!)
//      }
//
//      body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//      request.httpBody = body
//
//      // Perform the request
//      URLSession.shared.dataTask(with: request) { data, response, error in
//          if let error = error {
//              completion(.failure(error))
//              return
//          }
//
//          guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
//              let statusError = NSError(domain: "Invalid server response", code: 0, userInfo: nil)
//              completion(.failure(statusError))
//              return
//          }
//
//          completion(.success(()))
//      }.resume()
//  }
//
//  private func createMultipartBody(for details: [String: String], boundary: String) -> Data {
//      var body = Data()
//      let boundaryPrefix = "--\(boundary)\r\n"
//
//      func addFormField(_ name: String, _ value: String) {
//          body.append(boundaryPrefix.data(using: .utf8)!)
//          body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
//          body.append("\(value)\r\n".data(using: .utf8)!)
//      }
//
//      // Add each key-value pair from the details dictionary
//      for (key, value) in details {
//          addFormField(key, value)
//      }
//
//      body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//      return body
//  }
//
//}
