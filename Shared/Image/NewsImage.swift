//
//  NewsImage.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//

import SwiftUI

struct NewsImage: View {
    @StateObject var remoteImg = RemoteImg()
    
    private var ulr: URL
    
    init(url: URL) {
        self.ulr = url
    }
    var body: some View {
        VStack {
            if remoteImg.image != nil {
                withAnimation(){
                    Image(uiImage: remoteImg.image!)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            } else {
                ActivityIndicator(shouldAnimate: .constant(true))
            }
        }.onAppear{
            self.remoteImg.load(url: self.ulr)
        }.onDisappear{
            self.remoteImg.cancel()
        }
    }
}

struct NewsImage_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://d2t51sxsanqkl5.cloudfront.net/eda01ed9-26e5-4996-899b-a362b46315d1")!
        NewsImage(url: url)
    }
}
