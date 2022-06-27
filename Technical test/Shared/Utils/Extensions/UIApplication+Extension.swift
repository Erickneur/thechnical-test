//
//  UIApplication+Extension.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

extension UIApplication {
    
    class func getTopViewController(
        base: UIViewController? =
        UIApplication.shared.connectedScenes.filter({
            $0.activationState == .foregroundActive
        })
        .map({
            $0 as? UIWindowScene
        })
        .compactMap({
            $0
        })
        .first?.windows.filter({
            $0.isKeyWindow
        })
        .first?.rootViewController
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
