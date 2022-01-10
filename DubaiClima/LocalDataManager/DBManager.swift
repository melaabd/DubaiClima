//
//  DBManager.swift
//  DubaiClima
//
//  Created by melaabd on 1/10/22.
//

import Foundation
import RealmSwift

class DBManager: NSObject {
    private let myRealmQueue = DispatchQueue(label: "realmQueue", qos: .background)
    var database:Realm!

    static let shared = DBManager()
    var config = Realm.Configuration()
    
    override init() {
        super.init()
        
        config = Realm.Configuration(
            // set a new version number, the version number must bigger than before
            // if you never set it, it's 0
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in

                if (oldSchemaVersion < 1) {
                    // do nothing
                }
        })
        // tell Realm the new config should be used
        Realm.Configuration.defaultConfiguration = config

        // open realm file and it will do auto-migration
        myRealmQueue.sync { [weak self] in
            self?.database = try! Realm()
        }
        
    }
    
    func fetchData() -> Weather? {
        if let results =  self.database.objects(Weather.self).first {
            return results
        } else {
            return nil
        }
    }

    func replaceData(weather: Weather) {
        onMain { [weak self] in
        try! self?.database.write {
             self?.database.deleteAll()
             self?.database.add(weather, update: .all)
        }
        }
    }
}
