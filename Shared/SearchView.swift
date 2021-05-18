//
//  SearchView.swift
//  FashionTrends
//
//  Created by Anastasia Zimina on 5/17/21.
//

import SwiftUI

struct SearchView: View {
    @Binding var news: [NewsData]
    @Binding var selectedCategory: Categories
    let getByCategory: () -> Void
    var body: some View {
        VStack {
            HStack {
                Picker("Please choose a color", selection: $selectedCategory) {
                        ForEach(Categories.allCases) {
                            Text($0.rawValue)
                        }
                    }
           
                }
            List{
                ForEach(news) { elem in
                    NewsCell(newsElem: elem)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(news: .constant(NewsData.defaultData), selectedCategory: .constant(Categories.ml), getByCategory: {})
    }
}
