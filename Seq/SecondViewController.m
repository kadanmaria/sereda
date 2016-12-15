//
//  SecondViewController.m
//  Seq
//
//  Created by Maryia Kadan on 12/15/16.
//  Copyright © 2016 instinctools. All rights reserved.
//

#import "SecondViewController.h"
#import "Barcode.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonClick:(id)sender {
    if (![self.textField.text isEqualToString:@""]) {
        self.imageView.image = [Barcode createQRForString:self.textField.text size:self.imageView.frame.size];
    }
}


@end
