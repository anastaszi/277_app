//
//  TabedView.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//

import SwiftUI

struct TabedView: View {
    @State private var tabSelected = 0;
    @EnvironmentObject var latestNews: LatestNews
    var body: some View {
        HStack{
            TabView(selection: $tabSelected) {
            ContentView(news: $latestNews.data, uploadLatest: {latestNews.load()})
            .tabItem{
                Image(systemName: (tabSelected == 0 ? "newspaper" : "newspaper.fill"))
                    Text("All News")
            }.tag(0)
                SearchView(news: $latestNews.dataByCategory, selectedCategory: $latestNews.category, getByCategory: {latestNews.getByCategory()}).tabItem{
                Image(systemName: (tabSelected == 1 ? "magnifyingglass.circle" : "magnifyingglass.circle.fill"))
                        Text("Search")
            }.tag(1)
            }
        }
    }
}

struct TabedView_Previews: PreviewProvider {
    static var previews: some View {
        TabedView().environmentObject(LatestNews())
    }
}
