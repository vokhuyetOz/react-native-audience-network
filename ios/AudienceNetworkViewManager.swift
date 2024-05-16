import FBAudienceNetwork

@objc(AudienceNetworkViewManager)
class AudienceNetworkViewManager: RCTViewManager {

  override func view() -> (AudienceNetworkView) {
    return AudienceNetworkView()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

class AudienceNetworkView : UIView {

    
  
}
