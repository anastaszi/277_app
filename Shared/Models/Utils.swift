//
//  Utils.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/16/21.
//

import Foundation
import SwiftUI

enum Categories: String, CaseIterable, Hashable, Identifiable {
    case all = "All"
    case blockchain = "Blockchain"
    case ml = "ML"
    case ai = "AI"
    case ar = "AR"
    case bigdata = "BigData"
    case cv = "ComputerVision"
    
    var id: Categories {self}
}
