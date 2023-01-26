//
//  LoginView.swift
//  LoginView
//
//  Created by 김민령 on 2022/09/17.
//

import Foundation
import UIKit
import SnapKit

class LoginView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .black
        setup()
        addViews()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: view
    
    private lazy var emailBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var emailInfoLabel: UILabel = {
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
//        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        return tf
    }()
    
    private lazy var passwdBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var passwdInfoLabel: UILabel = {
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
//        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        return tf
    }()
    
    lazy var passwdSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(UIColor.white , for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        button.addTarget(self, action: #selector(passwdSecureModeSetting), for: .touchUpInside)
        
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
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var passwdResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailBoxView, passwdBoxView, loginButton])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        
        return st
    }()
    
    //텍스트 필드의 크기를 지정하는 변수
    private let textViewHeight:CGFloat = 48
    
    //autoLayout 변경을 위한 변수
    private lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailBoxView.centerYAnchor)
    private lazy var passwdInfoLabelCenterYConstraint = passwdInfoLabel.centerYAnchor.constraint(equalTo: passwdBoxView.centerYAnchor)
    
    // MARK: function
    
    func setup(){
        backgroundColor = .black
        
        emailTextField.delegate = self
        passwdTextField.delegate = self
    }
    
    func addViews(){
        [stackView, passwdResetButton].forEach{ addSubview($0)}
    }
    
    func setAutoLayout(){

        
        emailBoxView.addSubview(emailTextField)
        emailBoxView.addSubview(emailInfoLabel)
        
        passwdBoxView.addSubview(passwdTextField)
        passwdBoxView.addSubview(passwdInfoLabel)
        passwdBoxView.addSubview(passwdSecureButton)
        
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.leading.equalTo(snp.leading).offset(30)
            make.trailing.equalTo(snp.trailing).offset(-30)
            make.height.equalTo(textViewHeight*3 + 36)
        }
        
        emailInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailBoxView).offset(8)
            make.trailing.equalTo(emailBoxView).offset(8)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.edges.equalTo(emailBoxView).inset(UIEdgeInsets(top: 15, left: 8, bottom: 2, right: 8))
        }
        
        passwdInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwdBoxView).offset(8)
            make.trailing.equalTo(passwdBoxView).offset(8)
        }
        
        passwdTextField.snp.makeConstraints { make in
            make.edges.equalTo(passwdBoxView).inset(UIEdgeInsets(top: 15, left: 8, bottom: 2, right: 8))
        }
        
        passwdSecureButton.snp.makeConstraints { make in
            make.top.equalTo(passwdBoxView).offset(15)
            make.bottom.equalTo(passwdBoxView).offset(-15)
            make.trailing.equalTo(passwdBoxView).offset(-8)
        }
        
        passwdResetButton.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(30)
            make.trailing.equalTo(snp.trailing).offset(-30)
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.height.equalTo(textViewHeight)
        }
        
        //autoLayout isActive = true 없이 작성
        NSLayoutConstraint.activate([

//            emailInfoLabel.centerYAnchor.constraint(equalTo: emailBoxView.centerYAnchor),
            emailInfoLabelCenterYConstraint,
            
//            passwdInfoLabel.centerYAnchor.constraint(equalTo: passwdBoxView.centerYAnchor),
            passwdInfoLabelCenterYConstraint,
            

            
        ])
    }
}

// MARK: view event function
extension LoginView: UITextFieldDelegate {
    
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
    
    @objc func passwdSecureModeSetting(){
        passwdTextField.isSecureTextEntry.toggle()
        print("passwd secure mode : \(passwdTextField.isSecureTextEntry)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}


