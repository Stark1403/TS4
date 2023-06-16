//
//  DogsEntity.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//  
//

import Foundation

struct Dogs: Codable {
    var dogs: [DogsResponse]
}

class DogsResponse: Codable {
    var name: String?
    var lifeSpan: String?
    var description: String?
    var group: String?
    var image: URL?

    
    private enum CodingKeys: String, CodingKey {
        case name = "dogName"
        case lifeSpan = "dogLifeSpan"
        case description = "dogDesc"
        case group = "dogGroup"
        case image = "dogImage"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { name = try values.decode(String.self, forKey: .name) } catch {}
        do { lifeSpan = try values.decode(String.self, forKey: .lifeSpan) } catch {}
        do { description = try values.decode(String.self, forKey: .description) } catch {}
        do { group = try values.decode(String.self, forKey: .group) } catch {}
        do { image = try values.decode(URL.self, forKey: .image) } catch {}
    }
}
