//
//  SearchView.swift
//  FashionTrends
//
//  Created by Anastasia Zimina on 5/17/21.
//

import SwiftUI

struct SearchView: View {
    @Binding var news: [NewsData]
    let getByCategory: () -> Void
    @State private var selectedCategory = Categories.ai
    var body: some View {
        HStack {
                    Picker("Please choose a color", selection: $selectedCategory) {
                        ForEach(Categories.allCases) {
                            Text($0.rawValue)
                        }
                    }
            Text("You selected: \(selectedCategory.rawValue)")
                }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(news: .constant(NewsData.defaultData), getByCategory: {})
    }
}
