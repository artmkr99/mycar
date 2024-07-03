//
//  NetworkService.swift
//  MyAuto
//
//  Created by User on 02.04.24.
//

import Foundation

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse(String)
    case invalidData
}

struct LoginResponse {
    let accessToken: String
}

protocol NetworkServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)
    func getCarBrands(completion: @escaping (Result<CarBrand, NetworkError>) -> Void)
    func getCarModels(brandID: String, completion: @escaping (Result<CarModel, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCarModels(brandID: String, completion: @escaping (Result<CarModel, NetworkError>) -> Void) {
        guard let url = URL(string: "\(AppKeys.baseURL)models/\(brandID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Parse JSON data into CarBrand objects
            do {
                let decoder = JSONDecoder()
                let carBrands = try decoder.decode(CarModel.self, from: data)
                completion(.success(carBrands))
            } catch {
                completion(.failure(.invalidResponse("Failed to decode JSON")))
            }
        }.resume() // Don't forget to resume the task
    }
    
    func getCarBrands(completion: @escaping (Result<CarBrand, NetworkError>) -> Void) {
        // Create URL
        guard let url = URL(string: "\(AppKeys.baseURL)brands") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create URLSession task for making the GET request
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Parse JSON data into CarBrand objects
            do {
                let decoder = JSONDecoder()
                let carBrands = try decoder.decode(CarBrand.self, from: data)
                completion(.success(carBrands))
            } catch {
                completion(.failure(.invalidResponse("Failed to decode JSON")))
            }
        }.resume() // Don't forget to resume the task
    }

    
    
    func saveAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }

    // Получение токена из UserDefaults
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }

    // Удаление токена из UserDefaults (например, при выходе пользователя)
    func deleteAccessToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        // Создаем URL-адрес
        guard let url = URL(string: "\(AppKeys.baseURL)auth/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Создаем запрос
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Создаем форму для передачи данных
        var formData = [String: String]()
        formData["email"] = email
        formData["password"] = password
        
        // Генерируем данные формы
        var bodyData = Data()
        for (key, value) in formData {
            bodyData.append("--MyBoundary\r\n".data(using: .utf8)!)
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            bodyData.append("\(value)\r\n".data(using: .utf8)!)
        }
        bodyData.append("--MyBoundary--\r\n".data(using: .utf8)!)
        
        let contentType = "multipart/form-data; boundary=MyBoundary"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let accessToken = json["access_token"] as? String {
                        let loginResponse = LoginResponse(accessToken: accessToken)
                        self.saveAccessToken(token: accessToken)
                        completion(.success(loginResponse))
                    } else {
                        completion(.failure(.invalidResponse("Missing access_token")))
                    }
                }
            } catch {
                completion(.failure(.invalidResponse("Failed to parse JSON")))
            }
        }
        task.resume()
    }
}
