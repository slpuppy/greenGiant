//
//  AdManager.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 11/02/22.
//

import Foundation
import GoogleMobileAds

class AdManager: NSObject, GADFullScreenContentDelegate {
    
    private(set) var interstitial: GADInterstitialAd?
    
    func initialize(){
        
        requestInterstitialAd()
        
    }
    
    
    private func requestInterstitialAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                requestInterstitialAd()
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        })
        
    }
    
    func presentInterstitialAd(in vc: UIViewController) {
        DispatchQueue.main.async {
            self.interstitial?.present(fromRootViewController: vc)
        }
    }
    



/// Tells the delegate that the ad failed to present full screen content.
func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
    print("Ad did fail to present full screen content.")
}

/// Tells the delegate that the ad presented full screen content.
func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("Ad did present full screen content.")
}

/// Tells the delegate that the ad dismissed full screen content.
func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("Ad did dismiss full screen content.")
    requestInterstitialAd()
}



}
