//
//  RoundedView.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import Foundation
import UIKit

 public class RoundedView: UIView {

       required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
          setup()
       }
    func setup () {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
   
    }
 }
