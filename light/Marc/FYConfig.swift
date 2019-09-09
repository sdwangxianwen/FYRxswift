//
//  FYConfig.swift
//  light
//
//  Created by wang on 2019/9/9.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit
import CommonCrypto

let BASE_API_URL = "v109/"


/// 判断是否为iphonex 系列
///
/// - Returns: Bool
func isPhoneX() ->Bool {
    if #available(iOS 11.0, *) {
        if (UIApplication.shared.delegate as? AppDelegate )?.window?.safeAreaInsets.bottom != 0 {
            return true
        }
    }
    return false
}
//屏幕宽度
var kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高度
var kScreenHeight = UIScreen.main.bounds.size.height
/// tabBar高度
let TabBarHeight:CGFloat = isPhoneX() ? 83 : 49
/// nav高度
let NavBarHeight:CGFloat = isPhoneX() ? 88 : 64
/// 底部手势框的高度
let BottomLineHeight : CGFloat = isPhoneX() ? 34 : 0
/// 设置随机颜色
func UIColorRandom() -> UIColor {
    let color: UIColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
    return color;
}

// MARK: - 颜色的设置
extension UIColor {
    
    /*
     convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
     便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
     便利构造函数的特点：
     1、便利构造函数通常都是写在extension里面
     2、便利函数init前面需要加载convenience
     3、在便利构造函数中需要明确的调用self.init()
     */
    convenience init(hexString: String) {
        self.init(hexString: hexString,alpha: 1)
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
    
    
    /// 使用Int值快速创建颜色
    convenience init(redValue: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(redValue) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    //let color = UIColor(hex: "ff0000")
    
}

let mainColor = UIColor.init(hexString: "#24B5A1")

extension NSObject {
    func getCurrentController() -> UIViewController {
        let keywindow = (UIApplication.shared.delegate as! AppDelegate).window//UIApplication.shared.keyWindow使用此有时会崩溃
        let firstView: UIView = (keywindow?.subviews.first)!
        let secondView: UIView = firstView.subviews.first!
        var vc = viewForController(view: secondView)!
        vc = ((vc as! UITabBarController).selectedViewController! as! UINavigationController).visibleViewController!
        
        return vc
    }
    
    private func viewForController(view:UIView)->UIViewController?{
        var next:UIView? = view
        repeat{
            if let nextResponder = next?.next, nextResponder is UIViewController {
                return (nextResponder as! UIViewController)
            }
            next = next?.superview
        }while next != nil
        return nil
    }
}

extension String {
    //是否是有效的电话号码
    func isValidMobileNumber() -> Bool {
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9]|9[8])\\d{8}$"
        let CM = "^1(3[4-9]|4[7]|5[0-27-9]|6[6]|7[08]|8[2-478])\\d{8}$";
        let CU = "^1(3[0-2]|4[5]|5[56]|7[0156]|8[56]|9[9])\\d{8}$"
        let CT = "^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$"
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        
        let regextestMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestCM = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestCT = NSPredicate(format: "SELF MATCHES %@", CT)
        let regextestPHS = NSPredicate(format: "SELF MATCHES %@", PHS)
        let regextestCU = NSPredicate(format: "SELF MATCHES %@", CU)
        if (regextestMobile.evaluate(with: self) == true) ||
            regextestCM.evaluate(with: self) == true ||
            regextestCT.evaluate(with:self) == true ||
            regextestCU.evaluate(with: self) == true ||
            regextestPHS.evaluate(with: self) == true {
            return true
        }
        return false
    }
    //是否是有效的银行卡
    func isValidBankCardNumber() -> Bool {
        let BANKCARD = "^(\\d{16}|\\d{19})$";
        let predicate = NSPredicate(format: "SELF MATCHES %@", BANKCARD)
        return predicate.evaluate(with: self)
    }
    
    //是否是有效的邮箱
    func isValidEmail() -> Bool {
        let emailRegex = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
}
extension String {
    var md5 : String{
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH * 2))
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< CC_MD5_DIGEST_LENGTH{
            md5String.appendFormat("%02x", buffer[Int(i)])
        }
        free(buffer)
        return md5String as String
    }
}

public enum UIViewGradientDirection {
    case horizontally
    case vertically
}

public extension UIView {
    /// x
    var fy_x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    ///y
    var fy_y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
            
        }
    }
    
    ///height
    var fy_height : CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    ///width
    var fy_width : CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    //size
    var fy_size : CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    //centerx
    var fy_centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    ///centery
    var fy_centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    ///origin
    var fy_origin : CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
    
    ///maxX
    var fy_maxX : CGFloat {
        get {
            return frame.origin.x + frame.size.width;
        }
    }
    
    ///maxY
    var fy_maxY : CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
    }
    
    ///minX
    var fy_minX : CGFloat {
        get{
            return frame.minX
        }
    }
    
    ///minY
    var fy_minY : CGFloat {
        get{
            return frame.minY
        }
    }
    /// e设置指定位置的圆角
    ///
    /// - Parameters:
    ///   - corners: 位置,上下左右
    ///   - radius: 角度
    func customRectCorner(corners: UIRectCorner,radius:CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    /// 设置指定部位的圆角
    @discardableResult
    func fy_borderSpecified(_ specified: UIRectCorner,cornerRadius:CGFloat) -> UIView {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: specified, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return self
    }
    //view的渐变色
    func fy_addGradientLayer(gradientColors: [UIColor],gradientDirection direction: UIViewGradientDirection, gradientFrame: CGRect? = nil) {
        
        //创建并实例化CAGradientLayer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //设置frame和插入view的layer
        if let gradientFrame = gradientFrame {
            gradientLayer.frame = gradientFrame
        }else {
            gradientLayer.frame = CGRect(x: 0, y: 0, width: fy_width, height: fy_height)
        }
        
        gradientLayer.colors = gradientColors.map({ (color) -> CGColor in
            return color.cgColor
        })
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        if direction == .horizontally {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        }else {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIImage {
    //根据颜色创建一个纯Image
    func imageUseColor(color : String) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.init(hexString:color).cgColor)
        context.fill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}



class FYConfig: NSObject {
    
   

}
