//
//  NormalLayoutViewController.h
//  CollectionViewDemo
//
//  Created by tedliu on 12-10-31.
//
//

#import <UIKit/UIKit.h>

@interface NormalLayoutViewController : UICollectionViewController

@end

@interface NormalCell : UICollectionViewCell

@property (strong, nonatomic) UILabel* label;


@end

@interface NormalHeader : UICollectionReusableView

@property (strong, nonatomic) UILabel *label;

@end

@interface NormalFooter : NormalHeader

@end

@interface NormalDecoration : UICollectionReusableView

@end
