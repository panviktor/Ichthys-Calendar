//
//  StoreReviewHelper.swift
//  Ichthys Calendar
//
//  Created by Viktor on 30.11.2020.
//

import SwiftUI
import StoreKit

struct StoreReviewHelper {
    @AppStorage("AppOpenedCount") var appOpenedCount = 0
    
    static let shared = StoreReviewHelper()
    
    fileprivate init() {}
    
    func incrementAppOpenedCount() {
        appOpenedCount += 1
    }
    
    func checkAndAskForReview() {
        switch appOpenedCount {
        case 25, 50:
            StoreReviewHelper().requestReview()
        case _ where appOpenedCount % 100 == 0 :
            StoreReviewHelper().requestReview()
        default:
            break
        }
    }
    
    private func requestReview() {
        if let scene = UIApplication.shared.currentScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func requestFullReview() {
        guard let appURL = URL(string: Constant.appURL) else { return }
        var components = URLComponents(url: appURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "action", value: "write-review")
        ]
        guard let writeReviewURL = components?.url else {
            return
        }
        UIApplication.shared.open(writeReviewURL)
    }
}
