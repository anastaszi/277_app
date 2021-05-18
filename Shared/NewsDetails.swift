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
        HStack(alignment: .top){
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(news.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5.0)
                HStack {
                    Text("in \(news.category)")
                        .foregroundColor(Color.gray)
                    Text("by \(news.author)")
                        .foregroundColor(Color.gray)
                }
            
                Text(news.date, style: .date)
                    .foregroundColor(Color.gray)
            
                NewsImage(url: news.imgurl!)
                    .frame(width: .infinity, height: 200)
                    .padding(.vertical)
                Text(news.text)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
            Spacer()
        }
        .padding(.horizontal, 20.0)
    }
}

struct NewsDetails_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetails(news: .constant(NewsData.defaultData[0]))
    }
}
