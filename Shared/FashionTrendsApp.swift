//
//  FashionTrendsApp.swift
//  Shared
//
//  Created by Anastasia Zimina on 5/16/21.
//

import SwiftUI
import Amplify

@main
struct FashionTrendsApp: App {
    @StateObject private var data = LatestNews()
    var body: some Scene {
        WindowGroup {
            TabedView().environmentObject(data)
                .onAppear{
                    data.load()
                }
        }
    }
}
