//
//  TESliderButton.m
//  TESliderButton
//
//  Created by 顾卫明的mac on 2017/12/28.
//

#import "TESliderButton.h"
#import "UIColorAdditions.h"
#import "Sliderbutton.h"
@interface TESliderButton()
@end

@implementation TESliderButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createview];
    }
    return self;
}

-(void)setParam:(NSString *)name :(id)value{
    if ([name isEqualToString:@"params"]) {
        NSDictionary *json= value;
        if ([json objectForKey:@"BackgroundColor"]) {
            self.backgroundColor = [UIColor colorWithHex:value];
        }
        if ([json objectForKey:@"ShowValue"]) {
            self.indexvalue = [[json objectForKey:@"ShowValue"] intValue];
        }
        if ([json objectForKey:@"NowValue"]) {
            self.numberOfPart = [[json objectForKey:@"NowValue"] intValue];
        }
        if ([json objectForKey:@"textUnitFont"]) {
            self.textUnitFont = [[json objectForKey:@"textUnitFont"] floatValue];
        }
        if ([json objectForKey:@"textUnitColor"]) {
            self.textUnitColor = [json objectForKey:@"textUnitColor"];
        }
        if ([json objectForKey:@"ButtonText"]) {
            self.ButtonText = [json objectForKey:@"ButtonText"];
        }
        if ([json objectForKey:@"ButtonRadius"]) {
            self.ButtonRadius = [[json objectForKey:@"ButtonRadius"] floatValue];
        }
        if ([json objectForKey:@"ButtonColor"]) {
            self.ButtonColor = [json objectForKey:@"ButtonColor"];
        }
        
    }
    else if([name isEqualToString:@"ShowValue"]){
        self.indexvalue = [value intValue];
    }
    else if([name isEqualToString:@"NowValue"]){
        self.numberOfPart = [value intValue];
    }
    else if([name isEqualToString:@"BackgroundColor"]){
        self.backgroundColor = [UIColor colorWithHex:value];
    }else if([name isEqualToString:@"textUnitFont"]){
        self.textUnitFont = [value floatValue];
    }else if([name isEqualToString:@"textUnitColor"]){
        self.textUnitColor = value;
    }else if([name isEqualToString:@"ButtonText"]){
        self.ButtonText = value;
    }else if([name isEqualToString:@"ButtonRadius"]){
        self.ButtonRadius = [value floatValue];
    }else if([name isEqualToString:@"ButtonColor"]){
        self.ButtonColor = value;
    }
    
    [self createview];
}

- (void)createview {
    Sliderbutton *slider = [[Sliderbutton alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 100)];
    slider.backgroundColor = [UIColor grayColor];
    slider.sliderBarHeight = 10;
    slider.numberOfPart = 6;
    [slider addTarget:self action:@selector(valuechange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
}

- (void)valuechange:(Sliderbutton*)sender {
    NSLog(@"current index = %ld",(long)sender.value);
}

@end
