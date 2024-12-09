//
//  UIImageViewExtension.swift


import UIKit
import SDWebImage

extension UIImageView{
    
    func alphaAtPoint(_ point: CGPoint) -> CGFloat {
        
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let alphaInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        
        guard let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: alphaInfo) else {
            return 0
        }
        
        context.translateBy(x: -point.x, y: -point.y);
        
        layer.render(in: context)
        
        let floatAlpha = CGFloat(pixel[3])
        
        return floatAlpha
    }
    
  
    
    func setImage(link:String)
    {
        var getLink = link.removingPercentEncoding //REMOVING PREVIOUS PERCENTAGE ENCODING IN CASE OF ADDED BY OTHER PLATFORM
        getLink = getLink?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string:getLink ?? "") else {
            self.sd_setImage(with: URL(string:""), completed: nil)
            return
        }
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: url, completed: nil)
 
    }
    
    func setImageWithPlaceholder(link:String,imgName:String)
    {
        var getLink = link.removingPercentEncoding //REMOVING PREVIOUS PERCENTAGE ENCODING IN CASE OF ADDED BY OTHER PLATFORM
        getLink = getLink?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string:getLink ?? "") else {
            self.sd_setImage(with:URL(string:""), placeholderImage: UIImage(named: imgName))
            return
        }
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with:url, placeholderImage: UIImage(named: imgName))
    }
    
    
    
    func setImageWithoutLoader(link:String)
    {
        var getLink = link.removingPercentEncoding //REMOVING PREVIOUS PERCENTAGE ENCODING IN CASE OF ADDED BY OTHER PLATFORM
        getLink = getLink?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string:getLink ?? "") else {
            self.sd_setImage(with: URL(string:""), completed: nil)
            return
        }
        self.sd_setImage(with: url, completed: nil)
    }
   
    
    public func maskCircle() {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
