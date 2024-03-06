//
//  YourProfileVC.swift
//  GitHubUsers
//
//  Created by Sparsh Chadha on 02/03/24.
//

import UIKit

class YourProfileVC: UIViewController {
    let loginButton = GHFButton(backgroundColor: .systemBlue, buttonTitle: "Login With GitHub ")
    let loginLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLoginButtonAndLabel()
    }
    
    private func configureLoginButtonAndLabel() {
        loginLabel.text = "Login to view your GitHub profile stats"
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
      
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginButton.addTarget(self, action: #selector(startLoginWithGithub), for: .touchUpInside)
    }
    
    func fetchData() {
        let url = URL(string: "https://api.github.com/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if httpResponse.statusCode == 200 {
                // Parse and handle the response data
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response JSON: \(json)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("HTTP status code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
    }

    
    @objc func startLoginWithGithub() {
        if let url = URL(string: "https://github.com/login/oauth/authorize?client_id=1c91fdb72c57a551a942") {
            UIApplication.shared.open(url)
        }
    }
}
