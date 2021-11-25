//
//  FileManager.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 15/10/2020.
//

import Foundation

public extension FileManager {

    func createFolder(_ url: URL) {
        try? self.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
    }

    var docString: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }

    var docFolder: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }

    func saveJSONData(_ json: AnyObject, to filename: String) {
        guard
            let data = try? JSONSerialization.data(withJSONObject: json, options: [])
            else { return }

        saveData(data, to: filename)
    }

    func saveData(_ data: Data, to filename: String) {
        guard
            let file = self.docFolder?.appendingPathComponent(filename)
            else { return }

        try? data.write(to: file, options: .atomic)
    }

    func readJSONData(from filename: String) -> AnyObject? {
        guard
            let data = readData(from: filename)
            else { return nil }

        return try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject?
    }

    func readData(from filename: String) -> Data? {
        guard
            let file = self.docFolder?.appendingPathComponent(filename)
            else { return nil }
        return try? Data(contentsOf: file)
    }

    func readDataFromBundle(_ filename: String) -> Data? {
        guard
            let path = Bundle.main.path(forResource: filename, ofType: nil)
            else { return nil }

        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }

    func readJSONDataFromBundle(_ filename: String) -> AnyObject? {
        guard
            let data = readDataFromBundle(filename)
            else { return nil }

        return try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject?
    }

}
