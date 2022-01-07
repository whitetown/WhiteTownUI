//
//  Bundle.swift
//  WhiteTown
//
//  Created by Sergey Chehuta on 09/10/2020.
//

import UIKit

public extension Bundle {

    var appName: String {
        return self.object(forInfoDictionaryKey: kCFBundleExecutableKey as String) as? String ?? "WhiteTownUI"
    }

    var versionString: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0"
    }

    var bundleVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "1"
    }

    var formattedVersion: String {
        return "\(String(describing: versionString)) (\(bundleVersion))"
    }


    static func isUpdateAvailable() -> String? {

        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                return nil
        }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            return nil
        }
        if  let result = (json["results"] as? [Any])?.first as? [String: Any],
            let version = result["version"] as? String {
            return version > currentVersion ? version : nil
        }
        return nil
    }

}

extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}
