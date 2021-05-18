//
//  ContentView.swift
//  Shared
//
//  Created by Anastasia Zimina on 5/16/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var news: [NewsData]
    let uploadLatest: () -> Void
    
    var body: some View {
        NavigationView {
            List{
                ForEach(news) { elem in
                    NavigationLink(
                        
                        destination: NewsDetails(news: binding(for: elem)),
                        label: {
                            Text(elem.title)
                        }
                    )
                }
            }
            .navigationBarTitle("News Summary")
        }
    }
    
    private func binding(for elem: NewsData) -> Binding<NewsData> {
        guard let newsIndex = news.firstIndex(where: {$0.id == elem.id}) else { fatalError("Cannot find element")}
        return $news[newsIndex];
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(news: .constant(NewsData.defaultData), uploadLatest: {})
    }
}
