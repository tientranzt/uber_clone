//
//  LoginController.swift
//  hello_world
//
//  Created by tientran on 19/12/2020.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    
    //    Makr - properties
    private let titleLable : UILabel = {
        let lable = UILabel()
        lable.text = "UBER"
        lable.font = UIFont(name: "Avenir", size: 36)
        lable.textColor = UIColor(white: 1, alpha: 0.8)
        return lable
    }()
    
    private lazy var emailContainerView : UIView = {
        
        return UIView().inputContainer(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    }()
    
    private lazy var passwordContainerView : UIView = {
        
        return UIView().inputContainer(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
    }()
    
    private let emailTextField : UITextField = {
        let view =  UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let passwordTextField : UITextField = {
        let view =  UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let loginButton : AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Login", for: .normal)
        
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton : UIButton = {
        let button = UIButton()
        let attributeTitle = NSMutableAttributedString(string: "Don't have account? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.lightGray] )
        
        attributeTitle.append(NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.mainBlueTint] ))
        
        button.setAttributedTitle(attributeTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @objc func handleShowSignUp(){
        print("signin is pressed")
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLoginButton(){
        
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { (result, err) in
            if let err = err {
                print("Login fail : \(err)")
                return
            }
            
            guard let homeController = UIWindow.key?.rootViewController as? HomeController else { return }
            homeController.configureUI()
            self.dismiss(animated: true, completion: nil)
        
        }
        
    }
    
    func configureUI()  {
        
        configureNavigatioBar()
        
        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.8)
        
        view.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 26
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: titleLable.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 30)
    }
    
    func configureNavigatioBar()  {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
}

