//
//  ApiClient.swift
//  Contacts
//
//  Created by 登秝吳 on 26/04/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation

final class ApiClient {
    
    let session: URLSession
    let responseQueue: DispatchQueue?
    
    static let shared = ApiClient(session: .shared, responseQueue: .main)
    
    init(session: URLSession = .shared, responseQueue: DispatchQueue? = .main) {
        self.session = session
        self.responseQueue = responseQueue
    }

    @discardableResult
    func getContacts(completion: @escaping ([Contact]?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: "https://demomedia.co.uk/files/contacts.json")!
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                error == nil,
                let data = data else {
                    self.dispatchResult(error: error, completion: completion)
                    return
            }
            
            let decoder = JSONDecoder()
            do {
                let contactlist = try decoder.decode([Contact].self, from: data)
                self.dispatchResult(models: contactlist, completion: completion)
            } catch {
                self.dispatchResult(error: error, completion: completion)
            }
        }
        
        task.resume()
        return task
    }
    
    private func dispatchResult<Type>(
        models: Type? = nil,
        error: Error? = nil,
        completion: @escaping (Type?, Error?) -> Void) {
        guard let responseQueue = responseQueue else {
            completion(models, error)
            return
        }
        responseQueue.async {
            completion(models, error)
        }
    }
}
