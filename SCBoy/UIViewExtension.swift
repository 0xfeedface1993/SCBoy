//
//  UIViewExtension.swift
//  SCBoy
//
//  Created by virus1994 on 2019/4/22.
//  Copyright © 2019 ascp. All rights reserved.
//

import UIKit

extension UIView {
    func makeFullFlap() {
        guard let _ = self.superview else {
            assert(true, "This view not have superview!")
            return
        }
        let views: [String:UIView] = ["x": self]
        views.forEach({ $0.value.translatesAutoresizingMaskIntoConstraints = false })
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[x]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[x]|", options: [], metrics: nil, views: views))
    }
}
