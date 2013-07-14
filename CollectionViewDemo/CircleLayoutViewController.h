//
//  CircleLayoutViewController.h
//  CollectionViewDemo
//
//  Created by tedliu on 12-10-31.
//
//

#import <UIKit/UIKit.h>

@interface CircleLayoutViewController : UICollectionViewController

@property (nonatomic, assign) NSInteger cellCount;

@end

@interface CircleCell : UICollectionViewCell

@property (strong, nonatomic) UILabel* label;

@end

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

@end
