//
//  PGTViewController.m
//  ScrollTest
//
//  Created by Pablo González Thuillier on 21/09/14.
//  Copyright (c) 2014 Thuillier. All rights reserved.
//

#import "PGTViewController.h"
#import "PGTPageContentViewController.h"


@interface PGTViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic,copy) NSArray *pagesControllers;


@end

@implementation PGTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self configurePageController];
    
    
    
}

- (void)configureView {
    self.pagesControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"Page1"],
                              [self.storyboard instantiateViewControllerWithIdentifier:@"Page2"],
                              [self.storyboard instantiateViewControllerWithIdentifier:@"Page3"]];
    
}

- (void)configurePageController {
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PGTPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


#pragma mark - PageController Datasource


- (PGTPageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    PGTPageContentViewController *vc = self.pagesControllers[index];
    vc.index = index;
    
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    PGTPageContentViewController *vc = (PGTPageContentViewController *)viewController;
    NSUInteger index = vc.index;
    
    if (vc.index < [self.pagesControllers count]-1) {
        index ++;
        return [self viewControllerAtIndex:index];
    }
    
    return nil;
    
    

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    PGTPageContentViewController *vc = (PGTPageContentViewController *)viewController;
    NSUInteger index = vc.index;
    
    if(vc.index > 0 ){
        index --;
        return [self viewControllerAtIndex:index];
    }
    
    return nil;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pagesControllers count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
