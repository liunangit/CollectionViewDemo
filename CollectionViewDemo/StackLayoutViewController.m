//
//  StackLayoutViewController.m
//  CollectionViewDemo
//
//  Created by liunan on 13-7-14.
//
//

#import "StackLayoutViewController.h"

@interface StackLayoutViewController ()

@end

@implementation StackLayoutViewController

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[self nextViewControllerAtPoint:CGPointZero] animated:YES];
}


-(UICollectionViewController*)nextViewControllerAtPoint:(CGPoint)p
{
    // We could have multiple section stacks and find the right one,
    UICollectionViewFlowLayout* grid = [[UICollectionViewFlowLayout alloc] init];
    grid.itemSize = CGSizeMake(75.0, 75.0);
    grid.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    APLCollectionViewController* nextCollectionViewController = [[APLCollectionViewController alloc] initWithCollectionViewLayout:grid];
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 7.0) {
        nextCollectionViewController.useLayoutToLayoutNavigationTransitions = YES;
    }

    nextCollectionViewController.title = @"Grid Layout";
    return nextCollectionViewController;
}

@end

@implementation APLStackLayout

- (id) init
{
    self = [super init];
    
    if (self) {
        _stackCount = 5;
        _itemSize = CGSizeMake(150, 200);
        _angles = [[NSMutableArray alloc] initWithCapacity:_stackCount * 10];
    }
    return self;
}

- (void)dealloc
{
    [_angles release];
    [_attributesArray release];
    [super dealloc];
}

- (void)prepareLayout
{
    CGSize size = self.collectionView.bounds.size;
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);
    
    // We only display one section in this layout.
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] initWithCapacity:itemCount];
    }
    [_angles removeAllObjects];
    
    CGFloat maxAngle = M_1_PI / 3.0;
    CGFloat minAngle = - M_1_PI / 3.0;
    CGFloat diff = maxAngle - minAngle;
    
    [_angles addObject:[NSNumber numberWithFloat:0]];
    for (NSInteger i = 1; i < _stackCount * 10; i++) {
        int hash = (i * 2654435761 % 2^32);
        hash = (hash * 2654435761 % 2^32);
        
        CGFloat currentAngle = ((hash % 1000) / 1000.0 * diff) + minAngle;
        [_angles addObject:[NSNumber numberWithFloat:currentAngle]];
    }
    
    for (NSInteger i = 0; i < itemCount; i ++) {
        
        NSInteger angleIndex = i % (_stackCount * 10);
        
        NSNumber *angleNumber = [_angles objectAtIndex:angleIndex];
        CGFloat angle = angleNumber.floatValue;
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attributes.size = _itemSize;
        attributes.center = center;
        
        float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (ver >= 7) {
            attributes.transform = CGAffineTransformMakeRotation(angle);
        }
        else {
            attributes.transform3D = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(angle));
        }
       
        
        if (i > _stackCount)
        {
            attributes.alpha = 0.0;
        }
        else
        {
            attributes.alpha = 1.0;
        }
        attributes.zIndex = (itemCount - i);
        
        [_attributesArray addObject:attributes];
    }
}


- (void)invalidateLayout
{
    [_attributesArray release];
    _attributesArray = nil;
}


- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_attributesArray objectAtIndex:indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributesArray;
}

@end