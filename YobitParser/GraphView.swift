//
//  GraphView.swift
//  YobitParser
//
//  Created by Дмитрий Ю on 18/10/2018.
//  Copyright © 2018 Дмитрий Ю. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    
    
    @IBInspectable var lineColor : UIColor = .white
    @IBInspectable var lineWidth : CGFloat = 2.0
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    
    private struct Const {
        static let margin : CGFloat = 5
        static let topBorder : CGFloat = 5
        static let bottomBorder : CGFloat = 5
        static let colorAlpha : CGFloat = 0.3
    }
    var graphViewCont = GraphViewController()  // create GraphViewController
    private var graphLayer : CAShapeLayer!

    
    override func draw(_ rect: CGRect) {
        var graphPoints : [Float] = graphViewCont.graphPoints // create massive
        let width = rect.width
        let height = rect.height
        let margin = Const.margin
        let graphWidth = width - margin * 2
        let columnXPoint = {
            (column : Float) -> CGFloat in
            let spacing = graphWidth / CGFloat(graphPoints.count - 1)
            return CGFloat(column) * spacing + margin
        }
        
        let graphHeight = height - Const.topBorder - Const.bottomBorder
        let maxValue = graphPoints.max()!
        let mediana = (graphPoints.max()! + graphPoints.min()!) / 2
        let scale:Float = Float(graphHeight) / (graphPoints.max()! - graphPoints.min()!)
        let columnYPoint = {
            (graphPoint : Float) -> CGFloat in
            let y = abs(-5 + (graphPoint - maxValue) * scale)
            return CGFloat(y)
        }
        
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x : columnXPoint(0), y : columnYPoint(graphPoints[0])))
        
        for (index, value) in graphPoints.enumerated() {
            let nextPoint = CGPoint(x : columnXPoint(Float(index)), y : columnYPoint(Float(value)))
            graphPath.addLine(to: nextPoint)
        }
        
        //============================================================================
        // draw the line graph
        //UIColor.white.setFill()
        //UIColor.green.setStroke()
        UIColor.clear.setFill()
        UIColor.clear.setStroke()
        UIColor(red: 0.3961, green: 0.7686, blue: 0.4, alpha: 1.0).setFill()
        UIColor(red: 0.3961, green: 0.7686, blue: 0.4, alpha: 1.0).setStroke()
        
        
        //2 - get the current context
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        //3 - set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //4 - set up the color stops
        let colorLocations: [CGFloat] = [0.0, 1.0]
        //5 - create the gradient
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        //6 - draw the gradient
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        
        //Create the clipping path for the graph gradient
        //1 - save the state of the context (commented out for now)
        context.saveGState()
        //2 - make a copy of the path
        let clippingPath = graphPath.copy() as! UIBezierPath
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(x: columnXPoint(Float(graphPoints.count - 1)), y:height))
        clippingPath.addLine(to: CGPoint(x:columnXPoint(0), y:height))
        clippingPath.close()
        //4 - add the clipping path to the context
        clippingPath.addClip()
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context.restoreGState()
        //draw the line on top of the clipped gradient
        graphPath.lineWidth = lineWidth
        graphPath.stroke()
        
        
        //        graphLayer = CAShapeLayer()
        //        graphLayer.path = graphPath.cgPath
        //        graphLayer.fillColor = UIColor.clear.cgColor
        //        graphLayer.strokeColor = lineColor.cgColor
        //        graphLayer.lineWidth = lineWidth
        //        graphLayer.strokeEnd = 1.0
        //        layer.addSublayer(graphLayer)
        
        
        //                let graphAnim = CABasicAnimation(keyPath: "strokeEnd")
        //                graphAnim.duration = 1
        //                graphAnim.fromValue = 0
        //                graphAnim.toValue = 1
        //                graphLayer.add(graphAnim, forKey: "anim")
        
        
        //Draw horizontal graph lines on the top of everything
        let linePath = UIBezierPath()
        //vertical lines
        
        //top line
        linePath.move(to: CGPoint(x:margin, y:columnYPoint(graphPoints.max()!)))
        linePath.addLine(to: CGPoint(x:width - margin, y:columnYPoint(graphPoints.max()!)))
        //center line
        linePath.move(to: CGPoint(x:margin, y : columnYPoint(mediana)))
        linePath.addLine(to: CGPoint(x:width - margin, y : columnYPoint(mediana)))
        //bottom line
        linePath.move(to: CGPoint(x:margin, y:columnYPoint(graphPoints.min()!)))
        linePath.addLine(to: CGPoint(x:width - margin, y:columnYPoint(graphPoints.min()!)))
        let color = UIColor(white: 1.0, alpha: Const.colorAlpha)
        color.setStroke()
        linePath.lineWidth = 0.3
        linePath.stroke()
    }
}
