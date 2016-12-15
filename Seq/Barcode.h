//
//  Barcode.h
//  Seq
//
//  Created by Maryia Kadan on 12/15/16.
//  Copyright © 2016 instinctools. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Barcode : NSObject

+ (UIImage *)code39ImageFromString:(NSString *)strSource imageViewSize:(CGSize)imageViewSize;
+ (UIImage *)createQRForString:(NSString *)qrString size:(CGSize)imageViewSize;

@end
