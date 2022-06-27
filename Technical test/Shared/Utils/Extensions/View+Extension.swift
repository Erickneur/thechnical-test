//
//  UIView+Extension.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

extension View {
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarViewModifier(backgroundColor: backgroundColor))
    }
    
}
