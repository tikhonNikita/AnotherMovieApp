#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"

@interface MovieListViewManager : RCTViewManager
@end

@implementation MovieListViewManager

RCT_EXPORT_MODULE(MovieListView)

- (UIView *)view
{
  return [[UIView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString)

@end
