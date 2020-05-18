//
//  NSBundle+Utils.swift
//  DyooVideoPlayer
//
//  Created by Chaz Woodall on 3/21/19.
//  Copyright © 2019 Dyoo. All rights reserved.
//

import Foundation

extension Bundle {
    static func nvp_frameworkBundle() -> Bundle {
        let bundle = Bundle(for: NSPRTVideoPlayerControls.self)
        guard let path = bundle.path(forResource: "NSPRTVideoPlayer", ofType: "bundle") else { return bundle }
        return Bundle(path: path)!
    }
    
    static func resourceBundle() throws -> Bundle {
        let bundles = Bundle.allBundles
        let bundlePaths = bundles.compactMap { $0.resourceURL?.appendingPathComponent("Assets", isDirectory: false).appendingPathExtension("bundle") }

        guard let bundle = bundlePaths.compactMap({ Bundle(url: $0) }).first else {
            throw NSError(domain: "com.nsprtvideoplayer", code: 404, userInfo: [NSLocalizedDescriptionKey: "Missing resource bundle"])
        }
        return bundle
    }
}
