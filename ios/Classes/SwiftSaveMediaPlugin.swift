import Flutter
import UIKit
import Photos

public class SwiftSaveMediaPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "save_media", binaryMessenger: registrar.messenger())
    let instance = SwiftSaveMediaPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "saveMediaAssets" {
          guard let mediaItems = call.arguments as? [[String: Any]]
          else { return result(false) }
   
          PHPhotoLibrary.shared().performChanges {
              for item in mediaItems {
                  let fileURL = URL(fileURLWithPath: item["filePath"] as! String)
                  let pairedVideoFilePath = item["pairedVideoFilePath"] as? String
                  let isVideo = item["isVideo"] as! Bool
                  let creationRequest = PHAssetCreationRequest.forAsset()
                  creationRequest.addResource(with: isVideo ? .video : .photo, fileURL: fileURL, options: nil)
                  if pairedVideoFilePath != nil {
                      let pairedVideoFileURL = URL(fileURLWithPath: pairedVideoFilePath!)
                      if #available(iOS 9.1, *) {
                          creationRequest.addResource(with: .pairedVideo, fileURL: pairedVideoFileURL, options: nil)
                      }
                  }
              }
          } completionHandler: { success, error in
              result(success)
          }
          
      }

  }
}
