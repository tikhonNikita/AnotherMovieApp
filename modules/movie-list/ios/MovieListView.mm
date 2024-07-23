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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        static const auto defaultProps = std::make_shared<const MovieListViewProps>();
        _props = defaultProps;
        
        __weak MovieListView *weakSelf = self;
        self->_movie_list_view_controller = [MovieListViewController createViewControllerOnMoviePress:^(NSString* movieId) {
            __strong MovieListView *strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf onMoviePress:movieId];
            }
        }];
        
        return self;
    }
    return nil;
}

-(void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window) {
        [self setupView];
    }
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<MovieListViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<MovieListViewProps const>(props);
    
    if(oldViewProps.movieListStatus != newViewProps.movieListStatus) {
        NSLog(@"STATUS changed");
        NetworkStatus status = [self convertToMovieModelStatus:newViewProps.movieListStatus];
        [_movie_list_view_controller updateStatusWithStatus:status];
    }
    

        NSArray<Movie *> *newMoviesArray = [self convertToNSArray:newViewProps.movies];
        [_movie_list_view_controller updateMoviesWithMovies:newMoviesArray];
    
    
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
    UIViewController *parentViewController = [self parentViewController];
    if (parentViewController) {
        UIView *swiftUIView = _movie_list_view_controller.view;
        [self addSubview:swiftUIView];
        swiftUIView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [swiftUIView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [swiftUIView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [swiftUIView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [swiftUIView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
        ]];

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

- (NetworkStatus)convertToMovieModelStatus:(MovieListViewMovieListStatus) status {
    switch (status) {
        case MovieListViewMovieListStatus::Loading:
            return [NetworkStatusHelper createLoading];
            break;
        case MovieListViewMovieListStatus::Error:
            return [NetworkStatusHelper createError];
            break;
        case MovieListViewMovieListStatus::Success:
            return [NetworkStatusHelper createSuccess];
            break;
    }
}

- (void)onMoviePress:(NSString *)movieId {
    if (_eventEmitter != nullptr) {
        auto emitter = std::dynamic_pointer_cast<const facebook::react::MovieListViewEventEmitter>(_eventEmitter);
        if (emitter) {
            const char *cString = [movieId UTF8String];
                    std::string cppString(cString);
            emitter->onMoviePress(facebook::react::MovieListViewEventEmitter::OnMoviePress{cppString});
        }
    }
}

@end
