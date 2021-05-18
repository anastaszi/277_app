//
//  NewsDetails.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//

import SwiftUI

struct NewsDetails: View {
    @Binding var news: NewsData
    
    var body: some View {
        VStack {
            Spacer()
                        .frame(height: 10)
            VStack(spacing: 20) {
            Text(news.title)
            Text(news.category)
            Text(news.date, style: .date)
            
                NewsImage(url: news.imgurl!)
            Text(news.text)
            }
            Spacer()
                        .frame(height: 50)
        }
    }
}

struct NewsDetails_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetails(news: .constant(NewsData.defaultData[0]))
    }
}
