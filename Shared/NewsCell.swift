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
            NewsImage(url: newsElem.imgurl!)
            VStack(alignment: .leading, content: {
                Text(newsElem.title)
                            .font(.headline)
                            .padding(.leading)
        })
        }
        
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(newsElem: testData!)
    }
}
