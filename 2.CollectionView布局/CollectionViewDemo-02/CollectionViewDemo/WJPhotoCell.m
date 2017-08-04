//
//  WJPhotoCell.m
//  CollectionViewDemo
//
//  Created by cloudwalk on 16/7/10.
//  Copyright © 2016年 liuming. All rights reserved.
//

#import "WJPhotoCell.h"

@interface WJPhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation WJPhotoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 10;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
