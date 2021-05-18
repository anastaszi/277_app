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
    @Published var dataByCategory: [NewsData] = []
    @Published var category: Categories = Categories.all
    
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
        
        $category
            .dropFirst(1) //As soon as you create the observation, $city emits its first value. Since the first value is an empty string, you need to skip it to avoid an unintended network call.
            .debounce(for: .seconds(0.1), scheduler: scheduler) //debounce works by waiting a second until the user stops typing
            .sink(receiveValue: requestLatestNewsByType(category:)) //You observe these events via sink(receiveValue:) and handle them with requestCurrentWeather(querycity:)
            .store(in: &bag)
    }
    
    
    func getNewsCombine() -> AnyPublisher<Data, Error> {
        let getNewsURL = getAllNews().url!
        
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
    
    func getNewsCombine(category: String) -> AnyPublisher<Data, Error> {
        let getNewsURL = getNewsByCategory(category: category).url!
        
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
    
    func requestLatestNewsByTypeCombine(category: Categories) -> AnyPublisher<Data, Error> {
        return self.getNewsCombine(category: category.rawValue)
            .eraseToAnyPublisher()
    }
    
    func requestLatestNewsCombine() -> AnyPublisher<Data, Error> {
        return self.getNewsCombine()
            .eraseToAnyPublisher()
    }
    
    func requestLatestNewsByType(category: Categories)  {
        if (category == Categories.all) {
            self.requestLatestNews(main: false)
        } else {
            return self.requestLatestNewsByTypeCombine(category: category)
                .decode(type:FashionNewsAPIResponse.self, decoder: LatestNews.newsJSONDecoder)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: {_ in
                    print("receiveCompletion")
                }, receiveValue: { [weak self] news in
                    print(news.data.Items)
                    self?.newsResponse = news
                    self?.updateLocalNews(data: news, main: false)
                })
                .store(in: &bag)
        }
    }
    
    func requestLatestNews(main: Bool) {
        return self.requestLatestNewsCombine()
            .decode(type:FashionNewsAPIResponse.self, decoder: LatestNews.newsJSONDecoder)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in
                print("receiveCompletion")
            }, receiveValue: { [weak self] news in
                print(news.data.Items)
                self?.newsResponse = news
                self?.updateLocalNews(data: news, main: main)
            })
            .store(in: &bag)
    }
    
    func load() {
        //data.append(testData!);
        self.requestLatestNews(main: true)
    }
    
    func update() {
        self.load()
    }
    
    func getByCategory() {
        self.load()
    }
    
    func updateLocalNews(data: FashionNewsAPIResponse, main: Bool) {
        main ? self.data.removeAll() : self.dataByCategory.removeAll()
        
        for item in data.data.Items {
            print(item.dateCreated)
            guard let newItem = NewsData(id: item.id, title: item.title, author: item.author, text: item.title, imgurl: item.imgurl, category: item.category, date: Date()) else {
                fatalError("Not able to create new elem")
            }
            if (main) {
                self.data.append(newItem);
            } else {
                self.dataByCategory.append(newItem)
            }
            
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
    
    func getAllNews() -> URLComponents {
        var components = URLComponents()
        components.scheme = APIGateway.scheme
        components.host = APIGateway.host
        components.path = APIGateway.path + "/news"
        
        return components
    }
    
    func getNewsByCategory(category: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = APIGateway.scheme
        components.host = APIGateway.host
        components.path = APIGateway.path + "/categories/" + category
        
        return components
    }
}
