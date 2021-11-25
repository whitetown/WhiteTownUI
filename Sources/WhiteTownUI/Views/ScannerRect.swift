//
//  ScannerRect.swift
//  SynchroSnap
//
//  Created by Sergey Chehuta on 11/03/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import UIKit

class ScannerHole: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.isOpaque = false
    }

    override func draw( _ rect: CGRect) {

        self.backgroundColor?.setFill()
        UIRectFill(rect)

        let size: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 300 : 218
        let hole = CGRect(x: rect.size.width / 2 - size / 2,
                          y: rect.size.height / 2 - size / 2,
                          width: size,
                          height: size)

        let holeRectIntersection = rect.intersection(hole)
        UIColor.clear.setFill()
        UIRectFill(holeRectIntersection)
    }

}

class ScannerRect: UIView {

    var lineWidth: CGFloat = 12
    var color: UIColor = .white

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        self.backgroundColor = .clear
    }

    override func draw( _ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setLineWidth(self.lineWidth)
        context.setStrokeColor(self.color.cgColor)

        let ww = self.frame.size.width
        let hh = self.frame.size.height

        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: ww/3, y: 0))

        context.move(to: CGPoint(x: ww/3*2, y: 0))
        context.addLine(to: CGPoint(x: ww, y: 0))
        context.addLine(to: CGPoint(x: ww, y: hh/3))

        context.move(to: CGPoint(x: ww, y: hh/3*2))
        context.addLine(to: CGPoint(x: ww, y: hh))
        context.addLine(to: CGPoint(x: ww/3*2, y: hh))

        context.move(to: CGPoint(x: ww/3, y: hh))
        context.addLine(to: CGPoint(x: 0, y: hh))
        context.addLine(to: CGPoint(x: 0, y: hh/3*2))

        context.move(to: CGPoint(x: 0, y: hh/3))
        context.addLine(to: CGPoint(x: 0, y: 0))

        context.strokePath()
    }

}
