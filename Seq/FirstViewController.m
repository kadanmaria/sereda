//
//  FirstViewController.m
//  Seq
//
//  Created by Maryia Kadan on 12/15/16.
//  Copyright © 2016 instinctools. All rights reserved.
//

#import "FirstViewController.h"
#import "Barcode.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonClick:(id)sender {
    if (![self.textField.text isEqualToString:@""]) {
        self.imageView.image = [Barcode code39ImageFromString:self.textField.text imageViewSize:self.imageView.frame.size];
    } 
}

@end
