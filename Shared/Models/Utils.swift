//
//  Utils.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/16/21.
//

import Foundation
import SwiftUI

enum Categories: String, CaseIterable, Hashable, Identifiable {
    case bitcoin = "Bitcoin"
    case ml = "ML"
    case ai = "AI"
    
    var id: Categories {self}
}
