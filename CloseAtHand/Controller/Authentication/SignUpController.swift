//
//  SignUpController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 26/11/2020.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin

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
        let emailView = UIView().inputContainerViewForTextField(image: UIImage(systemName: "envelope")!,
                                                    textField: emailTextField)
        emailView.dimensions(height: 40)
        
        return emailView
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let fullnameView = UIView().inputContainerViewForTextField(image: UIImage(systemName: "person")!,
                                                    textField: fullnameTextField)
        fullnameView.dimensions(height: 40)
        
        return fullnameView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let passwordView = UIView().inputContainerViewForTextField(image: UIImage(systemName: "lock")!,
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
        button.addTarget(self, action: #selector(handleSignUpWithFacebook), for: .touchUpInside)
        
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

    //MARK: - Configure UI functions
    
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
                    self.presentAlertControllerWithOKButton(withTitle: "A verification link has been sent to your e-mail account", withMessage: "Click the link that has just been sent to your email account (\(user.email!)) to verify your email address and continue the logging in. \n \n If you not get this email, please check you spam box.")
                    return print("DEBUG: User email verification sent..")
                }
                print("DEBUG: Failed to sent a verification email to user: \(error)")
            }
            
            //Save data
            guard let uid = result?.user.uid else { return }
            let values = ["email": email, "fullname": fullname] as [String: Any]
            
            UsersService.shered.saveData(values: values, uid: uid)
        }
    }
    
    @objc func handleSignUpWithFacebook() {
    
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(granted: _, declined: _, token: _):
                self.shouldPresentLoadingView(true, message: "Sign Up..")
                self.signIntoFirebaseWithFacebook()
                
            case .cancelled:
                self.shouldPresentLoadingView(true, message: "Canceled getting Facebook user..")
                UIView.animate(withDuration: 3.5) {
                    self.shouldPresentLoadingView(false)
                }

            case .failed(let error):
                self.shouldPresentLoadingView(true, message: "Failed to get Facebook user with error: \(error)")
                UIView.animate(withDuration: 3.5) {
                    self.shouldPresentLoadingView(false)
                }
            }
        }
    }
    
    //MARK: - Helper functions
    
    fileprivate func signIntoFirebaseWithFacebook() {
        guard let authenticationToken = AccessToken.current?.tokenString else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("DEBUG: Failed logged in into Facebook with error: \(error)")
                return
            }
            
            guard let id = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference(withPath: "users")
            
            
            ref.child(id).observeSingleEvent(of: .value, with: {(snapshot) in
                if snapshot.exists() {
                    //User is signing IN
                    print("DEBUG: Successfully logged in into Facebook.")
                    self.shouldPresentLoadingView(false)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    //User is signing UP
                    print("DEBUG: Successfully logged up into Facebook.")
                    UsersService.shered.fetchFacebookUser()
                    self.shouldPresentLoadingView(false)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
}
