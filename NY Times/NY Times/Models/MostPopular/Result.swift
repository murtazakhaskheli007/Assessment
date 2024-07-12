//
//  Result.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 11/07/2024.
//

import Foundation

struct ResultData: Codable {
    var uri: String?
    var url: String?
    var id, assetID: Int?
    var source: String?
    var publishedDate, updated, section: String?
    var subsection: String?
    var nytdsection, adxKeywords: String?
    var column: JSONNull?
    var byline: String?
    var type: String?
    var title, abstract: String?
    var desFacet, orgFacet, perFacet, geoFacet: [String]?
    var media: [Media]?
    var etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
}
