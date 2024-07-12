//
//  Media.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 11/07/2024.
//

import Foundation

struct Media: Codable {
    var type: String?
    var subtype: String?
    var caption, copyright: String?
    var approvedForSyndication: Int?
    var mediaMetadata: [MediaMetadata]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    var url: String?
    var format: String?
    var height, width: Int?
}
