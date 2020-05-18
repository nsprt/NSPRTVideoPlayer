//
//  NSPRTVideoPlayerPlaybackError.swift
//  NSPRTVideoPlayer
//
//  Created by Chaz Woodall on 3/19/19.
//  Copyright © 2019 NSPRT. All rights reserved.
//

import Foundation

public enum NSPRTVideoPlayerPlaybackError {
    case unknown
    case notFound
    case unauthorized
    case authenticationError
    case forbidden
    case unavailable
    case mediaFileError
    case bandwidthExceeded
    case playlistUnchanged
    case decoderMalfunction
    case decoderTemporarilyUnavailable
    case wrongHostIP
    case wrongHostDNS
    case badURL
    case invalidRequest
}
