//
//  PhoneDataModel.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//
import Foundation

struct Models: Codable {
    var id, name: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var dataColor, dataCapacity: String?
    var capacityGB: Int?
    var dataPrice: Double?
    var dataGeneration: String?
    var year: Int?
    var cpuModel, hardDiskSize, strapColour, caseSize: String?
    var color, descriptionNew, capacity: String?
    var screenSize: Double?
    var generation, price: String?

    enum CodingKeys: String, CodingKey {
        case dataColor = "color"
        case dataCapacity = "capacity"
        case capacityGB = "capacity GB"
        case dataPrice = "price"
        case dataGeneration = "generation"
        case year
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case color = "Color"
        case descriptionNew = "Description"
        case capacity = "Capacity"
        case screenSize = "Screen size"
        case generation = "Generation"
        case price = "Price"
    }
}

typealias PhoneDataModel = [Models]
