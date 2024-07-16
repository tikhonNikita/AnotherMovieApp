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
        [self setupView];
        return self;
    }
    
    return self;
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
