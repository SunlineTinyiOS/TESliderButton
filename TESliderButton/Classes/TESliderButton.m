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
@property (nonatomic, strong) Sliderbutton *sliderbutton;
@end

@implementation TESliderButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bgcolor = @"#fff8ed";
        self.textUnitFont = 13;
        self.textUnitColor = @"#000000";
        self.ButtonRadius = 15;
        self.indexvalue = 0;
        self.ButtonColor = @"#ff0000";
        self.ButtonText = @"8M";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)setParam:(NSString *)name :(id)value{
    if ([name isEqualToString:@"param"]) {
        NSDictionary *json= value;
        if ([json objectForKey:@"BackgroundColor"]) {
            self.backgroundColor = [UIColor colorWithHex:[json objectForKey:@"BackgroundColor"] andAlpha:1];
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
        self.backgroundColor = [UIColor colorWithHex:value andAlpha:1];
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
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self createview];
}

- (void)createview {
    
    if (self.sliderbutton) {
        self.sliderbutton.indexvalue = self.indexvalue;
        self.sliderbutton.textUnitFont = self.textUnitFont;
        self.sliderbutton.textUnitColor = self.textUnitColor;
        self.sliderbutton.ButtonText = self.ButtonText;
        self.sliderbutton.numberOfPart = self.numberOfPart;
        self.sliderbutton.ButtonRadius = self.ButtonRadius;
        self.sliderbutton.ButtonColor = self.ButtonColor;
        [self.sliderbutton setNeedsDisplay];
    }else{
        self.sliderbutton = [[Sliderbutton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.sliderbutton.indexvalue = self.indexvalue;
        self.sliderbutton.textUnitFont = self.textUnitFont;
        self.sliderbutton.textUnitColor = self.textUnitColor;
        self.sliderbutton.ButtonText = self.ButtonText;
        self.sliderbutton.numberOfPart = self.numberOfPart;
        self.sliderbutton.ButtonRadius = self.ButtonRadius;
        self.sliderbutton.ButtonColor = self.ButtonColor;
    }
    
    [self.sliderbutton addTarget:self action:@selector(valuechange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.sliderbutton];
}

- (void)valuechange:(Sliderbutton*)sender {
    NSLog(@"current index = %ld",(long)sender.value);
    NSString *string = [NSString stringWithFormat:@"%ld", sender.value];
    [self executiveEvent:@"select" array:@[string]];
    
    
}


-(void)executiveEvent:(NSString *)event array:(NSArray *)array
{
    UIView *supView = self.superview;
    if([supView respondsToSelector:@selector(executiveEvent: array:)]) {
        [supView performSelector:@selector(executiveEvent: array:) withObject:event withObject:array];
    }
}

//-(void)executiveEvent:(NSString *)event array:(NSArray *)array
//{
//    JSManagedValue *script = [_context.element.eventDictinoary objectForKey:event];
//    if (script) {
//        JSValue *jsValue = script.value;
//
//        [jsValue callWithArguments:@[array]];
//    }
//}

@end
