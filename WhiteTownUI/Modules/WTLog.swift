//
//  WTLog.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 12/11/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit

public class WTLog {

    public static let shared = WTLog()

    private let enabled = true
    private var url: URL?
    private let df = DateFormatter()
    private let serialQueue = DispatchQueue(label: "logQueue")

    public static var filename: URL? {
        return FileManager.default.docFolder?.appendingPathComponent("wtlog.txt")
    }

    public init() {
        self.df.dateFormat = "dd.MM.YYYY HH:mm:ss"

        self.url = WTLog.filename
        //print(self.url as Any)

        log("\n"  + self.df.string(from: Date()))
        log("\n")
    }

    private func saveMessages(_ messages: [String]) {

        if !self.enabled { return }

        self.serialQueue.async {

        guard let url = self.url else { return }

        let value = "\n" + messages.joined(separator: " | ")
        guard let data = value.data(using: String.Encoding.utf8) else { return }

        if let file = FileHandle(forWritingAtPath: url.path) {
            defer { file.closeFile() }
            file.seekToEndOfFile()
            file.write(data)
        }
        else {
            try? data.write(to: url, options: .atomic)
        }

        }
    }
}

public extension WTLog {

    func log(_ message: String) {
        saveMessages([message])
    }

    func log(messages: [String]) {
        saveMessages(messages)
    }

    func log(_ messages: [String]) {
        saveMessages(messages)
    }

    func log(dictionary: NSDictionary) {
        log(dictionary.description)
    }

    func clear() {
        if let url = WTLog.filename {
            try? FileManager.default.removeItem(at: url)
        }
    }

}
