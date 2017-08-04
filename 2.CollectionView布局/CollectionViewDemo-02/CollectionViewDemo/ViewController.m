//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by cloudwalk on 16/7/8.
//  Copyright © 2016年 liuming. All rights reserved.
//

#import "ViewController.h"
#import "WJLineLayout.h"
#import "WJPhotoCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

static NSString *const WJPhotosId = @"photos";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建布局
    WJLineLayout *layout = [[WJLineLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    //水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat collectionW= self.view.frame.size.width;
    CGFloat collectionH= 200;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource =self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WJPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:WJPhotosId];
    

}

#pragma mark - <UICollectionViewDataSource>
//返回Item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WJPhotosId forIndexPath:indexPath];
    cell.imageName =[NSString stringWithFormat:@"%zd.jpg",indexPath.item+1];
//    cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
    
//    cell.backgroundColor = [UIColor orangeColor];
//    NSInteger tag =10;
//    UILabel *label = [cell.contentView viewWithTag:tag];
//    if (label == nil) {
//        label = [[UILabel alloc]init];
//        label.tag = tag;
//        [cell.contentView addSubview:label];
//    }
//   label.text = [NSString stringWithFormat:@"%zd",indexPath.item];
//   [label sizeToFit];
    
        return cell;
}
#pragma mark -<UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zd",indexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
