//
//  Barcode.m
//  Seq
//
//  Created by Maryia Kadan on 12/15/16.
//  Copyright © 2016 instinctools. All rights reserved.
//

#import "Barcode.h"

@implementation Barcode

+ (UIImage *)code39ImageFromString:(NSString *)strSource imageViewSize:(CGSize)imageViewSize {
    int intSourceLength = (int)strSource.length;
    
    CGFloat NarrowLength = (imageViewSize.width/(intSourceLength + 2)) / 17.0; // Length of narrow bar
    CGFloat WidLength = NarrowLength * 2; // Length of Wide bar
    
    CGFloat barcodeWidth = ((WidLength * 3 + NarrowLength * 7) * (intSourceLength + 2));
    CGFloat x = (imageViewSize.width - barcodeWidth)/2; // Left Margin
    CGFloat y = 0; // Top Margin

    NSString *strEncode = @"010010100"; // Encoding string for starting and ending mark *
    NSString * AlphaBet = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%*"; // Code39 alphabets
    NSString* Code39[] = //Encoding strings for Code39 alphabets
    {
        /* 0 */ @"000110100",
        /* 1 */ @"100100001",
        /* 2 */ @"001100001",
        /* 3 */ @"101100000",
        /* 4 */ @"000110001",
        /* 5 */ @"100110000",
        /* 6 */ @"001110000",
        /* 7 */ @"000100101",
        /* 8 */ @"100100100",
        /* 9 */ @"001100100",
        /* A */ @"100001001",
        /* B */ @"001001001",
        /* C */ @"101001000",
        /* D */ @"000011001",
        /* E */ @"100011000",
        /* F */ @"001011000",
        /* G */ @"000001101",
        /* H */ @"100001100",
        /* I */ @"001001100",
        /* J */ @"000011100",
        /* K */ @"100000011",
        /* L */ @"001000011",
        /* M */ @"101000010",
        /* N */ @"000010011",
        /* O */ @"100010010",
        /* P */ @"001010010",
        /* Q */ @"000000111",
        /* R */ @"100000110",
        /* S */ @"001000110",
        /* T */ @"000010110",
        /* U */ @"110000001",
        /* V */ @"011000001",
        /* W */ @"111000000",
        /* X */ @"010010001",
        /* Y */ @"110010000",
        /* Z */ @"011010000",
        /* - */ @"010000101",
        /* . */ @"110000100",
        /*' '*/ @"011000100",
        /* $ */ @"010101000",
        /* / */ @"010100010",
        /* + */ @"010001010",
        /* % */ @"000101010",
        /* * */ @"010010100"
    };
    
    strSource = [strSource uppercaseString];

    UIGraphicsBeginImageContext(imageViewSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, imageViewSize.width, imageViewSize.height));
    
    // beging encoding
    for (int i = 0; i < intSourceLength; i++)
    {
        // check for illegal characters
        char c = [strSource characterAtIndex:i];
        long index = [AlphaBet rangeOfString:[NSString stringWithFormat:@"%c",c]].location;
        if ((index == NSNotFound) || (c == '*'))
        {
            NSLog(@"This string contains illegal characters");
            return nil;
        }
        // get and concat encoding string
        strEncode = [NSString stringWithFormat:@"%@0%@",strEncode, Code39[index]];
    }
    // pad with ending *
    strEncode = [NSString stringWithFormat:@"%@0010010100", strEncode];
    
    int intEncodeLength = (int)strEncode.length;
    CGFloat fBarWidth;

    for (int i = 0; i < intEncodeLength; i++)
    {
        fBarWidth = ([strEncode characterAtIndex:i] == '1' ? WidLength : NarrowLength);
        if (i % 2 == 0) {
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
            CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
        }
        else {
            CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        }
        CGContextFillRect(context, CGRectMake(x, y, fBarWidth, imageViewSize.height));
        x += fBarWidth;
    }
 
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)createQRForString:(NSString *)qrString size:(CGSize)imageViewSize {
    NSData *stringData = [qrString dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    float scaleX = imageViewSize.width / qrImage.extent.size.width;
    float scaleY = imageViewSize.height / qrImage.extent.size.height;
    
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];
    
    UIImage *returnImage = [UIImage imageWithCIImage:qrImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    return returnImage;
}

@end
