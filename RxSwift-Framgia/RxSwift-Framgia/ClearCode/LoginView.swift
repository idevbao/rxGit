//
//  LoginView.swift
//  RxSwift-Framgia
//
//  Created by nguyen.van.bao on 21/06/2018.
//  Copyright © 2018 nguyen.van.bao. All rights reserved.
//
import UIKit
protocol LoginViewDelegate: class {
    func loginView(_ view: LoginView, didTapLoginButton button: UIButton)
}

class LoginView: View {
    
    weak var delegate: LoginViewDelegate?
    
    var emailAddress: String {
        return emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    var password: String {
        return passwordTextField.text ?? ""
    }
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    override func setViews() {
        super.setViews()
        
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
    }
    
    override func layoutViews() {
        // Ở đây chúng ta sẽ layout các button, textfield. Bạn có thể sử dụng SnapKit
    }
    
}

// MARK: - Actions
private extension LoginView {
    
    @objc func didTapLoginButton(_ button: UIButton) {
        delegate?.loginView(self, didTapLoginButton: button)
    }
    
}
