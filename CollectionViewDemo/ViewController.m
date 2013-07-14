//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by liunan on 12-10-28.
//
//

#import "ViewController.h"
#import "LineLayoutViewController.h"
#import "CircleLayoutViewController.h"
#import "NormalLayoutViewController.h"
#import "StackLayoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -
#pragma mark init

- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
    [tableView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UICollectionViewFlowLayout *)normalFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowLayout.itemSize = CGSizeMake(100, 80);
    flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 40);
    flowLayout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 20);
    return flowLayout;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewController *collectionController = nil;
    
    switch (indexPath.row) {
        case 0: {
            collectionController = [self normalLayoutController];
            break;
        }
        case 1:
            collectionController = [self lineLayoutController];
            break;
        case 2:
            collectionController = [self circleLayoutController];
            break;
        case 3:
            collectionController = [self stackLayoutController];
        default:
            break;
    }

    [self.navigationController pushViewController:collectionController animated:YES];
}

- (UICollectionViewController *)normalLayoutController
{
    UICollectionViewFlowLayout *flowLayout = [self normalFlowLayout];
    NormalLayoutViewController *collectionController = [[[NormalLayoutViewController alloc] initWithCollectionViewLayout:flowLayout] autorelease];
    return collectionController;
}

- (UICollectionViewController *)lineLayoutController
{
    LineLayout *layout = [[[LineLayout alloc] init] autorelease];
    LineLayoutViewController *collectionController = [[[LineLayoutViewController alloc] initWithCollectionViewLayout:layout] autorelease];
    return collectionController;
}

- (UICollectionViewController *)circleLayoutController
{
    CircleLayout *layout = [[[CircleLayout alloc] init] autorelease];
    CircleLayoutViewController *collectionController = [[[CircleLayoutViewController alloc] initWithCollectionViewLayout:layout] autorelease];
    return collectionController;
}

- (UICollectionViewController *)stackLayoutController
{
    APLStackLayout* stackLayout = [[APLStackLayout alloc] init];
    StackLayoutViewController* collectionViewController = [[StackLayoutViewController alloc] initWithCollectionViewLayout:stackLayout];
    collectionViewController.title = @"Stack Layout";
    
    self.transitionController = [[APLTransitionController alloc] initWithCollectionView:collectionViewController.collectionView];
    self.transitionController.delegate = self;
    
    return collectionViewController;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *titleStr = nil;
    switch (indexPath.row) {
        case 0:
            titleStr = @"normal layout";
            break;
        case 1:
            titleStr = @"line layout";
            break;
        case 2:
            titleStr = @"cycle layout";
            break;
        case 3:
            titleStr = @"stack layout";
        default:
            break;
    }
    cell.textLabel.text = titleStr;
    return cell;
}


- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (animationController==self.transitionController)
    {
        return self.transitionController;
    }
    return nil;
}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (![fromVC isKindOfClass:[UICollectionViewController class]] || ![toVC isKindOfClass:[UICollectionViewController class]])
    {
        return nil;
    }
    if (!self.transitionController.hasActiveInteraction)
    {
        return nil;
    }
    
    self.transitionController.navigationOperation = operation;
    return self.transitionController;
}

-(void)interactionBeganAtPoint:(CGPoint)p
{
    // Very basic communication between the transition controller and the top view controller
    // It would be easy to add more control, support pop, push or no-op
    UIViewController* viewController = [(APLCollectionViewController*)[self.navigationController topViewController] nextViewControllerAtPoint:p];
    if (viewController!=nil)
    {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
