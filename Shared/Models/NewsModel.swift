//
//  NewsModel.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/16/21.
//

import Foundation

class NewsData: Identifiable, Codable {
    
    
    var id: String
    var title: String
    var author: String
    var text: String
    var imgurl: URL?
    var category: String
    var date: Date
    
    
    init?(id: String, title: String, author: String, text: String, imgurl: String, category: String, date: Date) {
        
        guard !title.isEmpty  else {
            return nil
        }
        guard !author.isEmpty  else {
            return nil
        }
        
    
        self.id = id
        self.title = title;
        self.author = author;
        self.text = text;
        self.imgurl = URL(string: imgurl);
        self.category = category;
        self.date = date
    }
    
    static var defaultData: [NewsData] = {
        return loadDataFromCode()
    }()
    
    static func loadDataFromCode() -> [NewsData] {
        guard let news1 = NewsData(id: "234234", title: "Fashion News", author: "Anastasia", text: "This is a long text", imgurl: "https://d2t51sxsanqkl5.cloudfront.net/eda01ed9-26e5-4996-899b-a362b46315d1", category: "Bitcoin", date: Date()) else {fatalError("Unable to initiate news1")};
        var temp = [NewsData]()
        temp += [news1]
        return temp;
    }
}

let testData = NewsData(id: "234234", title: "Fashion News", author: "Anastasia", text: "This is a long text", imgurl: "https://d2t51sxsanqkl5.cloudfront.net/eda01ed9-26e5-4996-899b-a362b46315d1", category: "Bitcoin", date: Date())

 
