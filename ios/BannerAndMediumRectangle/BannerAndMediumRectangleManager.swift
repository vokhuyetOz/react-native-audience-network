//
//  File.swift
//  react-native-audience-network
//
//  Created by CI-CD on 15/05/2024.
//

import Foundation
import FBAudienceNetwork

@objc(BannerAndMediumRectangleManager)
class BannerAndMediumRectangleManager: RCTViewManager {
  override func view() -> (BannerAndMediumRectangle) {
    return BannerAndMediumRectangle()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

class BannerAndMediumRectangle : UIView, FBAdViewDelegate {
    var initPlacementId = ""
    var initSize : String = ""
    var initBidPayload : String = ""
    var initAdview : FBAdView? = nil
    
   @objc var placementID: String = "" {
     didSet {
        initPlacementId = placementID
         self.createBannerViewIfCan()
     }
   }
    @objc var size: String = "" {
      didSet {
          initSize = size
          self.createBannerViewIfCan()
      }
    }
    @objc var bidPayload: String = "" {
      didSet {
          initBidPayload = bidPayload
          self.createBannerViewIfCan()
      }
    }
    @objc var onDidLoad: RCTDirectEventBlock?
    func getSize(sizeString: String) -> FBAdSize {
        
        if(sizeString == "kFBAdSizeHeight90Banner"){
            return kFBAdSizeHeight90Banner
        }
        
        if(sizeString == "kFBAdSizeHeight250Rectangle"){
            return kFBAdSizeHeight250Rectangle
        }
        
        return kFBAdSizeHeight50Banner
    }
    func createBannerViewIfCan() {
        if(placementID == "" || initSize == "" || initBidPayload == "") {
            return
        }
        if (initAdview != nil) {
            initAdview?.removeFromSuperview()
         }
        let fbSize = getSize(sizeString: initSize)
        let adView = FBAdView(placementID: initPlacementId, adSize: fbSize, rootViewController: self.reactViewController())
        adView.frame = CGRect(x: 0, y: 0, width: fbSize.size.width, height: fbSize.size.height)
//        bidPayload The payload of the ad bid. You can get your bid id from Facebook bidder endpoint.
        adView.loadAd(withBidPayload: initBidPayload)
        adView.delegate = self
        self.addSubview(adView)
    }
     func adViewDidLoad(_ adView: FBAdView) {
        if(onDidLoad == nil ){
            return
        }
         let event = [AnyHashable: Any]()
         onDidLoad!(event)
    }
}
