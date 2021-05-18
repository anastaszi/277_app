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
        HStack(alignment: .top) {
            NewsImage(url: newsElem.imgurl!)
                .frame(width: 150, height: 150)
            VStack(alignment: .leading, spacing: 3.0, content: {
                Text(newsElem.title)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .padding(.trailing)
                    
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

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(newsElem: testShortData!)
    }
}
