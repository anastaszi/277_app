//
//  APIResponse.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//

import Foundation

struct FashionNewsAPIResponse: Codable {
    let data: Data
    
    struct Data: Codable {
        let Items: [Item]
        
        struct Item: Codable {
            let id: String;
                let category: String;
                let author: String;
                let dateCreated: String;
                let imgurl: String;
                let text: String;
                let title: String;
                
                enum CodingKeys: String, CodingKey {
                    case id="uuid"
                    case category
                    case author
                    case dateCreated
                    case imgurl
                    case text
                    case title
                }
            }
        }
    }
   
    
