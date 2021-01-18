//
//  SignUpController.swift
//  hello_world
//
//  Created by tientran on 20/12/2020.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import GeoFire

class SignUpController: UIViewController {
    
    let firestore = Firestore.firestore()
    
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
    
    private lazy var fullNameContainerView : UIView = {
        
        return UIView().inputContainer(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)
    }()
    
    private lazy var accountTypeContainerView : UIView = {
        
        let view =  UIView().inputContainer(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: accountTypeSegmentedControl)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
    private let emailTextField : UITextField = {
        let view =  UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.keyboardType = .emailAddress
        return view
    }()
    
    private let passwordTextField : UITextField = {
        let view =  UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let fullNameTextField : UITextField = {
        let view =  UITextField().textField(withPlaceholder: "Full name", isSecureTextEntry: false)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let accountTypeSegmentedControl : UISegmentedControl = {
        
        let sc = UISegmentedControl(items: ["User", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.8)
        sc.selectedSegmentIndex = 0
        
        return sc
    }()
    
    private let signUpButton : AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI()  {
        
        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.8)
        
        view.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, accountTypeContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 26
        stack.distribution = .fillProportionally
        
        view.addSubview(stack)
        stack.anchor(top: titleLable.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
    
    @objc func handleSignUpButton(){
        //        navigationController?.popViewController(animated: true)
        
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        guard let name = fullNameTextField.text else { return }
        let userType = accountTypeSegmentedControl.selectedSegmentIndex
    
        
        Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
            if let error = err {
                print("Fail to create user \(error)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let geofire = GeoFire(firebaseRef: DRIVER_LOCATION_REF)
            
            
            
            self.firestore.collection("users").document(uid).setData([
                "email" : email,
                "pass" : pass,
                "fullName" : name,
                "userType" : userType
            ]) { (err) in
                if err == nil {
                    print("Succes to add document")
                }
                else{
                    print("Fail to add document")
                }
            }
            
        }
    }
    
}

