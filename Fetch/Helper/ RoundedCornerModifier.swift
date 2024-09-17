//
//   RoundedCornerModifier.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/17/24.
//

import SwiftUI

struct RoundedCornerModifier: ViewModifier {
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .cornerRadius(radius)
    }
}

extension View {
    func roundedCorners(_ radius: CGFloat) -> some View {
        self.modifier(RoundedCornerModifier(radius: radius))
    }
}
