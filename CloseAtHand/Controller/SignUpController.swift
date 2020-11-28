//
//  SignUpController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 26/11/2020.
//

import UIKit
import Firebase

class SignUpController: UIViewController {

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
    
    private let fullnameTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "FULLNAME",
                                         isSecureTextEntry: false)
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
    
    private lazy var fullnameContainerView: UIView = {
        let fullnameView = UIView().inputContainerView(image: UIImage(systemName: "person")!,
                                                    textField: fullnameTextField)
        fullnameView.dimensions(height: 40)
        
        return fullnameView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let passwordView = UIView().inputContainerView(image: UIImage(systemName: "lock")!,
                                                       textField: passwordTextField)
        passwordView.dimensions(height: 40)
        return passwordView
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.init(white: 1, alpha: 0.15)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let separationView: UIView = {
        let separator = UIView().createSeparationView(withText: "OR")
        separator.dimensions(height: 12)
        
        return separator
    }()
    
    private let signUpWithFacebookButton: AuthButton = {
        let button = AuthButton()
        button.setTitle("Continue with Facebook", for: .normal)
        button.backgroundColor = UIColor.facebookColor
        button.addSymbol(withLogo: "facebook")
        
        return button
    }()
    
    private let signUpWithAppleButton: AuthButton = {
        let button = AuthButton()
        button.setTitle("Continue with Apple", for: .normal)
        button.backgroundColor = UIColor.appleColor.withAlphaComponent(0.5)
        button.addSymbol(withLogo: "apple")
        
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedButton(withFirstString: "Already have an account?  ", withSecondString: "Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hideKeyboardWhenTappedAround()
        
        //Gesture Recognizer
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleShowLogin))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: - Helper functions
    
    func configureUI() {
        
        view.addGradientWithColors(.topColorGradient, .bottomColorGradient, direction: .topRightCornerToBottomLeftCorner)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 25)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, signUpButton, separationView, signUpWithFacebookButton, signUpWithAppleButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 24
                
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 18, paddingLeft: 30, paddingRight: 30)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 5)
        alreadyHaveAccountButton.centerX(inView: view)
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    //MARK: - Selectors

    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to register user with error: \(error)")
                return
            }
            
            //Send a verification e-mail
            guard let user = Auth.auth().currentUser else { return }
            
            user.sendEmailVerification { (error) in
                guard let error = error else {
                    
                    self.presentAlertControllerWithOKButton(withTitle: "A verification link has been sent to your e-mail account",
                                                            withMessage: "Click the link that has just been sent to your email account (\(user.email!)) to verify your email address and continue the logging in. \n If you not get this email, please check you spam box.")
                    return print("DEBUG: User email verification sent..")
                }
                print("DEBUG: Failed to sent a verification email to user: \(error)")
            }
            
            //Save data
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email, "fullname": fullname] as [String: Any]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                print("DEBUG: Successfully register user and saved data...")
            }
        }
    }
}
