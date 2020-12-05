//
//  Extension.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 26/11/2020.
//

import UIKit

//MARK: - UIView Extension

extension UIView {
    
    //MARK: - Anchor and dimensions

    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
    }
    
    func dimensions(width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    
    func centerY(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    
    //MARK: - Gradient layer
    
    enum Direction: Int {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
        case topLeftCornerToBottomRightCorner
        case topRightCornerToBottomLeftCorner
    }
    
    func addGradientWithColors(_ firstColor: UIColor, _ secondColor: UIColor, direction: Direction, locations: [NSNumber]? = [0.0, 1.0]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = locations
        
        switch direction {

        case .topToBottom:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
            
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
            
        case .topLeftCornerToBottomRightCorner:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        case .topRightCornerToBottomLeftCorner:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
    
        self.layer.addSublayer(gradient)
    }
    
    //MARK: - Shadow
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.masksToBounds = false
    }
    
    //MARK: - Corner Radius
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor

    }
    
    //MARK: - ContainerView for UITextField in Login/SignUp Controller
    
    func inputContainerViewForTextField(image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        imageView.anchor(left: view.leftAnchor)
        imageView.dimensions(width: 18, height: 18)
        imageView.centerY(inView: view)
        
        view.addSubview(textField)
        textField.anchor(left: imageView.rightAnchor, right: view.rightAnchor, paddingLeft: 8)
        textField.centerY(inView: view)
        
        let separationView = UIView()
        separationView.backgroundColor = .white
        view.addSubview(separationView)
        separationView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        separationView.dimensions(height: 1)
        
        return view
    }
    
    func inputContainerViewForTitle(title: String, imageColor color: String, image: String) -> UIView {
        let view = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.init(named: Constatnt.textColor)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .left
      //  titleLabel.addShadow()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.init(named: color)
        imageView.addShadow()
        
        view.addSubview(imageView)
        imageView.dimensions(width: 30, height: 30)
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 5, paddingLeft: 10)
        
        view.addSubview(titleLabel)
        view.backgroundColor = UIColor.init(named: Constatnt.secendaryBackgroundColor)
        titleLabel.anchor(left: imageView.rightAnchor, paddingLeft: 10)
        titleLabel.centerY(inView: imageView)
        titleLabel.dimensions(height: 25)
        
        view.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 4.5)
    
        return view
    }
    
    //MARK: - SeparationView
    
    func createSeparationView(withText text: String) -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        
        view.addSubview(label)
        label.centerX(inView: view)
        label.centerY(inView: view)
        
        let leftSeparationView = UIView()
        leftSeparationView.backgroundColor = .white
        
        let rightSeparationView = UIView()
        rightSeparationView.backgroundColor = .white
        
        view.addSubview(leftSeparationView)
        leftSeparationView.anchor(left: view.leftAnchor, right: label.rightAnchor, paddingLeft: 0, paddingRight: 35)
        leftSeparationView.dimensions(height: 1)
        leftSeparationView.centerY(inView: view)
        
        view.addSubview(rightSeparationView)
        rightSeparationView.anchor(left: label.leftAnchor, right: view.rightAnchor, paddingLeft: 35, paddingRight: 0)
        rightSeparationView.dimensions(height: 1)
        rightSeparationView.centerY(inView: view)
        
        return view
    }
    
    func createSeparator(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.dimensions(height: 1)
        
        return view
    }
}

//MARK: - UIColor

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let topColorGradient = UIColor.rgb(red: 19, green: 103, blue: 129)
    static let bottomColorGradient = UIColor.rgb(red: 88, green: 36, blue: 76)

    static let facebookColor = UIColor.rgb(red: 59, green: 89, blue: 152)
    static let appleColor = UIColor.rgb(red: 25, green: 25, blue: 25)
}

//MARK: - UITextField

extension UITextField {
    
    func textField(withPlaceholder placeholder: String, isSecureTextEntry: Bool) -> UITextField{
        let tf = UITextField()
        tf.borderStyle = .none
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.5)])
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = isSecureTextEntry
        tf.keyboardAppearance = .dark
        
        return tf
    }
}

//MARK: - AuthButton

extension AuthButton {
    
    func addSymbol(withLogo nameLogo: String) {
        let logo = UIImageView()
        logo.image = UIImage(named: "\(nameLogo)")
        logo.contentMode = .scaleAspectFit
        
        self.addSubview(logo)
        logo.anchor(left: self.leftAnchor, paddingLeft: 15)
        logo.dimensions(width: 18, height: 18)
        logo.centerY(inView: self)
    }
}

//MARK: - UIButton

extension UIButton {
    
    func attributedButton(withFirstString firstString: String, withSecondString secondString: String) {
        let attributedTitle = NSMutableAttributedString(string: firstString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.5)])
        attributedTitle.append(NSAttributedString(string: secondString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}

//MARK: - UIViewController

extension UIViewController {
    
    //MARK: - Hide Keyboard
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Present Alert Controller
    
    func presentAlertControllerWithOKButton(withTitle title: String, withMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Loading View
    
    func shouldPresentLoadingView(_ present: Bool, message: String? = nil) {
        if present {
            let loadingView = UIView()
            loadingView.frame = self.view.frame
            loadingView.backgroundColor = .black
            loadingView.alpha = 0
            loadingView.tag = 1

            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.center = view.center
            
            let label = UILabel()
            label.text = message
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .white
            label.alpha = 0.87
            
            view.addSubview(loadingView)
            loadingView.addSubview(indicator)
            loadingView.addSubview(label)
            
            label.anchor(top: indicator.bottomAnchor, paddingTop: 32)
            label.centerX(inView: view)
            
            indicator.startAnimating()
            
            UIView.animate(withDuration: 0.3) {
                loadingView.alpha = 0.85
            }
        } else {
            view.subviews.forEach { (subview) in
                if subview.tag == 1 {
                    UIView.animate(withDuration: 0.3) {
                        subview.alpha = 0
                    } completion: { (_) in
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func configureNavigationBar(withTitle title: String, withColor color: UIColor) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: Constatnt.textColor), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationItem.title = title
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = color
    }
}
