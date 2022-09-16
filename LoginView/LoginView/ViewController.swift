//
//  ViewController.swift
//  LoginView
//
//  Created by 김민령 on 2022/09/02.
//

import UIKit

final class ViewController: UIViewController {
    
    let emailBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .darkGray
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        return tf
    }()
    
    let passwdBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let passwdInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    
    lazy var passwdTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .darkGray
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        return tf
    }()
    
    lazy var passwdSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(UIColor.white , for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwdSecureModeSetting), for: .touchUpInside)
        
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var passwdResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailBoxView, passwdBoxView, loginButton])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        
        return st
    }()
    
    //텍스트 필드의 크기를 지정하는 변수
    let textViewHeight:CGFloat = 48
    
    //autoLayout 변경을 위한 변수
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailBoxView.centerYAnchor)
    lazy var passwdInfoLabelCenterYConstraint = passwdInfoLabel.centerYAnchor.constraint(equalTo: passwdBoxView.centerYAnchor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        emailTextField.delegate = self
        passwdTextField.delegate = self
        
        autoLayout()

    }
    
    
    func autoLayout(){
        view.addSubview(stackView)
        view.addSubview(passwdResetButton)
        
        emailBoxView.addSubview(emailTextField)
        emailBoxView.addSubview(emailInfoLabel)
        
        passwdBoxView.addSubview(passwdTextField)
        passwdBoxView.addSubview(passwdInfoLabel)
        passwdBoxView.addSubview(passwdSecureButton)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwdInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwdTextField.translatesAutoresizingMaskIntoConstraints = false
        passwdSecureButton.translatesAutoresizingMaskIntoConstraints = false
        
        passwdResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36).isActive = true
        
        //autoLayout isActive = true 없이 작성
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailBoxView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailBoxView.trailingAnchor, constant: 8),
//            emailInfoLabel.centerYAnchor.constraint(equalTo: emailBoxView.centerYAnchor),
            emailInfoLabelCenterYConstraint,
            
            emailTextField.leadingAnchor.constraint(equalTo: emailBoxView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailBoxView.trailingAnchor, constant: 8),
            emailTextField.topAnchor.constraint(equalTo: emailBoxView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailBoxView.bottomAnchor, constant: 2),
            
            passwdInfoLabel.leadingAnchor.constraint(equalTo: passwdBoxView.leadingAnchor, constant: 8),
            passwdInfoLabel.trailingAnchor.constraint(equalTo: passwdBoxView.trailingAnchor, constant: 8),
//            passwdInfoLabel.centerYAnchor.constraint(equalTo: passwdBoxView.centerYAnchor),
            passwdInfoLabelCenterYConstraint,
            
            passwdTextField.leadingAnchor.constraint(equalTo: passwdBoxView.leadingAnchor, constant: 8),
            passwdTextField.trailingAnchor.constraint(equalTo: passwdBoxView.trailingAnchor, constant: 8),
            passwdTextField.topAnchor.constraint(equalTo: passwdBoxView.topAnchor, constant: 15),
            passwdTextField.bottomAnchor.constraint(equalTo: passwdBoxView.bottomAnchor, constant: 2),
            
            passwdSecureButton.topAnchor.constraint(equalTo: passwdBoxView.topAnchor, constant: 15),
            passwdSecureButton.bottomAnchor.constraint(equalTo: passwdBoxView.bottomAnchor, constant: -15),
            passwdSecureButton.trailingAnchor.constraint(equalTo: passwdBoxView.trailingAnchor, constant: -8),
            
            passwdResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwdResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwdResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwdResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
            
        ])
    }
    
    @objc func resetButtonTapped() {
        let alert = UIAlertController(title: "비밀번호 변경", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인 : \(action)")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancel in
            print("취소 : \(cancel)")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func passwdSecureModeSetting(){
        passwdTextField.isSecureTextEntry.toggle()
        print("passwd secure mode : \(passwdTextField.isSecureTextEntry)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func loginButtonTapped() {
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailBoxView.backgroundColor = .gray
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwdTextField {
            passwdBoxView.backgroundColor = .gray
            passwdInfoLabel.font = UIFont.systemFont(ofSize: 11)
            
            passwdInfoLabelCenterYConstraint.constant = -13
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            return
        }
        
        if textField == emailTextField {
            emailBoxView.backgroundColor = .darkGray
            emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
            
            emailInfoLabelCenterYConstraint.constant = 0
        }
        
        if textField == passwdTextField {
            passwdBoxView.backgroundColor = .darkGray
            passwdInfoLabel.font = UIFont.systemFont(ofSize: 18)
            
            passwdInfoLabelCenterYConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 && textField.text?.first == " " {
            textField.text = ""
            return
        }
    
        guard
            let email = emailTextField.text, !email.isEmpty,
            let passwd = passwdTextField.text, !passwd.isEmpty
    else {
        loginButton.backgroundColor = .clear
        loginButton.isEnabled = false
        return
    }
    loginButton.backgroundColor = .red
    loginButton.isEnabled = true
    }
}

