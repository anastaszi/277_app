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
                .frame(width: 150, height: 100)
            VStack(alignment: .leading, content: {
                Text(newsElem.title)
                    .font(.title)
                    .lineLimit(0)
                    .padding(.trailing)
                    
                Text("in \(newsElem.category)")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.trailing)
                Text(newsElem.text).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .font(.body)
                    .foregroundColor(Color.gray)
                    .padding(.trailing)
                    
            })
            .padding(.bottom)
        }
        
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(newsElem: testData!)
    }
}
