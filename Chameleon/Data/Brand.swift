//
//  Brand.swift
//  Charmeleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 22.11.24.
//

import Foundation
import SwiftData

@Model
class Brand: Identifiable, Hashable {
    let id: UUID
    let name: String
    var mapping: [String:String]
    var isSelected: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        mapping: [String : String],
        isSelected: Bool
    ) {
        self.id = id
        self.name = name
        self.mapping = mapping
        self.isSelected = isSelected
    }
}

extension Brand {
    static var defaults: [Brand] {
        [
            Brand(
                name: "Glovo",
                mapping: [
                    "020658": "006F5A",
                    "160A9D": "188669",
                    "3F53B9": "009E81",
                    "98A6D7": "5ACBB6",
                    "D0DAF3": "B6EEE3",
                    "6C01A9": "BC9300",
                    "971CDE": "DBAB00",
                    "C154FF": "EBBA0B",
                    "DB9CFF": "FFCD1A",
                    "F4E2FF": "FFE68B"
                ],
                isSelected: true
            ),
            Brand(
                name: "Efood",
                mapping: [
                    "020658": "A40E0E",
                    "160A9D": "ED2E2E",
                    "3F53B9": "F15D5D",
                    "98A6D7": "F7A1A1",
                    "D0DAF3": "FDE8E8",
                    "6C01A9": "008B67",
                    "971CDE": "00B485",
                    "C154FF": "03D49D",
                    "DB9CFF": "42F0C3",
                    "F4E2FF": "B1FFEB"
                ],
                isSelected: true
            ),
            Brand(
                name: "Foodora",
                mapping: [
                    "020658": "C60D5C",
                    "160A9D": "D70F64",
                    "3F53B9": "FF3D8A",
                    "98A6D7": "F7BDD1",
                    "D0DAF3": "FDF1F5",
                    "6C01A9": "002C2C",
                    "971CDE": "1D4242",
                    "C154FF": "226A6A",
                    "DB9CFF": "61D2D2",
                    "F4E2FF": "D2F8F8"
                ],
                isSelected: true
            ),
            Brand(
                name: "Foodpanda",
                mapping: [
                    "020658": "89003B",
                    "160A9D": "D70F64",
                    "3F53B9": "FF2B85",
                    "98A6D7": "F386B4",
                    "D0DAF3": "FFE0ED",
                    "6C01A9": "826F3D",
                    "971CDE": "9F8644",
                    "C154FF": "C3A14A",
                    "DB9CFF": "E6C673",
                    "F4E2FF": "FFE6B3"
                ],
                isSelected: true
            ),
            Brand(
                name: "Foody",
                mapping: [
                    "020658": "BC4410",
                    "160A9D": "EC662B",
                    "3F53B9": "F29269",
                    "98A6D7": "F7BBA1",
                    "D0DAF3": "FCE4D9",
                    "6C01A9": "0098A7",
                    "971CDE": "07C1D4",
                    "C154FF": "0FDCF0",
                    "DB9CFF": "73F3FF",
                    "F4E2FF": "BAF9FF"
                ],
                isSelected: true
            ),
            Brand(
                name: "Hungerstation",
                mapping: [
                    "020658": "5A2F23",
                    "160A9D": "6F3D2F",
                    "3F53B9": "B76953",
                    "98A6D7": "EC967E",
                    "D0DAF3": "FFD700",
                    "6C01A9": "6C01A9",
                    "971CDE": "971CDE",
                    "C154FF": "C154FF",
                    "DB9CFF": "DB9CFF",
                    "F4E2FF": "F4E2FF"
                ],
                isSelected: true
            ),
            Brand(
                name: "Mjam",
                mapping: [:],
                isSelected: false
            ),
            Brand(
                name: "Pedidosya",
                mapping: [
                    "020658": "970131",
                    "160A9D": "EA044E",
                    "3F53B9": "F44F84",
                    "98A6D7": "F690B1",
                    "D0DAF3": "FFD1E0",
                    "6C01A9": "001ABB",
                    "971CDE": "00BEDD",
                    "C154FF": "00D9FC",
                    "DB9CFF": "68EAFF",
                    "F4E2FF": "BEF6FF",
                    "E06C00": "FFC000",
                    "FFF2DD": "FFEDB2",
                    "159D4B": "1C8663",
                    "D8FCDD": "CFFFEE"
                ],
                isSelected: true
            ),
            Brand(
                name: "Talabat",
                mapping: [
                    "020658": "E85301",
                    "160A9D": "FF5A00",
                    "3F53B9": "FF9459",
                    "98A6D7": "FFCDB2",
                    "D0DAF3": "FFEEE5",
                    "6C01A9": "012CAF",
                    "971CDE": "0E4AFF",
                    "C154FF": "5881FF",
                    "DB9CFF": "A6BCFF",
                    "F4E2FF": "D3DEFF"
                ],
                isSelected: true
            ),
            Brand(
                name: "Yemeksepeti",
                mapping: [
                    "020658": "AF0038",
                    "160A9D": "FA0050",
                    "3F53B9": "FB5187",
                    "98A6D7": "FEB2CA",
                    "D0DAF3": "FFE6EE",
                    "6C01A9": "0D9E5C",
                    "971CDE": "1EC177",
                    "C154FF": "29DC8B",
                    "DB9CFF": "5EFFB6",
                    "F4E2FF": "B8FFDF"
                ],
                isSelected: true
            )
        ]
    }
}
