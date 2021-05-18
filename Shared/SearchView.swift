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
                Picker("Please choose Category", selection: $selectedCategory) {
                        ForEach(Categories.allCases) {
                            Text($0.rawValue)
                        }
                }.pickerStyle(MenuPickerStyle())
           
            
            NavigationView {List{
                ForEach(news) { elem in
                    NavigationLink(
                        destination: NewsDetails(news: binding(for: elem)),
                        label: {
                            NewsCell(newsElem: elem)
                        }
                    ).navigationTitle("Results for: \(selectedCategory.rawValue)")
                }
            }
            
        }
            
            
        }.onAppear(perform: {
            self.getByCategory()
        })
    }
    private func binding(for elem: NewsData) -> Binding<NewsData> {
        guard let newsIndex = news.firstIndex(where: {$0.id == elem.id}) else { fatalError("Cannot find element")}
        return $news[newsIndex];
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(news: .constant(NewsData.defaultData), selectedCategory: .constant(Categories.ml), getByCategory: {})
    }
}
