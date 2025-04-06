//
//  api.swift
//  nu-munch
//
//  Created by Conrad on 4/6/25.
//

import Foundation

class ApiCall {    
    let baseUrl = "http://127.0.0.1:5000"

    func getUser(userId: String, completion: @escaping (Result<User, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/users/\(userId)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<User>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getOrder(orderId: String, completion: @escaping (Result<Order, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/orders/\(orderId)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<Order>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getAllOrders(completion: @escaping (Result<[Order], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/orders") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<[Order]>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getOrderLength(completion: @escaping (Result<Int, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/order_length") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<Int>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getAllEateries(completion: @escaping (Result<[Eatery], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/eateries") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<[Eatery]>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getEatery(eateryId: String, completion: @escaping (Result<Eatery, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/eateries/\(eateryId)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<Eatery>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getEateryItems(eateryId: String, completion: @escaping (Result<[FoodItem], Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/eateries/\(eateryId)/items") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<[FoodItem]>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getItem(itemId: String, completion: @escaping (Result<FoodItem, Error>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/items/\(itemId)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let feedback = try JSONDecoder().decode(Response<FoodItem>.self, from: data)
                if feedback.status == "success" {
                    completion(.success(feedback.feedback))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: feedback.feedback])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// Response struct to handle feedback and status
struct Response<T: Codable>: Codable {
    let feedback: T
    let status: String
}
