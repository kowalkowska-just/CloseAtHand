//
//  LoginController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 26/11/2020.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Closeathand"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Satisfy-Regular", size: 50)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField().textField(withPlaceholder: "EMAIL",
                                         isSecureTextEntry: false)
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private var passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "PASSWORD",
                                       isSecureTextEntry: true)
    }()
    
    private lazy var emailContainerView: UIView = {
        let emailView = UIView().inputContainerView(image: UIImage(systemName: "envelope")!,
                                                    textField: emailTextField)
        emailView.dimensions(height: 40)
        
        return emailView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let passwordView = UIView().inputContainerView(image: UIImage(systemName: "lock")!,
                                                       textField: passwordTextField)
        passwordView.dimensions(height: 40)
        return passwordView
    }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor.init(white: 1, alpha: 0.15)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let separationView: UIView = {
        let separator = UIView().createSeparationView(withText: "OR")
        separator.dimensions(height: 12)
        
        return separator
    }()
    
    private let loginWithFacebookButton: AuthButton = {
        let button = AuthButton()
        button.setTitle("Log in with Facebook", for: .normal)
        button.backgroundColor = UIColor.facebookColor
        button.addSymbol(withLogo: "facebook")
        
        return button
    }()
    
    private let loginWithAppleButton: AuthButton = {
        let button = AuthButton()
        button.setTitle("Log in with Apple", for: .normal)
        button.backgroundColor = UIColor.appleColor.withAlphaComponent(0.5)
        button.addSymbol(withLogo: "apple")
        
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("FORGOT YOUR PASSWORD?", for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.dimensions(height: 40)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedButton(withFirstString: "Don't have an account?  ", withSecondString: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSingUp), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hideKeyboardWhenTappedAround()
        
        //Gesture Recognizer
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleShowSingUp))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: - Helper functions
    
    func configureUI() {
        configureNavigationBar()
        
        view.addGradientWithColors(.topColorGradient, .bottomColorGradient, direction: .topLeftCornerToBottomRightCorner)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 25)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton, forgotPasswordButton, separationView, loginWithFacebookButton, loginWithAppleButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
                
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 18, paddingLeft: 30, paddingRight: 30)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 5)
        dontHaveAccountButton.centerX(inView: view)
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func handleError(error: Error) {
        let errorAuthStatus = AuthErrorCode.init(rawValue: error._code)!
        switch errorAuthStatus {
        case .wrongPassword,
             .invalidEmail,
             .userNotFound:
            
            return presentAlertControllerWithOKButton(withTitle: "Opss..", withMessage: "\(error.localizedDescription)")
            
        default: print("Error not supported here")
        }
    }
    
    //MARK: - Selectors
    
    @objc func handleShowSingUp() {
        let controller = SignUpController()
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
 
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in

            if let error = error {
                print("Failed to log user in with error \(error.localizedDescription) ")
                return self.handleError(error: error)
            }
            
            guard let user = Auth.auth().currentUser else { return }
            
            switch user.isEmailVerified {
            
            case true:
                print("Mail is verified..")
                self.dismiss(animated: true, completion: nil)
                
                
            case false:
                print("Mail is not verified yet")
                
                let alert = UIAlertController(title: "This account isn't verified.", message: "Please check your email box or resend verification email.", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addAction(UIAlertAction(title: "SEND", style: .default, handler: { (self) in
                    user.sendEmailVerification { (error) in
                        guard let error = error else {
                            return print("user email verification sent..")
                        }
                        print("Error with verification \(error)")
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
