//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let standardCornerRadius: CGFloat = 4.0
    
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let textFieldBorderWidth: CGFloat = 2
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private let textFieldContainer = UIView()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    private func setup() {
        backgroundColor = bgColor
        //MARK: Setup title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        //MARK: Setup textField
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textFieldContainer)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = textFieldBorderWidth
        textField.layer.cornerRadius = standardCornerRadius
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.isSecureTextEntry = true
        
        //textField.becomeFirstResponder()
        
        //MARK: Setup colorViews
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = standardCornerRadius
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = standardCornerRadius
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = standardCornerRadius
        
        //MARK: Setup desc label
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
        //MARK: Setup show/hide button
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(eyesWideShut), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            //in order as setup above and semantically with view
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -textFieldMargin),
            textFieldContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -standardMargin),
            
            weakView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: textFieldMargin),
            weakView.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            mediumView.topAnchor.constraint(equalTo: weakView.topAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strongView.topAnchor.constraint(equalTo: weakView.topAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor)
            
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func eyesWideShut() {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    private func animate(view: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.transform = CGAffineTransform(scaleX: 1.33, y: 1)
        }) { _ in
            view.transform = .identity
        }
    }
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        switch newText.count {
        case 0...9:
            strengthDescriptionLabel.text = "Too Weak"
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 10...19:
            strengthDescriptionLabel.text = "Could Be Stronger"
            if mediumView.backgroundColor == unusedColor {
                animate(view: mediumView)
                mediumView.backgroundColor = mediumColor
            }
            strongView.backgroundColor = unusedColor
        default:
            strengthDescriptionLabel.text = "Strong Password"
            if strongView.backgroundColor == unusedColor {
                animate(view: strongView)
                strongView.backgroundColor = strongColor
            }
        }
        return true
    }
}
