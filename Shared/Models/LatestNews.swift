//
//  NewsData.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//

import Foundation
import Combine


class LatestNews: ObservableObject {
    @Published var data: [NewsData] = []
    @Published var info: String = ""
    
    @Published var newsResponse: FashionNewsAPIResponse?
    @Published var activityShouldAnimate = false;
    
    static var newsJSONDecoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    private var dateDecoder: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()
    
    private var bag = Set<AnyCancellable>()
    
    private let session: URLSession
    
    init(session: URLSession = .shared, scheduler: DispatchQueue = DispatchQueue(label: "LatestNews")) {
        self.session = session
    }
    
    
    func getNewsCombine() -> AnyPublisher<Data, Error> {
        let getNewsURL = makeGetCall().url!
        
        let urlRequest = URLRequest(url: getNewsURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 30)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError({error -> Error in
                APIErrors(rawValue: error.code.rawValue) ?? APIProviderError.unknownError
            })
            .map {
                $0.data
            }
            .eraseToAnyPublisher()
    }
    
    func requestLatestNewsCombine() -> AnyPublisher<Data, Error> {
        return self.getNewsCombine()
            .eraseToAnyPublisher()
    }
    
    func requestLatestNews() {
        return self.requestLatestNewsCombine()
            .decode(type:FashionNewsAPIResponse.self, decoder: LatestNews.newsJSONDecoder)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in
                print("receiveCompletion")
            }, receiveValue: { [weak self] news in
                print(news.data.Items)
                self?.newsResponse = news
                self?.updateLocalNews(data: news)
            })
            .store(in: &bag)
    }
    
    func load() {
        //data.append(testData!);
        self.requestLatestNews()
    }
    
    func updateLocalNews(data: FashionNewsAPIResponse) {
        for item in data.data.Items {
            print(item.author)
            print(item.title)
            print(item.dateCreated)
            guard let newItem = NewsData(id: item.id, title: item.title, author: item.author, text: item.title, imgurl: item.imgurl, category: item.category, date: Date()) else {
                fatalError("Not able to create new elem")
            }
            
            self.data.append(newItem);
        }
    }
}
//https://wa1qmmjg24.execute-api.us-east-1.amazonaws.com/master/news
private extension LatestNews {
    struct APIGateway {
        static let scheme = "https"
        static let host = "wa1qmmjg24.execute-api.us-east-1.amazonaws.com"
        static let path = "/master"
    }
    
    func makeGetCall() -> URLComponents {
        var components = URLComponents()
        components.scheme = APIGateway.scheme
        components.host = APIGateway.host
        components.path = APIGateway.path + "/news"
        
        return components
    }
}
