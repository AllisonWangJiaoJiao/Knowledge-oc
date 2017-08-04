//
//  WJLineLayout.m
//  CollectionViewDemo
//
//  Created by cloudwalk on 16/7/8.
//  Copyright © 2016年 liuming. All rights reserved.
//

#import "WJLineLayout.h"

@implementation WJLineLayout

- (instancetype)init
{
    if (self = [super init]) {
       
    }
    return self;
}
/*
 *用来做布局的初始化操作(不建议在init方法里面做布局的初始化操作)
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
-(void)prepareLayout
{
    CGFloat insert = (self.collectionView.frame.size.width -self.itemSize.width)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, insert, 0, insert);

}

/*
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 */

//当collectionView的显示范围发生改变的时候,是否需要重新刷新布局
//一旦重新刷新布局,就会重新调用layoutAttributesForElementsInRect方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/*
 *这个方法的返回值是一个数组(数组里面存放着rect范围内所有元素的布局属性)
 *这个方法的返回值决定了rect范围内所有元素的排布(frame)
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{

    //获得super已经计算好的布局属性
    NSArray *array =[super layoutAttributesForElementsInRect:rect] ;
    
    //计算collectionView最中心点的X的值(用contentsize的X偏移量+collectionView宽度的一半)
    CGFloat centerX = self.collectionView.contentOffset.x +self.collectionView.frame.size.width*0.5;
    
    //在原有布局的基础上,进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
//        NSLog(@"%zd,%f",attrs.indexPath.item, attrs.center.x - centerX);
     //cell的中心店x和collecionView最中心点的X值的间距
        CGFloat delta = ABS(attrs.center.x - centerX);
    //根据间距值 计算cell的缩放比例
        CGFloat scale =1- delta/self.collectionView.frame.size.width ;
    //设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}
/*
 *这个方法的返回时就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x =proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    //这里建议调用super,因为用self会把里面for循环的transform再算一遍,但我们仅仅想拿到中心点X,super中已经算好中心点X的值了
    NSArray *array =[super layoutAttributesForElementsInRect:rect];
    //计算collectionView最中心点的X的值
    /*
     proposedContentOffset 目的,原本
     拿到最后这个偏移量的X,最后这些cell,距离最后中心点的位置
     */
     CGFloat centerX = proposedContentOffset.x +self.collectionView.frame.size.width*0.5;
    
    //存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta)  >ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        } ;
    }
    //修改原有的偏移量
    proposedContentOffset.x +=minDelta;
    
    return proposedContentOffset;
}

/**
 *1.cell的放大和缩小
 *2.停止滚动时,cell的剧中
 */
@end
