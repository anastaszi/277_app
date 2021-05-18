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
                            NewsCell(newsElem: elem)
                        }
                    )
                }
            }
            .navigationBarTitle("Tech and Fashion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {uploadLatest()}, label: {
                        Image(systemName: "arrow.2.circlepath")
                    })
                }
            }
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

