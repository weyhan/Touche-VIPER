//
//  RadiusTestField.swift
//  Touche-VIPER
//
//  Created by weyhan.
//  Copyright © 2020 eccentricdeveloper. All rights reserved.
//

import UIKit

class RadiusTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initKeyboardToolbar()
    }

    fileprivate func initKeyboardToolbar() {
        let keyboardToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        keyboardToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))

        keyboardToolbar.items = [flexSpace, done]
        keyboardToolbar.sizeToFit()

        inputAccessoryView = keyboardToolbar
    }

    @objc fileprivate func doneAction() {
        resignFirstResponder()
    }
}
