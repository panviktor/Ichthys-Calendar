//
//  RadioStation.swift
//  Ichthys Calendar
//
//  Created by Viktor on 21.12.2020.
//

import Foundation

struct RadioStation: Codable {
    let id: Int
    let name: String
    let streamURL: URL
    let description: String
    let longDescription: String
    let stationImage: String?
    
    init(id: Int, name: String, streamURL: URL,  description: String = "",
         longDescription: String = "", stationStringImage: String? = nil) {
        self.id = id
        self.name = name
        self.streamURL = streamURL
        self.description = description
        self.longDescription = longDescription
        self.stationImage = stationStringImage
    }
}

extension RadioStation: Equatable {
    static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return (lhs.id == rhs.id) && (lhs.name == rhs.name) && (lhs.streamURL == rhs.streamURL)
    }
}

extension RadioStation: Identifiable {}

extension RadioStation {
    static var mocRadio = RadioStation(id: 1, name: "Очень длинное название Радио Радонеж", streamURL: URL(string: "http://icecast.radonezh.cdnvideo.ru:8000/rad128")!, description: "Ра́донеж — московская православная радиостанция, вещающая с 1991 года и существующая на пожертвования своих слушателей.", longDescription: "Радио «Радонеж» вышло в эфир в 31 марта 1991 года по благословению Патриарха Московского и всея Руси Алексия II, став независимой в СССР радиостанцией. \n Многие программы имеют миссионерскую направленность. Программы радио «Радонеж» включают в себя беседы, лекции, дискуссии, открытый эфир, встречи со священноначалием, с ведущими представителями духовенства, церковной и гражданской науки, с общественными деятелями, новости, проповеди, музыкальные передачи, литературные композиции и многое другое.", stationStringImage: "Radonez")
}
