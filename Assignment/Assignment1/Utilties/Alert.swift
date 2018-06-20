//
//  Alert.swift
//  Assignment1
//
//  Created by Sachin Gupta on 5/14/18.
//  Copyright © 2018 Sachin Gupta. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
       func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
