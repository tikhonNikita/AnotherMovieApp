#import "MovieListView.h"

#import <react/renderer/components/RNMovieListViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/RNMovieListViewSpec/EventEmitters.h>
#import <react/renderer/components/RNMovieListViewSpec/Props.h>
#import <react/renderer/components/RNMovieListViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"


#import "React/RCTConversions.h"

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
        self->_movie_list_view_controller = [MovieListViewController createViewController];
        return self;
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview) {
        [self setupView];
    }
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<MovieListViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<MovieListViewProps const>(props);
    
    //TODO: add comparation between old and new movies
    NSArray<Movie *> *moviesArray = [self convertToNSArray:newViewProps.movies];
    [_movie_list_view_controller updateMoviesWithMovies:moviesArray];
    
    [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> MovieListViewCls(void)
{
    return MovieListView.class;
}

- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    NSLog(@"Parent view controller Initilally. Responder: %@", responder);
    while ([responder isKindOfClass:[UIView class]]) {
        responder = [responder nextResponder];
    }
    if ([responder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)responder;
    } else {
        NSLog(@"Parent view controller is nil. Responder: %@", responder);
        return nil;
    }
}

- (void)setupView {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *parentViewController = [self parentViewController];
        if (parentViewController) {
            UIView *swiftUIView = self->_movie_list_view_controller.view;
            [self addSubview:swiftUIView];
            swiftUIView.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [swiftUIView.topAnchor constraintEqualToAnchor:self.topAnchor],
                [swiftUIView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                [swiftUIView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                [swiftUIView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
            ]];

            [parentViewController addChildViewController:self->_movie_list_view_controller];
            [self->_movie_list_view_controller didMoveToParentViewController:parentViewController];
        }
    });
}

- (NSArray<Movie *> *)convertToNSArray:(const std::vector<MovieListViewMoviesStruct> &)moviesStruct {
    NSMutableArray<Movie *> *moviesArray = [NSMutableArray arrayWithCapacity:moviesStruct.size()];

    for (const auto &movieStruct : moviesStruct) {
        Movie *movie = [Movie createWithId:movieStruct.id
                                       url:[NSString stringWithUTF8String:movieStruct.url.c_str()]
                                     title:[NSString stringWithUTF8String:movieStruct.title.c_str()]
                          movieDescription:[NSString stringWithUTF8String:movieStruct.movieDescription.c_str()]
                                    rating:movieStruct.rating];
        [moviesArray addObject:movie];
    }

    return [moviesArray copy];
}

@end
