//
//  TESliderButtonViewController.m
//  TESliderButton
//
//  Created by 顾卫明 on 12/28/2017.
//  Copyright (c) 2017 顾卫明. All rights reserved.
//

#import "TESliderButtonViewController.h"
#import "TESliderButton.h"
@interface TESliderButtonViewController ()

@end

@implementation TESliderButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TESliderButton *slider = [[TESliderButton alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 100)];
    slider.backgroundColor = [UIColor grayColor];
    slider.sliderBarHeight = 10;
    slider.numberOfPart = 6;
    [self.view addSubview:slider];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
