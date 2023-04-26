//
//  Presenter.swift
//  MVPPattern
//
//  Created by e.mubarakov on 26.04.2023.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    
    weak var delegate: PresenterDelegate?
    
    func getUsers() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let request = URLRequest(url: url)
            
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else { return }
            
            if let users = try? JSONDecoder().decode([User].self, from: data) {
                self.delegate?.presentUsers(users: users)
            } else {
                print("Fail")
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTap(user: User) {
        delegate?.presentAlert(title: user.name,
                               message: "\(user.name) has an email of \(user.email) & a username of \(user.username)")
    }
}
