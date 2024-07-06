#import "MovieListView.h"

#import <react/renderer/components/RNMovieListViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/RNMovieListViewSpec/EventEmitters.h>
#import <react/renderer/components/RNMovieListViewSpec/Props.h>
#import <react/renderer/components/RNMovieListViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@interface MovieListView () <RCTMovieListViewViewProtocol>
@end

@implementation MovieListView {
    MovieListViewController * _movie_list_view_controller;
    UIView * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<MovieListViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        static const auto defaultProps = std::make_shared<const MovieListViewProps>();
        _props = defaultProps;
        [self setupView];
        return self;
    }
    
    return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<MovieListViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<MovieListViewProps const>(props);
    
    if (oldViewProps.color != newViewProps.color) {
        NSString * colorToConvert = [[NSString alloc] initWithUTF8String: newViewProps.color.c_str()];
        [_view setBackgroundColor:[self hexStringToColor:colorToConvert]];
    }
    
    [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> MovieListViewCls(void)
{
    return MovieListView.class;
}

- hexStringToColor:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *stringScanner = [NSScanner scannerWithString:noHashString];
    
    unsigned hex;
    if (![stringScanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]]) {
        responder = [responder nextResponder];
    }
    return (UIViewController *)responder;
}

-(void)setupView {
    _movie_list_view_controller = [MovieListViewController createViewController];
    
    
    UIView *swiftUIView = _movie_list_view_controller.view;
    self.contentView = swiftUIView;
    
    swiftUIView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [swiftUIView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [swiftUIView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [swiftUIView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [swiftUIView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
    
    UIViewController *parentViewController = [self parentViewController];
    if (parentViewController) {
        [parentViewController addChildViewController:_movie_list_view_controller];
        [_movie_list_view_controller didMoveToParentViewController:parentViewController];
    }
}

@end
