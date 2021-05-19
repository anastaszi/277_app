//
//  NewsCell.swift
//  FashionTrends
//
//  Created by Anastasia Zimina on 5/17/21.
//

import SwiftUI

struct NewsCell: View {
    var newsElem: NewsData
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0.0){
            Text(newsElem.title)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                
                HStack(alignment: .top, spacing: 0.0) {
                    NewsImage(url: newsElem.imgurl!)
                        .padding(.trailing)
                .frame(width: 150, height: 100)
            VStack(alignment: .leading, spacing: 3.0, content: {

                Text("in \(newsElem.category)")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.trailing)
                Text(newsElem.text)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(Color.gray)
                    .padding(.trailing)
                    
                    
            })
            .frame(width: .infinity, height: 100, alignment: .center)
          
        }
        
            }
            }
        }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(newsElem: testShortData!)
    }
}
